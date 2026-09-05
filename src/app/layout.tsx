import type { Metadata, Viewport } from "next";
import { Geist, Geist_Mono } from "next/font/google";
import "./globals.css";
import Navbar from "@/components/Navbar";
import Footer from "@/components/Footer";
import { ThemeProvider } from "@/components/ThemeProvider";

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

const siteUrl = process.env.NEXT_PUBLIC_SITE_URL || "https://pixelsubz.lk";

export const viewport: Viewport = {
  width: "device-width",
  initialScale: 1,
  maximumScale: 5,
  themeColor: [
    { media: "(prefers-color-scheme: dark)", color: "#141414" },
    { media: "(prefers-color-scheme: light)", color: "#ffffff" },
  ],
};

export const metadata: Metadata = {
  metadataBase: new URL(siteUrl),
  title: {
    default: "PixelSubzLk — Download Sinhala Subtitles (.SRT) & Direct Telegram Movies",
    template: "%s | PixelSubzLk",
  },
  description:
    "Download synchronized Sinhala subtitles (.srt) for the latest Hollywood, Bollywood, Tamil, Malayalam & TV Series. Fast direct Telegram download links with verified 480p, 720p, 1080p video qualities on PixelSubzLk.",
  keywords: [
    "PixelSubzLk",
    "PixelSubz",
    "Sinhala Subtitles",
    "Sinhala Sub",
    "Download Sinhala Subtitles",
    "Sinhala Subtitles for Movies",
    "Sinhala Subtitles for TV Series",
    "baiscope sinhala sub",
    "cineru sinhala subtitles",
    "subz lk sinhala sub",
    "සිංහල උපසිරැසි",
    "සිංහල සබ්",
    "සිංහල සබ් ඩවුන්ලෝඩ්",
    "Telegram Movie Download Sri Lanka",
    "Direct Telegram Links Sri Lanka",
    "Sinhala Subtitles srt",
    "Free Movie Subtitles Sri Lanka",
  ],
  authors: [{ name: "PixelSubzLk Community" }],
  creator: "PixelSubzLk",
  publisher: "PixelSubzLk",
  formatDetection: {
    email: false,
    address: false,
    telephone: false,
  },
  alternates: {
    canonical: "/",
  },
  openGraph: {
    type: "website",
    locale: "si_LK",
    alternateLocale: ["en_US"],
    url: siteUrl,
    title: "PixelSubzLk — Sinhala Subtitles (.SRT) & Telegram Movie Downloads",
    description:
      "Find and download latest Sinhala subtitles and direct Telegram movies & TV series in Full HD on PixelSubzLk.",
    siteName: "PixelSubzLk",
    images: [
      {
        url: "/og-image.jpg",
        width: 1200,
        height: 630,
        alt: "PixelSubzLk - Sinhala Subtitles and Telegram Downloads",
      },
    ],
  },
  twitter: {
    card: "summary_large_image",
    title: "PixelSubzLk — Sinhala Subtitles & Telegram Movie Downloads",
    description:
      "Download the latest Sinhala subtitles and direct Telegram files for movies & series on PixelSubzLk.",
    images: ["/logo.png"],
  },
  icons: {
    icon: "/logo.png",
    shortcut: "/logo.png",
    apple: "/logo.png",
  },
  robots: {
    index: true,
    follow: true,
    googleBot: {
      index: true,
      follow: true,
      "max-video-preview": -1,
      "max-image-preview": "large",
      "max-snippet": -1,
    },
  },
};

export default function RootLayout({
  children,
}: Readonly<{ children: React.ReactNode }>) {
  // Global Structured Data (JSON-LD) for Google Search
  const jsonLd = {
    "@context": "https://schema.org",
    "@graph": [
      {
        "@type": "WebSite",
        "@id": `${siteUrl}/#website`,
        "url": siteUrl,
        "name": "PixelSubzLk",
        "alternateName": ["PixelSubz", "Pixel Subz Sri Lanka"],
        "description": "Download Sinhala Subtitles & Direct Telegram Movies",
        "potentialAction": [
          {
            "@type": "SearchAction",
            "target": {
              "@type": "EntryPoint",
              "urlTemplate": `${siteUrl}/?search={search_term_string}`,
            },
            "query-input": "required name=search_term_string",
          },
        ],
        "inLanguage": ["si-LK", "en-US"],
      },
      {
        "@type": "Organization",
        "@id": `${siteUrl}/#organization`,
        "name": "PixelSubzLk",
        "url": siteUrl,
        "logo": {
          "@type": "ImageObject",
          "url": `${siteUrl}/logo.png`,
        },
        "sameAs": [
          "https://t.me/pixelsubzlk",
        ],
      },
    ],
  };

  return (
    <html
      lang="si"
      className={`${geistSans.variable} ${geistMono.variable} antialiased`}
    >
      <head>
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
        />
      </head>
      <body
        className="min-h-screen flex flex-col transition-colors duration-200"
        style={{ background: "var(--color-bg)", color: "var(--color-text)" }}
      >
        <ThemeProvider>
          <Navbar />
          <main className="flex-grow">{children}</main>
          <Footer />
        </ThemeProvider>
      </body>
    </html>
  );
}
