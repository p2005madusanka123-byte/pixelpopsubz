import prisma from '@/lib/db';
import { createClient } from '@/lib/supabase/server';
import { NextResponse } from 'next/server';

export async function POST(request: Request) {
  try {
    const supabase = await createClient();
    const { data: { user } } = await supabase.auth.getUser();

    if (!user) {
      return NextResponse.json({ error: 'Unauthorized.' }, { status: 401 });
    }

    const {
      movieId,
      botToken: customBotToken,
      chatId: customChatId,
      customMessage,
    } = await request.json();

    if (!movieId) {
      return NextResponse.json({ error: 'Movie selection is required.' }, { status: 400 });
    }

    const botToken = customBotToken?.trim() || process.env.TELEGRAM_BOT_TOKEN;
    const chatId = customChatId?.trim() || process.env.TELEGRAM_CHAT_ID || '@PixelSubzLk';

    if (!botToken) {
      return NextResponse.json({
        error: 'Telegram Bot Token is required. Please provide a bot token or set TELEGRAM_BOT_TOKEN in .env',
      }, { status: 400 });
    }

    if (!chatId) {
      return NextResponse.json({
        error: 'Telegram Channel/Chat ID is required (e.g. @PixelSubzLk or -100xxxxxxxx).',
      }, { status: 400 });
    }

    // Fetch movie details
    let movie: any = null;
    try {
      movie = await prisma.movie.findUnique({
        where: { id: movieId },
        include: {
          subtitles: { select: { fileName: true, language: true } },
          telegramLinks: { select: { quality: true, size: true } },
        },
      });
    } catch {
      // Fallback
    }

    if (!movie) {
      return NextResponse.json({ error: 'Movie/TV Series not found in database.' }, { status: 404 });
    }

    const siteUrl = process.env.NEXT_PUBLIC_SITE_URL || 'https://pixelsubz.lk';
    const movieUrl = `${siteUrl}/movies/${movie.id}`;
    const year = movie.releaseDate ? movie.releaseDate.split('-')[0] : '';
    const isTv = movie.type === 'TV_SHOW';

    const cleanDescription = movie.description
      ? movie.description.length > 250
        ? movie.description.substring(0, 247) + '…'
        : movie.description
      : 'Latest Sinhala Subtitle release now available on PixelSubzLk.';

    // Construct high-aesthetic Telegram caption
    const defaultCaption = [
      `🎬 <b>${movie.title} ${year ? `(${year})` : ''}</b>`,
      `🎭 <b>Type:</b> ${isTv ? '📺 TV Series' : '🍿 Feature Film'}`,
      `🇱🇰 <b>Sinhala Subtitle:</b> Available (.srt) ✅`,
      movie.telegramLinks?.length ? `⚡ <b>Qualities:</b> ${movie.telegramLinks.map((t: any) => t.quality).join(' | ')}` : '',
      ``,
      `📝 <b>Storyline:</b>`,
      `<i>${cleanDescription}</i>`,
      ``,
      `📥 <b>Download Sinhala Subtitles:</b>`,
      `👉 <a href="${movieUrl}">${movieUrl}</a>`,
      ``,
      `📢 <b>Channel:</b> @PixelSubzLk | 🌐 <b>Website:</b> pixelsubz.lk`,
    ].filter(Boolean).join('\n');

    const caption = customMessage?.trim() || defaultCaption;

    // Inline Keyboard Buttons
    const inlineKeyboard = {
      inline_keyboard: [
        [
          { text: '📥 Download Sinhala Subtitle', url: movieUrl },
        ],
        [
          { text: '⚡ Open on Website', url: movieUrl },
          { text: '📢 Join Channel', url: 'https://t.me/PixelSubzLk' },
        ],
      ],
    };

    let telegramRes;
    const cleanPoster = movie.posterPath?.startsWith('http') ? movie.posterPath : null;

    if (cleanPoster) {
      // Send Photo with formatted caption
      telegramRes = await fetch(`https://api.telegram.org/bot${botToken}/sendPhoto`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          chat_id: chatId,
          photo: cleanPoster,
          caption: caption,
          parse_mode: 'HTML',
          reply_markup: inlineKeyboard,
        }),
      });
    } else {
      // Fallback: Send Text message
      telegramRes = await fetch(`https://api.telegram.org/bot${botToken}/sendMessage`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          chat_id: chatId,
          text: caption,
          parse_mode: 'HTML',
          reply_markup: inlineKeyboard,
          disable_web_page_preview: false,
        }),
      });
    }

    const tgData = await telegramRes.json();

    if (!tgData.ok) {
      return NextResponse.json({
        error: `Telegram API Error: ${tgData.description || 'Failed to publish post'} (Code ${tgData.error_code || 'Unknown'})`,
      }, { status: 400 });
    }

    return NextResponse.json({
      success: true,
      messageId: tgData.result?.message_id,
      postUrl: tgData.result?.chat?.username ? `https://t.me/${tgData.result.chat.username}/${tgData.result.message_id}` : null,
    });
  } catch (error: any) {
    console.error('Telegram publish error:', error);
    return NextResponse.json({ error: error.message || 'Internal Telegram publishing error' }, { status: 500 });
  }
}
