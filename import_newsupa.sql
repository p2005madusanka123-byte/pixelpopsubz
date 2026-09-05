-- ============================================================================
-- PixelSubzLk – Data Migration from subtitles_rows.csv
-- Run this in: Supabase Dashboard → SQL Editor → Run (Ctrl+Enter)
-- ============================================================================

-- Ensure default system user exists for uploader_id foreign key
INSERT INTO users (id, email, role) VALUES ('00000000-0000-0000-0000-000000000001', 'admin@pixelsubz.lk', 'ADMIN') ON CONFLICT (id) DO NOTHING;

-- 1. MOVIES
INSERT INTO movies (id, title, original_title, type, description, release_date, year, runtime, imdb_rating, genres, seo_tags, language, country, status, total_seasons, poster_path, backdrop_path, created_at, updated_at) VALUES ('d439155b-a6e0-4497-a8cd-aab4f6a88429', 'Sons of Anarchy', 'Sons of Anarchy', 'TV_SHOW', 'Sons of Anarchy (SAMCRO)  ☠️ සැබෑ සහෝදරත්වයේ සහ අපරාධ ලෝකයේ දරුණුතම සටන

​Breaking Bad, Peaky Blinders, Banshee වගේ Extreme Drama සහ Crime සීරීස් බලන්න ආස කරන කෙනෙක් නම්, Sons of Anarchy (SOA) කියන්නේ අනිවාර්යයෙන්ම මඟනොහැරිය යුතු Masterpiece එකක්. 💯

IMDb දර්ශකයේ 8.5/10 ක ඉහළම අගයක් ලබාගනිමින්, ලොව පුරා මිලියන ගණනක ප්‍රේක්ෂක ආකර්ෂණයක් දිනාගත් මේ කතාමාලාව, සාමාන්‍ය ටීවී සීරීස් එකකට වඩා එහා ගිය වෙනස්ම අත්දැකීමක්!❤️

​කතාව මොකක්ද?🔰

​කාලිෆෝනියාවේ "චාමිං" (Charming) කියන කුඩා නගරය කේන්ද්‍ර කරගෙන, නීතියට පිටින් මෝටර් සයිකල් පදවන කල්ලියක් (Outlaw Motorcycle Club) වන SAMCRO (Sons of Anarchy Motorcycle Club, Redwood Original) වටා තමයි මේ කතාව ගෙතෙන්නේ. බැලූ බැල්මට මෝටර් සයිකල් සමාජ ශාලාවක් වුණත්, තිරය පිටුපස මොවුන් මහා පරිමාණ නීතිවිරෝධී අවි ආයුධ ජාවාරමක නිරත වෙනවා.
​කල්ලියේ උප සභාපති වෙන තරුණ, බුද්ධිමත් Jax Teller ට තමන්ගේ මියගිය පියා ලියපු රහස් දිනපොතක් හමුවීමත් එක්ක මුළු කතාවම වෙනස් මඟකට හැරෙනවා. ක්ලබ් එකේ වර්තමාන ක්‍රියාකලාපය සහ තමන්ගේ පියාගේ සැබෑ දැක්ම අතර අතරමං වන ජැක්ස්ට, තමන්ගේ පවුල ආරක්ෂා කරගනිමින් මේ දරුණු අපරාධ ලෝකයේ කරන වැඩ ගැන තමයි කතාවේ තියෙන්නේ.🔥

නීතිය, අපරාධ කල්ලි, පොලිසිය සහ පවුල අතර මැද දෝලනය වන මේ Tv series එක, 
කුතුහලයෙන් යුතුව සිංහල substitute එක්ක  රස විදින්න.👈', '2008-01-01', 2008, 50, 8.5, ARRAY['Action','Crime','Drama','Tragedy']::TEXT[], ARRAY['Sons of Anarchy Season [X] Episode [Y]','Sons of Anarchy Sinhala Subtitles','Sons of Anarchy [X]x[Y] sub','Watch Sons of Anarchy online','SAMCRO','Jax Teller','TV Series Sinhala Sub','Sons of anarchy download','[pixelpoplk]']::TEXT[], 'Sinhala', 'USA', 'Ongoing', 7, 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-02 20:20:47.74712+00', '2026-07-02 20:20:47.74712+00') ON CONFLICT (id) DO UPDATE SET poster_path = EXCLUDED.poster_path, total_seasons = EXCLUDED.total_seasons;
INSERT INTO movies (id, title, original_title, type, description, release_date, year, runtime, imdb_rating, genres, seo_tags, language, country, status, total_seasons, poster_path, backdrop_path, created_at, updated_at) VALUES ('e4eca4e4-b362-4f1f-aa05-448470197acf', 'House Of The Dragon', 'House Of The Dragon', 'TV_SHOW', 'House of the Dragon තුන්වෙනි සීසන් එකේ තුන්වෙනි එපිසෝඩ් එකට සබ් එක තමයි මේ ගෙනාවේ. කලින් එපිසෝඩ් එකේදී ඒමොන්ඩ් වේගාර් එක්ක හැරන්හෝල් වලට ගියපු වෙලාවෙන් ප්‍රයෝජන අරගෙන, ඇලිසන්ට්ගේ සහ හෙලේනාගේ සහයෝගයත් එක්ක කිසිම කරදරයක් නැතුව රෙනයිරා King''s Landing නුවර බලය අතට ගත්තා මතකනේ. ඔටෝ හයිටවර්ට දඬුවම් දීලා Iron Throne එකේ බලය පිහිටෙව්වත්, ඒගොන්වයි ලැරිස්වයි කොටුකරගන්න බැරි වුණා. රෙනයිරාට මේ අලුත් බලය කොහොම පාලනය කරන්න වෙයිද, ඒ වගේම හැරන්හෝල් ගිය ඒමන්ඩ්ට මීලගට මොකක් වෙයිද කියලා මේ කොටසින් බලාගන්න පුළුවන්.

​මේකේ Direct sub එක පහළින්ම ඩවුන්ලෝඩ් කරගන්න පහසුකම තියෙනවා. ඒ වගේම Telegram එකෙන් 720p, 1080p සහ 4K අලුත්ම WEB-DL වීඩියෝ පිටපත් එක්කම සබ් එකත් ලේසියෙන්ම අරගෙන සිංහල උපසිරැසි එක්කම කතාව රසවිඳින්නත් පුළුවන්.

ඊලග  Episode එකත් ඉක්මනින්ම ලබාගන්න අපේ Telegram channel එකට සහ Fb page එකට join වෙලා ඉන්න යාලුවනේ. ඒවගේම ගැටලු ඇත්නම් Request  එකක් යොමු කරන්න.', '2026-01-01', 2026, 50, 8.3, ARRAY['Drama','Fantasy','Adventure','Action']::TEXT[], ARRAY['House of the Dragon Season 3 Episode 3 Sinhala Subtitle. Telegram එකෙන් 720p','1080p','4K WEB-DL පිටපත් සහ සිංහල උපසිරැසි සෘජුවම බාගත කරගන්න.','House of the Dragon S03E03 Sinhala Sub','HOTD Season 3 Episode 3 Sinhala Subtitle','House of the Dragon Telegram','HOTD S3E3 WEB-DL','Sinhala Subtitles']::TEXT[], 'Sinhala', 'USA', 'Ongoing', 3, 'https://image.tmdb.org/t/p/original/wSvDQN6tZR4VzDDZD3MUPIghVjC.jpg', 'https://image.tmdb.org/t/p/original/wSvDQN6tZR4VzDDZD3MUPIghVjC.jpg', '2026-07-05 19:07:04.212977+00', '2026-07-05 19:07:04.212977+00') ON CONFLICT (id) DO UPDATE SET poster_path = EXCLUDED.poster_path, total_seasons = EXCLUDED.total_seasons;
INSERT INTO movies (id, title, original_title, type, description, release_date, year, runtime, imdb_rating, genres, seo_tags, language, country, status, total_seasons, poster_path, backdrop_path, created_at, updated_at) VALUES ('8990c886-92d6-4bc3-a5bb-2bca8f3a9a8a', 'Backrooms 2026', 'Backrooms 2026', 'MOVIE', '🚪 The Backrooms (2026) Movie - සිංහල උපසිරැසි 🎬

අන්තර්ජාලය පුරාම ලොකු කුතුහලයක් ඇති කරපු, හැමෝම මඟබලාගෙන හිටපු අභිරහස් The Backrooms Film එක ඔන්න දැන් නරඹන්න පුළුවන්. හිතාගන්නවත් බැරි විදිහට අපේ සාමාන්‍ය ලෝකයෙන් වෙනස්ම මානයකට ඇදවැටෙන මිනිස්සු පිරිසකට මුහුණ දෙන්න වෙන සිදුවීම් දාමයක් වටා තමයි මේ කතාව ගෙතිලා තියෙන්නේ. කහ පාට බිත්ති තියෙන, නිමක් නැති හිස් කාමර ගොඩක් ඇතුළේ තනිවුණාම දැනෙන තනිකමත් එක්කම එන අමුතුම බය මේ ෆිල්ම් එක පුරාම තියෙනවා. 🚪🔦

A24 ආයතනයේ සුපිරි නිෂ්පාදනයක් විදිහට Kane Parsons ගේ අධ්‍යක්ෂණයෙන් එළිදකින මේ ෆිල්ම් එකේ කතාව ගැන වැඩිපුර මුකුත්ම නොකියා ඉන්න එක තමයි හොඳම දේ. මොකද මේක එක පාරටම බලලා ඔයාම විඳගන්න ඕනේ වෙනස්ම විදිහේ Psychological Thriller අත්දැකීමක්. 🎬 ඇත්තටම The Backrooms වල තියෙන ලොකුම අබිරහස මොකක්ද කියලා ෆිල්ම් එක බලලම දැනගමු. 🤫

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: 
කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram පිටපත්: 
වීඩියෝව සමඟ උපසිරැසි නැරඹීමට කැමති අය සඳහා 720p, 1080p උසස් තත්ත්වයේ WEB  පිටපත් සහ උපසිරැසි සියල්ලම ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2026-01-01', 2026, 120, 7, ARRAY['Horror','Sci-Fi','Thriller','Movie']::TEXT[], ARRAY['Backrooms (2026) Sinhala Subtitles | බෑක්රූම්ස් සිංහල උපසිරැසි','Backrooms (2026) අලුත්ම Sci-Fi Horror චිත්‍රපටයේ සිංහල උපසිරැසි (Sinhala Subtitles) කිසිදු බාධාවකින් තොරව දැන්ම ඩවුන්ලෝඩ් කරගන්න.','backrooms 2026 sinhala sub','backrooms sinhala subtitles','download backrooms sinhala sub','sinhala sub backrooms','backrooms movie sinhala','index','follow','article','ඔයාගේ_පෝස්ට්_එකේ_ලින්ක්_එක_මෙතනට_දෙන්න','Backrooms (2026) Sinhala Subtitles | සිංහල උපසිරැසි','A24 හි Backrooms (2026) චිත්‍රපටයේ සිංහල උපසිරැසි (Sinhala Subtitles) සමඟින් චිත්‍රපටය රසවිඳින්න. දැන්ම Download කරගන්න.','ඔයාගේ_cover_photo_එකේ_ලින්ක්_එක_මෙතනට_දෙන්න','summary_large_image']::TEXT[], 'Sinhala', 'USA', 'Released', NULL, 'https://image.tmdb.org/t/p/original/rhGx6E3qRNMgj3i5su2oukNHwIQ.jpg', 'https://image.tmdb.org/t/p/original/rhGx6E3qRNMgj3i5su2oukNHwIQ.jpg', '2026-07-14 05:32:34.672294+00', '2026-07-14 05:32:34.672294+00') ON CONFLICT (id) DO UPDATE SET poster_path = EXCLUDED.poster_path, total_seasons = EXCLUDED.total_seasons;
INSERT INTO movies (id, title, original_title, type, description, release_date, year, runtime, imdb_rating, genres, seo_tags, language, country, status, total_seasons, poster_path, backdrop_path, created_at, updated_at) VALUES ('38c02fe6-2d82-40eb-a897-a95a7b1aa343', 'The East Palace (2026)', 'The East Palace (2026)', 'TV_SHOW', 'Netflix එකෙන් ගෙනාපු අලුත්ම Horror / Dark Fantasy කතාව - The East Palace (Donggung)! 🎬🔥

Kingdom, The Guest වගේ කතාවලට ආස අයට වගේම, හොල්මන්, අද්භූත Monsters ලා ඉන්න Action Thriller කතා පිස්සුවෙන් වගේ බලන අයට මේක සුපිරි භාණ්ඩයක්. 👻⚔️

කතාව යන්නේ ජොසොන් යුගයේ අභිරහස් සාපයකට ලක්වුණු රජ මාලිගාවක් ගැන. මාලිගාවේ පොකුණක ඉන්න භයානක භූතයෙක් නිසා රජ පවුලේ කුමාරවරු එකින් එක මැරෙනවා. මේක නවත්තන්න හොල්මන් සහ යක්ෂයෝ දඩයම් කරන අකීකරු කඩුවැල්කරුවෙකුයි (Nam Joo-hyuk), මළගිය අයගේ සද්ද ඇහෙන මාලිගාවේ සේවිකාවකුයි (Roh Yoon-seo) එකතු වෙලා ගේමක් ගහනවා.
VFX, පට්ට Action සහ ලේ වැගිරීම් එහෙම උපරිමයටම තියෙනවා. ඒ වගේම මේක Nam Joo-hyuk හමුදාවෙන් ආවට පස්සෙ කරන පලවෙනි කතාව නිසා මාර Hype එකක් තියෙන්නේ.

🔥 මේකේ තවත් විශේෂ කතාවක් තියෙනවා!
මේ කතා මාලාවේ ෂූටින් කරගෙන යන අතරතුර සෙට් එකේ ලොකු ගින්නක් ඇතිවෙලා මුළු ස්ටූඩියෝ එකම විනාශ වුණා. වාසනාවකට කාටවත් අනතුරක් වුණේ නැහැ. ඒ හැම බාධකයක්ම මැදින් තමයි මේ සුපිරි නිර්මාණය ඔයාලට බලන්න ඇවිත් තියෙන්නේ!

මේ පට්ටම Horror සීරිස් එක තව සුළු මොහොතකින් අපේ Telegram Channel එක සහ Website එක හරහා සිංහල උපසිරැසි (Sinhala Sub) සමඟින්ම ඔයාලට නරඹන්න පුළුවන්! 🥳🎉', '2026-01-01', 2026, 50, 7.6, ARRAY['Horror','Dark fantasy','Historical','Thriller','Action','Mystery','Fantasy','Kdrama']::TEXT[], ARRAY['The East Palace Ep 01 Sinhala Subtitles & The East Palace Sinhala Sub. The East Palace උපසිරැසි (East Palace Sinhala Sub) Pixelpoplk Subtitles වෙතින් දැන්ම බාගත කරගන්න!']::TEXT[], 'Sinhala', 'USA', 'Ongoing', 1, 'https://image.tmdb.org/t/p/original/yfYohBszGqoAW8oM0qydOtJ4kPh.jpg', 'https://image.tmdb.org/t/p/original/yfYohBszGqoAW8oM0qydOtJ4kPh.jpg', '2026-07-18 06:07:52.262353+00', '2026-07-18 06:07:52.262353+00') ON CONFLICT (id) DO UPDATE SET poster_path = EXCLUDED.poster_path, total_seasons = EXCLUDED.total_seasons;
INSERT INTO movies (id, title, original_title, type, description, release_date, year, runtime, imdb_rating, genres, seo_tags, language, country, status, total_seasons, poster_path, backdrop_path, created_at, updated_at) VALUES ('4419eb72-7023-4654-ab76-5d1c72a1306f', 'Disclosure Day 2026', 'Disclosure Day 2026', 'MOVIE', '🎬 The Disclosure Day - සිංහල උපසිරැසි 🎬

The Disclosure Day is a high-stakes sci-fi thriller exploring the dramatic fallout of humanity''s greatest secret being exposed.
As governments struggle to maintain control, ordinary people are pushed to their limits in a race to survive the global unraveling. Featuring intense suspense and unexpected twists, this film keeps viewers hooked from the opening scene to the final climax.
Download high quality WEB-DL video files in 720p, 1080p resolution along with direct Sinhala subtitle files.
Get fast, seamless access to watch or download The Disclosure Day with official Sinhala subs on Telegram and direct servers.

🔰ලෝකයෙන් වසන් කරගෙන හිටපු ලොකුම රහසක් හෙළිවන දවස ගැන තමයි මේ ෆිල්ම් එකෙන් කියවෙන්නේ. රජයන් සහ බලවත් සංවිධාන විසින් සාමාන්‍ය ජනතාවගෙන් හංගගෙන හිටපු මේ රහස එකපාරටම ලෝකෙට එළිවෙනකොට, මුළු ලෝකයම ලොකු අවුලකට පත්වෙනවා. මේ සිදුවීම් දාමය අස්සේ ප්‍රධාන චරිත මේ තත්ත්වයට මුහුණ දෙන විදිහ සහ තමන්ගේ පවුලේ අයව ආරක්ෂා කරගන්න ගන්නා උත්සාහය කතාව පුරාම බලාගන්න පුළුවන්.👈

කතාව ගැන වැඩිය කියන්නේ නැතුව කිව්වොත්, ආරම්භයේ ඉඳන් අවසානය වෙනකම්ම කුතුහලයෙන් බලන්න පුළුවන් ත්‍රාසජනක ෆිල්ම් එකක් විදිහට මේක හඳුන්වන්න පුළුවන්.💯

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram පිටපත්: වීඩියෝව සමඟ උපසිරැසි නැරඹීමට කැමති අය සඳහා 720p, 1080p  උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් සහ උපසිරැසි සියල්ලම ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2026-01-01', 2026, 120, 6.7, ARRAY['Sci-Fi','Mystery','Thriller','Drama','Adventure']::TEXT[], ARRAY['The Disclosure Day Sinhala Subtitles','The Disclosure Day Sinhala Sub','Download The Disclosure Day Sinhala Subtitle','The Disclosure Day Telegram Download','Web-DL 1080p 720p 4K','The Disclosure Day සිංහල උපසිරැසි','The Disclosure Day Movie Sinhala Sub']::TEXT[], 'Sinhala', 'USA', 'Released', NULL, 'https://image.tmdb.org/t/p/original/3o5YPjDGDTcTDL5ftDA9NwN9dLd.jpg', 'https://image.tmdb.org/t/p/original/3o5YPjDGDTcTDL5ftDA9NwN9dLd.jpg', '2026-07-21 08:01:41.770922+00', '2026-07-21 08:01:41.770922+00') ON CONFLICT (id) DO UPDATE SET poster_path = EXCLUDED.poster_path, total_seasons = EXCLUDED.total_seasons;
INSERT INTO movies (id, title, original_title, type, description, release_date, year, runtime, imdb_rating, genres, seo_tags, language, country, status, total_seasons, poster_path, backdrop_path, created_at, updated_at) VALUES ('8a6ae59a-72f4-49b6-aa9f-60325070db02', 'Dune: Prophecy', 'Dune: Prophecy', 'TV_SHOW', '🪐 Dune: Prophecy (2024-)  සිංහල උපසිරැසි 🎬

Dune: Prophecy is a sci-fi prequel set 10,000 years before Paul Atreides, following the Harkonnen sisters as they found the legendary Bene Gesserit. Download high-quality 720p WEB-DL video files with Sinhala subtitles on Telegram and direct servers.

Frank Herbert ගේ ලෝකප්‍රකට Dune විශ්වය ඇසුරෙන් නිර්මාණය වූ Dune: Prophecy කතා මාලාව දිගහැරෙන්නේ Paul Atreides ගේ ඉපදීමට සහ Arrakis ග්‍රහලෝකයේ සිදුවීම්වලට වසර 10,000 කට පෙර අතීත කාලවකවානුවකය. මනුෂ්‍ය වර්ගයා සිතන යන්ත්‍ර සහ කෘතිම බුද්ධිය (AI) සමඟ කළ මහා යුද්ධයෙන් (Thinking Machines Crisis) පසුව, තාක්ෂණය මත යැපීම තහනම් වූ යුගයක අනාගත මනුෂ්‍ය වර්ගයාගේ පැවැත්ම තීරණය කිරීමට සිදුවන්නේ මිනිස් මනසේ සහ ශරීරයේ උපරිම ශක්තිය මතය.

මෙම අභියෝගාත්මක වටපිටාව තුළ Harkonnen වංශයේ සහෝදරියන් වන Valya Harkonnen සහ Tula Harkonnen ප්‍රධාන චරිත බවට පත්වෙයි. තම වංශයට අහිමි වූ ගෞරවය නැවත ලබාගැනීමටත්, අනාගත රාජ්‍යයන්ගේ බලතුලනය තමන්ට අවශ්‍ය පරිදි මෙහෙයවීමටත් ඔවුන් කටයුතු කරයි. එහි ප්‍රතිඵලයක් ලෙස මනුෂ්‍ය වර්ගයාගේ අනාගතය වෙනස් කළ හැකි, දේශපාලන අධිරාජ්‍යයන් පවා පිටුපස සිට පාලනය කරන Bene Gesserit නම් අද්භූත සහ අතිශය බලවත් සහෝදරත්වය (Sisterhood) ආරම්භ වේ.

විශාල අධිරාජ්‍යයන් අතර පවතින රහසිගත සටන්, රාජකීය කුමන්ත්‍රණ, ආගමික සහ දාර්ශනික මතවාද මෙන්ම අභිරහස් අඳුරු බලවේගයන්ගෙන් පිරුණු මෙම නිර්මාණය Dune කතා මාලාවේ මූලාරම්භය ඉතා ගැඹුරින් හෙළි කරයි. Sci-Fi, Drama සහ Political Thriller ගණයට අයත් මෙම කතා මාලාව උසස්ම මට්ටමේ visual effects සහ පාලුවකින් තොරව එකදිගට නැරඹිය හැකි විශිෂ්ට කතා තේමාවකින් සමන්විත වේ.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:
📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.
✈️ Telegram පිටපත්: වීඩියෝව සමඟ උපසිරැසි නැරඹීමට කැමති අය සඳහා 720p WEB-DL වීඩියෝ පිටපත් සහ උපසිරැසි සියල්ලම ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2024-01-01', 2024, 50, 7.3, ARRAY['Fantasy','Action','Political','Philosophical','Drama','Sci-Fi']::TEXT[], ARRAY['Dune Prophecy Season 1 Episode 1','Dune Prophecy Sinhala Subtitles','Dune Prophecy S01E01 Sinhala Sub','Dune Prophecy 1x1 sub','Bene Gesserit','Valya Harkonnen','Dune prequel Sinhala Sub','pixelpoplk','Dune Prophecy Season 1 Episode 1 Sinhala Subtitles. Download Dune Prophecy S01E01 Sinhala Sub online from pixelpoplk.']::TEXT[], 'Sinhala', 'USA', 'Ongoing', 1, 'https://image.tmdb.org/t/p/original/5B8Cxz8ZZXp3w2WmmdKTXpkS24e.jpg', 'https://image.tmdb.org/t/p/original/5B8Cxz8ZZXp3w2WmmdKTXpkS24e.jpg', '2026-07-21 11:40:57.426392+00', '2026-07-21 11:40:57.426392+00') ON CONFLICT (id) DO UPDATE SET poster_path = EXCLUDED.poster_path, total_seasons = EXCLUDED.total_seasons;
INSERT INTO movies (id, title, original_title, type, description, release_date, year, runtime, imdb_rating, genres, seo_tags, language, country, status, total_seasons, poster_path, backdrop_path, created_at, updated_at) VALUES ('a6eb09ea-0a4e-4a2e-a5df-9f7214592ab2', 'Colony 2026', 'Colony 2026', 'MOVIE', '🎬 Colony (2026) - සිංහල උපසිරැසි 🎬

Colony is a 2026 Korean action horror thriller directed by Yeon Sang-ho (Train to Busan), starring Jun Ji-hyun, Koo Kyo-hwan, and Ji Chang-wook. Download high-quality 720p, 1080p, and 4K WEB-DL video files with Sinhala subtitles on Telegram and direct servers.

Train to Busan, Peninsula වැනි ලෝකප්‍රකට Horror නිර්මාණ ගෙන ආ Yeon Sang-ho අධ්‍යක්ෂවරයාගේ අලුත්ම දකුණු කොරියානු Action Horror Thriller චිත්‍රපටය වන Colony (2026) මුළු ලෝකයේම දැඩි අවධානයක් දිනාගත් නිර්මාණයකි. 

කතාව ආරම්භ වන්නේ ජෛව තාක්ෂණික (Biotech) සමුළුවක් අතරතුර සිදුවන නොසිතූ තාක්ෂණික සහ වෛරස් කාන්දුවක් මුල් කරගනිමින්. මෙම අතිශය භයානක වෛරසය පැතිරී යාමත් සමඟම බලධාරීන් විසින් සමුළුව පැවැත්වෙන මුළු ගොඩනැගිල්ලම පිටතින් සම්පූර්ණයෙන්ම වසා දමනු ලබනවා. එහි ඇතුළත සිරවෙන Se-jeong (Jun Ji-hyun) ඇතුළු පිරිසට මුහුණ දීමට සිදුවන්නේ සාමාන්‍ය වෛරස් ආසාදිතයන්ට නෙමෙයි. තත්පරයෙන් තත්පරය ශරීර වෙනස්කම්වලට ලක්වෙමින්, එකිනෙකා අතර සන්නිවේදනය කරමින් සංවිධානාත්මකව ප්‍රහාර එල්ල කරන අතිශය බුද්ධිමත් සහ භයානක ආසාදිතයන් පිරිසකටයි.

පිටතට යාමට කිසිදු මාර්ගයක් නොමැතිව, හුදකලා වූ ගොඩනැගිල්ල තුළ සිරවී තමන්ගේ ජීවිත බේරාගැනීමට කරන අතිශය ත්‍රාසජනක සටන සහ නොසිතන මොහොතක සිදුවන සිදුවීම් සමුදායක් මෙම චිත්‍රපටය පුරාම බලාගන්න පුළුවන්. Horror, Sci-Fi සහ Thriller ගණයට අයත් මෙම චිත්‍රපටය ආරම්භයේ සිට අවසානය දක්වාම කුතුහලයෙන් සහ භීතියෙන් පිරුණු විශිෂ්ට සිනමා අත්දැකීමක් ලබාදෙයි.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

🔰Link එක click කරලා තප්පර 5ක් විතර හිටියම Auto download වෙනවා. Auto Download උනේ නැත්නම්  කොලපාටින් popup වෙන download button එක ඔබන්න.

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව සෘජුවම බාගත කරගත හැක.

✈️ Telegram පිටපත්: 720p, 1080p උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2026-01-01', 2026, 120, 6.9, ARRAY['Movie','Horror','Action','Triller']::TEXT[], ARRAY['Colony 2026 Sinhala Subtitles','Colony 2026 sinhala sub','Colony movie sinhala sub','Colony sinhala subtitle download','Colony 2026 sinhala sub pixelpoplk','Colony sinhala sub pixelpop.lk','pixelpoplk colony 2026','කොලනි 2026 සිංහල උපසිරැසි','Colony korean movie sinhala sub','Colony 2026 full movie sinhala subtitles download','Colony 2026 sinhala sub web-dl','Ji Chang-wook Colony movie sinhala subtitle','Yeon Sang-ho Colony movie sinhala sub','pixelpoplk sinhala subtitles','කොලනි ෆිල්ම් එකේ සිංහල සබ්']::TEXT[], 'Sinhala', 'USA', 'Released', NULL, 'https://m.media-amazon.com/images/M/MV5BMDgwNzhmMjItMDhlYi00ODdlLWI1NjUtZDgxZGMzMGU5MmM4XkEyXkFqcGc@._V1_.jpg', 'https://m.media-amazon.com/images/M/MV5BMDgwNzhmMjItMDhlYi00ODdlLWI1NjUtZDgxZGMzMGU5MmM4XkEyXkFqcGc@._V1_.jpg', '2026-07-23 19:35:18.298072+00', '2026-07-23 19:35:18.298072+00') ON CONFLICT (id) DO UPDATE SET poster_path = EXCLUDED.poster_path, total_seasons = EXCLUDED.total_seasons;
INSERT INTO movies (id, title, original_title, type, description, release_date, year, runtime, imdb_rating, genres, seo_tags, language, country, status, total_seasons, poster_path, backdrop_path, created_at, updated_at) VALUES ('4b94c16b-3dfb-40d2-a0a3-587c25306447', 'Anomie 2026', 'Anomie 2026', 'MOVIE', '🎬 Anomie: The Equation of Death (2026) - සිංහල උපසිරැසි 🎬

Anomie (2026) is a highly anticipated Malayalam psychological sci-fi thriller directed by Riyas Marath, starring Bhavana and Rahman in lead roles. Download high-quality 720p, 1080p  WEB-DL video files with Sinhala subtitles via direct links and Telegram.

මෑත කාලයේ මලයාලම් සිනමාවේ බිහිවූ වෙනස්ම ආකාරයේ Sci-Fi / Psychological Thriller අත්දැකීමක් වන Anomie: The Equation of Death (2026) චිත්‍රපටය මේ වන විට ප්‍රේක්ෂකයන් අතර දැඩි කතාබහකට ලක්වෙලා තියෙනවා. Riyas Marath ගේ අධ්‍යක්ෂණයෙන් හැඩවුණු මෙහි ප්‍රධාන චරිත නිරූපණය කරන්නේ අති දක්ෂ නිළි Bhavana සහ ජනප්‍රිය නළු Rahman විසිනි.

කතාව ගෙතෙන්නේ දක්ෂ අධිකරණ වෛද්‍ය විශේෂඥවරියක් (Forensic Expert) වන Zara Philip (Bhavana) වටායි. තමන්ගේ අතීත මානසික කම්පනයකින් පෙළෙන ඇගේ සහෝදරයා හදිසියේම අතුරුදහන් වෙනවා. කිසිදු පොලිස් සහයක් නිසි ලෙස නොලැබෙන තැන, ඔහුව සෙවීමේ මෙහෙයුම ඇය තනිවම ආරම්භ කරනවා. එහිදී ඇයට සොයාගන්න ලැබෙන්නේ, තම සහෝදරයාට සමාන මානසික මට්ටම් ඇති තවත් කිහිපදෙනෙකුම මේ ආකාරයෙන්ම අතුරුදහන් වී ඇති බවට සැකකටයුතු හෝඩුවාවන් රැසක්. 

මේ අතරතුර, තම අතීත වැරදීම් නිසා කම්පනයට පත්ව සිටින පොලිස් නිලධාරී Jibran (Rahman) ද මෙම අභිරහස පසුපස හඹා යාම ආරම්භ කරනවා. ඔවුන් දෙදෙනාගේම පරීක්ෂණ එකිනෙක ගැටෙද්දී, මේ සියල්ල පිටුපස සිටින අතිශය බුද්ධිමත්, තමන් කරන්නේ වරදක් යැයි කිසිසේත්ම විශ්වාස නොකරන මනෝව්‍යාධිකයෙකුගේ (Psychopath) බිහිසුණු සැලසුමක් හෙළිවෙන්න ගන්නවා. 

විද්‍යාව, අපරාධ සහ මනෝවිද්‍යාව (Sci-Fi & Psychology) එකට කැටිවූ මෙම චිත්‍රපටය, කුතුහලය උපරිමයෙන් රඳවාගෙන අවසානය දක්වාම එක හුස්මට නැරඹිය හැකි විශිෂ්ට නිර්මාණයක්!

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

🔰Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

👉වීඩියෝ ගොනු බාගත කිරීම: Link එක click කර තත්පර 5ක් පමණ රැඳී සිටින්න, එවිට Auto download වීම ආරම්භ වේ. Auto Download වූයේ නැත්නම් කොළ පැහැයෙන් pop-up වන "Download" button එක click කරන්න.

👉 Telegram පිටපත්: 720p, 1080 උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් අපගේ ටෙලිග්‍රෑම් චැනලය හරහා පහසුවෙන් ලබාගත හැක.', '2026-01-01', 2026, 120, 7.9, ARRAY['Movie','Thriller','Crime','Mystery','Sci-Fi']::TEXT[], ARRAY['Anomie 2026 Sinhala Subtitles','Anomie 2026 sinhala sub','Anomie movie sinhala sub','Anomie sinhala subtitle download','Anomie 2026 sinhala sub pixelpoplk','Anomie sinhala sub pixelpop.lk','pixelpoplk anomie 2026','ඇනෝමි 2026 සිංහල උපසිරැසි','Anomie malayalam movie sinhala sub','Anomie 2026 full movie sinhala subtitles download','Anomie 2026 sinhala sub web-dl','Bhavana Anomie movie sinhala subtitle','Rahman Anomie movie sinhala subtitle','Riyas Marath Anomie movie sinhala sub','pixelpoplk sinhala subtitles','ඇනෝමි ෆිල්ම් එකේ සිංහල සබ්']::TEXT[], 'Sinhala', 'USA', 'Released', NULL, 'https://image.tmdb.org/t/p/original/p9czhWmPhyMFp8eHNYO34Z9hOGA.jpg', 'https://image.tmdb.org/t/p/original/p9czhWmPhyMFp8eHNYO34Z9hOGA.jpg', '2026-07-24 12:04:54.624116+00', '2026-07-24 12:04:54.624116+00') ON CONFLICT (id) DO UPDATE SET poster_path = EXCLUDED.poster_path, total_seasons = EXCLUDED.total_seasons;
INSERT INTO movies (id, title, original_title, type, description, release_date, year, runtime, imdb_rating, genres, seo_tags, language, country, status, total_seasons, poster_path, backdrop_path, created_at, updated_at) VALUES ('97dc5ae0-49c8-4620-aa67-4b78022b9e44', '72 Hours (2026)', '72 Hours (2026)', 'MOVIE', '🎬 72 Hours (2026) - සිංහල උපසිරැසි 🎬

72 Hours (2026) is a hilarious new comedy movie packed with non-stop laughs, crazy situations, and a chaotic ticking-clock adventure. Download high-quality 720p, 1080p  WEB-DL video files with Sinhala subtitles on Telegram and direct servers.

72 Hours (2026) කියන්නේ මුල ඉඳන් අගටම හිනා වෙලා පණ යන මට්ටමේ සුපිරි Comedy සිනමා නිර්මාණයක්. කතාව ගෙතෙන්නේ ප්‍රධාන චරිතයට සහ ඔහුගේ යාළුවන්ට අහම්බෙන් මුහුණ දෙන්න වෙන මාරක වගේම අතිශය විහිළු සහගත සිදුවීම් දාමයක් වටායි. 

තමන් අතින් වුණු ලොකු අත්වැරැද්දක් නිවැරදි කරගන්න, එහෙමත් නැත්නම් ජීවිතේ ලැබුණු ලොකුම අවස්ථාවක් බේරගන්න මේ යාලුවෝ සෙට් එකට ලැබෙන්නේ හරියටම පැය 72ක සීමිත කාලයක් විතරයි. මේ දවස් තුන ඇතුළත එයාලා කරන පිස්සු වැඩ, මුණගැහෙන අමුතුම විදිහේ චරිත සහ කිසිසේත්ම බලාපොරොත්තු නොවන සිදුවීම් නිසා චිත්‍රපටිය පුරාම කිසිම කම්මැලිකමක් නැතුව හිනාවෙවී බලන්න පුළුවන්. 

හුස්ම ගන්නවත් වෙලාවක් නැති තරමට එක දිගට සිදුවෙන විහිළු සහගත සිදුවීම් එක්ක ගලාගෙන යන මේ ෆිල්ම් එක Comedy නිර්මාණවලට කැමති අයට නිදහසේ විනෝදයෙන් බලන්න කියාපු ෆිල්ම් එකක් විදිහට හඳුන්වන්න පුළුවන්.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව සෘජුවම බාගත කරගත හැක.

✈️ Telegram පිටපත්: 720p, 1080p  උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් සහ උපසිරැසි සියල්ලම ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2026-01-01', 2026, 120, 6.1, ARRAY['Movie','Comedy','18+']::TEXT[], ARRAY['72 Hours 2026 Sinhala Subtitles','72 Hours 2026 sinhala sub','72 Hours movie sinhala sub','72 Hours sinhala subtitle download','72 Hours 2026 sinhala sub pixelpoplk','72 Hours sinhala sub pixelpop.lk','pixelpoplk 72 hours 2026','72 Hours 2026 සිංහල උපසිරැසි','72 Hours comedy movie sinhala sub','72 Hours 2026 full movie sinhala subtitles download','72 Hours 2026 sinhala sub web-dl','pixelpoplk sinhala subtitles','72 Hours ෆිල්ම් එකේ සිංහල සබ්']::TEXT[], 'Sinhala', 'USA', 'Released', NULL, 'https://image.tmdb.org/t/p/original/9Bu1PW2R1XayqRqnl0aDOgMcrdS.jpg', 'https://image.tmdb.org/t/p/original/9Bu1PW2R1XayqRqnl0aDOgMcrdS.jpg', '2026-07-26 08:15:56.089476+00', '2026-07-26 08:15:56.089476+00') ON CONFLICT (id) DO UPDATE SET poster_path = EXCLUDED.poster_path, total_seasons = EXCLUDED.total_seasons;
INSERT INTO movies (id, title, original_title, type, description, release_date, year, runtime, imdb_rating, genres, seo_tags, language, country, status, total_seasons, poster_path, backdrop_path, created_at, updated_at) VALUES ('e6ca7b18-48c7-4684-a073-e0da1e5ac586', 'The Walking Dead: Dead City', 'The Walking Dead: Dead City', 'TV_SHOW', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිටින්න Auto download උනේ නැත්නම්, Back උනාම කොලපාට  download button එකක් එයි.

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් Movie  එක්හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2023-01-01', 2023, 50, 7, ARRAY['Survival','Horror','Zombie','Drama']::TEXT[], ARRAY['Walking dead dead city sinhala sub','dead city sinhala sub','The walking dead']::TEXT[], 'Sinhala', 'USA', 'Ongoing', 3, 'https://image.tmdb.org/t/p/original/seYokxOjFyTVX13XgD2FNjWIry8.jpg', 'https://image.tmdb.org/t/p/original/seYokxOjFyTVX13XgD2FNjWIry8.jpg', '2026-07-26 09:14:46.57961+00', '2026-07-26 09:14:46.57961+00') ON CONFLICT (id) DO UPDATE SET poster_path = EXCLUDED.poster_path, total_seasons = EXCLUDED.total_seasons;
INSERT INTO movies (id, title, original_title, type, description, release_date, year, runtime, imdb_rating, genres, seo_tags, language, country, status, total_seasons, poster_path, backdrop_path, created_at, updated_at) VALUES ('1dfeef95-9101-40ab-ace3-f15fe887772a', 'Supergirl (2026)', 'Supergirl (2026)', 'MOVIE', '🦸‍♀️ Supergirl: Woman of Tomorrow (2026) - සිංහල උපසිරැසි 🎬

Supergirl: Woman of Tomorrow (2026) marks a bold new chapter in James Gunn''s revamped DC Universe. Starring Milly Alcock as Kara Zor-El, this sci-fi epic takes fans on an emotional and action-packed journey across the galaxy. Download high-quality 720p, 1080p WEB-DL video files with Sinhala subtitles directly or via Telegram. Get ready to experience the next massive DCU blockbuster.

Supergirl: Woman of Tomorrow (2026) චිත්‍රපටය කියන්නේ අලුත් DC Universe එකේ James Gunn ගේ මූලිකත්වයෙන් එළියට එන දැවැන්තම නිර්මාණයක්. මේක සාමාන්‍ය සුපර්හීරෝ කතාවකට වඩා සම්පූර්ණයෙන්ම වෙනස්, මන්දාකිණිය හරහා යන දැවැන්ත sci-fi ගමනක් විදිහටයි නිර්මාණය වෙලා තියෙන්නේ. Tom King ගේ ජනප්‍රිය කොමික් පොත් මාලාව පාදක කරගෙන තමයි මේ චිත්‍රපටය හැදිලා තියෙන්නේ.

කතාවේ කිසිම දෙයක් spoil කරන්නේ නැතුව කිව්වොත්, මේකෙන් පෙන්නන්නේ Superman සහ Supergirl (Kara Zor-El) අතර තියෙන ලොකු වෙනස. Superman පෘථිවියට ඇවිත් ආදරණීය පවුලක් එක්ක හැදෙනකොට, Kara ට සිද්ධ වෙන්නේ විනාශ වෙච්ච Krypton ග්‍රහලෝකයේ ඉතුරු වෙච්ච කෑල්ලක අවුරුදු 14ක් තිස්සේ මරණය සහ වේදනාව මැද්දේ තනියම ජීවත් වෙන්න. ඒ නිසා අපි මේ චිත්‍රපටයෙන් දකින්නේ අපි කලින් දැකපු අහිංසක Supergirl නෙවෙයි, ඊට වඩා ගොඩක් රළු, දරුණු අත්දැකීම් වලට මුහුණ දීපු ශක්තිමත් කෙනෙක්. 

House of the Dragon කතා මාලාවෙන් අපි දැකපු දක්ෂ නිළි Milly Alcock තමයි මෙහි Supergirl ගේ චරිතයට පණ පොවන්නේ. ඒ වගේම Krypto කියන සුපර් බල්ලා (Superdog) වගේ අලුත් චරිතත් එක්ක එකතු වෙන මේ චිත්‍රපටය, කිසිම කම්මැලිකමක් නැතුව බලන්න පුළුවන්, DC රසිකයින්ට වෙනස්ම අත්දැකීමක් දෙන එකක් බව අනිවාර්යයි.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p, 1080p උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් Telegram චැනලය හරහා ලබාගත හැක.', '2026-01-01', 2026, 120, 6.2, ARRAY['Movie','Action','Adventure','Sci-Fi','Superhero']::TEXT[], ARRAY['Supergirl Woman of Tomorrow 2026 Sinhala Subtitles','Supergirl 2026 sinhala sub','Supergirl Woman of Tomorrow sinhala subtitle download','Supergirl 2026 sinhala sub pixelpoplk','Supergirl 2026 sinhala sub pixelpop.lk','pixelpoplk DC movies','සුපර්ගර්ල් සිංහල උපසිරැසි','Supergirl 2026 full movie sinhala subtitles download','Supergirl 2026 sinhala sub web-dl','pixelpoplk sinhala subtitles','DCU Supergirl movie sinhala sub']::TEXT[], 'Sinhala', 'USA', 'Released', NULL, 'https://image.tmdb.org/t/p/original/xhei2GX9L2H1eQlrHeFw44VNLd1.jpg', 'https://image.tmdb.org/t/p/original/xhei2GX9L2H1eQlrHeFw44VNLd1.jpg', '2026-07-27 06:46:17.212937+00', '2026-07-27 06:46:17.212937+00') ON CONFLICT (id) DO UPDATE SET poster_path = EXCLUDED.poster_path, total_seasons = EXCLUDED.total_seasons;
INSERT INTO movies (id, title, original_title, type, description, release_date, year, runtime, imdb_rating, genres, seo_tags, language, country, status, total_seasons, poster_path, backdrop_path, created_at, updated_at) VALUES ('34044c4a-ae0d-4b36-ac01-6a2be3df5795', 'The Sopranos', 'The Sopranos', 'TV_SHOW', '🔫 The Sopranos - සිංහල උපසිරැසි 🎬

The Sopranos is widely considered one of the greatest television series of all time. Dive into the complex life of Tony Soprano, a New Jersey mob boss balancing his ruthless mafia family with his actual family. Download high-quality 720p, 1080p, and 4K WEB-DL video files with Sinhala subtitles directly or via Telegram. Experience the masterpiece that changed modern television forever.

ලෝකයේ බිහිවුණු විශිෂ්ටතම රූපවාහිනී කතා මාලාවන්ගෙන් එකක් විදිහට හැඳින්වෙන The Sopranos තමයි මේ අරගෙන එන්නේ. New Jersey වල මාෆියා නායකයෙක් වෙන Tony Soprano ගේ ජීවිතය වටා තමයි මේ කතාව ගෙතිලා තියෙන්නේ. තමන්ගේ අපරාධ ජාලය මෙහෙයවන එකයි, පවුලේ ප්‍රශ්න විසඳන එකයි අතරේ ඔහු කොහොමද සමබරතාවය තියාගන්නේ කියන එක මේකෙන් ගොඩක් තාත්විකව පෙන්නනවා.

සාමාන්‍ය මාෆියා කතාවකට වඩා මේක ගොඩක් වෙනස් වෙන්නේ, Tony Soprano මුහුණ දෙන මානසික ආතතිය සහ ඒ නිසා ඔහු මනෝ වෛද්‍යවරයෙක් මුණගැහෙන්න යන සිදුවීම් නිසා. Action, Crime කතා වලට වගේම, ටිකක් ගැඹුරු කතා තේමාවන් වලට කැමති අයට කිසිම කම්මැලිකමක් නැතුව බලන්න පුළුවන් සුපිරිම කතා මාලාවක් තමයි මේක. HBO නාලිකාවෙන් විකාශය වුණු මේ කතාව, අදටත් රූපවාහිනී කලාවේ දැවැන්තම සන්ධිස්ථානයක් විදිහට සැලකෙනවා. 

🔰🔰🔰මෙම උපසිරැසි  bluray පිටපත් වලට පමනක් ගැලපේ.🔰🔰🔰🔰

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව බාගත කරගත හැක.

✈️ Telegram Download: 720p, 1080p උසස් තත්ත්වයේ Bluray වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '1997-01-01', 1997, 50, 9.2, ARRAY['Action','Crime','Drama']::TEXT[], ARRAY['The Sopranos Sinhala Subtitles','The Sopranos sinhala sub','The Sopranos sinhala subtitle download','The Sopranos tv series sinhala sub pixelpoplk','The Sopranos sinhala sub pixelpop.lk','pixelpoplk HBO series','ද සොප්‍රානොස් සිංහල උපසිරැසි','The Sopranos full series sinhala subtitles download','The Sopranos sinhala sub web-dl','pixelpoplk sinhala subtitles','The Sopranos කතා මාලාවේ සිංහල සබ්']::TEXT[], 'Sinhala', 'USA', 'Ongoing', 4, 'https://image.tmdb.org/t/p/original/rTc7ZXdroqjkKivFPvCPX0Ru7uw.jpg', 'https://image.tmdb.org/t/p/original/rTc7ZXdroqjkKivFPvCPX0Ru7uw.jpg', '2026-07-28 16:58:59.501453+00', '2026-07-28 16:58:59.501453+00') ON CONFLICT (id) DO UPDATE SET poster_path = EXCLUDED.poster_path, total_seasons = EXCLUDED.total_seasons;
INSERT INTO movies (id, title, original_title, type, description, release_date, year, runtime, imdb_rating, genres, seo_tags, language, country, status, total_seasons, poster_path, backdrop_path, created_at, updated_at) VALUES ('60c54a53-ba5f-4932-ae6a-e0f88f89b0d8', 'Demon Slayer - Infinity Castle 2025', 'Demon Slayer - Infinity Castle 2025', 'MOVIE', '⚔️ Demon Slayer: Infinity Castle (2025) - සිංහල උපසිරැසි 🎬

Demon Slayer: Kimetsu no Yaiba - Infinity Castle (2025) brings the epic final battle to the screen. Join Tanjiro, the Hashira, and the Demon Slayer Corps as they enter Muzan''s deadly labyrinth for the ultimate showdown. Download high-quality 720p, 1080p, and 4K WEB-DL video files with Sinhala subtitles directly or via Telegram. Experience the breathtaking animation and action of this highly anticipated anime masterpiece.

ලෝකයේම ආදරය දිනාගත්ත Demon Slayer ඇනිමේ කතා මාලාවේ අවසාන මහා සටන, ඒ කියන්නේ "Infinity Castle Arc" එක තමයි මේ විදිහට චිත්‍රපටයක් විදිහට 2025 අවුරුද්දේ එළියට එන්නේ. පසුගිය Hashira Training Arc එක අවසානයේදී Muzan Kibutsuji විසින් තමන්ගේ අපරාධ මූලස්ථානය වෙන Infinity Castle එක ඇතුළට හැමෝවම ඇදලා දාපු තැනින් තමයි මේ කතාව පටන් ගන්නේ.

කතාව ස්පොයිල් කරන්නේ නැතුව කිව්වොත්, තමන්ගේ උපරිම ශක්තිය පාවිච්චි කරලා Tanjiro ඇතුළු Hashira වරුන්ට සිද්ධ වෙනවා Muzan වගේම ඉතුරු වෙලා ඉන්න අති දරුණු Upper-Rank යක්ෂයින් (Akaza, Doma, Kokushibo) එක්ක ජීවිතයත් මරණයත් අතර සටනකට මුහුණ දෙන්න. ඇනිමේෂන් අතින් උපරිම තත්ත්වයේ තියෙන, ඇඟේ හිරිගඩු පිපෙන Action සීන් වලින් පිරිලා තියෙන මේ ෆිල්ම් එක Demon Slayer බලන හැමෝම අනිවාර්යයෙන්ම බලන්න ඕනේ සුපිරිම නිර්මාණයක්. 

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p, 1080p උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2025-01-01', 2025, 120, 8.4, ARRAY['Action','Anime','Movie','Japanese']::TEXT[], ARRAY['Demon Slayer Infinity Castle 2025 Sinhala Subtitles','Demon Slayer 2025 sinhala sub','Kimetsu no Yaiba Infinity Castle sinhala subtitle download','Demon Slayer movie sinhala sub pixelpoplk','Demon Slayer sinhala sub pixelpop.lk','pixelpoplk anime movies','ඩිමන් ස්ලේයර් සිංහල උපසිරැසි','Demon Slayer 2025 full movie sinhala subtitles download','Demon Slayer Infinity Castle sinhala sub web-dl','pixelpoplk sinhala subtitles','Demon Slayer ඇනිමේ සිංහල සබ්','Japan','Japanese','Japan Anime']::TEXT[], 'Sinhala', 'USA', 'Released', NULL, 'https://image.tmdb.org/t/p/original/sUsVimPdA1l162FvdBIlmKBlWHx.jpg', 'https://image.tmdb.org/t/p/original/sUsVimPdA1l162FvdBIlmKBlWHx.jpg', '2026-07-28 20:01:07.145515+00', '2026-07-28 20:01:07.145515+00') ON CONFLICT (id) DO UPDATE SET poster_path = EXCLUDED.poster_path, total_seasons = EXCLUDED.total_seasons;
INSERT INTO movies (id, title, original_title, type, description, release_date, year, runtime, imdb_rating, genres, seo_tags, language, country, status, total_seasons, poster_path, backdrop_path, created_at, updated_at) VALUES ('a0fe85f4-925d-4476-adb9-a37da947b1c4', 'Spider-Man: Brand New Day (2026)', 'Spider-Man: Brand New Day (2026)', 'MOVIE', 'Spider Man brand New day Cam copy එකක්. කැමති අය බලන්න. අඩුම තරමේ Digital release උනාම බලන්න.', '2026-01-01', 2026, 120, 8.5, ARRAY['Movie','Action']::TEXT[], ARRAY['Spider man brand new day','spider','spider man','spiderman','Marval','spider man brandnew day download']::TEXT[], 'Sinhala', 'USA', 'Released', NULL, 'https://image.tmdb.org/t/p/original/iPOn6DinuVyLY17YM9mKuPofV08.jpg', 'https://image.tmdb.org/t/p/original/iPOn6DinuVyLY17YM9mKuPofV08.jpg', '2026-07-30 10:11:12.178415+00', '2026-07-30 10:11:12.178415+00') ON CONFLICT (id) DO UPDATE SET poster_path = EXCLUDED.poster_path, total_seasons = EXCLUDED.total_seasons;
INSERT INTO movies (id, title, original_title, type, description, release_date, year, runtime, imdb_rating, genres, seo_tags, language, country, status, total_seasons, poster_path, backdrop_path, created_at, updated_at) VALUES ('34933997-ea4a-4210-ad5d-fde3f6bcc8a0', 'Batman: Caped Crusader', 'Batman: Caped Crusader', 'TV_SHOW', '🦇 Batman: Caped Crusader - සිංහල උපසිරැසි 🎬

Batman: Caped Crusader brings a dark, noir-inspired take on the Dark Knight''s early days in Gotham City. Produced by Bruce Timm, Matt Reeves, and J.J. Abrams, this animated series is a must-watch for DC fans. Download high-quality 720p WEB-DL video files with Sinhala subtitles directly or via Telegram. Experience the ultimate psychological and action-packed detective story.

Batman: Caped Crusader කියන්නේ DC රසිකයින්ට ලැබුණු අලුත්ම සහ වෙනස්ම විදිහේ ඇනිමේටඩ් කතා මාලාවක්. සුප්‍රසිද්ධ Batman: The Animated Series එක හදපු Bruce Timm වගේම The Batman චිත්‍රපටය අධ්‍යක්ෂණය කරපු Matt Reeves ගේ සහ J.J. Abrams ගේ එකතුවෙන් තමයි මේක නිර්මාණය වෙලා තියෙන්නේ. ඒ නිසාම මේකට ලොකු ප්‍රේක්ෂක ආකර්ෂණයක් ලැබිලා තියෙනවා.

කතාව යන්නේ 1940 දශකයේ අඳුරු Gotham නගරයේ. ගොඩක් දියුණු තාක්ෂණයන් නැති, දූෂණය සහ අපරාධ වලින් පිරිච්ච නගරයක Bruce Wayne තමන්ගේ මුල්ම කාලයේ Batman විදිහට අපරාධකරුවන්ට විරුද්ධව සටන් කරන හැටි තමයි මේකෙන් පෙන්නන්නේ. මේ කතාවේ ඉන්න Batman ටිකක් රළුයි වගේම, අපි දන්න Catwoman, Harley Quinn, Two-Face සහ Penguin වගේ අනිත් චරිතත් මේ කතාවේදී සම්පූර්ණයෙන්ම අලුත් වගේම වෙනස්ම විදිහකට තමයි නිර්මාණය කරලා තියෙන්නේ.

DC කොමික් පොත් වල තිබුණු මුල්ම කාලයේ අඳුරු Noir ගතියට සහ රහස් පරීක්ෂක (Detective) කතා වලට කැමති අයට කිසිම කම්මැලිකමක් නැතුව බලන්න පුළුවන් සුපිරිම කතා මාලාවක් තමයි මේක.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:
📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් Telegram චැනලය හරහා ලබාගත හැක.', '2024-01-01', 2024, 50, 7.2, ARRAY['Animation','Action','Adventure','Crime','Drama','Mystery','Sci-Fi']::TEXT[], ARRAY['Batman Caped Crusader Season 1 Episode 1 Sinhala Subtitles','Batman Caped Crusader S01E01 Sinhala Sub','Batman Caped Crusader 1x1 sub','Batman Caped Crusader sinhala sub','Batman Caped Crusader sinhala subtitle download','Batman Caped Crusader series sinhala sub pixelpoplk','Batman Caped Crusader sinhala sub pixelpop.lk','pixelpoplk DC series','බැට්මෑන් සිංහල උපසිරැසි','Batman Caped Crusader full series sinhala subtitles download','Batman Caped Crusader sinhala sub web-dl','pixelpoplk sinhala subtitles','Batman Caped Crusader ඇනිමේෂන් සිංහල සබ්','Batman Caped Crusader Season 1 Episode 1 Sinhala Subtitles. Download Batman Caped Crusader S01E01 Sinhala Sub online from pixelpoplk.']::TEXT[], 'Sinhala', 'USA', 'Ongoing', 1, 'https://image.tmdb.org/t/p/original/tJ7zq4VtvJqUyaRsLeNjpEFDXzk.jpg', 'https://image.tmdb.org/t/p/original/tJ7zq4VtvJqUyaRsLeNjpEFDXzk.jpg', '2026-07-31 09:09:26.160221+00', '2026-07-31 09:09:26.160221+00') ON CONFLICT (id) DO UPDATE SET poster_path = EXCLUDED.poster_path, total_seasons = EXCLUDED.total_seasons;
INSERT INTO movies (id, title, original_title, type, description, release_date, year, runtime, imdb_rating, genres, seo_tags, language, country, status, total_seasons, poster_path, backdrop_path, created_at, updated_at) VALUES ('e38e1231-d3a8-489f-ac3e-7b7ae6832722', 'Soulm8te', 'Soulm8te', 'MOVIE', '🤖 Soulm8te (2026) - සිංහල උපසිරැසි 🎬

Soulm8te (2026) expands the M3GAN universe with a thrilling new sci-fi horror experience. When a grieving man acquires an AI android to cope with his loss, his attempt to create a truly sentient partner turns a harmless lovebot into a deadly companion. Download high-quality 720p, 1080p, and 4K WEB-DL video files with Sinhala subtitles directly or via Telegram. Experience the terrifying new Blumhouse and Atomic Monster spin-off.

M3GAN චිත්‍රපටයේ විශ්වයට (M3GAN Universe) සම්බන්ධ අලුත්ම චිත්‍රපටය විදිහට තමයි Soulm8te (2026) එළියට එන්නේ. සුප්‍රසිද්ධ Blumhouse සහ Atomic Monster ආයතන වල එකතුවෙන් නිර්මාණය වුණු මේක Sci-fi Horror ගණයට අයිති වෙන වෙනස්ම විදිහේ කතාවක්.

කතාව ගැන කිව්වොත්, තමන්ගේ බිරිඳගේ මරණයෙන් පස්සේ මානසිකව වැටිලා ඉන්න කෙනෙක් තමන්ගේ පාළුව මකාගන්න AI (කෘත්‍රිම බුද්ධිය) තියෙන ඇන්ඩ්‍රොයිඩ් රොබෝ කෙනෙක්ව අරගෙන එනවා. එයාට ඕනේ කරන්නේ මේ රොබෝව නිකම්ම යන්ත්‍රයක් විදිහට නැතුව හැඟීම් දැනීම් තියෙන සහකාරියක් විදිහට වෙනස් කරන්න. හැබැයි මේ උත්සාහය නිසා අන්තිමට ඒ අහිංසක රොබෝ භයානක කෙනෙක් බවට පත් වෙනවා. තාක්ෂණයත් එක්ක මනුස්ස හැඟීම් පැටලුණාම වෙන භයානක ප්‍රතිඵල තමයි මේකෙන් බලාගන්න පුළුවන් වෙන්නේ.

M3GAN චිත්‍රපටයට කැමති වුණු අයට වගේම, විද්‍යා ප්‍රබන්ධ සහ ත්‍රාසජනක (Horror/Thriller) කතා වලට කැමති අයට මේක කිසිම කම්මැලිකමක් නැතුව බලන්න පුළුවන් සුපිරි චිත්‍රපටයක්.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p, 1080p උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2026-01-01', 2026, 120, 7.5, ARRAY['Movie','18+','Horror','Sci-fi']::TEXT[], ARRAY['Soulm8te 2026 Sinhala Subtitles','Soulm8te sinhala sub','Soulm8te sinhala subtitle download','Soulm8te movie sinhala sub pixelpoplk','Soulm8te sinhala sub pixelpop.lk','pixelpoplk horror movies','සෝල්මේට් සිංහල උපසිරැසි','Soulm8te 2026 full movie sinhala subtitles download','Soulm8te sinhala sub web-dl','pixelpoplk sinhala subtitles','M3GAN spinoff sinhala sub']::TEXT[], 'Sinhala', 'USA', 'Released', NULL, 'https://image.tmdb.org/t/p/original/9ma5UG4RwHgzpZEhpbXTNQ51Tx9.jpg', 'https://image.tmdb.org/t/p/original/9ma5UG4RwHgzpZEhpbXTNQ51Tx9.jpg', '2026-08-02 10:40:16.846602+00', '2026-08-02 10:40:16.846602+00') ON CONFLICT (id) DO UPDATE SET poster_path = EXCLUDED.poster_path, total_seasons = EXCLUDED.total_seasons;
INSERT INTO movies (id, title, original_title, type, description, release_date, year, runtime, imdb_rating, genres, seo_tags, language, country, status, total_seasons, poster_path, backdrop_path, created_at, updated_at) VALUES ('5f87f198-cd0f-44e3-a8d0-a5fdf9c552c1', 'Evil Dead Burn (2026)', 'Evil Dead Burn (2026)', 'MOVIE', '🩸 Evil Dead Burn (2026) - සිංහල උපසිරැසි 🎬

Evil Dead Burn (2026) brings the next terrifying chapter of Sam Raimi''s iconic horror franchise to the screen. After a tragic loss, a woman seeks solace with her in-laws, only to find themselves trapped in a family reunion from hell as demonic Deadites are unleashed. Download high-quality 720p and 1080p WEB-DL video files with Sinhala subtitles directly or via Telegram. Experience the ultimate blood-soaked nightmare with this highly anticipated Evil Dead Rise sequel.

ලෝකයේම ප්‍රසිද්ධ, ඇඟේ හිරිගඩු පිපෙන Horror ෆ්‍රැන්චයිස් එකක් වෙන Evil Dead කතා මාලාවේ අලුත්ම චිත්‍රපටය තමයි Evil Dead Burn (2026) කියන්නේ. 2023 අවුරුද්දේ ආපු Evil Dead Rise චිත්‍රපටයේ දැවැන්ත සාර්ථකත්වයෙන් පස්සේ, ඒ විශ්වයටම සම්බන්ධ වෙනස්ම කතාවක් විදිහට තමයි මේක එළියට එන්නේ. Sébastien Vaniček විසින් අධ්‍යක්ෂණය කරපු මේ චිත්‍රපටය, කලින් චිත්‍රපට වල තිබුණු ඒ භයානක ගතිය තවත් වැඩි කරලා තියෙනවා.

කතාව ගැන කිසිම දෙයක් ස්පොයිල් කරන්නේ නැතුව කිව්වොත්, තමන්ගේ සැමියාගේ හදිසි මරණයෙන් පස්සේ මානසිකව වැටිලා ඉන්න Alice කියන කාන්තාව ඇගේ සැමියාගේ පවුලේ අයත් එක්ක දුර පළාතක තියෙන ගෙදරකට එකතු වෙනවා. හැබැයි මේ පවුලේ අයගේ එකතුවීම කෙළවර වෙන්නේ කාටවත් හිතාගන්න බැරි තරම් භයානක විදිහකට. එකින් එකාට අර අපි දන්න භයානක "Deadites" ලා (යක්ෂ ආත්ම) වැහෙන්න ගන්නකොට, මේ ගෙදර ඇතුළේ ජීවිතය බේරගන්න කරන ලොකු සටනක් තමයි මේකෙන් බලාගන්න පුළුවන් වෙන්නේ. 

අතිශය භයානක දර්ශන (Gore) වලින් පිරිච්ච මේ චිත්‍රපටය, නියම Horror රසිකයින්ට කිසිම කම්මැලිකමක් නැතුව බලන්න පුළුවන් අනිවාර්යයෙන්ම මඟහැරගන්න නරක Film එකක්. 👈

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram download: 720p සහ 1080p උසස් තත්ත්වයේ WEBRip වීඩියෝ පිටපත්  ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2026-01-01', 2026, 120, 6.7, ARRAY['Horror','Thriller','Supernatural','Splatter']::TEXT[], ARRAY['Evil Dead Burn 2026 Sinhala Subtitles','Evil Dead Burn sinhala sub','Evil Dead Burn sinhala subtitle download','Evil Dead Burn movie sinhala sub pixelpoplk','Evil Dead Burn sinhala sub pixelpop.lk','pixelpoplk horror movies','ඊවිල් ඩෙඩ් බර්න් සිංහල උපසිරැසි','Evil Dead Burn 2026 full movie sinhala subtitles download','Evil Dead Burn sinhala sub web-dl','pixelpoplk sinhala subtitles','Evil Dead Rise sequel sinhala sub','Evil Dead Burn English Subtitles','Evil Dead burn english sub']::TEXT[], 'Sinhala', 'USA', 'Released', NULL, 'https://image.tmdb.org/t/p/original/syGSQh7bqPHCFRhwHewHdR5EqjD.jpg', 'https://image.tmdb.org/t/p/original/syGSQh7bqPHCFRhwHewHdR5EqjD.jpg', '2026-08-04 08:00:52.849475+00', '2026-08-04 08:00:52.849475+00') ON CONFLICT (id) DO UPDATE SET poster_path = EXCLUDED.poster_path, total_seasons = EXCLUDED.total_seasons;
INSERT INTO movies (id, title, original_title, type, description, release_date, year, runtime, imdb_rating, genres, seo_tags, language, country, status, total_seasons, poster_path, backdrop_path, created_at, updated_at) VALUES ('de89fa81-9fb4-4728-ae08-770da32cd8ff', 'The Isolate Thief (2026)', 'The Isolate Thief (2026)', 'MOVIE', '🎬 The Isolate Thief (2026) - සිංහල උපසිරැසි 🎬

The Isolate Thief (2026) delivers a high-stakes, adrenaline-fueled action thriller experience. Follow the story of a master thief forced out of hiding for one final, impossible heist that tests every limit. Download high-quality 720p and 1080p WEB-DL video files with Sinhala subtitles directly or via Telegram. Experience the suspense and intense action on pixelpop.lk.

The Isolate Thief (2026) කියන්නේ මේ අවුරුද්දේ එළියට ආපු සුපිරිම Action/Thriller චිත්‍රපටයක්. Fast & Furious වගේම වේගවත් ක්‍රියාදාම චිත්‍රපට වලට සහ Heist (සොරකම් කිරීම්) සම්බන්ධ කතා වලට කැමති අයට මේක කිසිම කම්මැලිකමක් නැතුව එක දිගටම බලන්න පුළුවන්.💯

කතාව ගැන කිසිම දෙයක් ස්පොයිල් කරන්නේ නැතුව කිව්වොත්, තමන්ගේ පාඩුවේ හැංගිලා ජීවත් වෙන ලෝකයේ දක්ෂතම සොරෙක්ට, තමන්ගේ කැමැත්තෙන් තොරව අවසාන වතාවට ලොකු මෙහෙයුමකට සම්බන්ධ වෙන්න සිද්ධ වෙනවා. මේක සාමාන්‍ය සොරකමක් නෙවෙයි, කිසිම කෙනෙක්ට ඇතුළු වෙන්න බැරි අධි ආරක්ෂිත තැනකින් කරන දැවැන්ත එකක්. මේ මෙහෙයුම අතරතුර එයාට මුහුණ දෙන්න වෙන බාධක සහ නොහිතන විදිහේ සිදුවීම් වලින් තමයි කතාව පුරාවටම කුතුහලය උපරිමයෙන්ම තියාගෙන ඉස්සරහට යන්නේ.✅

ක්‍රියාදාම සහ කුතුහලය පිරුණු අලුත්ම චිත්‍රපටයක් හොයනවා නම්, මේක අනිවාර්යයෙන්ම බලන්න ඕනේ නිර්මාණයක්.👈

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය;

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p සහ 1080p උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත්  ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2026-01-01', 2026, 120, 6.1, ARRAY['Survival','Action','Drama','Western']::TEXT[], ARRAY['The Isolate Thief 2026 Sinhala Subtitles','The Isolate Thief sinhala sub','The Isolate Thief sinhala subtitle download','The Isolate Thief movie sinhala sub pixelpoplk','The Isolate Thief sinhala sub pixelpop.lk','pixelpoplk action movies','දි අයිසොලේට් තීෆ් සිංහල උපසිරැසි','The Isolate Thief 2026 full movie sinhala subtitles download','The Isolate Thief sinhala sub web-dl','pixelpoplk sinhala subtitles','action thriller sinhala sub','The Isolate Thief (2026)','The Isolate Thief English subtitles','The Isolate Thief download','The Isolate Thief (2026) download']::TEXT[], 'Sinhala', 'USA', 'Released', NULL, 'https://image.tmdb.org/t/p/original/7pmvQNhIDwJTs4IVWxuihG7RjsL.jpg', 'https://image.tmdb.org/t/p/original/7pmvQNhIDwJTs4IVWxuihG7RjsL.jpg', '2026-08-05 06:34:07.587586+00', '2026-08-05 06:34:07.587586+00') ON CONFLICT (id) DO UPDATE SET poster_path = EXCLUDED.poster_path, total_seasons = EXCLUDED.total_seasons;
INSERT INTO movies (id, title, original_title, type, description, release_date, year, runtime, imdb_rating, genres, seo_tags, language, country, status, total_seasons, poster_path, backdrop_path, created_at, updated_at) VALUES ('842ac5eb-df6a-4881-a963-d47350bdd111', 'Black Bird', 'Black Bird', 'TV_SHOW', '🕵️‍♂️ Black Bird - සිංහල උපසිරැසි 🎬

Black Bird is an acclaimed Apple TV+ crime drama miniseries based on true events. Starring Taron Egerton and Paul Walter Hauser, this intense psychological thriller follows a convicted drug dealer offered freedom in exchange for coaxing a confession from an alleged serial killer inside a maximum-security prison. Download high-quality 720p  WEB-DL video files via Telegram. Experience this gripping masterpiece on pixelpoplk.

ඇත්තම සිදුවීමක් ඇසුරෙන් නිර්මාණය වුණු Black Bird කියන්නේ Apple TV+ නාලිකාවෙන් එළියට ආපු, ලෝකයේම ලොකු කතාබහකට ලක්වුණු Crime / Psychological Thriller කතා මාලාවක්. Taron Egerton, Paul Walter Hauser සහ ප්‍රසිද්ධ රංගන ශිල්පී Ray Liotta ගේ විශිෂ්ට රංගනයන්ගෙන් මේ කතාව අතිශය සාර්ථක එකක් බවට පත්වුණා.

කතාව ගැන කිසිම දෙයක් ස්පොයිල් කරන්නේ නැතුව කිව්වොත්, අවුරුදු 10ක සිරදඬුවමක් ලැබෙන Jimmy Keene කියන තරුණයාට අමුතුම විදිහේ යෝජනාවක් ලැබෙනවා. ඒ තමයි අතිශය භයානක අපරාධකාරයින් ඉන්න හිරගෙදරකට ගිහින්, එහෙ ඉන්න සීරියල් කිලර් කෙනෙක් (Serial Killer) කියලා සැකකරන පුද්ගලයෙක් එක්ක යහළුවෙලා එයාගෙන් රහස් තොරතුරු ලබාගන්න එක. එහෙම කළොත් Jimmy ගේ සිරදඬුවම සම්පූර්ණයෙන්ම නිදහස් කරන්න රජයෙන් පොරොන්දු වෙනවා.

හැබැයි මේ භයානක මානසික සටන ඇතුළේ ජීවිතයත් මරණයත් අතර සටනක් කරන්න Jimmy ට සිද්ධ වෙනවා. True Crime සහ Crime Mystery කතා වලට ආස අයට එක හුස්මට බලලා ඉවර කරන්න පුළුවන් සුපිරිම කතා මාලාවක් තමයි මේක.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (Zip) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p WEB-DL වීඩියෝ පිටපත් Telegram චැනලය හරහා ලබාගත හැක.', '2022-01-01', 2022, 50, 8.1, ARRAY['Drama','Thriller','Crime']::TEXT[], ARRAY['Black Bird Season 1 Episode 1 Sinhala Subtitles','Black Bird S01E01 Sinhala Sub','Black Bird 1x1 sub','Black Bird Sinhala Subtitles','Black Bird sinhala sub','Black Bird sinhala subtitle download','Black Bird tv series sinhala sub pixelpoplk','Black Bird sinhala sub pixelpop.lk','pixelpoplk Apple TV series','බ්ලැක් බර්ඩ් සිංහල උපසිරැසි','Black Bird full series sinhala subtitles download','Black Bird sinhala sub web-dl','pixelpoplk sinhala subtitles','Black Bird miniseries sinhala sub','Black Bird Season 1 Episode 1 Sinhala Subtitles. Download Black Bird S01E01 Sinhala Sub online from pixelpoplk.']::TEXT[], 'Sinhala', 'USA', 'Ongoing', 1, 'https://image.tmdb.org/t/p/original/qu312pwM61NPTr7nexvovCClDNP.jpg', 'https://image.tmdb.org/t/p/original/qu312pwM61NPTr7nexvovCClDNP.jpg', '2026-08-06 10:35:58.56554+00', '2026-08-06 10:35:58.56554+00') ON CONFLICT (id) DO UPDATE SET poster_path = EXCLUDED.poster_path, total_seasons = EXCLUDED.total_seasons;
INSERT INTO movies (id, title, original_title, type, description, release_date, year, runtime, imdb_rating, genres, seo_tags, language, country, status, total_seasons, poster_path, backdrop_path, created_at, updated_at) VALUES ('d8624299-504e-4135-a8b6-bb91d0217b72', 'Lenin (2026)', 'Lenin (2026)', 'MOVIE', '🕵️‍♂️ Lenin (2026) - සිංහල උපසිරැසි 🎬

Lenin delivers a high-stakes rural action-romance drama rooted in love, loyalty, and fierce village conflicts. Set against a gritty rural backdrop, a fearless young man fights to end a bloody, long-standing cycle of violence tied to a turbulent village festival. Download high-quality 720p, 1080p WEB-DL video files directly or via Telegram on pixelpoplk.

ඔන්න අරගෙන ආවා Action, Drama සහ Romance ගණයට ආස කරන අයට කිසිසේත්ම මඟහැරින්න බැරි, ආදරය, මිත්‍රත්වය සහ පලිගැනීම එකට මුසු වුණු සිනමාපටයක්. Zee5 ප්‍රවාහන සේවය ඔස්සේ නිකුත් වුණු, මහාභාරතයේ ආභාසය ලබාගනිමින් නිර්මාණය වුණු Lenin කියන්නේ IMDB හි 6.7/10 ක අගයක් දිනාගත්තු, ප්‍රේක්ෂක අවධානය දිනාගත්තු නිර්මාණයක්.

කතාව ගැන කිසිම දෙයක් ස්පොයිල් කරන්නේ නැතුව සරලවම කිව්වොත්, ශ්‍රීරාම්පුරම් කියන ගම්මානයේ වාර්ෂිකව සිදුවන ද්‍රෞපදී උත්සවය අතරතුර කිසිදු ලේ වැගිරීමක් සිදුනොවිය යුතු බවට ගම්වැසියන් දැඩිව විශ්වාස කරනවා. මෙම ගමේ හැදී වැඩෙන ලෙනින් (Akhil Akkineni) සහ තමන්ගේ සහෝදරයා වැනි මිතුරාට ගමේ පවතින කුමන්ත්‍රණ සහ පවුල් බලඅරගල නිසා දැඩි අභියෝගයන්ට මුහුණ දෙන්න සිද්ධ වෙනවා. තමන්ගේ ආදරය බේරාගන්නත්, ගමේ පවතින මේ වෛරී පලිගැනීමේ චක්‍රය නතර කරන්නත් ඔහුට අතිශය භයානක සටනකට මුහුණ දෙන්න වෙනවා.

Thaman S ගේ විශිෂ්ට සංගීතයෙන් හැඩවුණු, Akhil Akkineni සහ Bhagyashri Borse ගේ රංගනයෙන් හැඩවුණු මේ චිත්‍රපටය, තෙලිඟු සිනමාලෝලීන් අනිවාර්යයෙන්ම නැරඹිය යුතු එකක්.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: වීඩියෝව සමඟ උපසිරැසි නැරඹීමට කැමති අය සඳහා 720p, 1080p උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2026-01-01', 2026, 120, 6.7, ARRAY['Action','Drama','Romance','Thriller']::TEXT[], ARRAY['Lenin Sinhala Subtitles','Lenin sinhala sub','Lenin sinhala subtitle download','Lenin movie sinhala sub pixelpoplk','Lenin sinhala sub pixelpop.lk','pixelpoplk Zee5 Telugu movie','ලෙනින් සිංහල උපසිරැසි','Lenin full movie sinhala subtitles download','Lenin sinhala sub web-dl','pixelpoplk sinhala subtitles','Lenin Telugu movie sinhala sub','rural action drama sinhala sub']::TEXT[], 'Sinhala', 'USA', 'Released', NULL, 'https://image.tmdb.org/t/p/original/rAHQviBq8Fxi20hNtHPGLnr4L0f.jpg', 'https://image.tmdb.org/t/p/original/rAHQviBq8Fxi20hNtHPGLnr4L0f.jpg', '2026-08-07 07:34:34.672569+00', '2026-08-07 07:34:34.672569+00') ON CONFLICT (id) DO UPDATE SET poster_path = EXCLUDED.poster_path, total_seasons = EXCLUDED.total_seasons;
INSERT INTO movies (id, title, original_title, type, description, release_date, year, runtime, imdb_rating, genres, seo_tags, language, country, status, total_seasons, poster_path, backdrop_path, created_at, updated_at) VALUES ('046422c0-37bd-4d89-ab53-fb06e6e5da6d', 'Idhayam Murali (2026)', 'Idhayam Murali (2026)', 'MOVIE', '🕵️‍♂️ Idhayam Murali (2026) - සිංහල උපසිරැසි 🎬

Idhayam Murali delivers a breezy, heartwarming coming-of-age romantic drama centered on unspoken feelings. Follow a young man''s emotional journey through different stages of life, from boyhood crushes to college sweethearts, as he struggles to express his love. Download high-quality 720p, 1080p WEB-DL video files directly or via Telegram on pixelpoplk.

ඔන්න අරගෙන ආවා Romance, Comedy සහ Drama ගණයට අයත් වෙන, ආදරය සහ මිත්‍රත්වය පිරිණු සුන්දර තමිල් සිනමාපටයක්. 1991 වසරේ තිරගත වුණු සුප්‍රසිද්ධ "Idhayam" චිත්‍රපටයට උපහාරයක් ලෙසින් නිර්මාණය වුණු මෙය, එහි ප්‍රධාන නළුවා වූ මුරලිගේ පුත් අදර්වා (Atharvaa) ගේ ප්‍රධාන රංගනයෙන් හැඩවෙනවා.

කතාව ගැන කිසිම දෙයක් ස්පොයිල් කරන්නේ නැතුව සරලවම කිව්වොත්, තමන්ගේ හිතේ තියෙන ආදරය සහ හැඟීම් පිටතට ප්‍රකාශ කිරීමට අසීරු තරුණයෙක් වන ඉධයා (Idhaya) ගේ ආදර කතාව වටා තමයි මේ චිත්‍රපටය ගෙතෙන්නේ. තමන්ගේ විවාහයට පෙර, නාඳුනන පුද්ගලයෙක් (Fahadh Faasil) හමුවන ඔහු, තමන්ගේ පාසල් කාලයේ සිට විවිධ අවධීන් වලදී ජීවිතයට පැමිණි ආදරවන්තියන් පිළිබඳව අතීතාවර්ජනයක යෙදෙනවා. අවසානයේදී ඔහුට තමන්ගේ සැබෑ ආදරය ප්‍රකාශ කරලා ඇයව තමන්ගේ කරගන්න ලැබෙයිද?

Thaman S ගේ ලස්සන සංගීතයෙන් සහ Atharvaa සමඟ Preity Mukhundhan, Kayadu Lohar ගේ රංගනයෙන් හැඩවුණු මේ චිත්‍රපටය, සැහැල්ලු ආදර කතාවලට ප්‍රිය කරන ඔබ නැරඹිය යුතුම එකක්.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: වීඩියෝව සමඟ උපසිරැසි නැරඹීමට කැමති අය සඳහා 720p, 1080p උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2026-01-01', 2026, 120, 8.7, ARRAY['Romance','Comedy','Drama','Tamil']::TEXT[], ARRAY['Idhayam Murali Sinhala Subtitles','Idhayam Murali sinhala sub','Idhayam Murali sinhala subtitle download','Idhayam Murali movie sinhala sub pixelpoplk','Idhayam Murali sinhala sub pixelpop.lk','pixelpoplk Tamil movie','ඉධයම් මුරලි සිංහල උපසිරැසි','Idhayam Murali full movie sinhala subtitles download','Idhayam Murali sinhala sub web-dl','pixelpoplk sinhala subtitles','Idhayam Murali Tamil movie sinhala sub','romantic drama sinhala sub']::TEXT[], 'Sinhala', 'USA', 'Released', NULL, 'https://image.tmdb.org/t/p/original/xeb6080yZcKijIoXc1YxOU5A2Gb.jpg', 'https://image.tmdb.org/t/p/original/xeb6080yZcKijIoXc1YxOU5A2Gb.jpg', '2026-08-07 09:54:02.964215+00', '2026-08-07 09:54:02.964215+00') ON CONFLICT (id) DO UPDATE SET poster_path = EXCLUDED.poster_path, total_seasons = EXCLUDED.total_seasons;
INSERT INTO movies (id, title, original_title, type, description, release_date, year, runtime, imdb_rating, genres, seo_tags, language, country, status, total_seasons, poster_path, backdrop_path, created_at, updated_at) VALUES ('c70fa02f-bdf7-4ce8-a5e6-a4c04b4ea5e5', 'Our Sticky Love', 'Our Sticky Love', 'TV_SHOW', '🕵️‍♂️ Our Sticky Love (2026) - සිංහල උපසිරැසි 🎬

Our Sticky Love delivers a sweet yet action-packed romantic comedy centered on an unexpected cohabitation. An ambitious prosecutor loses her memory and finds herself hiding in a countryside village with a mysterious boxing coach who claims to be her boyfriend to protect her from a crime syndicate. Download high-quality 720p, 1080p WEB-DL video files directly or via Telegram on pixelpoplk.

ඔන්න අරගෙන ආවා Romantic Comedy, Action සහ Thriller කියන හැම රසයක්ම එකතු කරපු, Netflix හරහා නිකුත් වුණු අලුත්ම සුපිරි කොරියානු කතා මාලාව. D.P. සහ Love Next Door කතා මාලා හරහා අතිශය ජනප්‍රිය වුණු Jung Hae-in සහ දක්ෂ නිළි Ha Young ප්‍රධාන චරිත නිරූපණය කරන Our Sticky Love කියන්නේ නිකුත් වුණු දවසේ ඉඳලම ලෝකයේම ලොකු ප්‍රේක්ෂක අවධානයක් දිනාගත්තු අපූරු නිර්මාණයක්.

කතාව ගැන කිසිම දෙයක් ස්පොයිල් කරන්නේ නැතුව සරලවම කිව්වොත්, දූෂිත දේශපාලකයින් සහ මැර කල්ලියක් ගැන පරීක්ෂණ පවත්වන දක්ෂ රජයේ නීතිඥවරියක් වන Go Eun-sae ට මුහුණ දීමට සිදුවන අනතුරකින් පසුව ඇගේ මතකය සම්පූර්ණයෙන්ම අහිමි වෙනවා. ඇයව මරා දැමීමට මැර කල්ලියක් ලුහුබඳින අතරතුර, බොක්සිං පුහුණුකරුවෙකු සහ හිටපු මැරයෙකු වන Jang Tae-ha ඇයට හමුවෙනවා. ඇයව බේරාගැනීමේ අරමුණින් ඔහු තමන් ඇගේ පෙම්වතා බව පවසමින් බොරුවක් ගොතා ඇයව සාම්ප්‍රදායික පැණිරස රසකැවිලි සදන අපූරු ගම්මානයකට රැගෙන යනවා. මතකය අහිමි වූ ඇය සහ බොරු පෙම්වතෙක් වූ ඔහු අතර ඇතිවන මේ "ඇලෙන සුළු" ආදර කතාව මැරයින්ගෙන් බේරී අවසාන වන්නේ කෙසේද?

Kim Jang-han ගේ අධ්‍යක්ෂණයෙන් හැඩවුණු, හාස්‍යය, ආදරය මෙන්ම කුතුහලය පිරි මේ කතා මාලාව අනිවාර්යයෙන්ම ඔයාගේ Must Watch ලිස්ට් එකට එකතු කරගන්න ඕනේ එකක්.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: වීඩියෝව සමඟ උපසිරැසි නැරඹීමට කැමති අය සඳහා 720p, 1080p උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2026-01-01', 2026, 50, 8.4, ARRAY['Romantic','Comedy','Melodrama','Action','Thriller','K-Drama']::TEXT[], ARRAY['Our Sticky Love Sinhala Subtitles','Our Sticky Love sinhala sub','Our Sticky Love sinhala subtitle download','Our Sticky Love kdrama sinhala sub pixelpoplk','Our Sticky Love sinhala sub pixelpop.lk','pixelpoplk Netflix Korean series','අවර් ස්ටිකි ලව් සිංහල උපසිරැසි','Our Sticky Love full series sinhala subtitles download','Our Sticky Love sinhala sub web-dl','pixelpoplk sinhala subtitles','Our Sticky Love kdrama sinhala sub','romantic comedy k-drama sinhala sub']::TEXT[], 'Sinhala', 'USA', 'Ongoing', 1, 'https://image.tmdb.org/t/p/original/tSZ4aFpTGc8Oj52SuzPUUZ7WKL0.jpg', 'https://image.tmdb.org/t/p/original/tSZ4aFpTGc8Oj52SuzPUUZ7WKL0.jpg', '2026-08-08 08:30:23.609856+00', '2026-08-08 08:30:23.609856+00') ON CONFLICT (id) DO UPDATE SET poster_path = EXCLUDED.poster_path, total_seasons = EXCLUDED.total_seasons;
INSERT INTO movies (id, title, original_title, type, description, release_date, year, runtime, imdb_rating, genres, seo_tags, language, country, status, total_seasons, poster_path, backdrop_path, created_at, updated_at) VALUES ('9590db82-7e72-4ade-a714-4acc2da3170d', 'The Night of', 'The Night of', 'TV_SHOW', '🕵️‍♂️ The Night Of - සිංහල උපසිරැසි 🎬

The Night Of delivers a gripping, award-winning crime drama miniseries from HBO. After a night of partying with a mysterious stranger, a Pakistani-American student wakes up to find her stabbed to death and becomes the prime suspect in a complex murder trial. Download high-quality 720p Blu-Ray video files directly or via Telegram on pixelpoplk.

ඔන්න අරගෙන ආවා Crime, Mystery සහ Thriller ගණයේ රසිකයින්ට මඟහැරගන්නම බැරි, HBO නාලිකාව හරහා විකාශනය වුණු අතිශය ජනප්‍රිය වගේම සම්මානනීය මිනි-කතා මාලාවක්. එමී සම්මාන (Emmy Awards) පහක් දිනාගත්, IMDb හි 8.4/10 ක ඉහළම අගයක් හිමිකරගත් The Night Of කියන්නේ මුල සිට අගටම කුතුහලය උපරිමයෙන්ම පවත්වාගෙන යන විශිෂ්ටතම නිර්මාණයක්.👈

කතාව ගැන කිසිම දෙයක් ස්පොයිල් කරන්නේ නැතුව සරලවම කිව්වොත්, නිව්යෝර්ක් නුවර ජීවත් වන පකිස්ථාන-ඇමරිකානු තරුණයෙක් වන නසීර් "නෑස්" ඛාන් (Riz Ahmed), සාදයකට යාම සඳහා තමන්ගේ පියාගේ කුලී රථය රැගෙන යනවා. මඟදී ඔහුට මුණගැසෙන අද්භූත තරුණියක් සමඟ ගතකරන රාත්‍රියකින් පසු ඔහු නින්දෙන් ඇහැරෙන්නේ ඇය කෲර ලෙස ඝාතනය කර තිබෙනවා දකිමින්. කිසිවක් කරකියාගත නොහැකි වන ඔහු පොලිස් අත්අඩංගුවට පත්වෙන අතර, නීතීඥ ජෝන් ස්ටෝන් (John Turturro) ඔහු වෙනුවෙන් පෙනී සිටීමට ඉදිරිපත් වෙනවා. නසීර් ඇත්තටම ඝාතකයාද? නැතහොත් ඔහු සැඟවුණු දේශපාලන හා සාමාජීය කුමන්ත්‍රණයක ගොදුරක්ද?🤔

Riz Ahmed සහ John Turturro ගේ විශිෂ්ටතම රංගනයෙන් හැඩවුණු, මොහොතින් මොහොත උද්වේගකර බව වැඩිවන මේ කතා මාලාව අනිවාර්යයෙන්ම නැරඹිය යුතු එකක්.✅

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p  උසස් තත්ත්වයේ Bluray වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2016-01-01', 2016, 50, 8.4, ARRAY['Crime','Drama','Mystery','Thriller','Miniseries']::TEXT[], ARRAY['The Night Of Sinhala Subtitles','The Night Of sinhala sub','The Night Of sinhala subtitle download','The Night Of tv series sinhala sub pixelpoplk','The Night Of sinhala sub pixelpop.lk','pixelpoplk HBO miniseries','ද නයිට් ඔෆ් සිංහල උපසිරැසි','The Night Of full series sinhala subtitles download','The Night Of sinhala sub web-dl','pixelpoplk sinhala subtitles','The Night Of miniseries sinhala sub','crime drama sinhala sub','The night of sinhala sub','night of sinhala sub']::TEXT[], 'Sinhala', 'USA', 'Ongoing', 1, 'https://image.tmdb.org/t/p/original/q13XJHdnsmxQL9rXRcnNDrZGHjO.jpg', 'https://image.tmdb.org/t/p/original/q13XJHdnsmxQL9rXRcnNDrZGHjO.jpg', '2026-08-08 11:01:21.636301+00', '2026-08-08 11:01:21.636301+00') ON CONFLICT (id) DO UPDATE SET poster_path = EXCLUDED.poster_path, total_seasons = EXCLUDED.total_seasons;
INSERT INTO movies (id, title, original_title, type, description, release_date, year, runtime, imdb_rating, genres, seo_tags, language, country, status, total_seasons, poster_path, backdrop_path, created_at, updated_at) VALUES ('8fd23983-4862-4cc1-a7f5-77a8409fe8b4', 'The Invite (2026)', 'The Invite (2026)', 'MOVIE', '🕵️‍♂️ The Invite (2026) - සිංහල උපසිරැසි 🎬🔞

The Invite delivers a hilarious and sharp comedy-drama about modern relationships and adult compromises from A24. When a couple whose marriage is on thin ice invites their eccentric, free-spirited upstairs neighbors over for a dinner party, the evening quickly spirals into unpredictable, wild, and eye-opening territory. Download high-quality 720p, 1080p WEB-DL video files directly or via Telegram on pixelpoplk.

ඔන්න අරගෙන ආවා Comedy සහ Drama ගණයට ආස කරන අයට කිසිසේත්ම මඟහැරගන්න බැරි, ප්‍රසිද්ධ A24 සිනමා සමාගම හරහා නිකුත් වුණු අලුත්ම සුපිරි සිනමාපටයක්. සුප්‍රසිද්ධ ස්පාඤ්ඤ චිත්‍රපටයක් වන "The People Upstairs" ඇසුරෙන් නිර්මාණය වුණු The Invite කියන්නේ සබඳතා සහ විවාහ ජීවිතය පිළිබඳව හාස්‍යය මුසු කරමින් ඉතාමත් අපූරුවට කතාබහ කරන වැඩිහිටියන්ට පමණක් නිර්මාණය වූ 🔞 නිර්මාණයක්.

කතාව ගැන කිසිම දෙයක් ස්පොයිල් කරන්නේ නැතුව සරලවම කිව්වොත්, ජෝ (Seth Rogen) සහ ඇන්ජෙලා (Olivia Wilde) කියන්නේ සබඳතාවයේ ගැටලු රැසක් නිසා දික්කසාද වීමේ මට්ටමේ පසුවෙන යුවළක්. දිනක් ඔවුන්ගේ උඩුමහලේ පදිංචිව සිටින, තරමක් අමුතු අදහස් තියෙන අසල්වැසි යුවළක් වන පීනාව (Penélope Cruz) සහ හෝක්ව (Edward Norton) තමන්ගේ නිවසට රාත්‍රී ආහාර වේලක් සඳහා ඇරයුම් කරනවා. නමුත් සාමාන්‍ය විදිහට ඇරඹෙන මේ රාත්‍රී භෝජන සංග්‍රහය, ඔවුන් කිසිසේත්ම බලාපොරොත්තු නොවුණු, හාස්‍යයෙන් පිරි මෙන්ම දෙපිරිසේම පෞද්ගලික රහස් හෙළිවන අතිශය අවුල් සහගත තැනකට හැරෙන්නේ කෙසේද?

Olivia Wilde ගේ අධ්‍යක්ෂණයෙන් හැඩවුණු, Seth Rogen, Edward Norton සහ Penélope Cruz වැනි දක්ෂ නළු නිළියන් රැසකගේ රංගනයෙන් ඔපවත් වූ මේ චිත්‍රපටය අනිවාර්යයෙන්ම නැරඹිය යුතු එකක්.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: වීඩියෝව සමඟ උපසිරැසි නැරඹීමට කැමති අය සඳහා 720p, 1080p උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2026-01-01', 2026, 120, 7.9, ARRAY['Comedy','Drama','18+','Romance']::TEXT[], ARRAY['The Invite Sinhala Subtitles','The Invite sinhala sub','The Invite sinhala subtitle download','The Invite movie sinhala sub pixelpoplk','The Invite sinhala sub pixelpop.lk','pixelpoplk A24 movie','ද ඉන්වයිට් සිංහල උපසිරැසි','The Invite full movie sinhala subtitles download','The Invite sinhala sub web-dl','pixelpoplk sinhala subtitles','The Invite comedy drama sinhala sub','Olivia Wilde movie sinhala sub','18+']::TEXT[], 'Sinhala', 'USA', 'Released', NULL, 'https://image.tmdb.org/t/p/original/b7Dr8Chzse8VagexAporUu2RtLx.jpg', 'https://image.tmdb.org/t/p/original/b7Dr8Chzse8VagexAporUu2RtLx.jpg', '2026-08-10 12:27:21.523628+00', '2026-08-10 12:27:21.523628+00') ON CONFLICT (id) DO UPDATE SET poster_path = EXCLUDED.poster_path, total_seasons = EXCLUDED.total_seasons;
INSERT INTO movies (id, title, original_title, type, description, release_date, year, runtime, imdb_rating, genres, seo_tags, language, country, status, total_seasons, poster_path, backdrop_path, created_at, updated_at) VALUES ('24e0838d-f148-4401-a04b-6e7881bd93ee', 'Reacher', 'Reacher', 'TV_SHOW', '🕵️‍♂️ Reacher Season 4 Episode 1 - සිංහල උපසිරැසි 🎬

Reacher Season 4 Episode 1 delivers the highly anticipated return of television''s ultimate wanderer. Before diving into this brand new chapter of conspiracy and action, let''s take a quick journey back to Reacher''s past adventures—from uncovering the corruption in Margrave, to avenging his fallen military comrades, and surviving a deadly undercover mission. Download high-quality 720p, 1080p WEB-DL video files directly or via Telegram on pixelpoplk.

ඔන්න යාළුවනේ, ලෝක පුරා අතිශය ජනප්‍රිය වුණු, ඇමසන් ප්‍රයිම් (Prime Video) හරහා විකාශනය ආරම්භ වුණු Reacher කතා මාලාවේ 4 වැනි කතා සමයේ (Season 4) පළමු වැනි කොටසට (Episode 1) සිංහල උපසිරැසි අරගෙන ආවා. මේ අලුත්ම සීසන් එක බලන්න පටන් ගන්න කලින්, කලින් කතා සමයන් 1, 2 සහ 3 තුළින් රීචර් ආපු ගමන කෙටියෙන් මතක් කරගන්න එක ඔයාලට ගොඩක් වටිනවා.

පළමු කතා සමයේදී (Season 1) මාග්‍රේව් (Margrave) නම් කුඩා නගරයේ සිදුවූ තමන්ගේ සහෝදරයාගේ ඝාතනයට පලිගැනීම සඳහා නගරයේ රහස්‍ය කල්ලියක් සහ දූෂිත පොලිසියක් මුළුමනින්ම විනාශ කිරීමට රීචර් සමත් වුණා. දෙවන කතා සමයේදී (Season 2) තමන්ගේ පැරණි හමුදා ඒකකයේ (110th Special Investigators) මිතුරන් පාවාදී මරා දැමූ දූෂිත ආයුධ ජාවාරම්කරුවන් කල්ලියක් සොයා ගොස් තමන්ගේ මිතුරන් වෙනුවෙන් යුක්තිය ඉටු කරන්න ඔහුට සිද්ධ වුණා. පසුගිය තුන්වන කතා සමයේදී (Season 3) දරුණු ජාවාරම්කරුවන් පිරිසක් කොටු කරගැනීම සඳහා රීචර් අතිශය අවදානම් සහගත රහසිගත මෙහෙයුමකට (Undercover) සම්බන්ධ වෙමින් දැවැන්ත සටනක් දියත් කළා.

මෙන්න මේ විදිහට හැම තැනකදීම තමන්ගේ ශාරීරික ශක්තිය සහ අසමසම බුද්ධිය උපයෝගී කරගෙන සතුරන් මෙල්ල කරපු ජැක් රීචර්, මේ 4 වැනි කතා සමයෙන් තවත් අලුත්ම දේශපාලන සහ රහස් ඔත්තු සේවා කුමන්ත්‍රණයකට මැදි වෙනවා. Alan Ritchson ගේ සුපිරි රංගනය සහ සුපිරි සටන් දර්ශන රැසක් සමඟින් ඇරඹෙන Reacher Season 4 හි පළමු කොටස කිසිසේත්ම මඟහැරගන්න එපා.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: වීඩියෝව සමඟ උපසිරැසි නැරඹීමට කැමති අය සඳහා 720p, 1080p උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2026-01-01', 2026, 50, 8.1, ARRAY['Action','Crime','Thriller','Detective','Drama']::TEXT[], ARRAY['Reacher Season 4 Episode 1 Sinhala Subtitles','Reacher S04E01 sinhala sub','Reacher S4 Ep1 sinhala subtitle download','Reacher S04E01 sinhala sub pixelpoplk','Reacher S4E1 sinhala sub pixelpop.lk','pixelpoplk Prime Video Reacher','රීචර් සිංහල උපසිරැසි','Reacher Season 4 sinhala subtitles download','Reacher S04E01 web-dl sinhala sub','pixelpoplk sinhala subtitles','action thriller series sinhala sub','Reacher recap sinhala sub']::TEXT[], 'Sinhala', 'USA', 'Ongoing', 4, 'https://image.tmdb.org/t/p/original/wkKJHC34dIw9cJwAfNEEgDdb2ol.jpg', 'https://image.tmdb.org/t/p/original/wkKJHC34dIw9cJwAfNEEgDdb2ol.jpg', '2026-08-12 08:51:51.598699+00', '2026-08-12 08:51:51.598699+00') ON CONFLICT (id) DO UPDATE SET poster_path = EXCLUDED.poster_path, total_seasons = EXCLUDED.total_seasons;
INSERT INTO movies (id, title, original_title, type, description, release_date, year, runtime, imdb_rating, genres, seo_tags, language, country, status, total_seasons, poster_path, backdrop_path, created_at, updated_at) VALUES ('1de2af9b-9c53-4c39-a3b6-07c77210bbb0', 'Cocktail 2', 'Cocktail 2', 'MOVIE', '🕵️‍♂️ Cocktail 2 (2026) - සිංහල උපසිරැසි 🎬

ඔන්න අරගෙන ආවා Romance, Comedy වගේම Drama වලට ආස කරන අයට කිසිසේත්ම මඟහැරගන්න බැරි, මෑතකදී නිකුත් වුණු ලස්සන බොලිවුඩ් සිනමාපටයක්. 2012 වසරේ ආපු සුපිරිම "Cocktail" චිත්‍රපටයේ spiritual sequel එකක් විදිහට නිර්මාණය වුණු මේ නිර්මාණය, හාස්‍යය වගේම හැඟීම්බර ආදර කතාවක් අපූරුවට පෙන්නුම් කරනවා.

කතාව පැත්තට ගියොත්, කුනාල් (Shahid Kapoor) සහ දියා (Rashmika Mandanna) කියන්නේ කාලෙක ඉඳන් බොහොම සතුටින් එකට ජීවත් වෙන ආදරවන්තයෝ දෙන්නෙක්. හැබැයි මෙයාලට පවුලේ නෑදෑයින්ගෙන් නිතරම එල්ල වෙන්නේ එකම ප්‍රශ්නයක්. ඒ තමයි "කවදාද බඳින්නේ?" කියන එක. මේ කරදරකාරී ප්‍රශ්නවලින් බේරිලා නිදහසේ කාලය ගත කරන්න හිතාගෙන මෙයාලා ඉතාලියේ සිසිලි (Sicily) දූපතට ලස්සන සංචාරයක් යනවා. 

හැබැයි මෙයාලගේ මේ සුන්දර නිවාඩුව අතරතුරට අමුතුම විදිහේ කෙල්ලෙක් වෙන ඇලී (Kriti Sanon) එකතු වෙනවා. ඇලීගේ පැමිණීමත් එක්ක මේ දෙන්නගේ ආදරය, යාළුකම වගේම මුළු ජීවිතයම සම්පූර්ණයෙන්ම වෙනස් වෙලා, හිතාගන්න බැරි පැටලිලි සහගත ආදර ත්‍රිකෝණයක් නිර්මාණය වෙනවා. 

Homi Adajania ගේ අධ්‍යක්ෂණයෙන් වගේම Pritam ගේ සුපිරි සංගීතයෙන් හැඩවුණු, Shahid Kapoor, Kriti Sanon සහ Rashmika Mandanna ගේ සුපිරි රංගනයක් බලාගන්න පුළුවන් මේ ලස්සන චිත්‍රපටය ඔයාගේ Must Watch ලිස්ට් එකට අනිවාර්යයෙන්ම එකතු කරගන්න.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නේ මෙහෙමයි:

📄 Direct Subtitle Download: කිසිම කරදරයක් නැතුව සිංහල උපසිරැසි ගොනුව (SRT) කෙලින්ම ඩවුන්ලෝඩ් කරගන්න පුළුවන්.

✈️ Telegram Download: වීඩියෝ එකයි සබ් එකයි එකටම බලන්න කැමති අයට 720p, 1080p WEB-DL කොපි ටෙලිග්‍රෑම් චැනල් එක හරහා ගන්න පුළුවන්.', '2026-01-01', 2026, 120, 7.5, ARRAY['Movie','Comedy','Romance']::TEXT[], ARRAY['Cocktail 2 sinhala sub','cocktail hindi','Cocktail 2 Sinhala Subtitles','Cocktail 2 sinhala subtitle download','Cocktail 2 movie sinhala sub pixelpoplk','Cocktail 2 sinhala sub pixelpop.lk','pixelpoplk Bollywood movie','කොක්ටේල් 2 සිංහල උපසිරැසි','Cocktail 2 full movie sinhala subtitles download','Cocktail 2 sinhala sub web-dl','pixelpoplk sinhala subtitles','Cocktail 2 Hindi movie sinhala sub','romantic comedy drama sinhala sub']::TEXT[], 'Sinhala', 'USA', 'Released', NULL, 'https://image.tmdb.org/t/p/original/pRmPnUAhHHiDJPfNGLP8ikoc5cx.jpg', 'https://image.tmdb.org/t/p/original/pRmPnUAhHHiDJPfNGLP8ikoc5cx.jpg', '2026-08-14 18:39:26.460286+00', '2026-08-14 18:39:26.460286+00') ON CONFLICT (id) DO UPDATE SET poster_path = EXCLUDED.poster_path, total_seasons = EXCLUDED.total_seasons;
INSERT INTO movies (id, title, original_title, type, description, release_date, year, runtime, imdb_rating, genres, seo_tags, language, country, status, total_seasons, poster_path, backdrop_path, created_at, updated_at) VALUES ('e80dd75e-0b11-4662-ad8e-66165f1cbd76', 'Lanterns (2026)', 'Lanterns (2026)', 'TV_SHOW', '🕵️‍♂️ Lanterns (2026) - සිංහල උපසිරැසි 🎬

Lanterns delivers a gritty, grounded, and cosmic detective thriller from HBO. When a legendary, grizzled Green Lantern is forced to train a defiant new recruit, the two intergalactic cops find themselves drawn into a dark, small-town murder mystery with massive, universe-altering implications. Download high-quality 720p, 1080p WEB-DL video files directly or via Telegram on pixelpoplk.

ඔන්න යාළුවනේ, DC රසිකයෝ හැමෝම අතිශය උනන්දුවෙන් බලාගෙන හිටපු, HBO සහ Max හරහා අදම විකාශනය ආරම්භ වුණු "Lanterns" අලුත්ම සජීවීකරණ නොවන (Live-action) සුපිරි කතා මාලාවට සිංහල උපසිරැසි අරගෙන ආවා. James Gunn ගේ අලුත්ම DC විශ්වයට (DCU) අයත් වෙන මේ කතාව, සාමාන්‍ය සුපිරි වීර කතාවලට වඩා හාත්පසින්ම වෙනස් "True Detective" වගේ අඳුරු රහස් පරීක්ෂණ (Grounded Detective Thriller) විලාසිතාවකින් තමයි නිර්මාණය කරලා තියෙන්නේ.

කතාව පැත්තට ගියොත්, වසර ගණනාවක අත්දැකීම් තියෙන ප්‍රබල මෙන්ම වයස්ගත ග්‍රීන් ලැන්ටර්න් කෙනෙක් වෙන හැල් ජෝර්ඩන්ට (Kyle Chandler), අලුතින්ම මේ කණ්ඩායමට එකතු වෙන මුරණ්ඩු හිටපු මැරීන් සෙබළෙක් වන ජෝන් ස්ටුවර්ට්ව (Aaron Pierre) පුහුණු කරන්න සිද්ධ වෙනවා. මෙයාලා දෙන්නා ඇමරිකාවේ කුඩා ගමක සිද්ධ වෙන අමුතුම විදිහේ මිනීමැරුමක් ගැන පරීක්ෂණ පවත්වන්න එකතු වෙනවා. හැබැයි සාමාන්‍ය එකක් විදිහට පේන මේ මිනීමැරුම පිටුපස මුළු විශ්වයම උඩුයටිකුරු කරන්න පුළුවන් තරමේ අභ්‍යවකාශ සහ පිටසක්වල කුමන්ත්‍රණයක් හැංගිලා තියෙනවා කියලා මෙයාලට තේරුම් යනවා.

Ozark කතා මාලාවේ Chris Mundy, Lost සහ Watchmen නිර්මාණය කරපු Damon Lindelof වැනි අති දක්ෂ පිරිසකගේ තිර රචනයෙන් හැඩවුණු මේ සුපිරි කතා මාලාව, DC ලෝලීන් විතරක් නෙවෙයි හොඳ රහස් පරීක්ෂණ කතාවලට ආස කරන හැමෝම අනිවාර්යයෙන්ම බලන්න ඕනේ එකක්.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නේ මෙහෙමයි:

📄 Direct Download: කිසිම කරදරයක් නැතුව සිංහල උපසිරැසි ගොනුව (SRT) කෙලින්ම ඩවුන්ලෝඩ් කරගන්න පුළුවන්.

✈️ Telegram Download: 720p, 1080p WEB-DL කොපි ටෙලිග්‍රෑම් චැනල් එක හරහා ගන්න පුළුවන්.', '2026-01-01', 2026, 50, 8, ARRAY['Superhero','Sci-Fi','Mystery','Detective','Drama']::TEXT[], ARRAY['Lanterns Sinhala Subtitles','Lanterns sinhala sub','Lanterns sinhala subtitle download','Lanterns tv series sinhala sub pixelpoplk','Lanterns sinhala sub pixelpop.lk','pixelpoplk HBO DC series','ලැන්ටර්න්ස් සිංහල උපසිරැසි','Lanterns full series sinhala subtitles download','Lanterns sinhala sub web-dl','pixelpoplk sinhala subtitles','Lanterns DCU series','Green Lantern live action sinhala sub']::TEXT[], 'Sinhala', 'USA', 'Ongoing', 1, 'https://image.tmdb.org/t/p/original/isYpgPQdjxJ0Ht04uKgilVYGPp9.jpg', 'https://image.tmdb.org/t/p/original/isYpgPQdjxJ0Ht04uKgilVYGPp9.jpg', '2026-08-17 00:43:29.237961+00', '2026-08-17 00:43:29.237961+00') ON CONFLICT (id) DO UPDATE SET poster_path = EXCLUDED.poster_path, total_seasons = EXCLUDED.total_seasons;
INSERT INTO movies (id, title, original_title, type, description, release_date, year, runtime, imdb_rating, genres, seo_tags, language, country, status, total_seasons, poster_path, backdrop_path, created_at, updated_at) VALUES ('b16bd0d7-79c7-48db-acbf-5b55d6be7840', 'Dexter', 'Dexter', 'TV_SHOW', '🕵️‍♂️ Dexter Season 1 Episode 1 - සිංහල උපසිරැසි 🎬

Dexter Season 1 delivers a brilliant, darkly comedic psychological crime thriller from Showtime. A brilliant Miami forensics expert leads a double life as a meticulous vigilante serial killer who only hunts down other murderers. When a mysterious new killer begins leaving bloodless clues just for him, a high-stakes psychological game of cat-and-mouse begins.

ඔන්න අරගෙන ආවා Crime, Mystery වගේම Psychological Thriller කතාවලට ආස කරන අය හැමෝම අනිවාර්යයෙන්ම බලන්න ඕනේ, Showtime නාලිකාවෙන් නිකුත් කරපු ලෝක ප්‍රසිද්ධ ''Dexter'' කතා මාලාවේ පළමු කතා සමයේ (Season 1) පළමු වැනි කොටසට (Episode 1) සිංහල උපසිරැසි. IMDb එකේ 8.6/10ක ඉහළම රේටින් එකක් ගත්ත මේ සීරීස් එක, මුල ඉඳන් අගටම කුතුහලය උපරිමයෙන්ම තියාගෙන බලන්න පුළුවන් විශිෂ්ටතම නිර්මාණයක්.

කතාව පැත්තට ගියොත්, ඩෙක්ස්ටර් මෝගන් (Michael C. Hall) කියන්නේ මියාමි පොලිසියේ වැඩ කරන, ලේ පැල්ලම් ගැන පරීක්ෂණ පවත්වන දක්ෂ නිලධාරියෙක්. හැබැයි හැමෝටම පේන මේ සාමාන්‍ය ජීවිතයට අමතරව ඩෙක්ස්ටර්ට තව අඳුරු රහස් ජීවිතයක් තියෙනවා. ඒ තමයි එයා රෑට නීතියෙන් බේරිලා යන දරුණු වැරදිකරුවන් සොයාගෙන ඔවුන්ට දඬුවම් කරන රහසිගත ක්‍රියාකාරියෙක් (Vigilante) විදිහට වැඩ කරන එක. එයා මේ දේ කරන්නේ එයාගේ හදාගත්ත තාත්තා කියලා දුන්න දැඩි සීමාවන් සහ නීති මාලාවකට (The Code of Harry) අනුවයි.

මේ අතරේ මියාමි නගරයේ අමුතුම විදිහට අපරාධකරන අලුත් කෙනෙක් මතුවෙනවා. ''Ice Truck Killer'' විදිහට හඳුන්වන මේ පුද්ගලයා, තමන්ගේ ඉලක්කයන් ලේ බිඳක්වත් නැතිව සකසා පොදු ස්ථානවල දාලා යනවා. ඒ වගේම එයා ඩෙක්ස්ටර්ට විතරක් තේරෙන රහස් ඉඟි ඉතුරු කරමින් ඩෙක්ස්ටර් එක්ක අමුතුම මානසික සෙල්ලමක් කරන්න පටන් ගන්නවා. මේ රහස්‍ය පුද්ගලයා කවුද? එයා ඩෙක්ස්ටර් ගැන දන්නේ කොහොමද?

Michael C. Hall ගේ සුපිරිම රංගනයෙන් හැඩවුණු, හැම තත්පරේම කුතුහලයෙන් වගේම දරුණු suspense එකකින් බලන්න පුළුවන් මේ පට්ටම කතාව ඔයාගේ Must Watch ලිස්ට් එකට අනිවාර්යයෙන්ම එකතු කරගන්න.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නේ මෙහෙමයි:

📄 Direct Subtitle Download: කිසිම කරදරයක් නැතුව සිංහල උපසිරැසි ගොනුව (.zip) කෙලින්ම ඩවුන්ලෝඩ් කරගන්න පුළුවන්.

✈️ Telegram Download: 720p, 1080p Bluray කොපි ටෙලිග්‍රෑම් චැනල් එක හරහා ගන්න පුළුවන්.', '2006-01-01', 2006, 50, 8.6, ARRAY['Crime','Drama','Mystery','Thriller','Psychological']::TEXT[], ARRAY['Keywords: Dexter Season 1 Episode 1 Sinhala Subtitles','Dexter S01E01 sinhala sub','Dexter Season 1 sinhala subtitle download','Dexter S01E01 sinhala sub pixelpoplk','Dexter sinhala sub pixelpop.lk','pixelpoplk Showtime Dexter','ඩෙක්ස්ටර් සිංහල උපසිරැසි','Dexter full series sinhala subtitles download','Dexter season 1 sinhala sub bluray','pixelpoplk sinhala subtitles','crime drama series sinhala sub','psychological thriller sinhala sub | Description: Dexter Season 1 Episode 1 Sinhala Subtitles. Download Dexter S01E01 Sinhala Sub online from pixelpoplk.']::TEXT[], 'Sinhala', 'USA', 'Ongoing', 1, 'https://image.tmdb.org/t/p/original/rmhoMEHK3ZP2EAXX2VpxuKpW3Bf.jpg', 'https://image.tmdb.org/t/p/original/rmhoMEHK3ZP2EAXX2VpxuKpW3Bf.jpg', '2026-08-22 06:41:53.87792+00', '2026-08-22 06:41:53.87792+00') ON CONFLICT (id) DO UPDATE SET poster_path = EXCLUDED.poster_path, total_seasons = EXCLUDED.total_seasons;

-- 2. SEASONS
INSERT INTO seasons (id, movie_id, season_number, title, description, release_date, poster_path, episode_count, created_at, updated_at) VALUES ('5d5c3ba9-b154-4cd7-aa2f-c7d39a4193ab', 'd439155b-a6e0-4497-a8cd-aab4f6a88429', 1, 'Season 1', 'Sons of Anarchy Season 1', '2008-01-01', 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', 13, '2026-07-02 20:20:47.74712+00', '2026-07-02 20:20:47.74712+00') ON CONFLICT (movie_id, season_number) DO UPDATE SET episode_count = EXCLUDED.episode_count;
INSERT INTO seasons (id, movie_id, season_number, title, description, release_date, poster_path, episode_count, created_at, updated_at) VALUES ('40101ea4-8f61-4afe-a5ce-836fee184982', 'e4eca4e4-b362-4f1f-aa05-448470197acf', 3, 'Season 3', 'House Of The Dragon Season 3', '2026-01-01', 'https://image.tmdb.org/t/p/original/wSvDQN6tZR4VzDDZD3MUPIghVjC.jpg', 8, '2026-07-05 19:07:04.212977+00', '2026-07-05 19:07:04.212977+00') ON CONFLICT (movie_id, season_number) DO UPDATE SET episode_count = EXCLUDED.episode_count;
INSERT INTO seasons (id, movie_id, season_number, title, description, release_date, poster_path, episode_count, created_at, updated_at) VALUES ('e7eef909-777f-477d-ae80-aa7410f33b89', 'd439155b-a6e0-4497-a8cd-aab4f6a88429', 2, 'Season 2', 'Sons of Anarchy Season 2', '2008-01-01', 'https://image.tmdb.org/t/p/original/aIZ8Fze3sJHC0OWtYXIYVCKnpMr.jpg', 13, '2026-07-10 21:03:45.984807+00', '2026-07-10 21:03:45.984807+00') ON CONFLICT (movie_id, season_number) DO UPDATE SET episode_count = EXCLUDED.episode_count;
INSERT INTO seasons (id, movie_id, season_number, title, description, release_date, poster_path, episode_count, created_at, updated_at) VALUES ('009e9681-eb6c-4209-a8b5-115ac4c58259', 'd439155b-a6e0-4497-a8cd-aab4f6a88429', 3, 'Season 3', 'Sons of Anarchy Season 3', '2008-01-01', 'https://image.tmdb.org/t/p/original/tOdDvDXyRbKU0GIIlKxcjaN0SDN.jpg', 13, '2026-07-16 15:21:01.297081+00', '2026-07-16 15:21:01.297081+00') ON CONFLICT (movie_id, season_number) DO UPDATE SET episode_count = EXCLUDED.episode_count;
INSERT INTO seasons (id, movie_id, season_number, title, description, release_date, poster_path, episode_count, created_at, updated_at) VALUES ('f6bd855a-0c77-49b0-a975-0cc1b88bf232', '38c02fe6-2d82-40eb-a897-a95a7b1aa343', 1, 'Season 1', 'The East Palace (2026) Season 1', '2026-01-01', 'https://image.tmdb.org/t/p/original/yfYohBszGqoAW8oM0qydOtJ4kPh.jpg', 8, '2026-07-18 06:07:52.262353+00', '2026-07-18 06:07:52.262353+00') ON CONFLICT (movie_id, season_number) DO UPDATE SET episode_count = EXCLUDED.episode_count;
INSERT INTO seasons (id, movie_id, season_number, title, description, release_date, poster_path, episode_count, created_at, updated_at) VALUES ('189af987-8383-40e6-a82d-26b0f0ce1c09', 'd439155b-a6e0-4497-a8cd-aab4f6a88429', 4, 'Season 4', 'Sons of Anarchy Season 4', '2008-01-01', 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', 14, '2026-07-19 18:04:00.986472+00', '2026-07-19 18:04:00.986472+00') ON CONFLICT (movie_id, season_number) DO UPDATE SET episode_count = EXCLUDED.episode_count;
INSERT INTO seasons (id, movie_id, season_number, title, description, release_date, poster_path, episode_count, created_at, updated_at) VALUES ('7793265f-d915-44df-a361-888c8e6f2e97', '8a6ae59a-72f4-49b6-aa9f-60325070db02', 1, 'Season 1', 'Dune: Prophecy Season 1', '2024-01-01', 'https://image.tmdb.org/t/p/original/5B8Cxz8ZZXp3w2WmmdKTXpkS24e.jpg', 6, '2026-07-21 11:40:57.426392+00', '2026-07-21 11:40:57.426392+00') ON CONFLICT (movie_id, season_number) DO UPDATE SET episode_count = EXCLUDED.episode_count;
INSERT INTO seasons (id, movie_id, season_number, title, description, release_date, poster_path, episode_count, created_at, updated_at) VALUES ('475a4014-a733-400e-a11a-406b795015a4', 'd439155b-a6e0-4497-a8cd-aab4f6a88429', 5, 'Season 5', 'Sons of Anarchy Season 5', '2008-01-01', 'https://image.tmdb.org/t/p/original/sW67RSH740Ogrp6LGDCgpgGaK1u.jpg', 13, '2026-07-22 15:20:11.306013+00', '2026-07-22 15:20:11.306013+00') ON CONFLICT (movie_id, season_number) DO UPDATE SET episode_count = EXCLUDED.episode_count;
INSERT INTO seasons (id, movie_id, season_number, title, description, release_date, poster_path, episode_count, created_at, updated_at) VALUES ('ae16f018-861f-4083-a74e-223dc9b7f277', 'd439155b-a6e0-4497-a8cd-aab4f6a88429', 6, 'Season 6', 'Sons of Anarchy Season 6', '2008-01-01', 'https://image.tmdb.org/t/p/original/tB22kwHHXGAHT52P4bgBtBAPBRS.jpg', 13, '2026-07-25 11:21:03.246098+00', '2026-07-25 11:21:03.246098+00') ON CONFLICT (movie_id, season_number) DO UPDATE SET episode_count = EXCLUDED.episode_count;
INSERT INTO seasons (id, movie_id, season_number, title, description, release_date, poster_path, episode_count, created_at, updated_at) VALUES ('73c3fd9e-1f00-4fe7-a156-e1dc0ae06a9f', 'e6ca7b18-48c7-4684-a073-e0da1e5ac586', 3, 'Season 3', 'The Walking Dead: Dead City Season 3', '2023-01-01', 'https://image.tmdb.org/t/p/original/seYokxOjFyTVX13XgD2FNjWIry8.jpg', 3, '2026-07-26 09:14:46.57961+00', '2026-07-26 09:14:46.57961+00') ON CONFLICT (movie_id, season_number) DO UPDATE SET episode_count = EXCLUDED.episode_count;
INSERT INTO seasons (id, movie_id, season_number, title, description, release_date, poster_path, episode_count, created_at, updated_at) VALUES ('8a53dd11-3b8f-4853-a949-d19a7216fde8', '34044c4a-ae0d-4b36-ac01-6a2be3df5795', 1, 'Season 1', 'The Sopranos Season 1', '1997-01-01', 'https://image.tmdb.org/t/p/original/rTc7ZXdroqjkKivFPvCPX0Ru7uw.jpg', 13, '2026-07-28 16:58:59.501453+00', '2026-07-28 16:58:59.501453+00') ON CONFLICT (movie_id, season_number) DO UPDATE SET episode_count = EXCLUDED.episode_count;
INSERT INTO seasons (id, movie_id, season_number, title, description, release_date, poster_path, episode_count, created_at, updated_at) VALUES ('bc88d01f-ffdb-4d2c-ad97-aa59242e6ae9', 'd439155b-a6e0-4497-a8cd-aab4f6a88429', 7, 'Season 7', 'Sons of Anarchy Season 7', '2008-01-01', 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', 13, '2026-07-28 17:47:57.477299+00', '2026-07-28 17:47:57.477299+00') ON CONFLICT (movie_id, season_number) DO UPDATE SET episode_count = EXCLUDED.episode_count;
INSERT INTO seasons (id, movie_id, season_number, title, description, release_date, poster_path, episode_count, created_at, updated_at) VALUES ('5c4af11e-21f5-4ee9-a8a3-30fc4cf84989', '34933997-ea4a-4210-ad5d-fde3f6bcc8a0', 1, 'Season 1', 'Batman: Caped Crusader Season 1', '2024-01-01', 'https://image.tmdb.org/t/p/original/tJ7zq4VtvJqUyaRsLeNjpEFDXzk.jpg', 10, '2026-07-31 09:09:26.160221+00', '2026-07-31 09:09:26.160221+00') ON CONFLICT (movie_id, season_number) DO UPDATE SET episode_count = EXCLUDED.episode_count;
INSERT INTO seasons (id, movie_id, season_number, title, description, release_date, poster_path, episode_count, created_at, updated_at) VALUES ('40dee2dc-1a40-4b47-acaf-4308fe7654ba', '34044c4a-ae0d-4b36-ac01-6a2be3df5795', 2, 'Season 2', 'The Sopranos Season 2', '2000-01-01', 'https://image.tmdb.org/t/p/original/u7dlARwP2zsqHaMNL5HtHhaEPea.jpg', 13, '2026-08-04 13:03:55.568064+00', '2026-08-04 13:03:55.568064+00') ON CONFLICT (movie_id, season_number) DO UPDATE SET episode_count = EXCLUDED.episode_count;
INSERT INTO seasons (id, movie_id, season_number, title, description, release_date, poster_path, episode_count, created_at, updated_at) VALUES ('6d68cd70-3068-491f-a91e-e8e5bbbd03ff', '842ac5eb-df6a-4881-a963-d47350bdd111', 1, 'Season 1', 'Black Bird Season 1', '2022-01-01', 'https://image.tmdb.org/t/p/original/qu312pwM61NPTr7nexvovCClDNP.jpg', 6, '2026-08-06 10:35:58.56554+00', '2026-08-06 10:35:58.56554+00') ON CONFLICT (movie_id, season_number) DO UPDATE SET episode_count = EXCLUDED.episode_count;
INSERT INTO seasons (id, movie_id, season_number, title, description, release_date, poster_path, episode_count, created_at, updated_at) VALUES ('6d2489a4-b5aa-49c4-a658-5e50fa711912', 'c70fa02f-bdf7-4ce8-a5e6-a4c04b4ea5e5', 1, 'Season 1', 'Our Sticky Love Season 1', '2026-01-01', 'https://image.tmdb.org/t/p/original/tSZ4aFpTGc8Oj52SuzPUUZ7WKL0.jpg', 1, '2026-08-08 08:30:23.609856+00', '2026-08-08 08:30:23.609856+00') ON CONFLICT (movie_id, season_number) DO UPDATE SET episode_count = EXCLUDED.episode_count;
INSERT INTO seasons (id, movie_id, season_number, title, description, release_date, poster_path, episode_count, created_at, updated_at) VALUES ('4e2222e6-e565-426a-a473-df805e1bdcbe', '9590db82-7e72-4ade-a714-4acc2da3170d', 1, 'Season 1', 'The Night of Season 1', '2016-01-01', 'https://image.tmdb.org/t/p/original/q13XJHdnsmxQL9rXRcnNDrZGHjO.jpg', 8, '2026-08-08 11:01:21.636301+00', '2026-08-08 11:01:21.636301+00') ON CONFLICT (movie_id, season_number) DO UPDATE SET episode_count = EXCLUDED.episode_count;
INSERT INTO seasons (id, movie_id, season_number, title, description, release_date, poster_path, episode_count, created_at, updated_at) VALUES ('18944e7f-ca0e-4ec1-aa46-83a127da60fc', '34044c4a-ae0d-4b36-ac01-6a2be3df5795', 3, 'Season 3', 'The Sopranos Season 3', '2001-01-01', 'https://image.tmdb.org/t/p/original/fg2sTwO5FglA1S6prL7GlCo124n.jpg', 13, '2026-08-11 13:42:49.900781+00', '2026-08-11 13:42:49.900781+00') ON CONFLICT (movie_id, season_number) DO UPDATE SET episode_count = EXCLUDED.episode_count;
INSERT INTO seasons (id, movie_id, season_number, title, description, release_date, poster_path, episode_count, created_at, updated_at) VALUES ('672b0d61-4b51-4c36-a1ac-0e59ba524723', '24e0838d-f148-4401-a04b-6e7881bd93ee', 4, 'Season 4', 'Reacher Season 4', '2026-01-01', 'https://image.tmdb.org/t/p/original/wkKJHC34dIw9cJwAfNEEgDdb2ol.jpg', 3, '2026-08-12 08:51:51.598699+00', '2026-08-12 08:51:51.598699+00') ON CONFLICT (movie_id, season_number) DO UPDATE SET episode_count = EXCLUDED.episode_count;
INSERT INTO seasons (id, movie_id, season_number, title, description, release_date, poster_path, episode_count, created_at, updated_at) VALUES ('0ad44dce-04c9-49e5-ab78-a0f85ebdbe45', '34044c4a-ae0d-4b36-ac01-6a2be3df5795', 4, 'Season 4', 'The Sopranos Season 4', '2002-01-01', 'https://image.tmdb.org/t/p/original/EwMBNMUIx9kKf0DpijNF1bncJT.jpg', 13, '2026-08-15 23:36:34.227099+00', '2026-08-15 23:36:34.227099+00') ON CONFLICT (movie_id, season_number) DO UPDATE SET episode_count = EXCLUDED.episode_count;
INSERT INTO seasons (id, movie_id, season_number, title, description, release_date, poster_path, episode_count, created_at, updated_at) VALUES ('e51f6dc2-9dc4-470d-a724-3dc29628ffa2', 'e80dd75e-0b11-4662-ad8e-66165f1cbd76', 1, 'Season 1', 'Lanterns (2026) Season 1', '2026-01-01', 'https://image.tmdb.org/t/p/original/isYpgPQdjxJ0Ht04uKgilVYGPp9.jpg', 1, '2026-08-17 00:43:29.237961+00', '2026-08-17 00:43:29.237961+00') ON CONFLICT (movie_id, season_number) DO UPDATE SET episode_count = EXCLUDED.episode_count;
INSERT INTO seasons (id, movie_id, season_number, title, description, release_date, poster_path, episode_count, created_at, updated_at) VALUES ('d8cfb2ad-122c-4233-a3c4-1e5273a7950a', 'b16bd0d7-79c7-48db-acbf-5b55d6be7840', 1, 'Season 1', 'Dexter Season 1', '2006-01-01', 'https://image.tmdb.org/t/p/original/rmhoMEHK3ZP2EAXX2VpxuKpW3Bf.jpg', 12, '2026-08-22 06:41:53.87792+00', '2026-08-22 06:41:53.87792+00') ON CONFLICT (movie_id, season_number) DO UPDATE SET episode_count = EXCLUDED.episode_count;

-- 3. EPISODES
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('912b2ab3-2322-42ae-a212-39b1028bfe63', '5d5c3ba9-b154-4cd7-aa2f-c7d39a4193ab', 1, 'Episode 1', 'Sons of Anarchy (SAMCRO)  ☠️ සැබෑ සහෝදරත්වයේ සහ අපරාධ ලෝකයේ දරුණුතම සටන

​Breaking Bad, Peaky Blinders, Banshee වගේ Extreme Drama සහ Crime සීරීස් බලන්න ආස කරන කෙනෙක් නම්, Sons of Anarchy (SOA) කියන්නේ අනිවාර්යයෙන්ම මඟනොහැරිය යුතු Masterpiece එකක්. 💯

IMDb දර්ශකයේ 8.5/10 ක ඉහළම අගයක් ලබාගනිමින්, ලොව පුරා මිලියන ගණනක ප්‍රේක්ෂක ආකර්ෂණයක් දිනාගත් මේ කතාමාලාව, සාමාන්‍ය ටීවී සීරීස් එකකට වඩා එහා ගිය වෙනස්ම අත්දැකීමක්!❤️

​කතාව මොකක්ද?🔰

​කාලිෆෝනියාවේ "චාමිං" (Charming) කියන කුඩා නගරය කේන්ද්‍ර කරගෙන, නීතියට පිටින් මෝටර් සයිකල් පදවන කල්ලියක් (Outlaw Motorcycle Club) වන SAMCRO (Sons of Anarchy Motorcycle Club, Redwood Original) වටා තමයි මේ කතාව ගෙතෙන්නේ. බැලූ බැල්මට මෝටර් සයිකල් සමාජ ශාලාවක් වුණත්, තිරය පිටුපස මොවුන් මහා පරිමාණ නීතිවිරෝධී අවි ආයුධ ජාවාරමක නිරත වෙනවා.
​කල්ලියේ උප සභාපති වෙන තරුණ, බුද්ධිමත් Jax Teller ට තමන්ගේ මියගිය පියා ලියපු රහස් දිනපොතක් හමුවීමත් එක්ක මුළු කතාවම වෙනස් මඟකට හැරෙනවා. ක්ලබ් එකේ වර්තමාන ක්‍රියාකලාපය සහ තමන්ගේ පියාගේ සැබෑ දැක්ම අතර අතරමං වන ජැක්ස්ට, තමන්ගේ පවුල ආරක්ෂා කරගනිමින් මේ දරුණු අපරාධ ලෝකයේ කරන වැඩ ගැන තමයි කතාවේ තියෙන්නේ.🔥

නීතිය, අපරාධ කල්ලි, පොලිසිය සහ පවුල අතර මැද දෝලනය වන මේ Tv series එක, 
කුතුහලයෙන් යුතුව සිංහල substitute එක්ක  රස විදින්න.👈', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-02 20:20:47.74712+00', '2026-07-02 20:20:47.74712+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('d7d2a13f-ed0a-452d-a330-aa6b930a31ec', '40101ea4-8f61-4afe-a5ce-836fee184982', 3, 'Episode 3', 'House of the Dragon තුන්වෙනි සීසන් එකේ තුන්වෙනි එපිසෝඩ් එකට සබ් එක තමයි මේ ගෙනාවේ. කලින් එපිසෝඩ් එකේදී ඒමොන්ඩ් වේගාර් එක්ක හැරන්හෝල් වලට ගියපු වෙලාවෙන් ප්‍රයෝජන අරගෙන, ඇලිසන්ට්ගේ සහ හෙලේනාගේ සහයෝගයත් එක්ක කිසිම කරදරයක් නැතුව රෙනයිරා King''s Landing නුවර බලය අතට ගත්තා මතකනේ. ඔටෝ හයිටවර්ට දඬුවම් දීලා Iron Throne එකේ බලය පිහිටෙව්වත්, ඒගොන්වයි ලැරිස්වයි කොටුකරගන්න බැරි වුණා. රෙනයිරාට මේ අලුත් බලය කොහොම පාලනය කරන්න වෙයිද, ඒ වගේම හැරන්හෝල් ගිය ඒමන්ඩ්ට මීලගට මොකක් වෙයිද කියලා මේ කොටසින් බලාගන්න පුළුවන්.

​මේකේ Direct sub එක පහළින්ම ඩවුන්ලෝඩ් කරගන්න පහසුකම තියෙනවා. ඒ වගේම Telegram එකෙන් 720p, 1080p සහ 4K අලුත්ම WEB-DL වීඩියෝ පිටපත් එක්කම සබ් එකත් ලේසියෙන්ම අරගෙන සිංහල උපසිරැසි එක්කම කතාව රසවිඳින්නත් පුළුවන්.

ඊලග  Episode එකත් ඉක්මනින්ම ලබාගන්න අපේ Telegram channel එකට සහ Fb page එකට join වෙලා ඉන්න යාලුවනේ. ඒවගේම ගැටලු ඇත්නම් Request  එකක් යොමු කරන්න.', '2026-01-01', 50, 8.3, 'https://image.tmdb.org/t/p/original/wSvDQN6tZR4VzDDZD3MUPIghVjC.jpg', '2026-07-05 19:07:04.212977+00', '2026-07-05 19:07:04.212977+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('e9ec4820-ae59-4c5d-a2d2-a0bfeb571b49', '5d5c3ba9-b154-4cd7-aa2f-c7d39a4193ab', 2, 'Episode 2', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?
1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:
පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.
පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).
පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.
භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.
2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.
එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.
එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.
📌 අලුත්ම Updates ලබාගැනීමට:
චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-06 17:23:49.258164+00', '2026-07-06 17:23:49.258164+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('130421e6-7fff-48bc-acbc-b6413b7d7f95', '5d5c3ba9-b154-4cd7-aa2f-c7d39a4193ab', 3, 'Episode 3', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?
1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:
පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.
පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).
පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.
භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.
2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.
එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.
එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.
📌 අලුත්ම Updates ලබාගැනීමට:
චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-06 18:51:33.429257+00', '2026-07-06 18:51:33.429257+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('6eab0a74-a85c-43d3-adde-3708df59e4fa', '5d5c3ba9-b154-4cd7-aa2f-c7d39a4193ab', 4, 'Episode 4', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?
1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:
පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.
පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).
පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.
භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.
2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.
එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.
එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.
📌 අලුත්ම Updates ලබාගැනීමට:
චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-06 18:51:33.429257+00', '2026-07-06 18:51:33.429257+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('80cbe5f1-9a04-4c31-a897-2ad12135327c', '5d5c3ba9-b154-4cd7-aa2f-c7d39a4193ab', 5, 'Episode 5', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?
1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:
පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.
පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).
පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.
භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.
2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.
එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.
එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.
📌 අලුත්ම Updates ලබාගැනීමට:
චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-06 18:51:33.429257+00', '2026-07-06 18:51:33.429257+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('08367973-c5da-4826-a0c3-50c6b8ea613b', '5d5c3ba9-b154-4cd7-aa2f-c7d39a4193ab', 6, 'Episode 6', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?
1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:
පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.
පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).
පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.
භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.
2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.
එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.
එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.
📌 අලුත්ම Updates ලබාගැනීමට:
චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-06 18:51:33.429257+00', '2026-07-06 18:51:33.429257+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('7b534471-5ec0-428a-a903-a492f0bac484', '5d5c3ba9-b154-4cd7-aa2f-c7d39a4193ab', 7, 'Episode 7', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?
1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:
පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.
පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).
පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.
භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.
2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.
එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.
එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.
📌 අලුත්ම Updates ලබාගැනීමට:
චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-06 18:51:33.429257+00', '2026-07-06 18:51:33.429257+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('4d044d42-83db-4d92-ab9d-5e844d46af80', '5d5c3ba9-b154-4cd7-aa2f-c7d39a4193ab', 8, 'Episode 8', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?
1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:
පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.
පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).
පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.
භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.
2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.
එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.
එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.
📌 අලුත්ම Updates ලබාගැනීමට:
චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-06 18:51:33.429257+00', '2026-07-06 18:51:33.429257+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('7e74aa1f-e5a1-404b-afad-d34277775c00', '5d5c3ba9-b154-4cd7-aa2f-c7d39a4193ab', 9, 'Episode 9', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?
1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:
පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.
පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).
පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.
භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.
2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.
එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.
එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.
📌 අලුත්ම Updates ලබාගැනීමට:
චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-06 18:51:33.429257+00', '2026-07-06 18:51:33.429257+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('ccf25e3d-dce1-489e-a7e3-887f3e3684a4', '5d5c3ba9-b154-4cd7-aa2f-c7d39a4193ab', 10, 'Episode 10', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?
1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:
පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.
පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).
පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.
භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.
2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.
එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.
එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.
📌 අලුත්ම Updates ලබාගැනීමට:
චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-06 18:51:33.429257+00', '2026-07-06 18:51:33.429257+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('9b1833d7-6b9d-450e-a1e1-c8c474fac864', '5d5c3ba9-b154-4cd7-aa2f-c7d39a4193ab', 11, 'Episode 11', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?
1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:
පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.
පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).
පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.
භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.
2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.
එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.
එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.
📌 අලුත්ම Updates ලබාගැනීමට:
චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-06 18:51:33.429257+00', '2026-07-06 18:51:33.429257+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('0080317b-1392-475f-a627-015e66067c91', '5d5c3ba9-b154-4cd7-aa2f-c7d39a4193ab', 12, 'Episode 12', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?
1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:
පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.
පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).
පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.
භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.
2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.
එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.
එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.
📌 අලුත්ම Updates ලබාගැනීමට:
චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-06 18:51:33.429257+00', '2026-07-06 18:51:33.429257+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('0ce713eb-5148-4a97-a6e0-76a1beebc49f', '5d5c3ba9-b154-4cd7-aa2f-c7d39a4193ab', 13, 'Episode 13', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?
1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:
පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.
පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).
පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.
භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.
2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.
එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.
එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.
📌 අලුත්ම Updates ලබාගැනීමට:
චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-06 18:51:33.429257+00', '2026-07-06 18:51:33.429257+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('501b9add-7c98-4b1f-a385-fde8dfc42fa5', 'e7eef909-777f-477d-ae80-aa7410f33b89', 1, 'Episode 1', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/aIZ8Fze3sJHC0OWtYXIYVCKnpMr.jpg', '2026-07-10 21:03:45.984807+00', '2026-07-10 21:03:45.984807+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('2d08b8d2-2930-4b28-ac73-1d109580fda9', 'e7eef909-777f-477d-ae80-aa7410f33b89', 2, 'Episode 2', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/aIZ8Fze3sJHC0OWtYXIYVCKnpMr.jpg', '2026-07-10 21:03:45.984807+00', '2026-07-10 21:03:45.984807+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('7776b392-0042-4380-aba5-edd834ecd8c1', 'e7eef909-777f-477d-ae80-aa7410f33b89', 3, 'Episode 3', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා มාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/aIZ8Fze3sJHC0OWtYXIYVCKnpMr.jpg', '2026-07-10 21:03:45.984807+00', '2026-07-10 21:03:45.984807+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('fe745258-41e9-440d-ac56-9089056e8162', 'e7eef909-777f-477d-ae80-aa7410f33b89', 4, 'Episode 4', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/aIZ8Fze3sJHC0OWtYXIYVCKnpMr.jpg', '2026-07-10 21:03:45.984807+00', '2026-07-10 21:03:45.984807+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('b076b5cd-62f0-45cd-a063-a84af0ed7dcb', 'e7eef909-777f-477d-ae80-aa7410f33b89', 5, 'Episode 5', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/aIZ8Fze3sJHC0OWtYXIYVCKnpMr.jpg', '2026-07-10 21:03:45.984807+00', '2026-07-10 21:03:45.984807+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('9fa4c5a1-d432-4f13-a729-a8f1ee92775a', 'e7eef909-777f-477d-ae80-aa7410f33b89', 6, 'Episode 6', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/aIZ8Fze3sJHC0OWtYXIYVCKnpMr.jpg', '2026-07-10 21:03:45.984807+00', '2026-07-10 21:03:45.984807+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('fee1a5ec-118e-4f40-a7dd-dbf61b9b671d', '40101ea4-8f61-4afe-a5ce-836fee184982', 4, 'Episode 4', '🐉 House of the Dragon [Season 03 : Episode 04] - සිංහල උපසිරැසි 🎬

පසුගිය 3 වෙනි කොටසෙන් කතාව සම්පූර්ණයෙන්ම උඩුයටිකුරු කරන ලොකු හැරවුම් ලක්ෂ්‍ය කිහිපයක්ම සිද්ධ වුණා. 👑 Rhaenyra විසින් Aegon මියගිය බව ප්‍රකාශ කරලා King''s Landing වල තමන්ගේ බලය ස්ථාවර කරගන්න උත්සාහ කරද්දී, Ulf White, Hugh Hammer සහ Addam of Hull නිල වශයෙන් knightsලා බවට පත්වුණා. හැබැයි Harrenhal බලකොටුවෙන් පසු 🐉 Aemond සහ Vhagar මකරා අතුරුදන් වීමත්, Ormund Hightower සැබෑ Daeron Targaryenව සඟවාගෙන Tumbleton නගරය ආක්‍රමණය කිරීමත් නිසා Team Black එකට අලුත් තර්ජනයක් මතු වුණා. ⚔️

මේ සියලු ගැටලු මැද, Daemon විසින් Lady Arryn මුණගැසීමට The Vale බලා පිටත්ව යන අතරතුර, අද විකාශය වන 4 වැනි කොටසින් සැබෑ Daeronගේ පැමිණීමත් සමඟ සිදුවන දේශපාලන පෙරළිය සහ Aemondගේ අබිරහස ලිහෙන්නේ කොහොමද කියලා බලාගන්න පුළුවන්. 🧐

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram පිටපත්: වීඩියෝව සමඟ උපසිරැසි නැරඹීමට කැමති අය සඳහා 720p, 1080p සහ 4K උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් සහ උපසිරැසි සියල්ලම ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2026-01-01', 50, 8.3, 'https://image.tmdb.org/t/p/original/wSvDQN6tZR4VzDDZD3MUPIghVjC.jpg', '2026-07-13 01:46:09.988815+00', '2026-07-13 01:46:09.988815+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('5865956a-2dea-490d-aca4-e12a48b4052c', 'e7eef909-777f-477d-ae80-aa7410f33b89', 7, 'Episode 7', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/aIZ8Fze3sJHC0OWtYXIYVCKnpMr.jpg', '2026-07-14 11:59:44.37195+00', '2026-07-14 11:59:44.37195+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('e9b7dc41-4868-4e77-af89-5bf4f29c0b78', 'e7eef909-777f-477d-ae80-aa7410f33b89', 8, 'Episode 8', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/aIZ8Fze3sJHC0OWtYXIYVCKnpMr.jpg', '2026-07-14 11:59:44.37195+00', '2026-07-14 11:59:44.37195+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('ec3e5305-ec7d-47f1-a8a7-98ee6baca31f', 'e7eef909-777f-477d-ae80-aa7410f33b89', 9, 'Episode 9', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/aIZ8Fze3sJHC0OWtYXIYVCKnpMr.jpg', '2026-07-14 11:59:44.37195+00', '2026-07-14 11:59:44.37195+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('455acaea-abe3-4ef2-a545-cf518a7d60cb', 'e7eef909-777f-477d-ae80-aa7410f33b89', 10, 'Episode 10', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/aIZ8Fze3sJHC0OWtYXIYVCKnpMr.jpg', '2026-07-14 11:59:44.37195+00', '2026-07-14 11:59:44.37195+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('3bc7f956-2b03-447e-af1b-30679dddddc9', 'e7eef909-777f-477d-ae80-aa7410f33b89', 11, 'Episode 11', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/aIZ8Fze3sJHC0OWtYXIYVCKnpMr.jpg', '2026-07-14 11:59:44.37195+00', '2026-07-14 11:59:44.37195+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('72b6fbc9-3c36-443a-a6b5-1e337dec79d5', 'e7eef909-777f-477d-ae80-aa7410f33b89', 12, 'Episode 12', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/aIZ8Fze3sJHC0OWtYXIYVCKnpMr.jpg', '2026-07-14 11:59:44.37195+00', '2026-07-14 11:59:44.37195+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('47bed304-d417-4d22-a9a4-46ff0c3ca728', 'e7eef909-777f-477d-ae80-aa7410f33b89', 13, 'Episode 13', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/aIZ8Fze3sJHC0OWtYXIYVCKnpMr.jpg', '2026-07-14 11:59:44.37195+00', '2026-07-14 11:59:44.37195+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('d2606136-6589-4216-a7d7-c921c52d8391', '009e9681-eb6c-4209-a8b5-115ac4c58259', 1, 'Episode 1', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/tOdDvDXyRbKU0GIIlKxcjaN0SDN.jpg', '2026-07-16 15:21:01.297081+00', '2026-07-16 15:21:01.297081+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('c372ba8b-3837-47ca-a53c-0358a144f9b3', '009e9681-eb6c-4209-a8b5-115ac4c58259', 2, 'Episode 2', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/tOdDvDXyRbKU0GIIlKxcjaN0SDN.jpg', '2026-07-16 15:21:01.297081+00', '2026-07-16 15:21:01.297081+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('94cfd6ac-c1e9-43ba-ac16-a9c366bdfdff', '009e9681-eb6c-4209-a8b5-115ac4c58259', 3, 'Episode 3', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/tOdDvDXyRbKU0GIIlKxcjaN0SDN.jpg', '2026-07-16 15:21:01.297081+00', '2026-07-16 15:21:01.297081+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('d4f49640-ccda-488e-a7f9-c4000d59fb2c', '009e9681-eb6c-4209-a8b5-115ac4c58259', 4, 'Episode 4', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/tOdDvDXyRbKU0GIIlKxcjaN0SDN.jpg', '2026-07-16 15:21:01.297081+00', '2026-07-16 15:21:01.297081+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('eb619e4d-c2a6-4733-afa2-695c040bbb71', '009e9681-eb6c-4209-a8b5-115ac4c58259', 5, 'Episode 5', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/tOdDvDXyRbKU0GIIlKxcjaN0SDN.jpg', '2026-07-16 15:21:01.297081+00', '2026-07-16 15:21:01.297081+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('98fa1ea1-770d-4fff-acf6-d188e48d4edd', '009e9681-eb6c-4209-a8b5-115ac4c58259', 6, 'Episode 6', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/tOdDvDXyRbKU0GIIlKxcjaN0SDN.jpg', '2026-07-17 13:58:47.835069+00', '2026-07-17 13:58:47.835069+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('bac9e140-45d0-4d60-a9e7-65013015e9a6', '009e9681-eb6c-4209-a8b5-115ac4c58259', 7, 'Episode 7', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/tOdDvDXyRbKU0GIIlKxcjaN0SDN.jpg', '2026-07-17 13:58:47.835069+00', '2026-07-17 13:58:47.835069+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('aad2f5ff-8b1a-4227-a69d-738f6fd09262', '009e9681-eb6c-4209-a8b5-115ac4c58259', 8, 'Episode 8', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/tOdDvDXyRbKU0GIIlKxcjaN0SDN.jpg', '2026-07-17 13:58:47.835069+00', '2026-07-17 13:58:47.835069+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('b5e206f2-b7b4-463d-a793-aa55f5fc5203', '009e9681-eb6c-4209-a8b5-115ac4c58259', 9, 'Episode 9', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/tOdDvDXyRbKU0GIIlKxcjaN0SDN.jpg', '2026-07-17 13:58:47.835069+00', '2026-07-17 13:58:47.835069+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('17d1f196-4d18-4d69-aefc-4b0ae10dd230', '009e9681-eb6c-4209-a8b5-115ac4c58259', 10, 'Episode 10', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/tOdDvDXyRbKU0GIIlKxcjaN0SDN.jpg', '2026-07-17 13:58:47.835069+00', '2026-07-17 13:58:47.835069+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('eeeb736f-887f-4f3b-aa8f-57e090848623', '009e9681-eb6c-4209-a8b5-115ac4c58259', 11, 'Episode 11', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/tOdDvDXyRbKU0GIIlKxcjaN0SDN.jpg', '2026-07-17 13:58:47.835069+00', '2026-07-17 13:58:47.835069+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('a5dff875-a09a-4e56-af63-63bce732bf92', '009e9681-eb6c-4209-a8b5-115ac4c58259', 12, 'Episode 12', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/tOdDvDXyRbKU0GIIlKxcjaN0SDN.jpg', '2026-07-17 13:58:47.835069+00', '2026-07-17 13:58:47.835069+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('1fe002bc-e2d9-46da-abc4-32ef92d71d6b', '009e9681-eb6c-4209-a8b5-115ac4c58259', 13, 'Episode 13', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/tOdDvDXyRbKU0GIIlKxcjaN0SDN.jpg', '2026-07-17 13:58:47.835069+00', '2026-07-17 13:58:47.835069+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('f3bdae01-5b44-4098-a794-4703410f491c', 'f6bd855a-0c77-49b0-a975-0cc1b88bf232', 1, 'Episode 1', 'Netflix එකෙන් ගෙනාපු අලුත්ම Horror / Dark Fantasy කතාව - The East Palace (Donggung)! 🎬🔥

Kingdom, The Guest වගේ කතාවලට ආස අයට වගේම, හොල්මන්, අද්භූත Monsters ලා ඉන්න Action Thriller කතා පිස්සුවෙන් වගේ බලන අයට මේක සුපිරි භාණ්ඩයක්. 👻⚔️

කතාව යන්නේ ජොසොන් යුගයේ අභිරහස් සාපයකට ලක්වුණු රජ මාලිගාවක් ගැන. මාලිගාවේ පොකුණක ඉන්න භයානක භූතයෙක් නිසා රජ පවුලේ කුමාරවරු එකින් එක මැරෙනවා. මේක නවත්තන්න හොල්මන් සහ යක්ෂයෝ දඩයම් කරන අකීකරු කඩුවැල්කරුවෙකුයි (Nam Joo-hyuk), මළගිය අයගේ සද්ද ඇහෙන මාලිගාවේ සේවිකාවකුයි (Roh Yoon-seo) එකතු වෙලා ගේමක් ගහනවා.
VFX, පට්ට Action සහ ලේ වැගිරීම් එහෙම උපරිමයටම තියෙනවා. ඒ වගේම මේක Nam Joo-hyuk හමුදාවෙන් ආවට පස්සෙ කරන පලවෙනි කතාව නිසා මාර Hype එකක් තියෙන්නේ.

🔥 මේකේ තවත් විශේෂ කතාවක් තියෙනවා!
මේ කතා මාලාවේ ෂූටින් කරගෙන යන අතරතුර සෙට් එකේ ලොකු ගින්නක් ඇතිවෙලා මුළු ස්ටූඩියෝ එකම විනාශ වුණා. වාසනාවකට කාටවත් අනතුරක් වුණේ නැහැ. ඒ හැම බාධකයක්ම මැදින් තමයි මේ සුපිරි නිර්මාණය ඔයාලට බලන්න ඇවිත් තියෙන්නේ!

මේ පට්ටම Horror සීරිස් එක තව සුළු මොහොතකින් අපේ Telegram Channel එක සහ Website එක හරහා සිංහල උපසිරැසි (Sinhala Sub) සමඟින්ම ඔයාලට නරඹන්න පුළුවන්! 🥳🎉', '2026-01-01', 50, 7.6, 'https://image.tmdb.org/t/p/original/yfYohBszGqoAW8oM0qydOtJ4kPh.jpg', '2026-07-18 06:07:52.262353+00', '2026-07-18 06:07:52.262353+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('22c151e6-99ac-4fce-a987-8437b8e36a56', 'f6bd855a-0c77-49b0-a975-0cc1b88bf232', 2, 'Episode 2', 'Netflix එකෙන් ගෙනාපු අලුත්ම Horror / Dark Fantasy කතාව - The East Palace (Donggung)! 🎬🔥

Kingdom, The Guest වගේ කතාවලට ආස අයට වගේම, හොල්මන්, අද්භූත Monsters ලා ඉන්න Action Thriller කතා පිස්සුවෙන් වගේ බලන අයට මේක සුපිරි භාණ්ඩයක්. 👻⚔️

කතාව යන්නේ ජොසොන් යුගයේ අභිරහස් සාපයකට ලක්වුණු රජ මාලිගාවක් ගැන. මාලිගාවේ පොකුණක ඉන්න භයානක භූතයෙක් නිසා රජ පවුලේ කුමාරවරු එකින් එක මැරෙනවා. මේක නවත්තන්න හොල්මන් සහ යක්ෂයෝ දඩයම් කරන අකීකරු කඩුවැල්කරුවෙකුයි (Nam Joo-hyuk), මළගිය අයගේ සද්ද ඇහෙන මාලිගාවේ සේවිකාවකුයි (Roh Yoon-seo) එකතු වෙලා ගේමක් ගහනවා.
VFX, පට්ට Action සහ ලේ වැගිරීම් එහෙම උපරිමයටම තියෙනවා. ඒ වගේම මේක Nam Joo-hyuk හමුදාවෙන් ආවට පස්සෙ කරන පලවෙනි කතාව නිසා මාර Hype එකක් තියෙන්නේ.

🔥 මේකේ තවත් විශේෂ කතාවක් තියෙනවා!

මේ කතා මාලාවේ ෂූටින් කරගෙන යන අතරතුර සෙට් එකේ ලොකු ගින්නක් ඇතිවෙලා මුළු ස්ටූඩියෝ එකම විනාශ වුණා. වාසනාවකට කාටවත් අනතුරක් වුණේ නැහැ. ඒ හැම බාධකයක්ම මැදින් තමයි මේ සුපිරි නිර්මාණය ඔයාලට බලන්න ඇවිත් තියෙන්නේ!

මේ පට්ටම Horror සීරිස් එක තව සුළු මොහොතකින් අපේ Telegram Channel එක සහ Website එක හරහා සිංහල උපසිරැසි (Sinhala Sub) සමඟින්ම ඔයාලට නරඹන්න පුළුවන්! 🥳🎉', '2026-01-01', 50, 7.6, 'https://image.tmdb.org/t/p/original/yfYohBszGqoAW8oM0qydOtJ4kPh.jpg', '2026-07-18 06:09:35.713148+00', '2026-07-18 06:09:35.713148+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('dc7822df-1754-4be2-aed8-add4988a3e02', 'f6bd855a-0c77-49b0-a975-0cc1b88bf232', 3, 'Episode 3', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2026-01-01', 50, 7.6, 'https://image.tmdb.org/t/p/original/yfYohBszGqoAW8oM0qydOtJ4kPh.jpg', '2026-07-18 17:41:59.995576+00', '2026-07-18 17:41:59.995576+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('b1794662-3545-48b5-ab09-f0694d94b947', 'f6bd855a-0c77-49b0-a975-0cc1b88bf232', 4, 'Episode 4', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2026-01-01', 50, 7.6, 'https://image.tmdb.org/t/p/original/yfYohBszGqoAW8oM0qydOtJ4kPh.jpg', '2026-07-18 17:41:59.995576+00', '2026-07-18 17:41:59.995576+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('3d5128aa-b66b-4def-adb5-e834b398b028', 'f6bd855a-0c77-49b0-a975-0cc1b88bf232', 5, 'Episode 5', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2026-01-01', 50, 7.6, 'https://image.tmdb.org/t/p/original/yfYohBszGqoAW8oM0qydOtJ4kPh.jpg', '2026-07-18 17:41:59.995576+00', '2026-07-18 17:41:59.995576+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('413fcb34-2c58-4f47-ac85-9d81465233d6', 'f6bd855a-0c77-49b0-a975-0cc1b88bf232', 6, 'Episode 6', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2026-01-01', 50, 7.6, 'https://image.tmdb.org/t/p/original/yfYohBszGqoAW8oM0qydOtJ4kPh.jpg', '2026-07-18 17:41:59.995576+00', '2026-07-18 17:41:59.995576+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('74eeabd1-00f9-4c43-a0d7-e3aff995fa5f', 'f6bd855a-0c77-49b0-a975-0cc1b88bf232', 7, 'Episode 7', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2026-01-01', 50, 7.6, 'https://image.tmdb.org/t/p/original/yfYohBszGqoAW8oM0qydOtJ4kPh.jpg', '2026-07-18 17:41:59.995576+00', '2026-07-18 17:41:59.995576+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('81b3aec6-8271-4258-ad06-a768a577b139', 'f6bd855a-0c77-49b0-a975-0cc1b88bf232', 8, 'Episode 8', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2026-01-01', 50, 7.6, 'https://image.tmdb.org/t/p/original/yfYohBszGqoAW8oM0qydOtJ4kPh.jpg', '2026-07-18 17:41:59.995576+00', '2026-07-18 17:41:59.995576+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('e2653cfb-e48d-48b6-a5a4-089b70420785', '40101ea4-8f61-4afe-a5ce-836fee184982', 2, 'Episode 2', NULL, '2026-01-01', 50, 8.3, 'https://image.tmdb.org/t/p/original/wSvDQN6tZR4VzDDZD3MUPIghVjC.jpg', '2026-07-18 18:03:31.96276+00', '2026-07-18 18:03:31.96276+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('9a2076e3-ab74-45b0-a531-2f1c5107a11b', '40101ea4-8f61-4afe-a5ce-836fee184982', 1, 'Episode 1', NULL, '2026-01-01', 50, 8.3, 'https://image.tmdb.org/t/p/original/wSvDQN6tZR4VzDDZD3MUPIghVjC.jpg', '2026-07-18 18:05:34.87458+00', '2026-07-18 18:05:34.87458+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('d9d4f053-4098-4a04-a98c-12d316731311', '189af987-8383-40e6-a82d-26b0f0ce1c09', 1, 'Episode 1', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-19 18:04:00.986472+00', '2026-07-19 18:04:00.986472+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('584d05cf-344d-40e2-a516-a59ef8c9f405', '189af987-8383-40e6-a82d-26b0f0ce1c09', 2, 'Episode 2', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-19 18:04:00.986472+00', '2026-07-19 18:04:00.986472+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('03e6ba2d-e2ad-43d4-a63f-00fa5981cc0a', '189af987-8383-40e6-a82d-26b0f0ce1c09', 3, 'Episode 3', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-19 18:04:00.986472+00', '2026-07-19 18:04:00.986472+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('164e67e9-f105-4bd5-a53f-300713a4c798', '189af987-8383-40e6-a82d-26b0f0ce1c09', 4, 'Episode 4', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-19 18:04:00.986472+00', '2026-07-19 18:04:00.986472+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('ae823c98-696b-4815-a6ac-824d6cb70553', '189af987-8383-40e6-a82d-26b0f0ce1c09', 5, 'Episode 5', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-19 18:04:00.986472+00', '2026-07-19 18:04:00.986472+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('ff5100c5-3704-4805-a6f3-22680b085332', '189af987-8383-40e6-a82d-26b0f0ce1c09', 6, 'Episode 6', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-19 18:04:00.986472+00', '2026-07-19 18:04:00.986472+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('2620c6d3-5a7c-437a-ad25-8e540e35f11b', '40101ea4-8f61-4afe-a5ce-836fee184982', 5, 'Episode 5', '🐉 House of the Dragon [Season 03 : Episode 04] - සිංහල උපසිරැසි 🎬

පසුගිය කොටස්වලින් කතාවේ ලොකු වෙනස්කම් සිද්ධ වුණා. 👑 Rhaenyra විසින් ජනතාව අතර ආහාර සහ ද්‍රව්‍ය බෙදා දෙමින් King''s Landing වල තමන්ගේ බලය තියාගන්න උත්සාහ කළත්, ඇයට එරෙහිව මඩ ප්‍රචාර යන්න පටන් ගන්නවා. 🐉 Ulf White මේ ගැන Rhaenyra ට දැනුම් දුන්නත්, ඔහුව කාසල් එකට හිර කිරීමට ඇය පියවර ගන්නවා. 

අනෙක් පසින් Daemon විසින් The Vale හිදී Sheepstealer ව ක්ලේම් කරගත් Rhaena ව ආරක්ෂා කිරීමට එඬේරෙකුගේ හිස ගෙනැවිත් Rhaenyra ට ලබා දුන්නත්, Mysaria හට ඒ ගැන සැක මතු වෙනවා. ⚔️ මේ අතර Harrenhal හිදී Aemond සහ Vhagar අතුරුදන් වීම Criston Cole ට ලොකු ප්‍රශ්නයක් වෙනවා. Tumbleton නගරය දෙසට Ormund Hightower ගේ හමුදාව පැමිණෙද්දී, Rhaenyra විසින් Winter Wolves සහ Riverlords හමුදාව එතැනට යොමු කරනවා. 

එමෙන්ම, රහසිගතව Rook''s Rest වෙත යන Aegon II හට Sunfyre තවමත් ජීවතුන් අතර සිටින බව හැඟී යන අතර, Helaena ගැබිනියක් බවට පත්වීමත් සමඟ Green කල්ලියේ අනාගත රාජකීය උරුමය ගැන අලුත් පෙරළියක් ඇති වෙනවා. 🧐

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram පිටපත්: වීඩියෝව සමඟ උපසිරැසි නැරඹීමට කැමති අය සඳහා 720p, 1080p සහ 4K උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් සහ උපසිරැසි සියල්ලම ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2026-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/wSvDQN6tZR4VzDDZD3MUPIghVjC.jpg', '2026-07-20 02:26:00.42846+00', '2026-07-20 02:26:00.42846+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('ff5ed374-49c1-433f-a96e-f0ec63cda0e9', '189af987-8383-40e6-a82d-26b0f0ce1c09', 7, 'Episode 7', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-21 11:40:15.630722+00', '2026-07-21 11:40:15.630722+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('5d34ecf3-7cdb-4cef-af19-6de2d3d9ffbd', '189af987-8383-40e6-a82d-26b0f0ce1c09', 8, 'Episode 8', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්يك කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-21 11:40:15.630722+00', '2026-07-21 11:40:15.630722+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('157e7c9b-0cfe-456e-a209-6a7f39104c6b', '189af987-8383-40e6-a82d-26b0f0ce1c09', 9, 'Episode 9', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-21 11:40:15.630722+00', '2026-07-21 11:40:15.630722+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('048dc99f-6e98-40b0-aee8-99c4744c3fa3', '189af987-8383-40e6-a82d-26b0f0ce1c09', 10, 'Episode 10', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-21 11:40:15.630722+00', '2026-07-21 11:40:15.630722+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('a5accf34-bbe8-4ec9-ad35-5d5586911ede', '189af987-8383-40e6-a82d-26b0f0ce1c09', 11, 'Episode 11', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-21 11:40:15.630722+00', '2026-07-21 11:40:15.630722+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('0da19ae5-fa09-42ae-a07b-3f7df1a138fb', '189af987-8383-40e6-a82d-26b0f0ce1c09', 12, 'Episode 12', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-21 11:40:15.630722+00', '2026-07-21 11:40:15.630722+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('b671121c-bb64-487d-a9fc-fc8a43896b3b', '189af987-8383-40e6-a82d-26b0f0ce1c09', 13, 'Episode 13', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-21 11:40:15.630722+00', '2026-07-21 11:40:15.630722+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('ae98a8da-38d7-457c-ad73-f3fa36b05e71', '189af987-8383-40e6-a82d-26b0f0ce1c09', 14, 'Episode 14', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-21 11:40:15.630722+00', '2026-07-21 11:40:15.630722+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('71cdb260-6189-4909-a982-408b53b4a527', '7793265f-d915-44df-a361-888c8e6f2e97', 1, 'Episode 1', '🪐 Dune: Prophecy (2024-)  සිංහල උපසිරැසි 🎬

Dune: Prophecy is a sci-fi prequel set 10,000 years before Paul Atreides, following the Harkonnen sisters as they found the legendary Bene Gesserit. Download high-quality 720p WEB-DL video files with Sinhala subtitles on Telegram and direct servers.

Frank Herbert ගේ ලෝකප්‍රකට Dune විශ්වය ඇසුරෙන් නිර්මාණය වූ Dune: Prophecy කතා මාලාව දිගහැරෙන්නේ Paul Atreides ගේ ඉපදීමට සහ Arrakis ග්‍රහලෝකයේ සිදුවීම්වලට වසර 10,000 කට පෙර අතීත කාලවකවානුවකය. මනුෂ්‍ය වර්ගයා සිතන යන්ත්‍ර සහ කෘතිම බුද්ධිය (AI) සමඟ කළ මහා යුද්ධයෙන් (Thinking Machines Crisis) පසුව, තාක්ෂණය මත යැපීම තහනම් වූ යුගයක අනාගත මනුෂ්‍ය වර්ගයාගේ පැවැත්ම තීරණය කිරීමට සිදුවන්නේ මිනිස් මනසේ සහ ශරීරයේ උපරිම ශක්තිය මතය.

මෙම අභියෝගාත්මක වටපිටාව තුළ Harkonnen වංශයේ සහෝදරියන් වන Valya Harkonnen සහ Tula Harkonnen ප්‍රධාන චරිත බවට පත්වෙයි. තම වංශයට අහිමි වූ ගෞරවය නැවත ලබාගැනීමටත්, අනාගත රාජ්‍යයන්ගේ බලතුලනය තමන්ට අවශ්‍ය පරිදි මෙහෙයවීමටත් ඔවුන් කටයුතු කරයි. එහි ප්‍රතිඵලයක් ලෙස මනුෂ්‍ය වර්ගයාගේ අනාගතය වෙනස් කළ හැකි, දේශපාලන අධිරාජ්‍යයන් පවා පිටුපස සිට පාලනය කරන Bene Gesserit නම් අද්භූත සහ අතිශය බලවත් සහෝදරත්වය (Sisterhood) ආරම්භ වේ.

විශාල අධිරාජ්‍යයන් අතර පවතින රහසිගත සටන්, රාජකීය කුමන්ත්‍රණ, ආගමික සහ දාර්ශනික මතවාද මෙන්ම අභිරහස් අඳුරු බලවේගයන්ගෙන් පිරුණු මෙම නිර්මාණය Dune කතා මාලාවේ මූලාරම්භය ඉතා ගැඹුරින් හෙළි කරයි. Sci-Fi, Drama සහ Political Thriller ගණයට අයත් මෙම කතා මාලාව උසස්ම මට්ටමේ visual effects සහ පාලුවකින් තොරව එකදිගට නැරඹිය හැකි විශිෂ්ට කතා තේමාවකින් සමන්විත වේ.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:
📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.
✈️ Telegram පිටපත්: වීඩියෝව සමඟ උපසිරැසි නැරඹීමට කැමති අය සඳහා 720p WEB-DL වීඩියෝ පිටපත් සහ උපසිරැසි සියල්ලම ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2024-01-01', 50, 7.3, 'https://image.tmdb.org/t/p/original/5B8Cxz8ZZXp3w2WmmdKTXpkS24e.jpg', '2026-07-21 11:40:57.426392+00', '2026-07-21 11:40:57.426392+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('2e3c75b7-62f9-4016-aeb3-0db275e4694e', '7793265f-d915-44df-a361-888c8e6f2e97', 2, 'Episode 2', '🪐 Dune: Prophecy (2024-)  සිංහල උපසිරැසි 🎬

Dune: Prophecy is a sci-fi prequel set 10,000 years before Paul Atreides, following the Harkonnen sisters as they found the legendary Bene Gesserit. Download high-quality 720p WEB-DL video files with Sinhala subtitles on Telegram and direct servers.

Frank Herbert ගේ ලෝකප්‍රකට Dune විශ්වය ඇසුරෙන් නිර්මාණය වූ Dune: Prophecy කතා මාලාව දිගහැරෙන්නේ Paul Atreides ගේ ඉපදීමට සහ Arrakis ග්‍රහලෝකයේ සිදුවීම්වලට වසර 10,000 කට පෙර අතීත කාලවකවානුවකය. මනුෂ්‍ය වර්ගයා සිතන යන්ත්‍ර සහ කෘතිම බුද්ධිය (AI) සමඟ කළ මහා යුද්ධයෙන් (Thinking Machines Crisis) පසුව, තාක්ෂණය මත යැපීම තහනම් වූ යුගයක අනාගත මනුෂ්‍ය වර්ගයාගේ පැවැත්ම තීරණය කිරීමට සිදුවන්නේ මිනිස් මනසේ සහ ශරීරයේ උපරිම ශක්තිය මතය.

මෙම අභියෝගාත්මක වටපිටාව තුළ Harkonnen වංශයේ සහෝදරියන් වන Valya Harkonnen සහ Tula Harkonnen ප්‍රධාන චරිත බවට පත්වෙයි. තම වංශයට අහිමි වූ ගෞරවය නැවත ලබාගැනීමටත්, අනාගත රාජ්‍යයන්ගේ බලතුලනය තමන්ට අවශ්‍ය පරිදි මෙහෙයවීමටත් ඔවුන් කටයුතු කරයි. එහි ප්‍රතිඵලයක් ලෙස මනුෂ්‍ය වර්ගයාගේ අනාගතය වෙනස් කළ හැකි, දේශපාලන අධිරාජ්‍යයන් පවා පිටුපස සිට පාලනය කරන Bene Gesserit නම් අද්භූත සහ අතිශය බලවත් සහෝදරත්වය (Sisterhood) ආරම්භ වේ.

විශාල අධිරාජ්‍යයන් අතර පවතින රහසිගත සටන්, රාජකීය කුමන්ත්‍රණ, ආගමික සහ දාර්ශනික මතවාද මෙන්ම අභිරහස් අඳුරු බලවේගයන්ගෙන් පිරුණු මෙම නිර්මාණය Dune කතා මාලාවේ මූලාරම්භය ඉතා ගැඹුරින් හෙළි කරයි. Sci-Fi, Drama සහ Political Thriller ගණයට අයත් මෙම කතා මාලාව උසස්ම මට්ටමේ visual effects සහ පාලුවකින් තොරව එකදිගට නැරඹිය හැකි විශිෂ්ට කතා තේමාවකින් සමන්විත වේ.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:
📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.
✈️ Telegram පිටපත්: වීඩියෝව සමඟ උපසිරැසි නැරඹීමට කැමති අය සඳහා 720p WEB-DL වීඩියෝ පිටපත් සහ උපසිරැසි සියල්ලම ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2024-01-01', 50, 7.3, 'https://image.tmdb.org/t/p/original/5B8Cxz8ZZXp3w2WmmdKTXpkS24e.jpg', '2026-07-21 11:40:57.426392+00', '2026-07-21 11:40:57.426392+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('d75a210a-6176-46c7-a9b0-72c8257b7c94', '7793265f-d915-44df-a361-888c8e6f2e97', 3, 'Episode 3', '🪐 Dune: Prophecy (2024-)  සිංහල උපසිරැසි 🎬

Dune: Prophecy is a sci-fi prequel set 10,000 years before Paul Atreides, following the Harkonnen sisters as they found the legendary Bene Gesserit. Download high-quality 720p WEB-DL video files with Sinhala subtitles on Telegram and direct servers.

Frank Herbert ගේ ලෝකප්‍රකට Dune විශ්වය ඇසුරෙන් නිර්මාණය වූ Dune: Prophecy කතා මාලාව දිගහැරෙන්නේ Paul Atreides ගේ ඉපදීමට සහ Arrakis ග්‍රහලෝකයේ සිදුවීම්වලට වසර 10,000 කට පෙර අතීත කාලවකවානුවකය. මනුෂ්‍ය වර්ගයා සිතන යන්ත්‍ර සහ කෘතිම බුද්ධිය (AI) සමඟ කළ මහා යුද්ධයෙන් (Thinking Machines Crisis) පසුව, තාක්ෂණය මත යැපීම තහනම් වූ යුගයක අනාගත මනුෂ්‍ය වර්ගයාගේ පැවැත්ම තීරණය කිරීමට සිදුවන්නේ මිනිස් මනසේ සහ ශරීරයේ උපරිම ශක්තිය මතය.

මෙම අභියෝගාත්මක වටපිටාව තුළ Harkonnen වංශයේ සහෝදරියන් වන Valya Harkonnen සහ Tula Harkonnen ප්‍රධාන චරිත බවට පත්වෙයි. තම වංශයට අහිමි වූ ගෞරවය නැවත ලබාගැනීමටත්, අනාගත රාජ්‍යයන්ගේ බලතුලනය තමන්ට අවශ්‍ය පරිදි මෙහෙයවීමටත් ඔවුන් කටයුතු කරයි. එහි ප්‍රතිඵලයක් ලෙස මනුෂ්‍ය වර්ගයාගේ අනාගතය වෙනස් කළ හැකි, දේශපාලන අධිරාජ්‍යයන් පවා පිටුපස සිට පාලනය කරන Bene Gesserit නම් අද්භූත සහ අතිශය බලවත් සහෝදරත්වය (Sisterhood) ආරම්භ වේ.

විශාල අධිරාජ්‍යයන් අතර පවතින රහසිගත සටන්, රාජකීය කුමන්ත්‍රණ, ආගමික සහ දාර්ශනික මතවාද මෙන්ම අභිරහස් අඳුරු බලවේගයන්ගෙන් පිරුණු මෙම නිර්මාණය Dune කතා මාලාවේ මූලාරම්භය ඉතා ගැඹුරින් හෙළි කරයි. Sci-Fi, Drama සහ Political Thriller ගණයට අයත් මෙම කතා මාලාව උසස්ම මට්ටමේ visual effects සහ පාලුවකින් තොරව එකදිගට නැරඹිය හැකි විශිෂ්ට කතා තේමාවකින් සමන්විත වේ.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:
📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.
✈️ Telegram පිටපත්: වීඩියෝව සමඟ උපසිරැසි නැරඹීමට කැමති අය සඳහා 720p WEB-DL වීඩියෝ පිටපත් සහ උපසිරැසි සියල්ලම ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2024-01-01', 50, 7.3, 'https://image.tmdb.org/t/p/original/5B8Cxz8ZZXp3w2WmmdKTXpkS24e.jpg', '2026-07-21 11:40:57.426392+00', '2026-07-21 11:40:57.426392+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('d3dc4e95-a048-45fe-a465-79f7eca86a41', '7793265f-d915-44df-a361-888c8e6f2e97', 4, 'Episode 4', '🪐 Dune: Prophecy (2024-)  සිංහල උපසිරැසි 🎬

Dune: Prophecy is a sci-fi prequel set 10,000 years before Paul Atreides, following the Harkonnen sisters as they found the legendary Bene Gesserit. Download high-quality 720p WEB-DL video files with Sinhala subtitles on Telegram and direct servers.

Frank Herbert ගේ ලෝකප්‍රකට Dune විශ්වය ඇසුරෙන් නිර්මාණය වූ Dune: Prophecy කතා මාලාව දිගහැරෙන්නේ Paul Atreides ගේ ඉපදීමට සහ Arrakis ග්‍රහලෝකයේ සිදුවීම්වලට වසර 10,000 කට පෙර අතීත කාලවකවානුවකය. මනුෂ්‍ය වර්ගයා සිතන යන්ත්‍ර සහ කෘතිම බුද්ධිය (AI) සමඟ කළ මහා යුද්ධයෙන් (Thinking Machines Crisis) පසුව, තාක්ෂණය මත යැපීම තහනම් වූ යුගයක අනාගත මනුෂ්‍ය වර්ගයාගේ පැවැත්ම තීරණය කිරීමට සිදුවන්නේ මිනිස් මනසේ සහ ශරීරයේ උපරිම ශක්තිය මතය.

මෙම අභියෝගාත්මක වටපිටාව තුළ Harkonnen වංශයේ සහෝදරියන් වන Valya Harkonnen සහ Tula Harkonnen ප්‍රධාන චරිත බවට පත්වෙයි. තම වංශයට අහිමි වූ ගෞරවය නැවත ලබාගැනීමටත්, අනාගත රාජ්‍යයන්ගේ බලතුලනය තමන්ට අවශ්‍ය පරිදි මෙහෙයවීමටත් ඔවුන් කටයුතු කරයි. එහි ප්‍රතිඵලයක් ලෙස මනුෂ්‍ය වර්ගයාගේ අනාගතය වෙනස් කළ හැකි, දේශපාලන අධිරාජ්‍යයන් පවා පිටුපස සිට පාලනය කරන Bene Gesserit නම් අද්භූත සහ අතිශය බලවත් සහෝදරත්වය (Sisterhood) ආරම්භ වේ.

විශාල අධිරාජ්‍යයන් අතර පවතින රහසිගත සටන්, රාජකීය කුමන්ත්‍රණ, ආගමික සහ දාර්ශනික මතවාද මෙන්ම අභිරහස් අඳුරු බලවේගයන්ගෙන් පිරුණු මෙම නිර්මාණය Dune කතා මාලාවේ මූලාරම්භය ඉතා ගැඹුරින් හෙළි කරයි. Sci-Fi, Drama සහ Political Thriller ගණයට අයත් මෙම කතා මාලාව උසස්ම මට්ටමේ visual effects සහ පාලුවකින් තොරව එකදිගට නැරඹිය හැකි විශිෂ්ට කතා තේමාවකින් සමන්විත වේ.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:
📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.
✈️ Telegram පිටපත්: වීඩියෝව සමඟ උපසිරැසි නැරඹීමට කැමති අය සඳහා 720p WEB-DL වීඩියෝ පිටපත් සහ උපසිරැසි සියල්ලම ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2024-01-01', 50, 7.3, 'https://image.tmdb.org/t/p/original/5B8Cxz8ZZXp3w2WmmdKTXpkS24e.jpg', '2026-07-21 11:40:57.426392+00', '2026-07-21 11:40:57.426392+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('d079e06d-f5c7-4b22-adcc-4a2f4660fe20', '7793265f-d915-44df-a361-888c8e6f2e97', 5, 'Episode 5', '🪐 Dune: Prophecy (2024-)  සිංහල උපසිරැසි 🎬

Dune: Prophecy is a sci-fi prequel set 10,000 years before Paul Atreides, following the Harkonnen sisters as they found the legendary Bene Gesserit. Download high-quality 720p WEB-DL video files with Sinhala subtitles on Telegram and direct servers.

Frank Herbert ගේ ලෝකප්‍රකට Dune විශ්වය ඇසුරෙන් නිර්මාණය වූ Dune: Prophecy කතා මාලාව දිගහැරෙන්නේ Paul Atreides ගේ ඉපදීමට සහ Arrakis ග්‍රහලෝකයේ සිදුවීම්වලට වසර 10,000 කට පෙර අතීත කාලවකවානුවකය. මනුෂ්‍ය වර්ගයා සිතන යන්ත්‍ර සහ කෘතිම බුද්ධිය (AI) සමඟ කළ මහා යුද්ධයෙන් (Thinking Machines Crisis) පසුව, තාක්ෂණය මත යැපීම තහනම් වූ යුගයක අනාගත මනුෂ්‍ය වර්ගයාගේ පැවැත්ම තීරණය කිරීමට සිදුවන්නේ මිනිස් මනසේ සහ ශරීරයේ උපරිම ශක්තිය මතය.

මෙම අභියෝගාත්මක වටපිටාව තුළ Harkonnen වංශයේ සහෝදරියන් වන Valya Harkonnen සහ Tula Harkonnen ප්‍රධාන චරිත බවට පත්වෙයි. තම වංශයට අහිමි වූ ගෞරවය නැවත ලබාගැනීමටත්, අනාගත රාජ්‍යයන්ගේ බලතුලනය තමන්ට අවශ්‍ය පරිදි මෙහෙයවීමටත් ඔවුන් කටයුතු කරයි. එහි ප්‍රතිඵලයක් ලෙස මනුෂ්‍ය වර්ගයාගේ අනාගතය වෙනස් කළ හැකි, දේශපාලන අධිරාජ්‍යයන් පවා පිටුපස සිට පාලනය කරන Bene Gesserit නම් අද්භූත සහ අතිශය බලවත් සහෝදරත්වය (Sisterhood) ආරම්භ වේ.

විශාල අධිරාජ්‍යයන් අතර පවතින රහසිගත සටන්, රාජකීය කුමන්ත්‍රණ, ආගමික සහ දාර්ශනික මතවාද මෙන්ම අභිරහස් අඳුරු බලවේගයන්ගෙන් පිරුණු මෙම නිර්මාණය Dune කතා මාලාවේ මූලාරම්භය ඉතා ගැඹුරින් හෙළි කරයි. Sci-Fi, Drama සහ Political Thriller ගණයට අයත් මෙම කතා මාලාව උසස්ම මට්ටමේ visual effects සහ පාලුවකින් තොරව එකදිගට නැරඹිය හැකි විශිෂ්ට කතා තේමාවකින් සමන්විත වේ.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:
📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.
✈️ Telegram පිටපත්: වීඩියෝව සමඟ උපසිරැසි නැරඹීමට කැමති අය සඳහා 720p WEB-DL වීඩියෝ පිටපත් සහ උපසිරැසි සියල්ලම ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2024-01-01', 50, 7.3, 'https://image.tmdb.org/t/p/original/5B8Cxz8ZZXp3w2WmmdKTXpkS24e.jpg', '2026-07-21 11:40:57.426392+00', '2026-07-21 11:40:57.426392+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('d11bf2e7-32fb-4bae-a23f-6eafe1eebec4', '7793265f-d915-44df-a361-888c8e6f2e97', 6, 'Episode 6', '🪐 Dune: Prophecy (2024-)  සිංහල උපසිරැසි 🎬

Dune: Prophecy is a sci-fi prequel set 10,000 years before Paul Atreides, following the Harkonnen sisters as they found the legendary Bene Gesserit. Download high-quality 720p WEB-DL video files with Sinhala subtitles on Telegram and direct servers.

Frank Herbert ගේ ලෝකප්‍රකට Dune විශ්වය ඇසුරෙන් නිර්මාණය වූ Dune: Prophecy කතා මාලාව දිගහැරෙන්නේ Paul Atreides ගේ ඉපදීමට සහ Arrakis ග්‍රහලෝකයේ සිදුවීම්වලට වසර 10,000 කට පෙර අතීත කාලවකවානුවකය. මනුෂ්‍ය වර්ගයා සිතන යන්ත්‍ර සහ කෘතිම බුද්ධිය (AI) සමඟ කළ මහා යුද්ධයෙන් (Thinking Machines Crisis) පසුව, තාක්ෂණය මත යැපීම තහනම් වූ යුගයක අනාගත මනුෂ්‍ය වර්ගයාගේ පැවැත්ම තීරණය කිරීමට සිදුවන්නේ මිනිස් මනසේ සහ ශරීරයේ උපරිම ශක්තිය මතය.

මෙම අභියෝගාත්මක වටපිටාව තුළ Harkonnen වංශයේ සහෝදරියන් වන Valya Harkonnen සහ Tula Harkonnen ප්‍රධාන චරිත බවට පත්වෙයි. තම වංශයට අහිමි වූ ගෞරවය නැවත ලබාගැනීමටත්, අනාගත රාජ්‍යයන්ගේ බලතුලනය තමන්ට අවශ්‍ය පරිදි මෙහෙයවීමටත් ඔවුන් කටයුතු කරයි. එහි ප්‍රතිඵලයක් ලෙස මනුෂ්‍ය වර්ගයාගේ අනාගතය වෙනස් කළ හැකි, දේශපාලන අධිරාජ්‍යයන් පවා පිටුපස සිට පාලනය කරන Bene Gesserit නම් අද්භූත සහ අතිශය බලවත් සහෝදරත්වය (Sisterhood) ආරම්භ වේ.

විශාල අධිරාජ්‍යයන් අතර පවතින රහසිගත සටන්, රාජකීය කුමන්ත්‍රණ, ආගමික සහ දාර්ශනික මතවාද මෙන්ම අභිරහස් අඳුරු බලවේගයන්ගෙන් පිරුණු මෙම නිර්මාණය Dune කතා මාලාවේ මූලාරම්භය ඉතා ගැඹුරින් හෙළි කරයි. Sci-Fi, Drama සහ Political Thriller ගණයට අයත් මෙම කතා මාලාව උසස්ම මට්ටමේ visual effects සහ පාලුවකින් තොරව එකදිගට නැරඹිය හැකි විශිෂ්ට කතා තේමාවකින් සමන්විත වේ.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:
📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.
✈️ Telegram පිටපත්: වීඩියෝව සමඟ උපසිරැසි නැරඹීමට කැමති අය සඳහා 720p WEB-DL වීඩියෝ පිටපත් සහ උපසිරැසි සියල්ලම ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2024-01-01', 50, 7.3, 'https://image.tmdb.org/t/p/original/5B8Cxz8ZZXp3w2WmmdKTXpkS24e.jpg', '2026-07-21 11:40:57.426392+00', '2026-07-21 11:40:57.426392+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('64d587f8-1fc9-44ee-a2bc-7c3c946f94a1', '475a4014-a733-400e-a11a-406b795015a4', 1, 'Episode 1', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/sW67RSH740Ogrp6LGDCgpgGaK1u.jpg', '2026-07-22 15:20:11.306013+00', '2026-07-22 15:20:11.306013+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('f1ab93cd-7fb1-429f-ac72-d5a9575b58f8', '475a4014-a733-400e-a11a-406b795015a4', 2, 'Episode 2', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/sW67RSH740Ogrp6LGDCgpgGaK1u.jpg', '2026-07-22 15:20:11.306013+00', '2026-07-22 15:20:11.306013+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('cb90507c-99dd-47f9-a469-73a47bb820c6', '475a4014-a733-400e-a11a-406b795015a4', 3, 'Episode 3', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/sW67RSH740Ogrp6LGDCgpgGaK1u.jpg', '2026-07-22 15:20:11.306013+00', '2026-07-22 15:20:11.306013+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('109da833-6129-446c-ae6e-e2af0895c68c', '475a4014-a733-400e-a11a-406b795015a4', 4, 'Episode 4', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/sW67RSH740Ogrp6LGDCgpgGaK1u.jpg', '2026-07-22 15:20:11.306013+00', '2026-07-22 15:20:11.306013+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('c5d5fa30-2fa9-428e-a43d-c6acaa09817f', '475a4014-a733-400e-a11a-406b795015a4', 5, 'Episode 5', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/sW67RSH740Ogrp6LGDCgpgGaK1u.jpg', '2026-07-22 15:20:11.306013+00', '2026-07-22 15:20:11.306013+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('5e98ed7d-def9-4406-a85d-75f5b3f3f934', '475a4014-a733-400e-a11a-406b795015a4', 6, 'Episode 6', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/sW67RSH740Ogrp6LGDCgpgGaK1u.jpg', '2026-07-23 15:20:45.443248+00', '2026-07-23 15:20:45.443248+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('71a464db-5dbe-4456-ae84-175736c13c0e', '475a4014-a733-400e-a11a-406b795015a4', 7, 'Episode 7', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/sW67RSH740Ogrp6LGDCgpgGaK1u.jpg', '2026-07-23 15:20:45.443248+00', '2026-07-23 15:20:45.443248+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('30e31621-fe73-4d9f-ac06-0883b308948b', '475a4014-a733-400e-a11a-406b795015a4', 8, 'Episode 8', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/sW67RSH740Ogrp6LGDCgpgGaK1u.jpg', '2026-07-23 15:20:45.443248+00', '2026-07-23 15:20:45.443248+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('f7ff5cd9-3e7a-4854-a839-f08b1e796d03', '475a4014-a733-400e-a11a-406b795015a4', 9, 'Episode 9', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/sW67RSH740Ogrp6LGDCgpgGaK1u.jpg', '2026-07-23 15:20:45.443248+00', '2026-07-23 15:20:45.443248+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('90c2c1ce-3149-4420-acc4-5e1137a9f04b', '475a4014-a733-400e-a11a-406b795015a4', 10, 'Episode 10', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/sW67RSH740Ogrp6LGDCgpgGaK1u.jpg', '2026-07-23 15:20:45.443248+00', '2026-07-23 15:20:45.443248+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('d754f593-8f53-478a-a516-0a5d7dce1f13', '475a4014-a733-400e-a11a-406b795015a4', 11, 'Episode 11', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/sW67RSH740Ogrp6LGDCgpgGaK1u.jpg', '2026-07-23 15:20:45.443248+00', '2026-07-23 15:20:45.443248+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('9362b49e-c6a7-438e-abd0-e5d5ee591bcf', '475a4014-a733-400e-a11a-406b795015a4', 12, 'Episode 12', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/sW67RSH740Ogrp6LGDCgpgGaK1u.jpg', '2026-07-23 15:20:45.443248+00', '2026-07-23 15:20:45.443248+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('fc4e3466-8657-4b65-a78c-5b09ff582980', '475a4014-a733-400e-a11a-406b795015a4', 13, 'Episode 13', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/sW67RSH740Ogrp6LGDCgpgGaK1u.jpg', '2026-07-23 15:20:45.443248+00', '2026-07-23 15:20:45.443248+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('a282c926-810d-4deb-a0e5-966d01049ea3', 'ae16f018-861f-4083-a74e-223dc9b7f277', 1, 'Episode 1', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/tB22kwHHXGAHT52P4bgBtBAPBRS.jpg', '2026-07-25 11:21:03.246098+00', '2026-07-25 11:21:03.246098+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('4ebb547e-53ad-4d57-a144-4d675d22a6a6', 'ae16f018-861f-4083-a74e-223dc9b7f277', 2, 'Episode 2', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/tB22kwHHXGAHT52P4bgBtBAPBRS.jpg', '2026-07-25 11:21:03.246098+00', '2026-07-25 11:21:03.246098+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('58ec2e1a-2d6a-4a3e-a0dc-68bb6db32cde', 'ae16f018-861f-4083-a74e-223dc9b7f277', 3, 'Episode 3', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/tB22kwHHXGAHT52P4bgBtBAPBRS.jpg', '2026-07-25 11:21:03.246098+00', '2026-07-25 11:21:03.246098+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('78a5ef5c-d105-4c5d-a2da-650571142053', 'ae16f018-861f-4083-a74e-223dc9b7f277', 4, 'Episode 4', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/tB22kwHHXGAHT52P4bgBtBAPBRS.jpg', '2026-07-25 11:21:03.246098+00', '2026-07-25 11:21:03.246098+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('05f355ee-ec0b-43ac-aa33-0100facea393', 'ae16f018-861f-4083-a74e-223dc9b7f277', 5, 'Episode 5', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/tB22kwHHXGAHT52P4bgBtBAPBRS.jpg', '2026-07-25 11:21:03.246098+00', '2026-07-25 11:21:03.246098+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('917763f5-b2e9-4ffd-aa72-e0f0d0f15044', 'ae16f018-861f-4083-a74e-223dc9b7f277', 6, 'Episode 6', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/tB22kwHHXGAHT52P4bgBtBAPBRS.jpg', '2026-07-25 11:21:03.246098+00', '2026-07-25 11:21:03.246098+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('1aaebabc-8c9d-442a-af05-8378c46ac108', '73c3fd9e-1f00-4fe7-a156-e1dc0ae06a9f', 1, 'Episode 1', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිටින්න Auto download උනේ නැත්නම්, Back උනාම කොලපාට  download button එකක් එයි.

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් Movie  එක්හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2023-01-01', 50, 7, 'https://image.tmdb.org/t/p/original/seYokxOjFyTVX13XgD2FNjWIry8.jpg', '2026-07-26 09:14:46.57961+00', '2026-07-26 09:14:46.57961+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('6ac90a7e-a532-41ef-a8d2-904c6919461d', 'ae16f018-861f-4083-a74e-223dc9b7f277', 7, 'Episode 7', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/tB22kwHHXGAHT52P4bgBtBAPBRS.jpg', '2026-07-26 15:57:14.899352+00', '2026-07-26 15:57:14.899352+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('0f5f4ada-fd4d-43a9-a3e3-3073a506c2c9', 'ae16f018-861f-4083-a74e-223dc9b7f277', 8, 'Episode 8', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/tB22kwHHXGAHT52P4bgBtBAPBRS.jpg', '2026-07-26 15:57:14.899352+00', '2026-07-26 15:57:14.899352+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('33429f0e-4254-46c7-a0a8-51beb0ce4203', 'ae16f018-861f-4083-a74e-223dc9b7f277', 9, 'Episode 9', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/tB22kwHHXGAHT52P4bgBtBAPBRS.jpg', '2026-07-26 15:57:14.899352+00', '2026-07-26 15:57:14.899352+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('521ed8de-1fb7-45e4-a56e-f4a92cf90982', 'ae16f018-861f-4083-a74e-223dc9b7f277', 10, 'Episode 10', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/tB22kwHHXGAHT52P4bgBtBAPBRS.jpg', '2026-07-26 15:57:14.899352+00', '2026-07-26 15:57:14.899352+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('acf32d87-d3ce-46ba-a80a-337540ee3473', 'ae16f018-861f-4083-a74e-223dc9b7f277', 11, 'Episode 11', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/tB22kwHHXGAHT52P4bgBtBAPBRS.jpg', '2026-07-26 15:57:14.899352+00', '2026-07-26 15:57:14.899352+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('77f4da9c-a2cc-48ef-a2fa-cf5f32292ca3', 'ae16f018-861f-4083-a74e-223dc9b7f277', 12, 'Episode 12', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/tB22kwHHXGAHT52P4bgBtBAPBRS.jpg', '2026-07-26 15:57:14.899352+00', '2026-07-26 15:57:14.899352+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('b5ab48e7-40fe-4633-a06d-8414f9699a65', 'ae16f018-861f-4083-a74e-223dc9b7f277', 13, 'Episode 13', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/tB22kwHHXGAHT52P4bgBtBAPBRS.jpg', '2026-07-26 15:57:14.899352+00', '2026-07-26 15:57:14.899352+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('65b19554-c989-4991-abea-9231e8c70423', '40101ea4-8f61-4afe-a5ce-836fee184982', 6, 'Episode 6', 'House of the Dragon (Season 03 - Episode 06) - සිංහල උපසිරැසි💚

House of the Dragon Season 3 Episode 6 continues the epic Dance of the Dragons. Download high-quality 720p, 1080p, and 4K WEB-DL video files with Sinhala subtitles directly or via Telegram. Catch up on the previous episode''s events below before watching the latest release.

House of the Dragon Season 3 හයවෙනි එපිසෝඩ් එක (S03E06) තමයි මේ අරගෙන එන්නේ. Black සහ Green පාර්ශවයන් අතර තියෙන බල අරගලය තවත් දරුණු තත්ත්වයකට පත්වෙමින්, Westeros වල අලුත්ම දේශපාලන කුමන්ත්‍රණ සහ රහසිගත සැලසුම් මේ කොටසින් තවදුරටත් දැකගන්න පුළුවන්. අලුත්ම එපිසෝඩ් එක බලන්න කලින්, පහුගිය සතියේ නිකුත් වුණු පස්වෙනි එපිසෝඩ් එකේ (S03E05) මොකද වුණේ කියලා කෙටියෙන් මතක් කරගමු.

පසුගිය කොටසින් (S03E05 - Unbound and Unbroken):
Ormund Hightower විසින් Daeron ව යොදාගෙන අලුත් රත්තරන් කාසි නිකුත් කරමින් King''s Landing වලට ඔවුන්ගේ බලය සහ ධනය පෙන්වන්න කටයුතු කළා. Harrenhal වල හැංගිලා ඉන්න Aemond ට Alys Rivers ගේ මායා බලයෙන් ආරක්ෂාව ලැබෙන අතර, අනිත් පැත්තෙන් Aegon ව Essos වල Braavos නගරයට අරන් ගිහින් ආරක්ෂිතව හංගන්න Larys Strong සැලසුම් කරනවා. මේ අතර Criston Cole තමන්ගෙම Dornish ගරිල්ලා සටන් ක්‍රම පාවිච්චි කරමින් සියදිවි නසාගැනීමේ මාරක මෙහෙයුමක නිරත වෙනවා.

King''s Landing වලට Joffrey ඔහුගේ කුඩා මකරා එක්ක පැමිණෙන අතර, Rhaenyra සහ Daemon අතර ඉදිරි සැලසුම් ගැන සභාවේදී මත ගැටුම් ඇතිවෙනවා. ඒ වගේම ගැබ්ගෙන සිටින Helaena ට Alicent ගබ්සා පානයක් බොන්න බල කරන අතර, එහි රහස Misaria ප්‍රශ්න කිරීම් හමුවේ හෙළි කරගන්නවා. පසුව Alicent සහ Helaena රහස් උමඟකින් පැනලා යන්න හැදුවත්, උමඟ ඇතුළේ පන්දමත් නිවී ගොස් ඔවුන්ට ඉදිරියට යන්න විදිහක් නැතිව හිරවෙනවා. එපිසෝඩ් එක අවසන් වුණේ City Watch සෙබළුන්ව Hightower රහස් කණ්ඩායමක් විසින් ආගමික බිලිදීමක් ලෙස මරා දමා Feast for Crows ලෙස සටහන් කර තිබීමෙනි.

දැන් කතාව මොන අතට හැරෙයිද කියලා S03E06 අලුත්ම කොටසින් බලාගන්න පුළුවන්.

වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

✅Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✅Telegram Download: 720p, 1080p සහ 4K උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2026-01-01', 50, 8.3, 'https://image.tmdb.org/t/p/original/7V0Ebks0GgpKvQ7QbLAIdX5dos4.jpg', '2026-07-26 19:36:34.146575+00', '2026-07-26 19:36:34.146575+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('35f6fe55-6311-49b9-ab9b-0114ce81eb1a', '8a53dd11-3b8f-4853-a949-d19a7216fde8', 1, 'Episode 1', '🔫 The Sopranos - සිංහල උපසිරැසි 🎬

The Sopranos is widely considered one of the greatest television series of all time. Dive into the complex life of Tony Soprano, a New Jersey mob boss balancing his ruthless mafia family with his actual family. Download high-quality 720p, 1080p, and 4K WEB-DL video files with Sinhala subtitles directly or via Telegram. Experience the masterpiece that changed modern television forever.

ලෝකයේ බිහිවුණු විශිෂ්ටතම රූපවාහිනී කතා මාලාවන්ගෙන් එකක් විදිහට හැඳින්වෙන The Sopranos තමයි මේ අරගෙන එන්නේ. New Jersey වල මාෆියා නායකයෙක් වෙන Tony Soprano ගේ ජීවිතය වටා තමයි මේ කතාව ගෙතිලා තියෙන්නේ. තමන්ගේ අපරාධ ජාලය මෙහෙයවන එකයි, පවුලේ ප්‍රශ්න විසඳන එකයි අතරේ ඔහු කොහොමද සමබරතාවය තියාගන්නේ කියන එක මේකෙන් ගොඩක් තාත්විකව පෙන්නනවා.

සාමාන්‍ය මාෆියා කතාවකට වඩා මේක ගොඩක් වෙනස් වෙන්නේ, Tony Soprano මුහුණ දෙන මානසික ආතතිය සහ ඒ නිසා ඔහු මනෝ වෛද්‍යවරයෙක් මුණගැහෙන්න යන සිදුවීම් නිසා. Action, Crime කතා වලට වගේම, ටිකක් ගැඹුරු කතා තේමාවන් වලට කැමති අයට කිසිම කම්මැලිකමක් නැතුව බලන්න පුළුවන් සුපිරිම කතා මාලාවක් තමයි මේක. HBO නාලිකාවෙන් විකාශය වුණු මේ කතාව, අදටත් රූපවාහිනී කලාවේ දැවැන්තම සන්ධිස්ථානයක් විදිහට සැලකෙනවා. 

🔰🔰🔰මෙම උපසිරැසි  bluray පිටපත් වලට පමනක් ගැලපේ.🔰🔰🔰🔰

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව බාගත කරගත හැක.

✈️ Telegram Download: 720p, 1080p උසස් තත්ත්වයේ Bluray වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '1997-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/rTc7ZXdroqjkKivFPvCPX0Ru7uw.jpg', '2026-07-28 16:58:59.501453+00', '2026-07-28 16:58:59.501453+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('036066a4-ce3f-4abd-a925-7cf80865a47e', 'bc88d01f-ffdb-4d2c-ad97-aa59242e6ae9', 1, 'Episode 1', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-28 17:47:57.477299+00', '2026-07-28 17:47:57.477299+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('e251ab8b-a146-49fb-ace4-8ac6999f9c52', 'bc88d01f-ffdb-4d2c-ad97-aa59242e6ae9', 2, 'Episode 2', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-28 17:47:57.477299+00', '2026-07-28 17:47:57.477299+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('a9d7d420-367a-41ac-a08f-cfb2c57c7c01', 'bc88d01f-ffdb-4d2c-ad97-aa59242e6ae9', 3, 'Episode 3', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-28 17:47:57.477299+00', '2026-07-28 17:47:57.477299+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('08978a86-7c5d-40a9-ab7d-c7a9bfaf51e9', 'bc88d01f-ffdb-4d2c-ad97-aa59242e6ae9', 4, 'Episode 4', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/tB22kwHHXGAHT52P4bgBtBAPBRS.jpg', '2026-07-29 15:47:39.376403+00', '2026-07-29 15:47:39.376403+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('ecbaec1b-caa1-4d69-a91a-78c4f4697795', 'bc88d01f-ffdb-4d2c-ad97-aa59242e6ae9', 5, 'Episode 5', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/tB22kwHHXGAHT52P4bgBtBAPBRS.jpg', '2026-07-29 15:47:39.376403+00', '2026-07-29 15:47:39.376403+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('41046440-3189-46b3-a8fa-740fa6db1693', 'bc88d01f-ffdb-4d2c-ad97-aa59242e6ae9', 6, 'Episode 6', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/tB22kwHHXGAHT52P4bgBtBAPBRS.jpg', '2026-07-29 15:47:39.376403+00', '2026-07-29 15:47:39.376403+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('9fb72ef2-edfc-4785-ac04-12c1aca3e338', 'bc88d01f-ffdb-4d2c-ad97-aa59242e6ae9', 7, 'Episode 7', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/tB22kwHHXGAHT52P4bgBtBAPBRS.jpg', '2026-07-29 15:47:39.376403+00', '2026-07-29 15:47:39.376403+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('e8c4c40c-76e2-4e5e-ae88-8f0b32a3b979', '8a53dd11-3b8f-4853-a949-d19a7216fde8', 2, 'Episode 2', '🔫 The Sopranos - සිංහල උපසිරැසි 🎬

The Sopranos is widely considered one of the greatest television series of all time. Dive into the complex life of Tony Soprano, a New Jersey mob boss balancing his ruthless mafia family with his actual family. Download high-quality 720p, 1080p, and 4K WEB-DL video files with Sinhala subtitles directly or via Telegram. Experience the masterpiece that changed modern television forever.

ලෝකයේ බිහිවුණු විශිෂ්ටතම රූපවාහිනී කතා මාලාවන්ගෙන් එකක් විදිහට හැඳින්වෙන The Sopranos තමයි මේ අරගෙන එන්නේ. New Jersey වල මාෆියා නායකයෙක් වෙන Tony Soprano ගේ ජීවිතය වටා තමයි මේ කතාව ගෙතිලා තියෙන්නේ. තමන්ගේ අපරාධ ජාලය මෙහෙයවන එකයි, පවුලේ ප්‍රශ්න විසඳන එකයි අතරේ ඔහු කොහොමද සමබරතාවය තියාගන්නේ කියන එක මේකෙන් ගොඩක් තාත්විකව පෙන්නනවා.

සාමාන්‍ය මාෆියා කතාවකට වඩා මේක ගොඩක් වෙනස් වෙන්නේ, Tony Soprano මුහුණ දෙන මානසික ආතතිය සහ ඒ නිසා ඔහු මනෝ වෛද්‍යවරයෙක් මුණගැහෙන්න යන සිදුවීම් නිසා. Action, Crime කතා වලට වගේම, ටිකක් ගැඹුරු කතා තේමාවන් වලට කැමති අයට කිසිම කම්මැලිකමක් නැතුව බලන්න පුළුවන් සුපිරිම කතා මාලාවක් තමයි මේක. HBO නාලිකාවෙන් විකාශය වුණු මේ කතාව, අදටත් රූපවාහිනී කලාවේ දැවැන්තම සන්ධිස්ථානයක් විදිහට සැලකෙනවා. 

🔰🔰🔰මෙම උපසිරැසි  bluray පිටපත් වලට පමනක් ගැලපේ.🔰🔰🔰🔰

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව බාගත කරගත හැක.

✈️ Telegram Download: 720p, 1080p උසස් තත්ත්වයේ Bluray වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '1997-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/rTc7ZXdroqjkKivFPvCPX0Ru7uw.jpg', '2026-07-29 16:57:22.390038+00', '2026-07-29 16:57:22.390038+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('53a8a58d-9d48-42e3-ac68-e01620c6baf7', 'bc88d01f-ffdb-4d2c-ad97-aa59242e6ae9', 8, 'Episode 8', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/tB22kwHHXGAHT52P4bgBtBAPBRS.jpg', '2026-07-30 09:44:00.617394+00', '2026-07-30 09:44:00.617394+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('f63e74e5-57f1-4b88-a874-98af749ad9ba', 'bc88d01f-ffdb-4d2c-ad97-aa59242e6ae9', 9, 'Episode 9', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/tB22kwHHXGAHT52P4bgBtBAPBRS.jpg', '2026-07-30 09:44:00.617394+00', '2026-07-30 09:44:00.617394+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('65144140-f36e-46ce-a66b-3f62e6cd8a54', 'bc88d01f-ffdb-4d2c-ad97-aa59242e6ae9', 10, 'Episode 10', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/tB22kwHHXGAHT52P4bgBtBAPBRS.jpg', '2026-07-30 09:44:00.617394+00', '2026-07-30 09:44:00.617394+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('ba267558-45f5-4e0f-aa45-e12fdbf2e3cd', 'bc88d01f-ffdb-4d2c-ad97-aa59242e6ae9', 11, 'Episode 11', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-30 09:44:00.617394+00', '2026-07-30 09:44:00.617394+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('8e18b46e-16da-49d6-aa93-e1a334593e1d', 'bc88d01f-ffdb-4d2c-ad97-aa59242e6ae9', 12, 'Episode 12', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-30 09:44:00.617394+00', '2026-07-30 09:44:00.617394+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('2417b2ef-dd12-414e-a010-9b14a0948b47', 'bc88d01f-ffdb-4d2c-ad97-aa59242e6ae9', 13, 'Episode 13', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට, නැවත Back වන්න (Navigate back).

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් අදාළ Subtitle ෆයිල් එක සහ ඒ හා සබැඳි Movie හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2008-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-30 09:44:00.617394+00', '2026-07-30 09:44:00.617394+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('a9fab54f-7d32-40a3-a8c7-ea7f2c6ac230', '8a53dd11-3b8f-4853-a949-d19a7216fde8', 3, 'Episode 3', '🔫 The Sopranos  Season 1 Episode 03- සිංහල උපසිරැසි 🎬

The Sopranos is widely considered one of the greatest television series of all time. Dive into the complex life of Tony Soprano, a New Jersey mob boss balancing his ruthless mafia family with his actual family. Download high-quality 720p, 1080p Blu-Ray video files with Sinhala subtitles directly or via Telegram. Experience the masterpiece that changed modern television forever.

ලෝකයේ බිහිවුණු විශිෂ්ටතම රූපවාහිනී කතා මාලාවන්ගෙන් එකක් විදිහට හැඳින්වෙන The Sopranos තමයි මේ අරගෙන එන්නේ. New Jersey වල මාෆියා නායකයෙක් වෙන Tony Soprano ගේ ජීවිතය වටා තමයි මේ කතාව ගෙතිලා තියෙන්නේ. තමන්ගේ අපරාධ ජාලය මෙහෙයවන එකයි, පවුලේ ප්‍රශ්න විසඳන එකයි අතරේ ඔහු කොහොමද සමබරතාවය තියාගන්නේ කියන එක මේකෙන් ගොඩක් තාත්විකව පෙන්නනවා.

සාමාන්‍ය මාෆියා කතාවකට වඩා මේක ගොඩක් වෙනස් වෙන්නේ, Tony Soprano මුහුණ දෙන මානසික ආතතිය සහ ඒ නිසා ඔහු මනෝ වෛද්‍යවරයෙක් මුණගැහෙන්න යන සිදුවීම් නිසා. Action, Crime කතා වලට වගේම, ටිකක් ගැඹුරු කතා තේමාවන් වලට කැමති අයට කිසිම කම්මැලිකමක් නැතුව බලන්න පුළුවන් සුපිරිම කතා මාලාවක් තමයි මේක. HBO නාලිකාවෙන් විකාශය වුණු මේ කතාව, අදටත් රූපවාහිනී කලාවේ දැවැන්තම සන්ධිස්ථානයක් විදිහට සැලකෙනවා. 

🔰🔰🔰මෙම උපසිරැසි  bluray පිටපත් වලට පමනක් ගැලපේ.🔰🔰🔰🔰

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව බාගත කරගත හැක.

✈️ Telegram Download: 720p, 1080p උසස් තත්ත්වයේ Bluray වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '1997-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/rTc7ZXdroqjkKivFPvCPX0Ru7uw.jpg', '2026-07-30 17:16:11.526432+00', '2026-07-30 17:16:11.526432+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('80444a0d-09f0-4108-ab58-1d91d73f0011', '5c4af11e-21f5-4ee9-a8a3-30fc4cf84989', 1, 'Episode 1', '🦇 Batman: Caped Crusader - සිංහල උපසිරැසි 🎬

Batman: Caped Crusader brings a dark, noir-inspired take on the Dark Knight''s early days in Gotham City. Produced by Bruce Timm, Matt Reeves, and J.J. Abrams, this animated series is a must-watch for DC fans. Download high-quality 720p WEB-DL video files with Sinhala subtitles directly or via Telegram. Experience the ultimate psychological and action-packed detective story.

Batman: Caped Crusader කියන්නේ DC රසිකයින්ට ලැබුණු අලුත්ම සහ වෙනස්ම විදිහේ ඇනිමේටඩ් කතා මාලාවක්. සුප්‍රසිද්ධ Batman: The Animated Series එක හදපු Bruce Timm වගේම The Batman චිත්‍රපටය අධ්‍යක්ෂණය කරපු Matt Reeves ගේ සහ J.J. Abrams ගේ එකතුවෙන් තමයි මේක නිර්මාණය වෙලා තියෙන්නේ. ඒ නිසාම මේකට ලොකු ප්‍රේක්ෂක ආකර්ෂණයක් ලැබිලා තියෙනවා.

කතාව යන්නේ 1940 දශකයේ අඳුරු Gotham නගරයේ. ගොඩක් දියුණු තාක්ෂණයන් නැති, දූෂණය සහ අපරාධ වලින් පිරිච්ච නගරයක Bruce Wayne තමන්ගේ මුල්ම කාලයේ Batman විදිහට අපරාධකරුවන්ට විරුද්ධව සටන් කරන හැටි තමයි මේකෙන් පෙන්නන්නේ. මේ කතාවේ ඉන්න Batman ටිකක් රළුයි වගේම, අපි දන්න Catwoman, Harley Quinn, Two-Face සහ Penguin වගේ අනිත් චරිතත් මේ කතාවේදී සම්පූර්ණයෙන්ම අලුත් වගේම වෙනස්ම විදිහකට තමයි නිර්මාණය කරලා තියෙන්නේ.

DC කොමික් පොත් වල තිබුණු මුල්ම කාලයේ අඳුරු Noir ගතියට සහ රහස් පරීක්ෂක (Detective) කතා වලට කැමති අයට කිසිම කම්මැලිකමක් නැතුව බලන්න පුළුවන් සුපිරිම කතා මාලාවක් තමයි මේක.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:
📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් Telegram චැනලය හරහා ලබාගත හැක.', '2024-01-01', 50, 7.2, 'https://image.tmdb.org/t/p/original/tJ7zq4VtvJqUyaRsLeNjpEFDXzk.jpg', '2026-07-31 09:09:26.160221+00', '2026-07-31 09:09:26.160221+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('e6b409ef-70f8-4c35-aefa-89af278eebc2', '5c4af11e-21f5-4ee9-a8a3-30fc4cf84989', 2, 'Episode 2', '🦇 Batman: Caped Crusader - සිංහල උපසිරැසි 🎬

Batman: Caped Crusader brings a dark, noir-inspired take on the Dark Knight''s early days in Gotham City. Produced by Bruce Timm, Matt Reeves, and J.J. Abrams, this animated series is a must-watch for DC fans. Download high-quality 720p WEB-DL video files with Sinhala subtitles directly or via Telegram. Experience the ultimate psychological and action-packed detective story.

Batman: Caped Crusader කියන්නේ DC රසිකයින්ට ලැබුණු අලුත්ම සහ වෙනස්ම විදිහේ ඇනිමේටඩ් කතා මාලාවක්. සුප්‍රසිද්ධ Batman: The Animated Series එක හදපු Bruce Timm වගේම The Batman චිත්‍රපටය අධ්‍යක්ෂණය කරපු Matt Reeves ගේ සහ J.J. Abrams ගේ එකතුවෙන් තමයි මේක නිර්මාණය වෙලා තියෙන්නේ. ඒ නිසාම මේකට ලොකු ප්‍රේක්ෂක ආකර්ෂණයක් ලැබිලා තියෙනවා.

කතාව යන්නේ 1940 දශකයේ අඳුරු Gotham නගරයේ. ගොඩක් දියුණු තාක්ෂණයන් නැති, දූෂණය සහ අපරාධ වලින් පිරිච්ච නගරයක Bruce Wayne තමන්ගේ මුල්ම කාලයේ Batman විදිහට අපරාධකරුවන්ට විරුද්ධව සටන් කරන හැටි තමයි මේකෙන් පෙන්නන්නේ. මේ කතාවේ ඉන්න Batman ටිකක් රළුයි වගේම, අපි දන්න Catwoman, Harley Quinn, Two-Face සහ Penguin වගේ අනිත් චරිතත් මේ කතාවේදී සම්පූර්ණයෙන්ම අලුත් වගේම වෙනස්ම විදිහකට තමයි නිර්මාණය කරලා තියෙන්නේ.

DC කොමික් පොත් වල තිබුණු මුල්ම කාලයේ අඳුරු Noir ගතියට සහ රහස් පරීක්ෂක (Detective) කතා වලට කැමති අයට කිසිම කම්මැලිකමක් නැතුව බලන්න පුළුවන් සුපිරිම කතා මාලාවක් තමයි මේක.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:
📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් Telegram චැනලය හරහා ලබාගත හැක.', '2024-01-01', 50, 7.2, 'https://image.tmdb.org/t/p/original/tJ7zq4VtvJqUyaRsLeNjpEFDXzk.jpg', '2026-07-31 09:09:26.160221+00', '2026-07-31 09:09:26.160221+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('4b5d654a-6290-4155-a9b7-3b97dfe35911', '5c4af11e-21f5-4ee9-a8a3-30fc4cf84989', 3, 'Episode 3', '🦇 Batman: Caped Crusader - සිංහල උපසිරැසි 🎬

Batman: Caped Crusader brings a dark, noir-inspired take on the Dark Knight''s early days in Gotham City. Produced by Bruce Timm, Matt Reeves, and J.J. Abrams, this animated series is a must-watch for DC fans. Download high-quality 720p WEB-DL video files with Sinhala subtitles directly or via Telegram. Experience the ultimate psychological and action-packed detective story.

Batman: Caped Crusader කියන්නේ DC රසිකයින්ට ලැබුණු අලුත්ම සහ වෙනස්ම විදිහේ ඇනිමේටඩ් කතා මාලාවක්. සුප්‍රසිද්ධ Batman: The Animated Series එක හදපු Bruce Timm වගේම The Batman චිත්‍රපටය අධ්‍යක්ෂණය කරපු Matt Reeves ගේ සහ J.J. Abrams ගේ එකතුවෙන් තමයි මේක නිර්මාණය වෙලා තියෙන්නේ. ඒ නිසාම මේකට ලොකු ප්‍රේක්ෂක ආකර්ෂණයක් ලැබිලා තියෙනවා.

කතාව යන්නේ 1940 දශකයේ අඳුරු Gotham නගරයේ. ගොඩක් දියුණු තාක්ෂණයන් නැති, දූෂණය සහ අපරාධ වලින් පිරිච්ච නගරයක Bruce Wayne තමන්ගේ මුල්ම කාලයේ Batman විදිහට අපරාධකරුවන්ට විරුද්ධව සටන් කරන හැටි තමයි මේකෙන් පෙන්නන්නේ. මේ කතාවේ ඉන්න Batman ටිකක් රළුයි වගේම, අපි දන්න Catwoman, Harley Quinn, Two-Face සහ Penguin වගේ අනිත් චරිතත් මේ කතාවේදී සම්පූර්ණයෙන්ම අලුත් වගේම වෙනස්ම විදිහකට තමයි නිර්මාණය කරලා තියෙන්නේ.

DC කොමික් පොත් වල තිබුණු මුල්ම කාලයේ අඳුරු Noir ගතියට සහ රහස් පරීක්ෂක (Detective) කතා වලට කැමති අයට කිසිම කම්මැලිකමක් නැතුව බලන්න පුළුවන් සුපිරිම කතා මාලාවක් තමයි මේක.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:
📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් Telegram චැනලය හරහා ලබාගත හැක.', '2024-01-01', 50, 7.2, 'https://image.tmdb.org/t/p/original/tJ7zq4VtvJqUyaRsLeNjpEFDXzk.jpg', '2026-07-31 09:09:26.160221+00', '2026-07-31 09:09:26.160221+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('fc321ceb-143e-4aa2-a525-9936fceb4ca6', '5c4af11e-21f5-4ee9-a8a3-30fc4cf84989', 4, 'Episode 4', '🦇 Batman: Caped Crusader - සිංහල උපසිරැසි 🎬

Batman: Caped Crusader brings a dark, noir-inspired take on the Dark Knight''s early days in Gotham City. Produced by Bruce Timm, Matt Reeves, and J.J. Abrams, this animated series is a must-watch for DC fans. Download high-quality 720p WEB-DL video files with Sinhala subtitles directly or via Telegram. Experience the ultimate psychological and action-packed detective story.

Batman: Caped Crusader කියන්නේ DC රසිකයින්ට ලැබුණු අලුත්ම සහ වෙනස්ම විදිහේ ඇනිමේටඩ් කතා මාලාවක්. සුප්‍රසිද්ධ Batman: The Animated Series එක හදපු Bruce Timm වගේම The Batman චිත්‍රපටය අධ්‍යක්ෂණය කරපු Matt Reeves ගේ සහ J.J. Abrams ගේ එකතුවෙන් තමයි මේක නිර්මාණය වෙලා තියෙන්නේ. ඒ නිසාම මේකට ලොකු ප්‍රේක්ෂක ආකර්ෂණයක් ලැබිලා තියෙනවා.

කතාව යන්නේ 1940 දශකයේ අඳුරු Gotham නගරයේ. ගොඩක් දියුණු තාක්ෂණයන් නැති, දූෂණය සහ අපරාධ වලින් පිරිච්ච නගරයක Bruce Wayne තමන්ගේ මුල්ම කාලයේ Batman විදිහට අපරාධකරුවන්ට විරුද්ධව සටන් කරන හැටි තමයි මේකෙන් පෙන්නන්නේ. මේ කතාවේ ඉන්න Batman ටිකක් රළුයි වගේම, අපි දන්න Catwoman, Harley Quinn, Two-Face සහ Penguin වගේ අනිත් චරිතත් මේ කතාවේදී සම්පූර්ණයෙන්ම අලුත් වගේම වෙනස්ම විදිහකට තමයි නිර්මාණය කරලා තියෙන්නේ.

DC කොමික් පොත් වල තිබුණු මුල්ම කාලයේ අඳුරු Noir ගතියට සහ රහස් පරීක්ෂක (Detective) කතා වලට කැමති අයට කිසිම කම්මැලිකමක් නැතුව බලන්න පුළුවන් සුපිරිම කතා මාලාවක් තමයි මේක.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:
📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් Telegram චැනලය හරහා ලබාගත හැක.', '2024-01-01', 50, 7.2, 'https://image.tmdb.org/t/p/original/tJ7zq4VtvJqUyaRsLeNjpEFDXzk.jpg', '2026-07-31 09:09:26.160221+00', '2026-07-31 09:09:26.160221+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('dc8d1497-fa15-477d-ac20-2adf75dfe81e', '5c4af11e-21f5-4ee9-a8a3-30fc4cf84989', 5, 'Episode 5', '🦇 Batman: Caped Crusader - සිංහල උපසිරැසි 🎬

Batman: Caped Crusader brings a dark, noir-inspired take on the Dark Knight''s early days in Gotham City. Produced by Bruce Timm, Matt Reeves, and J.J. Abrams, this animated series is a must-watch for DC fans. Download high-quality 720p WEB-DL video files with Sinhala subtitles directly or via Telegram. Experience the ultimate psychological and action-packed detective story...

Batman: Caped Crusader කියන්නේ DC රසිකයින්ට ලැබුණු අලුත්ම සහ වෙනස්ම විදිහේ ඇනිමේටඩ් කතා මාලාවක්. සුප්‍රසිද්ධ Batman: The Animated Series එක හදපු Bruce Timm වගේම The Batman චිත්‍රපටය අධ්‍යක්ෂණය කරපු Matt Reeves ගේ සහ J.J. Abrams ගේ එකතුවෙන් තමයි මේක නිර්මාණය වෙලා තියෙන්නේ. ඒ නිසාම මේකට ලොකු ප්‍රේක්ෂක ආකර්ෂණයක් ලැබිලා තියෙනවා.

කතාව යන්නේ 1940 දශකයේ අඳුරු Gotham නගරයේ. ගොඩක් දියුණු තාක්ෂණයන් නැති, දූෂණය සහ අපරාධ වලින් පිරිච්ච නගරයක Bruce Wayne තමන්ගේ මුල්ම කාලයේ Batman විදිහට අපරාධකරුවන්ට විරුද්ධව සටන් කරන හැටි තමයි මේකෙන් පෙන්නන්නේ. මේ කතාවේ ඉන්න Batman ටිකක් රළුයි වගේම, අපි දන්න Catwoman, Harley Quinn, Two-Face සහ Penguin වගේ අනිත් චරිතත් මේ කතාවේදී සම්පූර්ණයෙන්ම අලුත් වගේම වෙනස්ම විදිහකට තමයි නිර්මාණය කරලා තියෙන්නේ.

DC කොමික් පොත් වල තිබුණු මුල්ම කාලයේ අඳුරු Noir ගතියට සහ රහස් පරීක්ෂක (Detective) කතා වලට කැමති අයට කිසිම කම්මැලිකමක් නැතුව බලන්න පුළුවන් සුපිරිම කතා මාලාවක් තමයි මේක.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:
📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් Telegram චැනලය හරහා ලබාගත හැක', '2024-01-01', 50, 7.2, 'https://image.tmdb.org/t/p/original/tJ7zq4VtvJqUyaRsLeNjpEFDXzk.jpg', '2026-07-31 09:09:26.160221+00', '2026-07-31 09:09:26.160221+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('a2b2f7e7-78c7-4f3a-abff-a535a82c1a08', '8a53dd11-3b8f-4853-a949-d19a7216fde8', 4, 'Episode 4', '🔫 The Sopranos  Season 1 Episode 04- සිංහල උපසිරැසි 🎬

The Sopranos is widely considered one of the greatest television series of all time. Dive into the complex life of Tony Soprano, a New Jersey mob boss balancing his ruthless mafia family with his actual family. Download high-quality 720p, 1080p Blu-Ray video files with Sinhala subtitles directly or via Telegram. Experience the masterpiece that changed modern television forever.

ලෝකයේ බිහිවුණු විශිෂ්ටතම රූපවාහිනී කතා මාලාවන්ගෙන් එකක් විදිහට හැඳින්වෙන The Sopranos තමයි මේ අරගෙන එන්නේ. New Jersey වල මාෆියා නායකයෙක් වෙන Tony Soprano ගේ ජීවිතය වටා තමයි මේ කතාව ගෙතිලා තියෙන්නේ. තමන්ගේ අපරාධ ජාලය මෙහෙයවන එකයි, පවුලේ ප්‍රශ්න විසඳන එකයි අතරේ ඔහු කොහොමද සමබරතාවය තියාගන්නේ කියන එක මේකෙන් ගොඩක් තාත්විකව පෙන්නනවා.

සාමාන්‍ය මාෆියා කතාවකට වඩා මේක ගොඩක් වෙනස් වෙන්නේ, Tony Soprano මුහුණ දෙන මානසික ආතතිය සහ ඒ නිසා ඔහු මනෝ වෛද්‍යවරයෙක් මුණගැහෙන්න යන සිදුවීම් නිසා. Action, Crime කතා වලට වගේම, ටිකක් ගැඹුරු කතා තේමාවන් වලට කැමති අයට කිසිම කම්මැලිකමක් නැතුව බලන්න පුළුවන් සුපිරිම කතා මාලාවක් තමයි මේක. HBO නාලිකාවෙන් විකාශය වුණු මේ කතාව, අදටත් රූපවාහිනී කලාවේ දැවැන්තම සන්ධිස්ථානයක් විදිහට සැලකෙනවා. 

🔰🔰🔰මෙම උපසිරැසි  bluray පිටපත් වලට පමනක් ගැලපේ.🔰🔰🔰🔰

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව බාගත කරගත හැක.

✈️ Telegram Download: 720p, 1080p උසස් තත්ත්වයේ Bluray වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '1997-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/rTc7ZXdroqjkKivFPvCPX0Ru7uw.jpg', '2026-07-31 15:59:35.827563+00', '2026-07-31 15:59:35.827563+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('05719008-186f-46bd-ad7a-dfa00f934cb6', '8a53dd11-3b8f-4853-a949-d19a7216fde8', 5, 'Episode 5', '🔫 The Sopranos  Season 1 Episode 05- සිංහල උපසිරැසි 🎬

The Sopranos is widely considered one of the greatest television series of all time. Dive into the complex life of Tony Soprano, a New Jersey mob boss balancing his ruthless mafia family with his actual family. Download high-quality 720p, 1080p Blu-Ray video files with Sinhala subtitles directly or via Telegram. Experience the masterpiece that changed modern television forever.

ලෝකයේ බිහිවුණු විශිෂ්ටතම රූපවාහිනී කතා මාලාවන්ගෙන් එකක් විදිහට හැඳින්වෙන The Sopranos තමයි මේ අරගෙන එන්නේ. New Jersey වල මාෆියා නායකයෙක් වෙන Tony Soprano ගේ ජීවිතය වටා තමයි මේ කතාව ගෙතිලා තියෙන්නේ. තමන්ගේ අපරාධ ජාලය මෙහෙයවන එකයි, පවුලේ ප්‍රශ්න විසඳන එකයි අතරේ ඔහු කොහොමද සමබරතාවය තියාගන්නේ කියන එක මේකෙන් ගොඩක් තාත්විකව පෙන්නනවා.

සාමාන්‍ය මාෆියා කතාවකට වඩා මේක ගොඩක් වෙනස් වෙන්නේ, Tony Soprano මුහුණ දෙන මානසික ආතතිය සහ ඒ නිසා ඔහු මනෝ වෛද්‍යවරයෙක් මුණගැහෙන්න යන සිදුවීම් නිසා. Action, Crime කතා වලට වගේම, ටිකක් ගැඹුරු කතා තේමාවන් වලට කැමති අයට කිසිම කම්මැලිකමක් නැතුව බලන්න පුළුවන් සුපිරිම කතා මාලාවක් තමයි මේක. HBO නාලිකාවෙන් විකාශය වුණු මේ කතාව, අදටත් රූපවාහිනී කලාවේ දැවැන්තම සන්ධිස්ථානයක් විදිහට සැලකෙනවා. 

🔰🔰🔰මෙම උපසිරැසි  bluray පිටපත් වලට පමනක් ගැලපේ.🔰🔰🔰🔰

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව බාගත කරගත හැක.

✈️ Telegram Download: 720p, 1080p උසස් තත්ත්වයේ Bluray වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '1997-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/rTc7ZXdroqjkKivFPvCPX0Ru7uw.jpg', '2026-07-31 17:35:43.965012+00', '2026-07-31 17:35:43.965012+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('549b2796-9dd2-468f-ab9c-28c70312dc07', '8a53dd11-3b8f-4853-a949-d19a7216fde8', 6, 'Episode 6', '🔫 The Sopranos  Season 1 Episode 06- සිංහල උපසිරැසි 🎬

The Sopranos is widely considered one of the greatest television series of all time. Dive into the complex life of Tony Soprano, a New Jersey mob boss balancing his ruthless mafia family with his actual family. Download high-quality 720p, 1080p Blu-Ray video files with Sinhala subtitles directly or via Telegram. Experience the masterpiece that changed modern television forever.

ලෝකයේ බිහිවුණු විශිෂ්ටතම රූපවාහිනී කතා මාලාවන්ගෙන් එකක් විදිහට හැඳින්වෙන The Sopranos තමයි මේ අරගෙන එන්නේ. New Jersey වල මාෆියා නායකයෙක් වෙන Tony Soprano ගේ ජීවිතය වටා තමයි මේ කතාව ගෙතිලා තියෙන්නේ. තමන්ගේ අපරාධ ජාලය මෙහෙයවන එකයි, පවුලේ ප්‍රශ්න විසඳන එකයි අතරේ ඔහු කොහොමද සමබරතාවය තියාගන්නේ කියන එක මේකෙන් ගොඩක් තාත්විකව පෙන්නනවා.

සාමාන්‍ය මාෆියා කතාවකට වඩා මේක ගොඩක් වෙනස් වෙන්නේ, Tony Soprano මුහුණ දෙන මානසික ආතතිය සහ ඒ නිසා ඔහු මනෝ වෛද්‍යවරයෙක් මුණගැහෙන්න යන සිදුවීම් නිසා. Action, Crime කතා වලට වගේම, ටිකක් ගැඹුරු කතා තේමාවන් වලට කැමති අයට කිසිම කම්මැලිකමක් නැතුව බලන්න පුළුවන් සුපිරිම කතා මාලාවක් තමයි මේක. HBO නාලිකාවෙන් විකාශය වුණු මේ කතාව, අදටත් රූපවාහිනී කලාවේ දැවැන්තම සන්ධිස්ථානයක් විදිහට සැලකෙනවා. 

🔰🔰🔰මෙම උපසිරැසි  bluray පිටපත් වලට පමනක් ගැලපේ.🔰🔰🔰🔰

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව බාගත කරගත හැක.

✈️ Telegram Download: 720p, 1080p උසස් තත්ත්වයේ Bluray වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '1997-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/rTc7ZXdroqjkKivFPvCPX0Ru7uw.jpg', '2026-08-01 18:42:43.72199+00', '2026-08-01 18:42:43.72199+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('1a753b91-dcf4-47e6-ac93-5415111aeb4f', '8a53dd11-3b8f-4853-a949-d19a7216fde8', 7, 'Episode 7', '🔫 The Sopranos  Season 1 Episode 07- සිංහල උපසිරැසි 🎬

The Sopranos is widely considered one of the greatest television series of all time. Dive into the complex life of Tony Soprano, a New Jersey mob boss balancing his ruthless mafia family with his actual family. Download high-quality 720p, 1080p Blu-Ray video files with Sinhala subtitles directly or via Telegram. Experience the masterpiece that changed modern television forever.

ලෝකයේ බිහිවුණු විශිෂ්ටතම රූපවාහිනී කතා මාලාවන්ගෙන් එකක් විදිහට හැඳින්වෙන The Sopranos තමයි මේ අරගෙන එන්නේ. New Jersey වල මාෆියා නායකයෙක් වෙන Tony Soprano ගේ ජීවිතය වටා තමයි මේ කතාව ගෙතිලා තියෙන්නේ. තමන්ගේ අපරාධ ජාලය මෙහෙයවන එකයි, පවුලේ ප්‍රශ්න විසඳන එකයි අතරේ ඔහු කොහොමද සමබරතාවය තියාගන්නේ කියන එක මේකෙන් ගොඩක් තාත්විකව පෙන්නනවා.

සාමාන්‍ය මාෆියා කතාවකට වඩා මේක ගොඩක් වෙනස් වෙන්නේ, Tony Soprano මුහුණ දෙන මානසික ආතතිය සහ ඒ නිසා ඔහු මනෝ වෛද්‍යවරයෙක් මුණගැහෙන්න යන සිදුවීම් නිසා. Action, Crime කතා වලට වගේම, ටිකක් ගැඹුරු කතා තේමාවන් වලට කැමති අයට කිසිම කම්මැලිකමක් නැතුව බලන්න පුළුවන් සුපිරිම කතා මාලාවක් තමයි මේක. HBO නාලිකාවෙන් විකාශය වුණු මේ කතාව, අදටත් රූපවාහිනී කලාවේ දැවැන්තම සන්ධිස්ථානයක් විදිහට සැලකෙනවා. 

🔰🔰🔰මෙම උපසිරැසි  bluray පිටපත් වලට පමනක් ගැලපේ.🔰🔰🔰🔰

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව බාගත කරගත හැක.

✈️ Telegram Download: 720p, 1080p උසස් තත්ත්වයේ Bluray වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '1997-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/rTc7ZXdroqjkKivFPvCPX0Ru7uw.jpg', '2026-08-01 18:42:43.72199+00', '2026-08-01 18:42:43.72199+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('28e5ebf9-a675-4e01-af74-021ee06a6b85', '8a53dd11-3b8f-4853-a949-d19a7216fde8', 8, 'Episode 8', '🔫 The Sopranos  Season 1 Episode 08- සිංහල උපසිරැසි 🎬

The Sopranos is widely considered one of the greatest television series of all time. Dive into the complex life of Tony Soprano, a New Jersey mob boss balancing his ruthless mafia family with his actual family. Download high-quality 720p, 1080p Blu-Ray video files with Sinhala subtitles directly or via Telegram. Experience the masterpiece that changed modern television forever.

ලෝකයේ බිහිවුණු විශිෂ්ටතම රූපවාහිනී කතා මාලාවන්ගෙන් එකක් විදිහට හැඳින්වෙන The Sopranos තමයි මේ අරගෙන එන්නේ. New Jersey වල මාෆියා නායකයෙක් වෙන Tony Soprano ගේ ජීවිතය වටා තමයි මේ කතාව ගෙතිලා තියෙන්නේ. තමන්ගේ අපරාධ ජාලය මෙහෙයවන එකයි, පවුලේ ප්‍රශ්න විසඳන එකයි අතරේ ඔහු කොහොමද සමබරතාවය තියාගන්නේ කියන එක මේකෙන් ගොඩක් තාත්විකව පෙන්නනවා.

සාමාන්‍ය මාෆියා කතාවකට වඩා මේක ගොඩක් වෙනස් වෙන්නේ, Tony Soprano මුහුණ දෙන මානසික ආතතිය සහ ඒ නිසා ඔහු මනෝ වෛද්‍යවරයෙක් මුණගැහෙන්න යන සිදුවීම් නිසා. Action, Crime කතා වලට වගේම, ටිකක් ගැඹුරු කතා තේමාවන් වලට කැමති අයට කිසිම කම්මැලිකමක් නැතුව බලන්න පුළුවන් සුපිරිම කතා මාලාවක් තමයි මේක. HBO නාලිකාවෙන් විකාශය වුණු මේ කතාව, අදටත් රූපවාහිනී කලාවේ දැවැන්තම සන්ධිස්ථානයක් විදිහට සැලකෙනවා. 

🔰🔰🔰මෙම උපසිරැසි  bluray පිටපත් වලට පමනක් ගැලපේ.🔰🔰🔰🔰

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව බාගත කරගත හැක.

✈️ Telegram Download: 720p, 1080p උසස් තත්ත්වයේ Bluray වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '1997-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/rTc7ZXdroqjkKivFPvCPX0Ru7uw.jpg', '2026-08-01 18:42:43.72199+00', '2026-08-01 18:42:43.72199+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('734420f6-3943-4eee-a22c-cf1cb905a96d', '8a53dd11-3b8f-4853-a949-d19a7216fde8', 9, 'Episode 9', '🔫 The Sopranos  Season 1 Episode 09- සිංහල උපසිරැසි 🎬

The Sopranos is widely considered one of the greatest television series of all time. Dive into the complex life of Tony Soprano, a New Jersey mob boss balancing his ruthless mafia family with his actual family. Download high-quality 720p, 1080p Blu-Ray video files with Sinhala subtitles directly or via Telegram. Experience the masterpiece that changed modern television forever.

ලෝකයේ බිහිවුණු විශිෂ්ටතම රූපවාහිනී කතා මාලාවන්ගෙන් එකක් විදිහට හැඳින්වෙන The Sopranos තමයි මේ අරගෙන එන්නේ. New Jersey වල මාෆියා නායකයෙක් වෙන Tony Soprano ගේ ජීවිතය වටා තමයි මේ කතාව ගෙතිලා තියෙන්නේ. තමන්ගේ අපරාධ ජාලය මෙහෙයවන එකයි, පවුලේ ප්‍රශ්න විසඳන එකයි අතරේ ඔහු කොහොමද සමබරතාවය තියාගන්නේ කියන එක මේකෙන් ගොඩක් තාත්විකව පෙන්නනවා.

සාමාන්‍ය මාෆියා කතාවකට වඩා මේක ගොඩක් වෙනස් වෙන්නේ, Tony Soprano මුහුණ දෙන මානසික ආතතිය සහ ඒ නිසා ඔහු මනෝ වෛද්‍යවරයෙක් මුණගැහෙන්න යන සිදුවීම් නිසා. Action, Crime කතා වලට වගේම, ටිකක් ගැඹුරු කතා තේමාවන් වලට කැමති අයට කිසිම කම්මැලිකමක් නැතුව බලන්න පුළුවන් සුපිරිම කතා මාලාවක් තමයි මේක. HBO නාලිකාවෙන් විකාශය වුණු මේ කතාව, අදටත් රූපවාහිනී කලාවේ දැවැන්තම සන්ධිස්ථානයක් විදිහට සැලකෙනවා. 

🔰🔰🔰මෙම උපසිරැසි  bluray පිටපත් වලට පමනක් ගැලපේ.🔰🔰🔰🔰

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව බාගත කරගත හැක.

✈️ Telegram Download: 720p, 1080p උසස් තත්ත්වයේ Bluray වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '1999-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/rTc7ZXdroqjkKivFPvCPX0Ru7uw.jpg', '2026-08-02 11:53:59.619015+00', '2026-08-02 11:53:59.619015+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('78ce7f43-6636-46f0-a55a-193958f3dd9d', '8a53dd11-3b8f-4853-a949-d19a7216fde8', 10, 'Episode 10', '🔫 The Sopranos  Season 1 Episode 10- සිංහල උපසිරැසි 🎬

The Sopranos is widely considered one of the greatest television series of all time. Dive into the complex life of Tony Soprano, a New Jersey mob boss balancing his ruthless mafia family with his actual family. Download high-quality 720p, 1080p Blu-Ray video files with Sinhala subtitles directly or via Telegram. Experience the masterpiece that changed modern television forever.

ලෝකයේ බිහිවුණු විශිෂ්ටතම රූපවාහිනී කතා මාලාවන්ගෙන් එකක් විදිහට හැඳින්වෙන The Sopranos තමයි මේ අරගෙන එන්නේ. New Jersey වල මාෆියා නායකයෙක් වෙන Tony Soprano ගේ ජීවිතය වටා තමයි මේ කතාව ගෙතිලා තියෙන්නේ. තමන්ගේ අපරාධ ජාලය මෙහෙයවන එකයි, පවුලේ ප්‍රශ්න විසඳන එකයි අතරේ ඔහු කොහොමද සමබරතාවය තියාගන්නේ කියන එක මේකෙන් ගොඩක් තාත්විකව පෙන්නනවා.

සාමාන්‍ය මාෆියා කතාවකට වඩා මේක ගොඩක් වෙනස් වෙන්නේ, Tony Soprano මුහුණ දෙන මානසික ආතතිය සහ ඒ නිසා ඔහු මනෝ වෛද්‍යවරයෙක් මුණගැහෙන්න යන සිදුවීම් නිසා. Action, Crime කතා වලට වගේම, ටිකක් ගැඹුරු කතා තේමාවන් වලට කැමති අයට කිසිම කම්මැලිකමක් නැතුව බලන්න පුළුවන් සුපිරිම කතා මාලාවක් තමයි මේක. HBO නාලිකාවෙන් විකාශය වුණු මේ කතාව, අදටත් රූපවාහිනී කලාවේ දැවැන්තම සන්ධිස්ථානයක් විදිහට සැලකෙනවා. 

🔰🔰🔰මෙම උපසිරැසි  bluray පිටපත් වලට පමනක් ගැලපේ.🔰🔰🔰🔰

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව බාගත කරගත හැක.

✈️ Telegram Download: 720p, 1080p උසස් තත්ත්වයේ Bluray වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '1999-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/rTc7ZXdroqjkKivFPvCPX0Ru7uw.jpg', '2026-08-02 11:53:59.619015+00', '2026-08-02 11:53:59.619015+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('ea6dea3d-fe91-401a-a94c-d36f75b13947', '8a53dd11-3b8f-4853-a949-d19a7216fde8', 11, 'Episode 11', '🔫 The Sopranos  Season 1 Episode 11- සිංහල උපසිරැසි 🎬

The Sopranos is widely considered one of the greatest television series of all time. Dive into the complex life of Tony Soprano, a New Jersey mob boss balancing his ruthless mafia family with his actual family. Download high-quality 720p, 1080p Blu-Ray video files with Sinhala subtitles directly or via Telegram. Experience the masterpiece that changed modern television forever.

ලෝකයේ බිහිවුණු විශිෂ්ටතම රූපවාහිනී කතා මාලාවන්ගෙන් එකක් විදිහට හැඳින්වෙන The Sopranos තමයි මේ අරගෙන එන්නේ. New Jersey වල මාෆියා නායකයෙක් වෙන Tony Soprano ගේ ජීවිතය වටා තමයි මේ කතාව ගෙතිලා තියෙන්නේ. තමන්ගේ අපරාධ ජාලය මෙහෙයවන එකයි, පවුලේ ප්‍රශ්න විසඳන එකයි අතරේ ඔහු කොහොමද සමබරතාවය තියාගන්නේ කියන එක මේකෙන් ගොඩක් තාත්විකව පෙන්නනවා.

සාමාන්‍ය මාෆියා කතාවකට වඩා මේක ගොඩක් වෙනස් වෙන්නේ, Tony Soprano මුහුණ දෙන මානසික ආතතිය සහ ඒ නිසා ඔහු මනෝ වෛද්‍යවරයෙක් මුණගැහෙන්න යන සිදුවීම් නිසා. Action, Crime කතා වලට වගේම, ටිකක් ගැඹුරු කතා තේමාවන් වලට කැමති අයට කිසිම කම්මැලිකමක් නැතුව බලන්න පුළුවන් සුපිරිම කතා මාලාවක් තමයි මේක. HBO නාලිකාවෙන් විකාශය වුණු මේ කතාව, අදටත් රූපවාහිනී කලාවේ දැවැන්තම සන්ධිස්ථානයක් විදිහට සැලකෙනවා. 

🔰🔰🔰මෙම උපසිරැසි  bluray පිටපත් වලට පමනක් ගැලපේ.🔰🔰🔰🔰

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව බාගත කරගත හැක.

✈️ Telegram Download: 720p, 1080p උසස් තත්ත්වයේ Bluray වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '1999-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/rTc7ZXdroqjkKivFPvCPX0Ru7uw.jpg', '2026-08-02 11:53:59.619015+00', '2026-08-02 11:53:59.619015+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('08225473-5860-4a5d-ab4d-2d41843fecff', '8a53dd11-3b8f-4853-a949-d19a7216fde8', 12, 'Episode 12', '🔫 The Sopranos  Season 1 Episode 12- සිංහල උපසිරැසි 🎬

The Sopranos is widely considered one of the greatest television series of all time. Dive into the complex life of Tony Soprano, a New Jersey mob boss balancing his ruthless mafia family with his actual family. Download high-quality 720p, 1080p Blu-Ray video files with Sinhala subtitles directly or via Telegram. Experience the masterpiece that changed modern television forever.

ලෝකයේ බිහිවුණු විශිෂ්ටතම රූපවාහිනී කතා මාලාවන්ගෙන් එකක් විදිහට හැඳින්වෙන The Sopranos තමයි මේ අරගෙන එන්නේ. New Jersey වල මාෆියා නායකයෙක් වෙන Tony Soprano ගේ ජීවිතය වටා තමයි මේ කතාව ගෙතිලා තියෙන්නේ. තමන්ගේ අපරාධ ජාලය මෙහෙයවන එකයි, පවුලේ ප්‍රශ්න විසඳන එකයි අතරේ ඔහු කොහොමද සමබරතාවය තියාගන්නේ කියන එක මේකෙන් ගොඩක් තාත්විකව පෙන්නනවා.

සාමාන්‍ය මාෆියා කතාවකට වඩා මේක ගොඩක් වෙනස් වෙන්නේ, Tony Soprano මුහුණ දෙන මානසික ආතතිය සහ ඒ නිසා ඔහු මනෝ වෛද්‍යවරයෙක් මුණගැහෙන්න යන සිදුවීම් නිසා. Action, Crime කතා වලට වගේම, ටිකක් ගැඹුරු කතා තේමාවන් වලට කැමති අයට කිසිම කම්මැලිකමක් නැතුව බලන්න පුළුවන් සුපිරිම කතා මාලාවක් තමයි මේක. HBO නාලිකාවෙන් විකාශය වුණු මේ කතාව, අදටත් රූපවාහිනී කලාවේ දැවැන්තම සන්ධිස්ථානයක් විදිහට සැලකෙනවා. 

🔰🔰🔰මෙම උපසිරැසි  bluray පිටපත් වලට පමනක් ගැලපේ.🔰🔰🔰🔰

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව බාගත කරගත හැක.

✈️ Telegram Download: 720p, 1080p උසස් තත්ත්වයේ Bluray වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '1999-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/rTc7ZXdroqjkKivFPvCPX0Ru7uw.jpg', '2026-08-02 11:53:59.619015+00', '2026-08-02 11:53:59.619015+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('bc1005bd-12af-4957-a65f-ee1fbe7554ba', '8a53dd11-3b8f-4853-a949-d19a7216fde8', 13, 'Episode 13', '🔫 The Sopranos  Season 1 Episode 13- සිංහල උපසිරැසි 🎬

The Sopranos is widely considered one of the greatest television series of all time. Dive into the complex life of Tony Soprano, a New Jersey mob boss balancing his ruthless mafia family with his actual family. Download high-quality 720p, 1080p Blu-Ray video files with Sinhala subtitles directly or via Telegram. Experience the masterpiece that changed modern television forever.

ලෝකයේ බිහිවුණු විශිෂ්ටතම රූපවාහිනී කතා මාලාවන්ගෙන් එකක් විදිහට හැඳින්වෙන The Sopranos තමයි මේ අරගෙන එන්නේ. New Jersey වල මාෆියා නායකයෙක් වෙන Tony Soprano ගේ ජීවිතය වටා තමයි මේ කතාව ගෙතිලා තියෙන්නේ. තමන්ගේ අපරාධ ජාලය මෙහෙයවන එකයි, පවුලේ ප්‍රශ්න විසඳන එකයි අතරේ ඔහු කොහොමද සමබරතාවය තියාගන්නේ කියන එක මේකෙන් ගොඩක් තාත්විකව පෙන්නනවා.

සාමාන්‍ය මාෆියා කතාවකට වඩා මේක ගොඩක් වෙනස් වෙන්නේ, Tony Soprano මුහුණ දෙන මානසික ආතතිය සහ ඒ නිසා ඔහු මනෝ වෛද්‍යවරයෙක් මුණගැහෙන්න යන සිදුවීම් නිසා. Action, Crime කතා වලට වගේම, ටිකක් ගැඹුරු කතා තේමාවන් වලට කැමති අයට කිසිම කම්මැලිකමක් නැතුව බලන්න පුළුවන් සුපිරිම කතා මාලාවක් තමයි මේක. HBO නාලිකාවෙන් විකාශය වුණු මේ කතාව, අදටත් රූපවාහිනී කලාවේ දැවැන්තම සන්ධිස්ථානයක් විදිහට සැලකෙනවා. 

🔰🔰🔰මෙම උපසිරැසි  bluray පිටපත් වලට පමනක් ගැලපේ.🔰🔰🔰🔰

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව බාගත කරගත හැක.

✈️ Telegram Download: 720p, 1080p උසස් තත්ත්වයේ Bluray වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '1999-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/rTc7ZXdroqjkKivFPvCPX0Ru7uw.jpg', '2026-08-02 11:53:59.619015+00', '2026-08-02 11:53:59.619015+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('96d63812-eeae-4131-a276-c3a5edf2efac', '40101ea4-8f61-4afe-a5ce-836fee184982', 7, 'Episode 7', 'House of the Dragon (Season 03 - Episode 07) - සිංහල උපසිරැසි💚

The House of the Dragon Season 3 Episode 07 Breakdown by New Rockstars is now available with Sinhala subtitles. Dive deep into every hidden detail, Easter egg, and lore reference you missed in the latest episode, including Sir Criston Cole''s shocking fate, the five mysterious dragon eggs at Harrenhal, and Corlys Velaryon''s unexpected capture. Download high-quality 720p, 1080p, WEB-DL video files with Sinhala subtitles directly or via Telegram. Enhance your Westeros experience with this ultimate episode.

වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

✅Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✅Telegram Download: 720p, 1080p සහ 4K උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2026-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/7V0Ebks0GgpKvQ7QbLAIdX5dos4.jpg', '2026-08-03 02:22:22.473636+00', '2026-08-03 02:22:22.473636+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('351c770e-05fc-441a-aa76-4a2616b0b506', '73c3fd9e-1f00-4fe7-a156-e1dc0ae06a9f', 2, 'Episode 2', 'The Walking Dead: Dead City (Season 03 - Episode 02) - සිංහල උපසිරැසි💚

වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

✅Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✅Telegram Download: 720p, 1080p සහ 4K උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2023-01-01', 50, 7, 'https://image.tmdb.org/t/p/original/seYokxOjFyTVX13XgD2FNjWIry8.jpg', '2026-08-03 09:03:10.202106+00', '2026-08-03 09:03:10.202106+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('1615a249-5dbb-426e-a17f-ffd3a1d7600a', '40dee2dc-1a40-4b47-acaf-4308fe7654ba', 1, 'Episode 1', '🔫 The Sopranos Season 2 - සිංහල උපසිරැසි 🎬

Continue the legendary journey with The Sopranos Season 2, one of the most intense and captivating chapters in television history. As Tony Soprano steps up to lead the DiMeo crime family, he faces growing paranoia, betrayal from close associates, and unresolved psychological turmoil that threatens his mafia empire and family life.

Download all episodes of The Sopranos Season 2 in high-definition quality. Choose from 720p, 1080p WEB-DL video files, all paired with accurate Sinhala subtitles. Access your files instantly via high-speed direct download links or convenient Telegram links.

නිව් ජර්සි නගරය කේන්ද්‍ර කරගනිමින් ක්‍රියාත්මක වන ප්‍රබල මාෆියා කල්ලියක ප්‍රධානියෙකු වන ටෝනි සෝප්‍රානෝ (Tony Soprano) සාමාන්‍ය පවුල් ජීවිතයත්, අපරාධ ලෝකයත් අතර දෝලනය වන චරිතයකි. පළමු කලාපය ආරම්භ වන්නේ ඔහු මුහුණ දෙන අභ්‍යන්තර සහ බාහිර ගැටුම් රැසක් සමඟිනි. අධික මානසික පීඩනය නිසා ඇති වන හදිසි ක්ලාන්ත සහ භීතිකා තත්ත්වයන් (Panic Attacks) හේතුවෙන්, ටෝනිට සිදුවන්නේ රහසින් මනෝ වෛද්‍ය ජෙනිෆර් මෙල්ෆි (Dr. Jennifer Melfi) හමුවී ප්‍රතිකාර ලබා ගැනීමටය. මාෆියා සංස්කෘතිය තුළ මෙවැනි ප්‍රතිකාර ලබා ගැනීම බරපතළ දුර්වලතාවයක් ලෙස සලකන බැවින්, මෙම වෛද්‍ය හමුවීම් සඟවා තබා ගැනීමට ඔහුට දැඩි වෙහෙසක් දැරීමට සිදු වේ.

මේ අතර, කල්ලියේ ප්‍රධානියා වූ ජැකී ඇප්‍රිල්ගේ අභාවයත් සමඟ නායකත්වය සඳහා ටෝනි සහ ඔහුගේ බාප්පා වන ජූනියර් (Uncle Junior) අතර දැඩි බල අරගලයක් නිර්මාණය වේ. අනවශ්‍ය ගැටුම් මඟහරවා ගැනීම සඳහා ටෝනි ඉතා සූක්ෂ්ම ලෙස ජූනියර්ව නාමිකව පවුලේ ප්‍රධානියා (Official Boss) ලෙස පත් කිරීමට කටයුතු කරයි. කෙසේ වෙතත්, සැබෑ බලය සහ ප්‍රධාන තීරණ ගැනීම් සිදු කරන්නේ ටෝනි සහ ඔහුගේ සමීපතම කණ්ඩායම විසින් වන අතර, මෙය ජූනියර්ගේ නොසතුටට හේතු වේ.

ටෝනිගේ පෞද්ගලික ජීවිතය ද මෙවැනිම ගැටලුවලින් පිරී පවතී. ඔහුගේ අහංකාර සහ මානසිකව පීඩාකාරී මව වන ලිවියා (Livia) ව බලා ගැනීමට නොහැකි තැන, ටෝනි ඇයව විශ්‍රාමික නිවාසයක නතර කිරීමට තීරණය කරයි. තමන්ව මෙවැනි තැනකට යැවීම පිළිබඳව දැඩි වෛරයකින් පසුවන ලිවියා, ටෝනි කෙරෙහි පළිගැනීමේ චේතනාවෙන් පසුවේ.

ටෝනි රහසින් මනෝ වෛද්‍යවරයෙකු හමුවන බවත්, තමන්ව රවටා පවුලේ බලය හසුරුවන බවත් ජූනියර් මාමා දැනගන්නේ මෙම වටපිටාව තුළය. මේ සඳහා ලිවියා ද වක්‍රව ජූනියර්ව පොළඹවන අතර, එහි ප්‍රතිඵලයක් ලෙස ඔවුන් දෙදෙනා එක්ව ටෝනිව ඝාතනය කිරීමට සැලසුම් කරයි. කෙසේ වෙතත්, එම මාරාන්තික වෙඩි තැබීමේ උත්සාහයෙන් ඉතා ආශ්චර්යමත් ලෙස ටෝනි බේරීමට සමත් වේ. පසුව, FBI ආයතනය විසින් පටිගත කරන ලද රහසිගත හඬපට මාර්ගයෙන් තමන්ව ඝාතනය කිරීමට සැලසුම් කළේ තමන්ගේම මව සහ බාප්පා බව ටෝනි වටහා ගනී.

පළමු කලාපය අවසන් වන්නේ මෙම පාවාදීම් පිළිබඳ ඇත්ත හෙළිවීමත් සමඟය. ටෝනිගේ ප්‍රතිප්‍රහාර හමුවේ ජූනියර් මාමාගේ සමීපතමයින් විනාශ වන අතර, අවසානයේදී ජූනියර් FBI අත්අඩංගුවට පත් වේ. තම පුතාගේ කෝපයෙන් බේරීම සඳහා ලිවියා හදිසි ආඝාත තත්ත්වයක් රඟපාමින් රෝහල්ගත වේ. පළමු කලාපය නිමාවට පත්වන විට ටෝනි පවුලේ අවිවාදිත සැබෑ නායකයා බවට පත් වුවද, සමීපතමයන්ගෙන් ලැබුණු ද්‍රෝහීකම් නිසා ඔහුගේ සිත තුළ ගැඹුරු කැලඹීමක් ඉතිරි වේ. දෙවන කලාපය ආරම්භ වන්නේ මෙම සිදුවීම් මාලාවෙන් පසුව ඇති වන නව අභියෝග රැසක් සමඟිනි.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram download: 720p සහ 1080p උසස් තත්ත්වයේ WEBRip වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2000-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/u7dlARwP2zsqHaMNL5HtHhaEPea.jpg', '2026-08-04 13:03:55.568064+00', '2026-08-04 13:03:55.568064+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('a7b3691d-be6c-4727-acf0-289c5cdcebc0', '40dee2dc-1a40-4b47-acaf-4308fe7654ba', 2, 'Episode 2', '🔫 The Sopranos Season 2 - සිංහල උපසිරැසි 🎬

Continue the legendary journey with The Sopranos Season 2, one of the most intense and captivating chapters in television history. As Tony Soprano steps up to lead the DiMeo crime family, he faces growing paranoia, betrayal from close associates, and unresolved psychological turmoil that threatens his mafia empire and family life.

Download all episodes of The Sopranos Season 2 in high-definition quality. Choose from 720p, 1080p WEB-DL video files, all paired with accurate Sinhala subtitles. Access your files instantly via high-speed direct download links or convenient Telegram links.

නිව් ජර්සි නගරය කේන්ද්‍ර කරගනිමින් ක්‍රියාත්මක වන ප්‍රබල මාෆියා කල්ලියක ප්‍රධානියෙකු වන ටෝනි සෝප්‍රානෝ (Tony Soprano) සාමාන්‍ය පවුල් ජීවිතයත්, අපරාධ ලෝකයත් අතර දෝලනය වන චරිතයකි. පළමු කලාපය ආරම්භ වන්නේ ඔහු මුහුණ දෙන අභ්‍යන්තර සහ බාහිර ගැටුම් රැසක් සමඟිනි. අධික මානසික පීඩනය නිසා ඇති වන හදිසි ක්ලාන්ත සහ භීතිකා තත්ත්වයන් (Panic Attacks) හේතුවෙන්, ටෝනිට සිදුවන්නේ රහසින් මනෝ වෛද්‍ය ජෙනිෆර් මෙල්ෆි (Dr. Jennifer Melfi) හමුවී ප්‍රතිකාර ලබා ගැනීමටය. මාෆියා සංස්කෘතිය තුළ මෙවැනි ප්‍රතිකාර ලබා ගැනීම බරපතළ දුර්වලතාවයක් ලෙස සලකන බැවින්, මෙම වෛද්‍ය හමුවීම් සඟවා තබා ගැනීමට ඔහුට දැඩි වෙහෙසක් දැරීමට සිදු වේ.

මේ අතර, කල්ලියේ ප්‍රධානියා වූ ජැකී ඇප්‍රිල්ගේ අභාවයත් සමඟ නායකත්වය සඳහා ටෝනි සහ ඔහුගේ බාප්පා වන ජූනියර් (Uncle Junior) අතර දැඩි බල අරගලයක් නිර්මාණය වේ. අනවශ්‍ය ගැටුම් මඟහරවා ගැනීම සඳහා ටෝනි ඉතා සූක්ෂ්ම ලෙස ජූනියර්ව නාමිකව පවුලේ ප්‍රධානියා (Official Boss) ලෙස පත් කිරීමට කටයුතු කරයි. කෙසේ වෙතත්, සැබෑ බලය සහ ප්‍රධාන තීරණ ගැනීම් සිදු කරන්නේ ටෝනි සහ ඔහුගේ සමීපතම කණ්ඩායම විසින් වන අතර, මෙය ජූනියර්ගේ නොසතුටට හේතු වේ.

ටෝනිගේ පෞද්ගලික ජීවිතය ද මෙවැනිම ගැටලුවලින් පිරී පවතී. ඔහුගේ අහංකාර සහ මානසිකව පීඩාකාරී මව වන ලිවියා (Livia) ව බලා ගැනීමට නොහැකි තැන, ටෝනි ඇයව විශ්‍රාමික නිවාසයක නතර කිරීමට තීරණය කරයි. තමන්ව මෙවැනි තැනකට යැවීම පිළිබඳව දැඩි වෛරයකින් පසුවන ලිවියා, ටෝනි කෙරෙහි පළිගැනීමේ චේතනාවෙන් පසුවේ.

ටෝනි රහසින් මනෝ වෛද්‍යවරයෙකු හමුවන බවත්, තමන්ව රවටා පවුලේ බලය හසුරුවන බවත් ජූනියර් මාමා දැනගන්නේ මෙම වටපිටාව තුළය. මේ සඳහා ලිවියා ද වක්‍රව ජූනියර්ව පොළඹවන අතර, එහි ප්‍රතිඵලයක් ලෙස ඔවුන් දෙදෙනා එක්ව ටෝනිව ඝාතනය කිරීමට සැලසුම් කරයි. කෙසේ වෙතත්, එම මාරාන්තික වෙඩි තැබීමේ උත්සාහයෙන් ඉතා ආශ්චර්යමත් ලෙස ටෝනි බේරීමට සමත් වේ. පසුව, FBI ආයතනය විසින් පටිගත කරන ලද රහසිගත හඬපට මාර්ගයෙන් තමන්ව ඝාතනය කිරීමට සැලසුම් කළේ තමන්ගේම මව සහ බාප්පා බව ටෝනි වටහා ගනී.

පළමු කලාපය අවසන් වන්නේ මෙම පාවාදීම් පිළිබඳ ඇත්ත හෙළිවීමත් සමඟය. ටෝනිගේ ප්‍රතිප්‍රහාර හමුවේ ජූනියර් මාමාගේ සමීපතමයින් විනාශ වන අතර, අවසානයේදී ජූනියර් FBI අත්අඩංගුවට පත් වේ. තම පුතාගේ කෝපයෙන් බේරීම සඳහා ලිවියා හදිසි ආඝාත තත්ත්වයක් රඟපාමින් රෝහල්ගත වේ. පළමු කලාපය නිමාවට පත්වන විට ටෝනි පවුලේ අවිවාදිත සැබෑ නායකයා බවට පත් වුවද, සමීපතමයන්ගෙන් ලැබුණු ද්‍රෝහීකම් නිසා ඔහුගේ සිත තුළ ගැඹුරු කැලඹීමක් ඉතිරි වේ. දෙවන කලාපය ආරම්භ වන්නේ මෙම සිදුවීම් මාලාවෙන් පසුව ඇති වන නව අභියෝග රැසක් සමඟිනි.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram download: 720p සහ 1080p උසස් තත්ත්වයේ WEBRip වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2000-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/u7dlARwP2zsqHaMNL5HtHhaEPea.jpg', '2026-08-04 13:03:55.568064+00', '2026-08-04 13:03:55.568064+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('eef9047f-c1c3-4980-a62a-d7cb0510f8fa', '40dee2dc-1a40-4b47-acaf-4308fe7654ba', 3, 'Episode 3', '🔫 The Sopranos Season 2 - සිංහල උපසිරැසි 🎬

Continue the legendary journey with The Sopranos Season 2, one of the most intense and captivating chapters in television history. As Tony Soprano steps up to lead the DiMeo crime family, he faces growing paranoia, betrayal from close associates, and unresolved psychological turmoil that threatens his mafia empire and family life.

Download all episodes of The Sopranos Season 2 in high-definition quality. Choose from 720p, 1080p WEB-DL video files, all paired with accurate Sinhala subtitles. Access your files instantly via high-speed direct download links or convenient Telegram links.

නිව් ජර්සි නගරය කේන්ද්‍ර කරගනිමින් ක්‍රියාත්මක වන ප්‍රබල මාෆියා කල්ලියක ප්‍රධානියෙකු වන ටෝනි සෝප්‍රානෝ (Tony Soprano) සාමාන්‍ය පවුල් ජීවිතයත්, අපරාධ ලෝකයත් අතර දෝලනය වන චරිතයකි. පළමු කලාපය ආරම්භ වන්නේ ඔහු මුහුණ දෙන අභ්‍යන්තර සහ බාහිර ගැටුම් රැසක් සමඟිනි. අධික මානසික පීඩනය නිසා ඇති වන හදිසි ක්ලාන්ත සහ භීතිකා තත්ත්වයන් (Panic Attacks) හේතුවෙන්, ටෝනිට සිදුවන්නේ රහසින් මනෝ වෛද්‍ය ජෙනිෆර් මෙල්ෆි (Dr. Jennifer Melfi) හමුවී ප්‍රතිකාර ලබා ගැනීමටය. මාෆියා සංස්කෘතිය තුළ මෙවැනි ප්‍රතිකාර ලබා ගැනීම බරපතළ දුර්වලතාවයක් ලෙස සලකන බැවින්, මෙම වෛද්‍ය හමුවීම් සඟවා තබා ගැනීමට ඔහුට දැඩි වෙහෙසක් දැරීමට සිදු වේ.

මේ අතර, කල්ලියේ ප්‍රධානියා වූ ජැකී ඇප්‍රිල්ගේ අභාවයත් සමඟ නායකත්වය සඳහා ටෝනි සහ ඔහුගේ බාප්පා වන ජූනියර් (Uncle Junior) අතර දැඩි බල අරගලයක් නිර්මාණය වේ. අනවශ්‍ය ගැටුම් මඟහරවා ගැනීම සඳහා ටෝනි ඉතා සූක්ෂ්ම ලෙස ජූනියර්ව නාමිකව පවුලේ ප්‍රධානියා (Official Boss) ලෙස පත් කිරීමට කටයුතු කරයි. කෙසේ වෙතත්, සැබෑ බලය සහ ප්‍රධාන තීරණ ගැනීම් සිදු කරන්නේ ටෝනි සහ ඔහුගේ සමීපතම කණ්ඩායම විසින් වන අතර, මෙය ජූනියර්ගේ නොසතුටට හේතු වේ.

ටෝනිගේ පෞද්ගලික ජීවිතය ද මෙවැනිම ගැටලුවලින් පිරී පවතී. ඔහුගේ අහංකාර සහ මානසිකව පීඩාකාරී මව වන ලිවියා (Livia) ව බලා ගැනීමට නොහැකි තැන, ටෝනි ඇයව විශ්‍රාමික නිවාසයක නතර කිරීමට තීරණය කරයි. තමන්ව මෙවැනි තැනකට යැවීම පිළිබඳව දැඩි වෛරයකින් පසුවන ලිවියා, ටෝනි කෙරෙහි පළිගැනීමේ චේතනාවෙන් පසුවේ.

ටෝනි රහසින් මනෝ වෛද්‍යවරයෙකු හමුවන බවත්, තමන්ව රවටා පවුලේ බලය හසුරුවන බවත් ජූනියර් මාමා දැනගන්නේ මෙම වටපිටාව තුළය. මේ සඳහා ලිවියා ද වක්‍රව ජූනියර්ව පොළඹවන අතර, එහි ප්‍රතිඵලයක් ලෙස ඔවුන් දෙදෙනා එක්ව ටෝනිව ඝාතනය කිරීමට සැලසුම් කරයි. කෙසේ වෙතත්, එම මාරාන්තික වෙඩි තැබීමේ උත්සාහයෙන් ඉතා ආශ්චර්යමත් ලෙස ටෝනි බේරීමට සමත් වේ. පසුව, FBI ආයතනය විසින් පටිගත කරන ලද රහසිගත හඬපට මාර්ගයෙන් තමන්ව ඝාතනය කිරීමට සැලසුම් කළේ තමන්ගේම මව සහ බාප්පා බව ටෝනි වටහා ගනී.

පළමු කලාපය අවසන් වන්නේ මෙම පාවාදීම් පිළිබඳ ඇත්ත හෙළිවීමත් සමඟය. ටෝනිගේ ප්‍රතිප්‍රහාර හමුවේ ජූනියර් මාමාගේ සමීපතමයින් විනාශ වන අතර, අවසානයේදී ජූනියර් FBI අත්අඩංගුවට පත් වේ. තම පුතාගේ කෝපයෙන් බේරීම සඳහා ලිවියා හදිසි ආඝාත තත්ත්වයක් රඟපාමින් රෝහල්ගත වේ. පළමු කලාපය නිමාවට පත්වන විට ටෝනි පවුලේ අවිවාදිත සැබෑ නායකයා බවට පත් වුවද, සමීපතමයන්ගෙන් ලැබුණු ද්‍රෝහීකම් නිසා ඔහුගේ සිත තුළ ගැඹුරු කැලඹීමක් ඉතිරි වේ. දෙවන කලාපය ආරම්භ වන්නේ මෙම සිදුවීම් මාලාවෙන් පසුව ඇති වන නව අභියෝග රැසක් සමඟිනි.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram download: 720p සහ 1080p උසස් තත්ත්වයේ WEBRip වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2000-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/u7dlARwP2zsqHaMNL5HtHhaEPea.jpg', '2026-08-04 13:03:55.568064+00', '2026-08-04 13:03:55.568064+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('79b18af7-251b-49d7-a5d3-b6f01110179c', '40dee2dc-1a40-4b47-acaf-4308fe7654ba', 4, 'Episode 4', '🔫 The Sopranos Season 2 - සිංහල උපසිරැසි 🎬

Continue the legendary journey with The Sopranos Season 2, one of the most intense and captivating chapters in television history. As Tony Soprano steps up to lead the DiMeo crime family, he faces growing paranoia, betrayal from close associates, and unresolved psychological turmoil that threatens his mafia empire and family life.

Download all episodes of The Sopranos Season 2 in high-definition quality. Choose from 720p, 1080p WEB-DL video files, all paired with accurate Sinhala subtitles. Access your files instantly via high-speed direct download links or convenient Telegram links.

නිව් ජර්සි නගරය කේන්ද්‍ර කරගනිමින් ක්‍රියාත්මක වන ප්‍රබල මාෆියා කල්ලියක ප්‍රධානියෙකු වන ටෝනි සෝප්‍රානෝ (Tony Soprano) සාමාන්‍ය පවුල් ජීවිතයත්, අපරාධ ලෝකයත් අතර දෝලනය වන චරිතයකි. පළමු කලාපය ආරම්භ වන්නේ ඔහු මුහුණ දෙන අභ්‍යන්තර සහ බාහිර ගැටුම් රැසක් සමඟිනි. අධික මානසික පීඩනය නිසා ඇති වන හදිසි ක්ලාන්ත සහ භීතිකා තත්ත්වයන් (Panic Attacks) හේතුවෙන්, ටෝනිට සිදුවන්නේ රහසින් මනෝ වෛද්‍ය ජෙනිෆර් මෙල්ෆි (Dr. Jennifer Melfi) හමුවී ප්‍රතිකාර ලබා ගැනීමටය. මාෆියා සංස්කෘතිය තුළ මෙවැනි ප්‍රතිකාර ලබා ගැනීම බරපතළ දුර්වලතාවයක් ලෙස සලකන බැවින්, මෙම වෛද්‍ය හමුවීම් සඟවා තබා ගැනීමට ඔහුට දැඩි වෙහෙසක් දැරීමට සිදු වේ.

මේ අතර, කල්ලියේ ප්‍රධානියා වූ ජැකී ඇප්‍රිල්ගේ අභාවයත් සමඟ නායකත්වය සඳහා ටෝනි සහ ඔහුගේ බාප්පා වන ජූනියර් (Uncle Junior) අතර දැඩි බල අරගලයක් නිර්මාණය වේ. අනවශ්‍ය ගැටුම් මඟහරවා ගැනීම සඳහා ටෝනි ඉතා සූක්ෂ්ම ලෙස ජූනියර්ව නාමිකව පවුලේ ප්‍රධානියා (Official Boss) ලෙස පත් කිරීමට කටයුතු කරයි. කෙසේ වෙතත්, සැබෑ බලය සහ ප්‍රධාන තීරණ ගැනීම් සිදු කරන්නේ ටෝනි සහ ඔහුගේ සමීපතම කණ්ඩායම විසින් වන අතර, මෙය ජූනියර්ගේ නොසතුටට හේතු වේ.

ටෝනිගේ පෞද්ගලික ජීවිතය ද මෙවැනිම ගැටලුවලින් පිරී පවතී. ඔහුගේ අහංකාර සහ මානසිකව පීඩාකාරී මව වන ලිවියා (Livia) ව බලා ගැනීමට නොහැකි තැන, ටෝනි ඇයව විශ්‍රාමික නිවාසයක නතර කිරීමට තීරණය කරයි. තමන්ව මෙවැනි තැනකට යැවීම පිළිබඳව දැඩි වෛරයකින් පසුවන ලිවියා, ටෝනි කෙරෙහි පළිගැනීමේ චේතනාවෙන් පසුවේ.

ටෝනි රහසින් මනෝ වෛද්‍යවරයෙකු හමුවන බවත්, තමන්ව රවටා පවුලේ බලය හසුරුවන බවත් ජූනියර් මාමා දැනගන්නේ මෙම වටපිටාව තුළය. මේ සඳහා ලිවියා ද වක්‍රව ජූනියර්ව පොළඹවන අතර, එහි ප්‍රතිඵලයක් ලෙස ඔවුන් දෙදෙනා එක්ව ටෝනිව ඝාතනය කිරීමට සැලසුම් කරයි. කෙසේ වෙතත්, එම මාරාන්තික වෙඩි තැබීමේ උත්සාහයෙන් ඉතා ආශ්චර්යමත් ලෙස ටෝනි බේරීමට සමත් වේ. පසුව, FBI ආයතනය විසින් පටිගත කරන ලද රහසිගත හඬපට මාර්ගයෙන් තමන්ව ඝාතනය කිරීමට සැලසුම් කළේ තමන්ගේම මව සහ බාප්පා බව ටෝනි වටහා ගනී.

පළමු කලාපය අවසන් වන්නේ මෙම පාවාදීම් පිළිබඳ ඇත්ත හෙළිවීමත් සමඟය. ටෝනිගේ ප්‍රතිප්‍රහාර හමුවේ ජූනියර් මාමාගේ සමීපතමයින් විනාශ වන අතර, අවසානයේදී ජූනියර් FBI අත්අඩංගුවට පත් වේ. තම පුතාගේ කෝපයෙන් බේරීම සඳහා ලිවියා හදිසි ආඝාත තත්ත්වයක් රඟපාමින් රෝහල්ගත වේ. පළමු කලාපය නිමාවට පත්වන විට ටෝනි පවුලේ අවිවාදිත සැබෑ නායකයා බවට පත් වුවද, සමීපතමයන්ගෙන් ලැබුණු ද්‍රෝහීකම් නිසා ඔහුගේ සිත තුළ ගැඹුරු කැලඹීමක් ඉතිරි වේ. දෙවන කලාපය ආරම්භ වන්නේ මෙම සිදුවීම් මාලාවෙන් පසුව ඇති වන නව අභියෝග රැසක් සමඟිනි.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram download: 720p සහ 1080p උසස් තත්ත්වයේ WEBRip වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2000-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/u7dlARwP2zsqHaMNL5HtHhaEPea.jpg', '2026-08-04 13:03:55.568064+00', '2026-08-04 13:03:55.568064+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('f7aff376-6900-44c6-a6b2-d3bac58ad610', '40dee2dc-1a40-4b47-acaf-4308fe7654ba', 5, 'Episode 5', '🔫 The Sopranos Season 2 - සිංහල උපසිරැසි 🎬

Continue the legendary journey with The Sopranos Season 2, one of the most intense and captivating chapters in television history. As Tony Soprano steps up to lead the DiMeo crime family, he faces growing paranoia, betrayal from close associates, and unresolved psychological turmoil that threatens his mafia empire and family life.

Download all episodes of The Sopranos Season 2 in high-definition quality. Choose from 720p, 1080p WEB-DL video files, all paired with accurate Sinhala subtitles. Access your files instantly via high-speed direct download links or convenient Telegram links.

නිව් ජර්සි නගරය කේන්ද්‍ර කරගනිමින් ක්‍රියාත්මක වන ප්‍රබල මාෆියා කල්ලියක ප්‍රධානියෙකු වන ටෝනි සෝප්‍රානෝ (Tony Soprano) සාමාන්‍ය පවුල් ජීවිතයත්, අපරාධ ලෝකයත් අතර දෝලනය වන චරිතයකි. පළමු කලාපය ආරම්භ වන්නේ ඔහු මුහුණ දෙන අභ්‍යන්තර සහ බාහිර ගැටුම් රැසක් සමඟිනි. අධික මානසික පීඩනය නිසා ඇති වන හදිසි ක්ලාන්ත සහ භීතිකා තත්ත්වයන් (Panic Attacks) හේතුවෙන්, ටෝනිට සිදුවන්නේ රහසින් මනෝ වෛද්‍ය ජෙනිෆර් මෙල්ෆි (Dr. Jennifer Melfi) හමුවී ප්‍රතිකාර ලබා ගැනීමටය. මාෆියා සංස්කෘතිය තුළ මෙවැනි ප්‍රතිකාර ලබා ගැනීම බරපතළ දුර්වලතාවයක් ලෙස සලකන බැවින්, මෙම වෛද්‍ය හමුවීම් සඟවා තබා ගැනීමට ඔහුට දැඩි වෙහෙසක් දැරීමට සිදු වේ.

මේ අතර, කල්ලියේ ප්‍රධානියා වූ ජැකී ඇප්‍රිල්ගේ අභාවයත් සමඟ නායකත්වය සඳහා ටෝනි සහ ඔහුගේ බාප්පා වන ජූනියර් (Uncle Junior) අතර දැඩි බල අරගලයක් නිර්මාණය වේ. අනවශ්‍ය ගැටුම් මඟහරවා ගැනීම සඳහා ටෝනි ඉතා සූක්ෂ්ම ලෙස ජූනියර්ව නාමිකව පවුලේ ප්‍රධානියා (Official Boss) ලෙස පත් කිරීමට කටයුතු කරයි. කෙසේ වෙතත්, සැබෑ බලය සහ ප්‍රධාන තීරණ ගැනීම් සිදු කරන්නේ ටෝනි සහ ඔහුගේ සමීපතම කණ්ඩායම විසින් වන අතර, මෙය ජූනියර්ගේ නොසතුටට හේතු වේ.

ටෝනිගේ පෞද්ගලික ජීවිතය ද මෙවැනිම ගැටලුවලින් පිරී පවතී. ඔහුගේ අහංකාර සහ මානසිකව පීඩාකාරී මව වන ලිවියා (Livia) ව බලා ගැනීමට නොහැකි තැන, ටෝනි ඇයව විශ්‍රාමික නිවාසයක නතර කිරීමට තීරණය කරයි. තමන්ව මෙවැනි තැනකට යැවීම පිළිබඳව දැඩි වෛරයකින් පසුවන ලිවියා, ටෝනි කෙරෙහි පළිගැනීමේ චේතනාවෙන් පසුවේ.

ටෝනි රහසින් මනෝ වෛද්‍යවරයෙකු හමුවන බවත්, තමන්ව රවටා පවුලේ බලය හසුරුවන බවත් ජූනියර් මාමා දැනගන්නේ මෙම වටපිටාව තුළය. මේ සඳහා ලිවියා ද වක්‍රව ජූනියර්ව පොළඹවන අතර, එහි ප්‍රතිඵලයක් ලෙස ඔවුන් දෙදෙනා එක්ව ටෝනිව ඝාතනය කිරීමට සැලසුම් කරයි. කෙසේ වෙතත්, එම මාරාන්තික වෙඩි තැබීමේ උත්සාහයෙන් ඉතා ආශ්චර්යමත් ලෙස ටෝනි බේරීමට සමත් වේ. පසුව, FBI ආයතනය විසින් පටිගත කරන ලද රහසිගත හඬපට මාර්ගයෙන් තමන්ව ඝාතනය කිරීමට සැලසුම් කළේ තමන්ගේම මව සහ බාප්පා බව ටෝනි වටහා ගනී.

පළමු කලාපය අවසන් වන්නේ මෙම පාවාදීම් පිළිබඳ ඇත්ත හෙළිවීමත් සමඟය. ටෝනිගේ ප්‍රතිප්‍රහාර හමුවේ ජූනියර් මාමාගේ සමීපතමයින් විනාශ වන අතර, අවසානයේදී ජූනියර් FBI අත්අඩංගුවට පත් වේ. තම පුතාගේ කෝපයෙන් බේරීම සඳහා ලිවියා හදිසි ආඝාත තත්ත්වයක් රඟපාමින් රෝහල්ගත වේ. පළමු කලාපය නිමාවට පත්වන විට ටෝනි පවුලේ අවිවාදිත සැබෑ නායකයා බවට පත් වුවද, සමීපතමයන්ගෙන් ලැබුණු ද්‍රෝහීකම් නිසා ඔහුගේ සිත තුළ ගැඹුරු කැලඹීමක් ඉතිරි වේ. දෙවන කලාපය ආරම්භ වන්නේ මෙම සිදුවීම් මාලාවෙන් පසුව ඇති වන නව අභියෝග රැසක් සමඟිනි.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram download: 720p සහ 1080p උසස් තත්ත්වයේ WEBRip වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2000-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/u7dlARwP2zsqHaMNL5HtHhaEPea.jpg', '2026-08-04 13:03:55.568064+00', '2026-08-04 13:03:55.568064+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('5dc47798-fc74-4c44-a337-4fae7c9ef7e2', '40dee2dc-1a40-4b47-acaf-4308fe7654ba', 6, 'Episode 6', '🔫 The Sopranos Season 2 - සිංහල උපසිරැසි 🎬

Continue the legendary journey with The Sopranos Season 2, one of the most intense and captivating chapters in television history. As Tony Soprano steps up to lead the DiMeo crime family, he faces growing paranoia, betrayal from close associates, and unresolved psychological turmoil that threatens his mafia empire and family life.

Download all episodes of The Sopranos Season 2 in high-definition quality. Choose from 720p, 1080p WEB-DL video files, all paired with accurate Sinhala subtitles. Access your files instantly via high-speed direct download links or convenient Telegram links.

නිව් ජර්සි නගරය කේන්ද්‍ර කරගනිමින් ක්‍රියාත්මක වන ප්‍රබල මාෆියා කල්ලියක ප්‍රධානියෙකු වන ටෝනි සෝප්‍රානෝ (Tony Soprano) සාමාන්‍ය පවුල් ජීවිතයත්, අපරාධ ලෝකයත් අතර දෝලනය වන චරිතයකි. පළමු කලාපය ආරම්භ වන්නේ ඔහු මුහුණ දෙන අභ්‍යන්තර සහ බාහිර ගැටුම් රැසක් සමඟිනි. අධික මානසික පීඩනය නිසා ඇති වන හදිසි ක්ලාන්ත සහ භීතිකා තත්ත්වයන් (Panic Attacks) හේතුවෙන්, ටෝනිට සිදුවන්නේ රහසින් මනෝ වෛද්‍ය ජෙනිෆර් මෙල්ෆි (Dr. Jennifer Melfi) හමුවී ප්‍රතිකාර ලබා ගැනීමටය. මාෆියා සංස්කෘතිය තුළ මෙවැනි ප්‍රතිකාර ලබා ගැනීම බරපතළ දුර්වලතාවයක් ලෙස සලකන බැවින්, මෙම වෛද්‍ය හමුවීම් සඟවා තබා ගැනීමට ඔහුට දැඩි වෙහෙසක් දැරීමට සිදු වේ.

මේ අතර, කල්ලියේ ප්‍රධානියා වූ ජැකී ඇප්‍රිල්ගේ අභාවයත් සමඟ නායකත්වය සඳහා ටෝනි සහ ඔහුගේ බාප්පා වන ජූනියර් (Uncle Junior) අතර දැඩි බල අරගලයක් නිර්මාණය වේ. අනවශ්‍ය ගැටුම් මඟහරවා ගැනීම සඳහා ටෝනි ඉතා සූක්ෂ්ම ලෙස ජූනියර්ව නාමිකව පවුලේ ප්‍රධානියා (Official Boss) ලෙස පත් කිරීමට කටයුතු කරයි. කෙසේ වෙතත්, සැබෑ බලය සහ ප්‍රධාන තීරණ ගැනීම් සිදු කරන්නේ ටෝනි සහ ඔහුගේ සමීපතම කණ්ඩායම විසින් වන අතර, මෙය ජූනියර්ගේ නොසතුටට හේතු වේ.

ටෝනිගේ පෞද්ගලික ජීවිතය ද මෙවැනිම ගැටලුවලින් පිරී පවතී. ඔහුගේ අහංකාර සහ මානසිකව පීඩාකාරී මව වන ලිවියා (Livia) ව බලා ගැනීමට නොහැකි තැන, ටෝනි ඇයව විශ්‍රාමික නිවාසයක නතර කිරීමට තීරණය කරයි. තමන්ව මෙවැනි තැනකට යැවීම පිළිබඳව දැඩි වෛරයකින් පසුවන ලිවියා, ටෝනි කෙරෙහි පළිගැනීමේ චේතනාවෙන් පසුවේ.

ටෝනි රහසින් මනෝ වෛද්‍යවරයෙකු හමුවන බවත්, තමන්ව රවටා පවුලේ බලය හසුරුවන බවත් ජූනියර් මාමා දැනගන්නේ මෙම වටපිටාව තුළය. මේ සඳහා ලිවියා ද වක්‍රව ජූනියර්ව පොළඹවන අතර, එහි ප්‍රතිඵලයක් ලෙස ඔවුන් දෙදෙනා එක්ව ටෝනිව ඝාතනය කිරීමට සැලසුම් කරයි. කෙසේ වෙතත්, එම මාරාන්තික වෙඩි තැබීමේ උත්සාහයෙන් ඉතා ආශ්චර්යමත් ලෙස ටෝනි බේරීමට සමත් වේ. පසුව, FBI ආයතනය විසින් පටිගත කරන ලද රහසිගත හඬපට මාර්ගයෙන් තමන්ව ඝාතනය කිරීමට සැලසුම් කළේ තමන්ගේම මව සහ බාප්පා බව ටෝනි වටහා ගනී.

පළමු කලාපය අවසන් වන්නේ මෙම පාවාදීම් පිළිබඳ ඇත්ත හෙළිවීමත් සමඟය. ටෝනිගේ ප්‍රතිප්‍රහාර හමුවේ ජූනියර් මාමාගේ සමීපතමයින් විනාශ වන අතර, අවසානයේදී ජූනියර් FBI අත්අඩංගුවට පත් වේ. තම පුතාගේ කෝපයෙන් බේරීම සඳහා ලිවියා හදිසි ආඝාත තත්ත්වයක් රඟපාමින් රෝහල්ගත වේ. පළමු කලාපය නිමාවට පත්වන විට ටෝනි පවුලේ අවිවාදිත සැබෑ නායකයා බවට පත් වුවද, සමීපතමයන්ගෙන් ලැබුණු ද්‍රෝහීකම් නිසා ඔහුගේ සිත තුළ ගැඹුරු කැලඹීමක් ඉතිරි වේ. දෙවන කලාපය ආරම්භ වන්නේ මෙම සිදුවීම් මාලාවෙන් පසුව ඇති වන නව අභියෝග රැසක් සමඟිනි.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram download: 720p සහ 1080p උසස් තත්ත්වයේ WEBRip වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2000-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/u7dlARwP2zsqHaMNL5HtHhaEPea.jpg', '2026-08-04 13:03:55.568064+00', '2026-08-04 13:03:55.568064+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('2a8682e5-292d-47ae-ab77-2de7656b6fcb', '40dee2dc-1a40-4b47-acaf-4308fe7654ba', 7, 'Episode 7', '🔫 The Sopranos Season 2 - සිංහල උපසිරැසි 🎬

Continue the legendary journey with The Sopranos Season 2, one of the most intense and captivating chapters in television history. As Tony Soprano steps up to lead the DiMeo crime family, he faces growing paranoia, betrayal from close associates, and unresolved psychological turmoil that threatens his mafia empire and family life.

Download all episodes of The Sopranos Season 2 in high-definition quality. Choose from 720p, 1080p WEB-DL video files, all paired with accurate Sinhala subtitles. Access your files instantly via high-speed direct download links or convenient Telegram links.

නිව් ජර්සි නගරය කේන්ද්‍ර කරගනිමින් ක්‍රියාත්මක වන ප්‍රබල මාෆියා කල්ලියක ප්‍රධානියෙකු වන ටෝනි සෝප්‍රානෝ (Tony Soprano) සාමාන්‍ය පවුල් ජීවිතයත්, අපරාධ ලෝකයත් අතර දෝලනය වන චරිතයකි. පළමු කලාපය ආරම්භ වන්නේ ඔහු මුහුණ දෙන අභ්‍යන්තර සහ බාහිර ගැටුම් රැසක් සමඟිනි. අධික මානසික පීඩනය නිසා ඇති වන හදිසි ක්ලාන්ත සහ භීතිකා තත්ත්වයන් (Panic Attacks) හේතුවෙන්, ටෝනිට සිදුවන්නේ රහසින් මනෝ වෛද්‍ය ජෙනිෆර් මෙල්ෆි (Dr. Jennifer Melfi) හමුවී ප්‍රතිකාර ලබා ගැනීමටය. මාෆියා සංස්කෘතිය තුළ මෙවැනි ප්‍රතිකාර ලබා ගැනීම බරපතළ දුර්වලතාවයක් ලෙස සලකන බැවින්, මෙම වෛද්‍ය හමුවීම් සඟවා තබා ගැනීමට ඔහුට දැඩි වෙහෙසක් දැරීමට සිදු වේ.

මේ අතර, කල්ලියේ ප්‍රධානියා වූ ජැකී ඇප්‍රිල්ගේ අභාවයත් සමඟ නායකත්වය සඳහා ටෝනි සහ ඔහුගේ බාප්පා වන ජූනියර් (Uncle Junior) අතර දැඩි බල අරගලයක් නිර්මාණය වේ. අනවශ්‍ය ගැටුම් මඟහරවා ගැනීම සඳහා ටෝනි ඉතා සූක්ෂ්ම ලෙස ජූනියර්ව නාමිකව පවුලේ ප්‍රධානියා (Official Boss) ලෙස පත් කිරීමට කටයුතු කරයි. කෙසේ වෙතත්, සැබෑ බලය සහ ප්‍රධාන තීරණ ගැනීම් සිදු කරන්නේ ටෝනි සහ ඔහුගේ සමීපතම කණ්ඩායම විසින් වන අතර, මෙය ජූනියර්ගේ නොසතුටට හේතු වේ.

ටෝනිගේ පෞද්ගලික ජීවිතය ද මෙවැනිම ගැටලුවලින් පිරී පවතී. ඔහුගේ අහංකාර සහ මානසිකව පීඩාකාරී මව වන ලිවියා (Livia) ව බලා ගැනීමට නොහැකි තැන, ටෝනි ඇයව විශ්‍රාමික නිවාසයක නතර කිරීමට තීරණය කරයි. තමන්ව මෙවැනි තැනකට යැවීම පිළිබඳව දැඩි වෛරයකින් පසුවන ලිවියා, ටෝනි කෙරෙහි පළිගැනීමේ චේතනාවෙන් පසුවේ.

ටෝනි රහසින් මනෝ වෛද්‍යවරයෙකු හමුවන බවත්, තමන්ව රවටා පවුලේ බලය හසුරුවන බවත් ජූනියර් මාමා දැනගන්නේ මෙම වටපිටාව තුළය. මේ සඳහා ලිවියා ද වක්‍රව ජූනියර්ව පොළඹවන අතර, එහි ප්‍රතිඵලයක් ලෙස ඔවුන් දෙදෙනා එක්ව ටෝනිව ඝාතනය කිරීමට සැලසුම් කරයි. කෙසේ වෙතත්, එම මාරාන්තික වෙඩි තැබීමේ උත්සාහයෙන් ඉතා ආශ්චර්යමත් ලෙස ටෝනි බේරීමට සමත් වේ. පසුව, FBI ආයතනය විසින් පටිගත කරන ලද රහසිගත හඬපට මාර්ගයෙන් තමන්ව ඝාතනය කිරීමට සැලසුම් කළේ තමන්ගේම මව සහ බාප්පා බව ටෝනි වටහා ගනී.

පළමු කලාපය අවසන් වන්නේ මෙම පාවාදීම් පිළිබඳ ඇත්ත හෙළිවීමත් සමඟය. ටෝනිගේ ප්‍රතිප්‍රහාර හමුවේ ජූනියර් මාමාගේ සමීපතමයින් විනාශ වන අතර, අවසානයේදී ජූනියර් FBI අත්අඩංගුවට පත් වේ. තම පුතාගේ කෝපයෙන් බේරීම සඳහා ලිවියා හදිසි ආඝාත තත්ත්වයක් රඟපාමින් රෝහල්ගත වේ. පළමු කලාපය නිමාවට පත්වන විට ටෝනි පවුලේ අවිවාදිත සැබෑ නායකයා බවට පත් වුවද, සමීපතමයන්ගෙන් ලැබුණු ද්‍රෝහීකම් නිසා ඔහුගේ සිත තුළ ගැඹුරු කැලඹීමක් ඉතිරි වේ. දෙවන කලාපය ආරම්භ වන්නේ මෙම සිදුවීම් මාලාවෙන් පසුව ඇති වන නව අභියෝග රැසක් සමඟිනි.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram download: 720p සහ 1080p උසස් තත්ත්වයේ WEBRip වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2000-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/u7dlARwP2zsqHaMNL5HtHhaEPea.jpg', '2026-08-04 13:03:55.568064+00', '2026-08-04 13:03:55.568064+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('9d64d3f6-bb77-4d39-a811-9c02dc4c973c', '5c4af11e-21f5-4ee9-a8a3-30fc4cf84989', 6, 'Episode 6', '🦇 Batman: Caped Crusader - සිංහල උපසිරැසි 🎬

Batman: Caped Crusader brings a dark, noir-inspired take on the Dark Knight''s early days in Gotham City. Produced by Bruce Timm, Matt Reeves, and J.J. Abrams, this animated series is a must-watch for DC fans. Download high-quality 720p WEB-DL video files with Sinhala subtitles directly or via Telegram. Experience the ultimate psychological and action-packed detective story.

Batman: Caped Crusader කියන්නේ DC රසිකයින්ට ලැබුණු අලුත්ම සහ වෙනස්ම විදිහේ ඇනිමේටඩ් කතා මාලාවක්. සුප්‍රසිද්ධ Batman: The Animated Series එක හදපු Bruce Timm වගේම The Batman චිත්‍රපටය අධ්‍යක්ෂණය කරපු Matt Reeves ගේ සහ J.J. Abrams ගේ එකතුවෙන් තමයි මේක නිර්මාණය වෙලා තියෙන්නේ. ඒ නිසාම මේකට ලොකු ප්‍රේක්ෂක ආකර්ෂණයක් ලැබිලා තියෙනවා.

කතාව යන්නේ 1940 දශකයේ අඳුරු Gotham නගරයේ. ගොඩක් දියුණු තාක්ෂණයන් නැති, දූෂණය සහ අපරාධ වලින් පිරිච්ච නගරයක Bruce Wayne තමන්ගේ මුල්ම කාලයේ Batman විදිහට අපරාධකරුවන්ට විරුද්ධව සටන් කරන හැටි තමයි මේකෙන් පෙන්නන්නේ. මේ කතාවේ ඉන්න Batman ටිකක් රළුයි වගේම, අපි දන්න Catwoman, Harley Quinn, Two-Face සහ Penguin වගේ අනිත් චරිතත් මේ කතාවේදී සම්පූර්ණයෙන්ම අලුත් වගේම වෙනස්ම විදිහකට තමයි නිර්මාණය කරලා තියෙන්නේ.

DC කොමික් පොත් වල තිබුණු මුල්ම කාලයේ අඳුරු Noir ගතියට සහ රහස් පරීක්ෂක (Detective) කතා වලට කැමති අයට කිසිම කම්මැලිකමක් නැතුව බලන්න පුළුවන් සුපිරිම කතා මාලාවක් තමයි මේක.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:
📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් Telegram චැනලය හරහා ලබාගත හැක.', '2024-01-01', 50, 7.2, 'https://image.tmdb.org/t/p/original/tJ7zq4VtvJqUyaRsLeNjpEFDXzk.jpg', '2026-08-05 06:40:15.262255+00', '2026-08-05 06:40:15.262255+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('5335fd6c-f2d4-4023-ae55-c46ba31bbbce', '5c4af11e-21f5-4ee9-a8a3-30fc4cf84989', 7, 'Episode 7', '🦇 Batman: Caped Crusader - සිංහල උපසිරැසි 🎬

Batman: Caped Crusader brings a dark, noir-inspired take on the Dark Knight''s early days in Gotham City. Produced by Bruce Timm, Matt Reeves, and J.J. Abrams, this animated series is a must-watch for DC fans. Download high-quality 720p WEB-DL video files with Sinhala subtitles directly or via Telegram. Experience the ultimate psychological and action-packed detective story.

Batman: Caped Crusader කියන්නේ DC රසිකයින්ට ලැබුණු අලුත්ම සහ වෙනස්ම විදිහේ ඇනිමේටඩ් කතා මාලාවක්. සුප්‍රසිද්ධ Batman: The Animated Series එක හදපු Bruce Timm වගේම The Batman චිත්‍රපටය අධ්‍යක්ෂණය කරපු Matt Reeves ගේ සහ J.J. Abrams ගේ එකතුවෙන් තමයි මේක නිර්මාණය වෙලා තියෙන්නේ. ඒ නිසාම මේකට ලොකු ප්‍රේක්ෂක ආකර්ෂණයක් ලැබිලා තියෙනවා.

කතාව යන්නේ 1940 දශකයේ අඳුරු Gotham නගරයේ. ගොඩක් දියුණු තාක්ෂණයන් නැති, දූෂණය සහ අපරාධ වලින් පිරිච්ච නගරයක Bruce Wayne තමන්ගේ මුල්ම කාලයේ Batman විදිහට අපරාධකරුවන්ට විරුද්ධව සටන් කරන හැටි තමයි මේකෙන් පෙන්නන්නේ. මේ කතාවේ ඉන්න Batman ටිකක් රළුයි වගේම, අපි දන්න Catwoman, Harley Quinn, Two-Face සහ Penguin වගේ අනිත් චරිතත් මේ කතාවේදී සම්පූර්ණයෙන්ම අලුත් වගේම වෙනස්ම විදිහකට තමයි නිර්මාණය කරලා තියෙන්නේ.

DC කොමික් පොත් වල තිබුණු මුල්ම කාලයේ අඳුරු Noir ගතියට සහ රහස් පරීක්ෂක (Detective) කතා වලට කැමති අයට කිසිම කම්මැලිකමක් නැතුව බලන්න පුළුවන් සුපිරිම කතා මාලාවක් තමයි මේක.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:
📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් Telegram චැනලය හරහා ලබාගත හැක.', '2024-01-01', 50, 7.2, 'https://image.tmdb.org/t/p/original/tJ7zq4VtvJqUyaRsLeNjpEFDXzk.jpg', '2026-08-05 06:40:15.262255+00', '2026-08-05 06:40:15.262255+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('172164d7-f03e-4dde-a6fc-d745cbf52b0c', '5c4af11e-21f5-4ee9-a8a3-30fc4cf84989', 8, 'Episode 8', '🦇 Batman: Caped Crusader - සිංහල උපසිරැසි 🎬

Batman: Caped Crusader brings a dark, noir-inspired take on the Dark Knight''s early days in Gotham City. Produced by Bruce Timm, Matt Reeves, and J.J. Abrams, this animated series is a must-watch for DC fans. Download high-quality 720p WEB-DL video files with Sinhala subtitles directly or via Telegram. Experience the ultimate psychological and action-packed detective story.

Batman: Caped Crusader කියන්නේ DC රසිකයින්ට ලැබුණු අලුත්ම සහ වෙනස්ම විදිහේ ඇනිමේටඩ් කතා මාලාවක්. සුප්‍රසිද්ධ Batman: The Animated Series එක හදපු Bruce Timm වගේම The Batman චිත්‍රපටය අධ්‍යක්ෂණය කරපු Matt Reeves ගේ සහ J.J. Abrams ගේ එකතුවෙන් තමයි මේක නිර්මාණය වෙලා තියෙන්නේ. ඒ නිසාම මේකට ලොකු ප්‍රේක්ෂක ආකර්ෂණයක් ලැබිලා තියෙනවා.

කතාව යන්නේ 1940 දශකයේ අඳුරු Gotham නගරයේ. ගොඩක් දියුණු තාක්ෂණයන් නැති, දූෂණය සහ අපරාධ වලින් පිරිච්ච නගරයක Bruce Wayne තමන්ගේ මුල්ම කාලයේ Batman විදිහට අපරාධකරුවන්ට විරුද්ධව සටන් කරන හැටි තමයි මේකෙන් පෙන්නන්නේ. මේ කතාවේ ඉන්න Batman ටිකක් රළුයි වගේම, අපි දන්න Catwoman, Harley Quinn, Two-Face සහ Penguin වගේ අනිත් චරිතත් මේ කතාවේදී සම්පූර්ණයෙන්ම අලුත් වගේම වෙනස්ම විදිහකට තමයි නිර්මාණය කරලා තියෙන්නේ.

DC කොමික් පොත් වල තිබුණු මුල්ම කාලයේ අඳුරු Noir ගතියට සහ රහස් පරීක්ෂක (Detective) කතා වලට කැමති අයට කිසිම කම්මැලිකමක් නැතුව බලන්න පුළුවන් සුපිරිම කතා මාලාවක් තමයි මේක.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:
📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් Telegram චැනලය හරහා ලබාගත හැක.', '2024-01-01', 50, 7.2, 'https://image.tmdb.org/t/p/original/tJ7zq4VtvJqUyaRsLeNjpEFDXzk.jpg', '2026-08-05 06:40:15.262255+00', '2026-08-05 06:40:15.262255+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('5e18c1a7-9145-46b0-a1b1-6cd8d8ae7c80', '5c4af11e-21f5-4ee9-a8a3-30fc4cf84989', 9, 'Episode 9', '🦇 Batman: Caped Crusader - සිංහල උපසිරැසි 🎬

Batman: Caped Crusader brings a dark, noir-inspired take on the Dark Knight''s early days in Gotham City. Produced by Bruce Timm, Matt Reeves, and J.J. Abrams, this animated series is a must-watch for DC fans. Download high-quality 720p WEB-DL video files with Sinhala subtitles directly or via Telegram. Experience the ultimate psychological and action-packed detective story.

Batman: Caped Crusader කියන්නේ DC රසිකයින්ට ලැබුණු අලුත්ම සහ වෙනස්ම විදිහේ ඇනිමේටඩ් කතා මාලාවක්. සුප්‍රසිද්ධ Batman: The Animated Series එක හදපු Bruce Timm වගේම The Batman චිත්‍රපටය අධ්‍යක්ෂණය කරපු Matt Reeves ගේ සහ J.J. Abrams ගේ එකතුවෙන් තමයි මේක නිර්මාණය වෙලා තියෙන්නේ. ඒ නිසාම මේකට ලොකු ප්‍රේක්ෂක ආකර්ෂණයක් ලැබිලා තියෙනවා.

කතාව යන්නේ 1940 දශකයේ අඳුරු Gotham නගරයේ. ගොඩක් දියුණු තාක්ෂණයන් නැති, දූෂණය සහ අපරාධ වලින් පිරිච්ච නගරයක Bruce Wayne තමන්ගේ මුල්ම කාලයේ Batman විදිහට අපරාධකරුවන්ට විරුද්ධව සටන් කරන හැටි තමයි මේකෙන් පෙන්නන්නේ. මේ කතාවේ ඉන්න Batman ටිකක් රළුයි වගේම, අපි දන්න Catwoman, Harley Quinn, Two-Face සහ Penguin වගේ අනිත් චරිතත් මේ කතාවේදී සම්පූර්ණයෙන්ම අලුත් වගේම වෙනස්ම විදිහකට තමයි නිර්මාණය කරලා තියෙන්නේ.

DC කොමික් පොත් වල තිබුණු මුල්ම කාලයේ අඳුරු Noir ගතියට සහ රහස් පරීක්ෂක (Detective) කතා වලට කැමති අයට කිසිම කම්මැලිකමක් නැතුව බලන්න පුළුවන් සුපිරිම කතා මාලාවක් තමයි මේක.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:
📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් Telegram චැනලය හරහා ලබාගත හැක.', '2024-01-01', 50, 7.2, 'https://image.tmdb.org/t/p/original/tJ7zq4VtvJqUyaRsLeNjpEFDXzk.jpg', '2026-08-05 06:40:15.262255+00', '2026-08-05 06:40:15.262255+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('ca6224a3-7235-413e-afb1-b993d63010e5', '5c4af11e-21f5-4ee9-a8a3-30fc4cf84989', 10, 'Episode 10', '🦇 Batman: Caped Crusader - සිංහල උපසිරැසි 🎬

Batman: Caped Crusader brings a dark, noir-inspired take on the Dark Knight''s early days in Gotham City. Produced by Bruce Timm, Matt Reeves, and J.J. Abrams, this animated series is a must-watch for DC fans. Download high-quality 720p WEB-DL video files with Sinhala subtitles directly or via Telegram. Experience the ultimate psychological and action-packed detective story.

Batman: Caped Crusader කියන්නේ DC රසිකයින්ට ලැබුණු අලුත්ම සහ වෙනස්ම විදිහේ ඇනිමේටඩ් කතා මාලාවක්. සුප්‍රසිද්ධ Batman: The Animated Series එක හදපු Bruce Timm වගේම The Batman චිත්‍රපටය අධ්‍යක්ෂණය කරපු Matt Reeves ගේ සහ J.J. Abrams ගේ එකතුවෙන් තමයි මේක නිර්මාණය වෙලා තියෙන්නේ. ඒ නිසාම මේකට ලොකු ප්‍රේක්ෂක ආකර්ෂණයක් ලැබිලා තියෙනවා.

කතාව යන්නේ 1940 දශකයේ අඳුරු Gotham නගරයේ. ගොඩක් දියුණු තාක්ෂණයන් නැති, දූෂණය සහ අපරාධ වලින් පිරිච්ච නගරයක Bruce Wayne තමන්ගේ මුල්ම කාලයේ Batman විදිහට අපරාධකරුවන්ට විරුද්ධව සටන් කරන හැටි තමයි මේකෙන් පෙන්නන්නේ. මේ කතාවේ ඉන්න Batman ටිකක් රළුයි වගේම, අපි දන්න Catwoman, Harley Quinn, Two-Face සහ Penguin වගේ අනිත් චරිතත් මේ කතාවේදී සම්පූර්ණයෙන්ම අලුත් වගේම වෙනස්ම විදිහකට තමයි නිර්මාණය කරලා තියෙන්නේ.

DC කොමික් පොත් වල තිබුණු මුල්ම කාලයේ අඳුරු Noir ගතියට සහ රහස් පරීක්ෂක (Detective) කතා වලට කැමති අයට කිසිම කම්මැලිකමක් නැතුව බලන්න පුළුවන් සුපිරිම කතා මාලාවක් තමයි මේක.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:
📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් Telegram චැනලය හරහා ලබාගත හැක.', '2024-01-01', 50, 7.2, 'https://image.tmdb.org/t/p/original/tJ7zq4VtvJqUyaRsLeNjpEFDXzk.jpg', '2026-08-05 06:40:15.262255+00', '2026-08-05 06:40:15.262255+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('c10e6331-100b-45da-a62a-bb4d9c8dfe2e', '40dee2dc-1a40-4b47-acaf-4308fe7654ba', 8, 'Episode 8', '🎬 The Sopranos Season 2 - සිංහල උපසිරැසි 🎬

Continue the legendary journey with The Sopranos Season 2, one of the most intense and captivating chapters in television history. As Tony Soprano steps up to lead the DiMeo family, he faces growing pressure, rivalry from close associates, and unresolved personal turmoil that threatens his empire and family life.

Download all episodes of The Sopranos Season 2 in high-definition quality. Choose from 720p, 1080p WEB-DL video files, all paired with accurate Sinhala subtitles. Access your files instantly via high-speed direct download links or convenient Telegram links.

නිව් ජර්සි නගරය කේන්ද්‍ර කරගනිමින් ක්‍රියාත්මක වන ප්‍රබල කණ්ඩායමක ප්‍රධානියෙකු වන ටෝනි සෝප්‍රානෝ (Tony Soprano) සාමාන්‍ය පවුල් ජීවිතයත්, ඔහුගේ රහසිගත ව්‍යාපාරික ලෝකයත් අතර දෝලනය වන චරිතයකි. පළමු කලාපය ආරම්භ වන්නේ ඔහු මුහුණ දෙන අභ්‍යන්තර සහ බාහිර ගැටුම් රැසක් සමඟිනි. අධික මානසික පීඩනය නිසා ඇති වන හදිසි ක්ලාන්ත සහ භීතිකා තත්ත්වයන් (Panic Attacks) හේතුවෙන්, ටෝනිට සිදුවන්නේ රහසින් මනෝ වෛද්‍ය ජෙනිෆර් මෙල්ෆි (Dr. Jennifer Melfi) හමුවී ප්‍රතිකාර ලබා ගැනීමටය. ඔහුගේ ව්‍යාපාරික වටපිටාව තුළ මෙවැනි ප්‍රතිකාර ලබා ගැනීම දුර්වලතාවයක් ලෙස සැලකිය හැකි බැවින්, මෙම වෛද්‍ය හමුවීම් සඟවා තබා ගැනීමට ඔහුට දැඩි වෙහෙසක් දැරීමට සිදු වේ.

මේ අතර, පෙර සිටි ප්‍රධානියාගේ අභාවයත් සමඟ නායකත්වය සඳහා ටෝනි සහ ඔහුගේ බාප්පා වන ජූනියර් (Uncle Junior) අතර දැඩි බල අරගලයක් නිර්මාණය වේ. අනවශ්‍ය ගැටුම් මඟහරවා ගැනීම සඳහා ටෝනි ඉතා සූක්ෂ්ම ලෙස ජූනියර්ව නාමිකව පවුලේ ප්‍රධානියා (Official Boss) ලෙස පත් කිරීමට කටයුතු කරයි. කෙසේ වෙතත්, සැබෑ බලය සහ ප්‍රධාන තීරණ ගැනීම් සිදු කරන්නේ ටෝනි සහ ඔහුගේ සමීපතම කණ්ඩායම විසින් වන අතර, මෙය ජූනියර්ගේ නොසතුටට හේතු වේ.

ටෝනිගේ පෞද්ගලික ජීවිතය ද මෙවැනිම ගැටලුවලින් පිරී පවතී. ඔහුගේ අහංකාර සහ මානසිකව පීඩාකාරී මව වන ලිවියා (Livia) ව බලා ගැනීමට නොහැකි තැන, ටෝනි ඇයව විශ්‍රාමික නිවාසයක නතර කිරීමට තීරණය කරයි. තමන්ව මෙවැනි තැනකට යැවීම පිළිබඳව දැඩි අමනාපයකින් පසුවන ලිවියා, ටෝනි කෙරෙහි විරෝධයෙන් පසුවේ.

ටෝනි රහසින් මනෝ වෛද්‍යවරයෙකු හමුවන බවත්, තමන්ව රවටා පවුලේ බලය හසුරුවන බවත් ජූනියර් මාමා දැනගන්නේ මෙම වටපිටාව තුළය. මේ සඳහා ලිවියා ද වක්‍රව ජූනියර්ව පොළඹවන අතර, එහි ප්‍රතිඵලයක් ලෙස ඔවුන් දෙදෙනා එක්ව ටෝනිට එරෙහිව දැඩි සැලසුම් සකස් කරයි. කෙසේ වෙතත්, එම අනපේක්ෂිත උපක්‍රමවලින් ඉතා ආශ්චර්යමත් ලෙස ටෝනි බේරීමට සමත් වේ. පසුව, රහසිගත තොරතුරු මාර්ගයෙන් තමන්ට එරෙහිව මෙම කුමන්ත්‍රණ මෙහෙයවූයේ තමන්ගේම මව සහ බාප්පා බව ටෝනි වටහා ගනී.

පළමු කලාපය අවසන් වන්නේ මෙම පාවාදීම් පිළිබඳ ඇත්ත හෙළිවීමත් සමඟය. ටෝනිගේ ප්‍රතිචාර හමුවේ ජූනියර් මාමාගේ සැලසුම් සහ සමීපතමයින්ගේ බලය බිඳ වැටෙන අතර, අවසානයේදී ජූනියර් නීතියේ රැහැනට හසු වේ. තම පුතාගේ කෝපයෙන් බේරීම සඳහා ලිවියා රෝහල්ගත වේ. පළමු කලාපය නිමාවට පත්වන විට ටෝනි පවුලේ අවිවාදිත සැබෑ නායකයා බවට පත් වුවද, සමීපතමයන්ගෙන් ලැබුණු ද්‍රෝහීකම් නිසා ඔහුගේ සිත තුළ ගැඹුරු කැලඹීමක් ඉතිරි වේ. දෙවන කලාපය ආරම්භ වන්නේ මෙම සිදුවීම් මාලාවෙන් පසුව ඇති වන නව අභියෝග රැසක් සමඟිනි.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram download: 720p සහ 1080p උසස් තත්ත්වයේ WEBRip වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2000-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/u7dlARwP2zsqHaMNL5HtHhaEPea.jpg', '2026-08-05 14:04:25.09645+00', '2026-08-05 14:04:25.09645+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('e1312426-8a25-4ae5-af0d-1990021252ca', '40dee2dc-1a40-4b47-acaf-4308fe7654ba', 9, 'Episode 9', '🎬 The Sopranos Season 2 - සිංහල උපසිරැසි 🎬

Continue the legendary journey with The Sopranos Season 2, one of the most intense and captivating chapters in television history. As Tony Soprano steps up to lead the DiMeo family, he faces growing pressure, rivalry from close associates, and unresolved personal turmoil that threatens his empire and family life.

Download all episodes of The Sopranos Season 2 in high-definition quality. Choose from 720p, 1080p WEB-DL video files, all paired with accurate Sinhala subtitles. Access your files instantly via high-speed direct download links or convenient Telegram links.

නිව් ජර්සි නගරය කේන්ද්‍ර කරගනිමින් ක්‍රියාත්මක වන ප්‍රබල කණ්ඩායමක ප්‍රධානියෙකු වන ටෝනි සෝප්‍රානෝ (Tony Soprano) සාමාන්‍ය පවුල් ජීවිතයත්, ඔහුගේ රහසිගත ව්‍යාපාරික ලෝකයත් අතර දෝලනය වන චරිතයකි. පළමු කලාපය ආරම්භ වන්නේ ඔහු මුහුණ දෙන අභ්‍යන්තර සහ බාහිර ගැටුම් රැසක් සමඟිනි. අධික මානසික පීඩනය නිසා ඇති වන හදිසි ක්ලාන්ත සහ භීතිකා තත්ත්වයන් (Panic Attacks) හේතුවෙන්, ටෝනිට සිදුවන්නේ රහසින් මනෝ වෛද්‍ය ජෙනිෆර් මෙල්ෆි (Dr. Jennifer Melfi) හමුවී ප්‍රතිකාර ලබා ගැනීමටය. ඔහුගේ ව්‍යාපාරික වටපිටාව තුළ මෙවැනි ප්‍රතිකාර ලබා ගැනීම දුර්වලතාවයක් ලෙස සැලකිය හැකි බැවින්, මෙම වෛද්‍ය හමුවීම් සඟවා තබා ගැනීමට ඔහුට දැඩි වෙහෙසක් දැරීමට සිදු වේ.

මේ අතර, පෙර සිටි ප්‍රධානියාගේ අභාවයත් සමඟ නායකත්වය සඳහා ටෝනි සහ ඔහුගේ බාප්පා වන ජූනියර් (Uncle Junior) අතර දැඩි බල අරගලයක් නිර්මාණය වේ. අනවශ්‍ය ගැටුම් මඟහරවා ගැනීම සඳහා ටෝනි ඉතා සූක්ෂ්ම ලෙස ජූනියර්ව නාමිකව පවුලේ ප්‍රධානියා (Official Boss) ලෙස පත් කිරීමට කටයුතු කරයි. කෙසේ වෙතත්, සැබෑ බලය සහ ප්‍රධාන තීරණ ගැනීම් සිදු කරන්නේ ටෝනි සහ ඔහුගේ සමීපතම කණ්ඩායම විසින් වන අතර, මෙය ජූනියර්ගේ නොසතුටට හේතු වේ.

ටෝනිගේ පෞද්ගලික ජීවිතය ද මෙවැනිම ගැටලුවලින් පිරී පවතී. ඔහුගේ අහංකාර සහ මානසිකව පීඩාකාරී මව වන ලිවියා (Livia) ව බලා ගැනීමට නොහැකි තැන, ටෝනි ඇයව විශ්‍රාමික නිවාසයක නතර කිරීමට තීරණය කරයි. තමන්ව මෙවැනි තැනකට යැවීම පිළිබඳව දැඩි අමනාපයකින් පසුවන ලිවියා, ටෝනි කෙරෙහි විරෝධයෙන් පසුවේ.

ටෝනි රහසින් මනෝ වෛද්‍යවරයෙකු හමුවන බවත්, තමන්ව රවටා පවුලේ බලය හසුරුවන බවත් ජූනියර් මාමා දැනගන්නේ මෙම වටපිටාව තුළය. මේ සඳහා ලිවියා ද වක්‍රව ජූනියර්ව පොළඹවන අතර, එහි ප්‍රතිඵලයක් ලෙස ඔවුන් දෙදෙනා එක්ව ටෝනිට එරෙහිව දැඩි සැලසුම් සකස් කරයි. කෙසේ වෙතත්, එම අනපේක්ෂිත උපක්‍රමවලින් ඉතා ආශ්චර්යමත් ලෙස ටෝනි බේරීමට සමත් වේ. පසුව, රහසිගත තොරතුරු මාර්ගයෙන් තමන්ට එරෙහිව මෙම කුමන්ත්‍රණ මෙහෙයවූයේ තමන්ගේම මව සහ බාප්පා බව ටෝනි වටහා ගනී.

පළමු කලාපය අවසන් වන්නේ මෙම පාවාදීම් පිළිබඳ ඇත්ත හෙළිවීමත් සමඟය. ටෝනිගේ ප්‍රතිචාර හමුවේ ජූනියර් මාමාගේ සැලසුම් සහ සමීපතමයින්ගේ බලය බිඳ වැටෙන අතර, අවසානයේදී ජූනියර් නීතියේ රැහැනට හසු වේ. තම පුතාගේ කෝපයෙන් බේරීම සඳහා ලිවියා රෝහල්ගත වේ. පළමු කලාපය නිමාවට පත්වන විට ටෝනි පවුලේ අවිවාදිත සැබෑ නායකයා බවට පත් වුවද, සමීපතමයන්ගෙන් ලැබුණු ද්‍රෝහීකම් නිසා ඔහුගේ සිත තුළ ගැඹුරු කැලඹීමක් ඉතිරි වේ. දෙවන කලාපය ආරම්භ වන්නේ මෙම සිදුවීම් මාලාවෙන් පසුව ඇති වන නව අභියෝග රැසක් සමඟිනි.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram download: 720p සහ 1080p උසස් තත්ත්වයේ WEBRip වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2000-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/u7dlARwP2zsqHaMNL5HtHhaEPea.jpg', '2026-08-05 14:04:25.09645+00', '2026-08-05 14:04:25.09645+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('cc49279f-7804-4ab9-ad06-b0088a2d6af3', '40dee2dc-1a40-4b47-acaf-4308fe7654ba', 10, 'Episode 10', '🎬 The Sopranos Season 2 - සිංහල උපසිරැසි 🎬

Continue the legendary journey with The Sopranos Season 2, one of the most intense and captivating chapters in television history. As Tony Soprano steps up to lead the DiMeo family, he faces growing pressure, rivalry from close associates, and unresolved personal turmoil that threatens his empire and family life.

Download all episodes of The Sopranos Season 2 in high-definition quality. Choose from 720p, 1080p WEB-DL video files, all paired with accurate Sinhala subtitles. Access your files instantly via high-speed direct download links or convenient Telegram links.

නිව් ජර්සි නගරය කේන්ද්‍ර කරගනිමින් ක්‍රියාත්මක වන ප්‍රබල කණ්ඩායමක ප්‍රධානියෙකු වන ටෝනි සෝප්‍රානෝ (Tony Soprano) සාමාන්‍ය පවුල් ජීවිතයත්, ඔහුගේ රහසිගත ව්‍යාපාරික ලෝකයත් අතර දෝලනය වන චරිතයකි. පළමු කලාපය ආරම්භ වන්නේ ඔහු මුහුණ දෙන අභ්‍යන්තර සහ බාහිර ගැටුම් රැසක් සමඟිනි. අධික මානසික පීඩනය නිසා ඇති වන හදිසි ක්ලාන්ත සහ භීතිකා තත්ත්වයන් (Panic Attacks) හේතුවෙන්, ටෝනිට සිදුවන්නේ රහසින් මනෝ වෛද්‍ය ජෙනිෆර් මෙල්ෆි (Dr. Jennifer Melfi) හමුවී ප්‍රතිකාර ලබා ගැනීමටය. ඔහුගේ ව්‍යාපාරික වටපිටාව තුළ මෙවැනි ප්‍රතිකාර ලබා ගැනීම දුර්වලතාවයක් ලෙස සැලකිය හැකි බැවින්, මෙම වෛද්‍ය හමුවීම් සඟවා තබා ගැනීමට ඔහුට දැඩි වෙහෙසක් දැරීමට සිදු වේ.

මේ අතර, පෙර සිටි ප්‍රධානියාගේ අභාවයත් සමඟ නායකත්වය සඳහා ටෝනි සහ ඔහුගේ බාප්පා වන ජූනියර් (Uncle Junior) අතර දැඩි බල අරගලයක් නිර්මාණය වේ. අනවශ්‍ය ගැටුම් මඟහරවා ගැනීම සඳහා ටෝනි ඉතා සූක්ෂ්ම ලෙස ජූනියර්ව නාමිකව පවුලේ ප්‍රධානියා (Official Boss) ලෙස පත් කිරීමට කටයුතු කරයි. කෙසේ වෙතත්, සැබෑ බලය සහ ප්‍රධාන තීරණ ගැනීම් සිදු කරන්නේ ටෝනි සහ ඔහුගේ සමීපතම කණ්ඩායම විසින් වන අතර, මෙය ජූනියර්ගේ නොසතුටට හේතු වේ.

ටෝනිගේ පෞද්ගලික ජීවිතය ද මෙවැනිම ගැටලුවලින් පිරී පවතී. ඔහුගේ අහංකාර සහ මානසිකව පීඩාකාරී මව වන ලිවියා (Livia) ව බලා ගැනීමට නොහැකි තැන, ටෝනි ඇයව විශ්‍රාමික නිවාසයක නතර කිරීමට تීරණය කරයි. තමන්ව මෙවැනි තැනකට යැවීම පිළිබඳව දැඩි අමනාපයකින් පසුවන ලිවියා, ටෝනි කෙරෙහි විරෝධයෙන් පසුවේ.

ටෝනි රහසින් මනෝ වෛද්‍යවරයෙකු හමුවන බවත්, තමන්ව රවටා පවුලේ බලය හසුරුවන බවත් ජූනියර් මාමා දැනගන්නේ මෙම වටපිටාව තුළය. මේ සඳහා ලිවියා ද වක්‍රව ජූනියර්ව පොළඹවන අතර, එහි ප්‍රතිඵලයක් ලෙස ඔවුන් දෙදෙනා එක්ව ටෝනිට එරෙහිව දැඩි සැලසුම් සකස් කරයි. කෙසේ වෙතත්, එම අනපේක්ෂිත උපක්‍රමවලින් ඉතා ආශ්චර්යමත් ලෙස ටෝනි බේරීමට සමත් වේ. පසුව, රහසිගත තොරතුරු මාර්ගයෙන් තමන්ට එරෙහිව මෙම කුමන්ත්‍රණ මෙහෙයවූයේ තමන්ගේම මව සහ බාප්පා බව ටෝනි වටහා ගනී.

පළමු කලාපය අවසන් වන්නේ මෙම පාවාදීම් පිළිබඳ ඇත්ත හෙළිවීමත් සමඟය. ටෝනිගේ ප්‍රතිචාර හමුවේ ජූනියර් මාමාගේ සැලසුම් සහ සමීපතමයින්ගේ බලය බිඳ වැටෙන අතර, අවසානයේදී ජූනියර් නීතියේ රැහැනට හසු වේ. තම පුතාගේ කෝපයෙන් බේරීම සඳහා ලිවියා රෝහල්ගත වේ. පළමු කලාපය නිමාවට පත්වන විට ටෝනි පවුලේ අවිවාදිත සැබෑ නායකයා බවට පත් වුවද, සමීපතමයන්ගෙන් ලැබුණු ද්‍රෝහීකම් නිසා ඔහුගේ සිත තුළ ගැඹුරු කැලඹීමක් ඉතිරි වේ. දෙවන කලාපය ආරම්භ වන්නේ මෙම සිදුවීම් මාලාවෙන් පසුව ඇති වන නව අභියෝග රැසක් සමඟිනි.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram download: 720p සහ 1080p උසස් තත්ත්වයේ WEBRip වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2000-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/u7dlARwP2zsqHaMNL5HtHhaEPea.jpg', '2026-08-05 14:04:25.09645+00', '2026-08-05 14:04:25.09645+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('29400325-859d-4550-ab10-9e19342a3559', '40dee2dc-1a40-4b47-acaf-4308fe7654ba', 11, 'Episode 11', '🎬 The Sopranos Season 2 - සිංහල උපසිරැසි 🎬

Continue the legendary journey with The Sopranos Season 2, one of the most intense and captivating chapters in television history. As Tony Soprano steps up to lead the DiMeo family, he faces growing pressure, rivalry from close associates, and unresolved personal turmoil that threatens his empire and family life.

Download all episodes of The Sopranos Season 2 in high-definition quality. Choose from 720p, 1080p WEB-DL video files, all paired with accurate Sinhala subtitles. Access your files instantly via high-speed direct download links or convenient Telegram links.

නිව් ජර්සි නගරය කේන්ද්‍ර කරගනිමින් ක්‍රියාත්මක වන ප්‍රබල කණ්ඩායමක ප්‍රධානියෙකු වන ටෝනි සෝප්‍රානෝ (Tony Soprano) සාමාන්‍ය පවුල් ජීවිතයත්, ඔහුගේ රහසිගත ව්‍යාපාරික ලෝකයත් අතර දෝලනය වන චරිතයකි. පළමු කලාපය ආරම්භ වන්නේ ඔහු මුහුණ දෙන අභ්‍යන්තර සහ බාහිර ගැටුම් රැසක් සමඟිනි. අධික මානසික පීඩනය නිසා ඇති වන හදිසි ක්ලාන්ත සහ භීතිකා තත්ත්වයන් (Panic Attacks) හේතුවෙන්, ටෝනිට සිදුවන්නේ රහසින් මනෝ වෛද්‍ය ජෙනිෆර් මෙල්ෆි (Dr. Jennifer Melfi) හමුවී ප්‍රතිකාර ලබා ගැනීමටය. ඔහුගේ ව්‍යාපාරික වටපිටාව තුළ මෙවැනි ප්‍රතිකාර ලබා ගැනීම දුර්වලතාවයක් ලෙස සැලකිය හැකි බැවින්, මෙම වෛද්‍ය හමුවීම් සඟවා තබා ගැනීමට ඔහුට දැඩි වෙහෙසක් දැරීමට සිදු වේ.

මේ අතර, පෙර සිටි ප්‍රධානියාගේ අභාවයත් සමඟ නායකත්වය සඳහා ටෝනි සහ ඔහුගේ බාප්පා වන ජූනියර් (Uncle Junior) අතර දැඩි බල අරගලයක් නිර්මාණය වේ. අනවශ්‍ය ගැටුම් මඟහරවා ගැනීම සඳහා ටෝනි ඉතා සූක්ෂ්ම ලෙස ජූනියර්ව නාමිකව පවුලේ ප්‍රධානියා (Official Boss) ලෙස පත් කිරීමට කටයුතු කරයි. කෙසේ වෙතත්, සැබෑ බලය සහ ප්‍රධාන තීරණ ගැනීම් සිදු කරන්නේ ටෝනි සහ ඔහුගේ සමීපතම කණ්ඩායම විසින් වන අතර, මෙය ජූනියර්ගේ නොසතුටට හේතු වේ.

ටෝනිගේ පෞද්ගලික ජීවිතය ද මෙවැනිම ගැටලුවලින් පිරී පවතී. ඔහුගේ අහංකාර සහ මානසිකව පීඩාකාරී මව වන ලිවියා (Livia) ව බලා ගැනීමට නොහැකි තැන, ටෝනි ඇයව විශ්‍රාමික නිවාසයක නතර කිරීමට තීරණය කරයි. තමන්ව මෙවැනි තැනකට යැවීම පිළිබඳව දැඩි අමනාපයකින් පසුවන ලිවියා, ටෝනි කෙරෙහි විරෝධයෙන් පසුවේ.

ටෝනි රහසින් මනෝ වෛද්‍යවරයෙකු හමුවන බවත්, තමන්ව රවටා පවුලේ බලය හසුරුවන බවත් ජූනියර් මාමා දැනගන්නේ මෙම වටපිටාව තුළය. මේ සඳහා ලිවියා ද වක්‍රව ජූනියර්ව පොළඹවන අතර, එහි ප්‍රතිඵලයක් ලෙස ඔවුන් දෙදෙනා එක්ව ටෝනිට එරෙහිව දැඩි සැලසුම් සකස් කරයි. කෙසේ වෙතත්, එම අනපේක්ෂිත උපක්‍රමවලින් ඉතා ආශ්චර්යමත් ලෙස ටෝනි බේරීමට සමත් වේ. පසුව, රහසිගත තොරතුරු මාර්ගයෙන් තමන්ට එරෙහිව මෙම කුමන්ත්‍රණ මෙහෙයවූයේ තමන්ගේම මව සහ බාප්පා බව ටෝනි වටහා ගනී.

පළමු කලාපය අවසන් වන්නේ මෙම පාවාදීම් පිළිබඳ ඇත්ත හෙළිවීමත් සමඟය. ටෝනිගේ ප්‍රතිචාර හමුවේ ජූනියර් මාමාගේ සැලසුම් සහ සමීපතමයින්ගේ බලය බිඳ වැටෙන අතර, අවසානයේදී ජූනියර් නීතියේ රැහැනට හසු වේ. තම පුතාගේ කෝපයෙන් බේරීම සඳහා ලිවියා රෝහල්ගත වේ. පළමු කලාපය නිමාවට පත්වන විට ටෝනි පවුලේ අවිවාදිත සැබෑ නායකයා බවට පත් වුවද, සමීපතමයන්ගෙන් ලැබුණු ද්‍රෝහීකම් නිසා ඔහුගේ සිත තුළ ගැඹුරු කැලඹීමක් ඉතිරි වේ. දෙවන කලාපය ආරම්භ වන්නේ මෙම සිදුවීම් මාලාවෙන් පසුව ඇති වන නව අභියෝග රැසක් සමඟිනි.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram download: 720p සහ 1080p උසස් තත්ත්වයේ WEBRip වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2000-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/u7dlARwP2zsqHaMNL5HtHhaEPea.jpg', '2026-08-05 14:04:25.09645+00', '2026-08-05 14:04:25.09645+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('4d6866db-8002-4ee6-a361-a2ed37c50650', '40dee2dc-1a40-4b47-acaf-4308fe7654ba', 12, 'Episode 12', '🎬 The Sopranos Season 2 - සිංහල උපසිරැසි 🎬

Continue the legendary journey with The Sopranos Season 2, one of the most intense and captivating chapters in television history. As Tony Soprano steps up to lead the DiMeo family, he faces growing pressure, rivalry from close associates, and unresolved personal turmoil that threatens his empire and family life.

Download all episodes of The Sopranos Season 2 in high-definition quality. Choose from 720p, 1080p WEB-DL video files, all paired with accurate Sinhala subtitles. Access your files instantly via high-speed direct download links or convenient Telegram links.

නිව් ජර්සි නගරය කේන්ද්‍ර කරගනිමින් ක්‍රියාත්මක වන ප්‍රබල කණ්ඩායමක ප්‍රධානියෙකු වන ටෝනි සෝප්‍රානෝ (Tony Soprano) සාමාන්‍ය පවුල් ජීවිතයත්, ඔහුගේ රහසිගත ව්‍යාපාරික ලෝකයත් අතර දෝලනය වන චරිතයකි. පළමු කලාපය ආරම්භ වන්නේ ඔහු මුහුණ දෙන අභ්‍යන්තර සහ බාහිර ගැටුම් රැසක් සමඟිනි. අධික මානසික පීඩනය නිසා ඇති වන හදිසි ක්ලාන්ත සහ භීතිකා තත්ත්වයන් (Panic Attacks) හේතුවෙන්, ටෝනිට සිදුවන්නේ රහසින් මනෝ වෛද්‍ය ජෙනිෆර් මෙල්ෆි (Dr. Jennifer Melfi) හමුවී ප්‍රතිකාර ලබා ගැනීමටය. ඔහුගේ ව්‍යාපාරික වටපිටාව තුළ මෙවැනි ප්‍රතිකාර ලබා ගැනීම දුර්වලතාවයක් ලෙස සැලකිය හැකි බැවින්, මෙම වෛද්‍ය හමුවීම් සඟවා තබා ගැනීමට ඔහුට දැඩි වෙහෙසක් දැරීමට සිදු වේ.

මේ අතර, පෙර සිටි ප්‍රධානියාගේ අභාවයත් සමඟ නායකත්වය සඳහා ටෝනි සහ ඔහුගේ බාප්පා වන ජූනියර් (Uncle Junior) අතර දැඩි බල අරගලයක් නිර්මාණය වේ. අනවශ්‍ය ගැටුම් මඟහරවා ගැනීම සඳහා ටෝනි ඉතා සූක්ෂ්ම ලෙස ජූනියර්ව නාමිකව පවුලේ ප්‍රධානියා (Official Boss) ලෙස පත් කිරීමට කටයුතු කරයි. කෙසේ වෙතත්, සැබෑ බලය සහ ප්‍රධාන තීරණ ගැනීම් සිදු කරන්නේ ටෝනි සහ ඔහුගේ සමීපතම කණ්ඩායම විසින් වන අතර, මෙය ජූනියර්ගේ නොසතුටට හේතු වේ.

ටෝනිගේ පෞද්ගලික ජීවිතය ද මෙවැනිම ගැටලුවලින් පිරී පවතී. ඔහුගේ අහංකාර සහ මානසිකව පීඩාකාරී මව වන ලිවියා (Livia) ව බලා ගැනීමට නොහැකි තැන, ටෝනි ඇයව විශ්‍රාමික නිවාසයක නතර කිරීමට තීරණය කරයි. තමන්ව මෙවැනි තැනකට යැවීම පිළිබඳව දැඩි අමනාපයකින් පසුවන ලිවියා, ටෝනි කෙරෙහි විරෝධයෙන් පසුවේ.

ටෝනි රහසින් මනෝ වෛද්‍යවරයෙකු හමුවන බවත්, තමන්ව රවටා පවුලේ බලය හසුරුවන බවත් ජූනියර් මාමා දැනගන්නේ මෙම වටපිටාව තුළය. මේ සඳහා ලිවියා ද වක්‍රව ජූනියර්ව පොළඹවන අතර, එහි ප්‍රතිඵලයක් ලෙස ඔවුන් දෙදෙනා එක්ව ටෝනිට එරෙහිව දැඩි සැලසුම් සකස් කරයි. කෙසේ වෙතත්, එම අනපේක්ෂිත උපක්‍රමවලින් ඉතා ආශ්චර්යමත් ලෙස ටෝනි බේරීමට සමත් වේ. පසුව, රහසිගත තොරතුරු මාර්ගයෙන් තමන්ට එරෙහිව මෙම කුමන්ත්‍රණ මෙහෙයවූයේ තමන්ගේම මව සහ බාප්පා බව ටෝනි වටහා ගනී.

පළමු කලාපය අවසන් වන්නේ මෙම පාවාදීම් පිළිබඳ ඇත්ත හෙළිවීමත් සමඟය. ටෝනිගේ ප්‍රතිචාර හමුවේ ජූනියර් මාමාගේ සැලසුම් සහ සමීපතමයින්ගේ බලය බිඳ වැටෙන අතර, අවසානයේදී ජූනියර් නීතියේ රැහැනට හසු වේ. තම පුතාගේ කෝපයෙන් බේරීම සඳහා ලිවියා රෝහල්ගත වේ. පළමු කලාපය නිමාවට පත්වන විට ටෝනි පවුලේ අවිවාදිත සැබෑ නායකයා බවට පත් වුවද, සමීපතමයන්ගෙන් ලැබුණු ද්‍රෝහීකම් නිසා ඔහුගේ සිත තුළ ගැඹුරු කැලඹීමක් ඉතිරි වේ. දෙවන කලාපය ආරම්භ වන්නේ මෙම සිදුවීම් මාලාවෙන් පසුව ඇති වන නව අභියෝග රැසක් සමඟිනි.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram download: 720p සහ 1080p උසස් තත්ත්වයේ WEBRip වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2000-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/u7dlARwP2zsqHaMNL5HtHhaEPea.jpg', '2026-08-05 14:04:25.09645+00', '2026-08-05 14:04:25.09645+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('9df4b35e-2508-4a00-adc6-d59fc0460a56', '40dee2dc-1a40-4b47-acaf-4308fe7654ba', 13, 'Episode 13', '🎬 The Sopranos Season 2 - සිංහල උපසිරැසි 🎬

Continue the legendary journey with The Sopranos Season 2, one of the most intense and captivating chapters in television history. As Tony Soprano steps up to lead the DiMeo family, he faces growing pressure, rivalry from close associates, and unresolved personal turmoil that threatens his empire and family life.

Download all episodes of The Sopranos Season 2 in high-definition quality. Choose from 720p, 1080p WEB-DL video files, all paired with accurate Sinhala subtitles. Access your files instantly via high-speed direct download links or convenient Telegram links.

නිව් ජර්සි නගරය කේන්ද්‍ර කරගනිමින් ක්‍රියාත්මක වන ප්‍රබල කණ්ඩායමක ප්‍රධානියෙකු වන ටෝනි සෝප්‍රානෝ (Tony Soprano) සාමාන්‍ය පවුල් ජීවිතයත්, ඔහුගේ රහසිගත ව්‍යාපාරික ලෝකයත් අතර දෝලනය වන චරිතයකි. පළමු කලාපය ආරම්භ වන්නේ ඔහු මුහුණ දෙන අභ්‍යන්තර සහ බාහිර ගැටුම් රැසක් සමඟිනි. අධික මානසික පීඩනය නිසා ඇති වන හදිසි ක්ලාන්ත සහ භීතිකා තත්ත්වයන් (Panic Attacks) හේතුවෙන්, ටෝනිට සිදුවන්නේ රහසින් මනෝ වෛද්‍ය ජෙනිෆර් මෙල්ෆි (Dr. Jennifer Melfi) හමුවී ප්‍රතිකාර ලබා ගැනීමටය. ඔහුගේ ව්‍යාපාරික වටපිටාව තුළ මෙවැනි ප්‍රතිකාර ලබා ගැනීම දුර්වලතාවයක් ලෙස සැලකිය හැකි බැවින්, මෙම වෛද්‍ය හමුවීම් සඟවා තබා ගැනීමට ඔහුට දැඩි වෙහෙසක් දැරීමට සිදු වේ.

මේ අතර, පෙර සිටි ප්‍රධානියාගේ අභාවයත් සමඟ නායකත්වය සඳහා ටෝනි සහ ඔහුගේ බාප්පා වන ජූනියර් (Uncle Junior) අතර දැඩි බල අරගලයක් නිර්මාණය වේ. අනවශ්‍ය ගැටුම් මඟහරවා ගැනීම සඳහා ටෝනි ඉතා සූක්ෂ්ම ලෙස ජූනියර්ව නාමිකව පවුලේ ප්‍රධානියා (Official Boss) ලෙස පත් කිරීමට කටයුතු කරයි. කෙසේ වෙතත්, සැබෑ බලය සහ ප්‍රධාන තීරණ ගැනීම් සිදු කරන්නේ ටෝනි සහ ඔහුගේ සමීපතම කණ්ඩායම විසින් වන අතර, මෙය ජූනියර්ගේ නොසතුටට හේතු වේ.

ටෝනිගේ පෞද්ගලික ජීවිතය ද මෙවැනිම ගැටලුවලින් පිරී පවතී. ඔහුගේ අහංකාර සහ මානසිකව පීඩාකාරී මව වන ලිවියා (Livia) ව බලා ගැනීමට නොහැකි තැන, ටෝනි ඇයව විශ්‍රාමික නිවාසයක නතර කිරීමට තීරණය කරයි. තමන්ව මෙවැනි තැනකට යැවීම පිළිබඳව දැඩි අමනාපයකින් පසුවන ලිවියා, ටෝනි කෙරෙහි විරෝධයෙන් පසුවේ.

ටෝනි රහසින් මනෝ වෛද්‍යවරයෙකු හමුවන බවත්, තමන්ව රවටා පවුලේ බලය හසුරුවන බවත් ජූනියර් මාමා දැනගන්නේ මෙම වටපිටාව තුළය. මේ සඳහා ලිවියා ද වක්‍රව ජූනියර්ව පොළඹවන අතර, එහි ප්‍රතිඵලයක් ලෙස ඔවුන් දෙදෙනා එක්ව ටෝනිට එරෙහිව දැඩි සැලසුම් සකස් කරයි. කෙසේ වෙතත්, එම අනපේක්ෂිත උපක්‍රමවලින් ඉතා ආශ්චර්යමත් ලෙස ටෝනි බේරීමට සමත් වේ. පසුව, රහසිගත තොරතුරු මාර්ගයෙන් තමන්ට එරෙහිව මෙම කුමන්ත්‍රණ මෙහෙයවූයේ තමන්ගේම මව සහ බාප්පා බව ටෝනි වටහා ගනී.

පළමු කලාපය අවසන් වන්නේ මෙම පාවාදීම් පිළිබඳ ඇත්ත හෙළිවීමත් සමඟය. ටෝනිගේ ප්‍රතිචාර හමුවේ ජූනියර් මාමාගේ සැලසුම් සහ සමීපතමයින්ගේ බලය බිඳ වැටෙන අතර, අවසානයේදී ජූනියර් නීතියේ රැහැනට හසු වේ. තම පුතාගේ කෝපයෙන් බේරීම සඳහා ලිවියා රෝහල්ගත වේ. පළමු කලාපය නිමාවට පත්වන විට ටෝනි පවුලේ අවිවාදිත සැබෑ නායකයා බවට පත් වුවද, සමීපතමයන්ගෙන් ලැබුණු ද්‍රෝහීකම් නිසා ඔහුගේ සිත තුළ ගැඹුරු කැලඹීමක් ඉතිරි වේ. දෙවන කලාපය ආරම්භ වන්නේ මෙම සිදුවීම් මාලාවෙන් පසුව ඇති වන නව අභියෝග රැසක් සමඟිනි.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram download: 720p සහ 1080p උසස් තත්ත්වයේ WEBRip වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2000-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/u7dlARwP2zsqHaMNL5HtHhaEPea.jpg', '2026-08-05 14:04:25.09645+00', '2026-08-05 14:04:25.09645+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('c76bb82b-9e39-4060-aa4c-f050b8c6e2e2', '6d68cd70-3068-491f-a91e-e8e5bbbd03ff', 1, 'Episode 1', '🕵️‍♂️ Black Bird - සිංහල උපසිරැසි 🎬

Black Bird is an acclaimed Apple TV+ crime drama miniseries based on true events. Starring Taron Egerton and Paul Walter Hauser, this intense psychological thriller follows a convicted drug dealer offered freedom in exchange for coaxing a confession from an alleged serial killer inside a maximum-security prison. Download high-quality 720p  WEB-DL video files via Telegram. Experience this gripping masterpiece on pixelpoplk.

ඇත්තම සිදුවීමක් ඇසුරෙන් නිර්මාණය වුණු Black Bird කියන්නේ Apple TV+ නාලිකාවෙන් එළියට ආපු, ලෝකයේම ලොකු කතාබහකට ලක්වුණු Crime / Psychological Thriller කතා මාලාවක්. Taron Egerton, Paul Walter Hauser සහ ප්‍රසිද්ධ රංගන ශිල්පී Ray Liotta ගේ විශිෂ්ට රංගනයන්ගෙන් මේ කතාව අතිශය සාර්ථක එකක් බවට පත්වුණා.

කතාව ගැන කිසිම දෙයක් ස්පොයිල් කරන්නේ නැතුව කිව්වොත්, අවුරුදු 10ක සිරදඬුවමක් ලැබෙන Jimmy Keene කියන තරුණයාට අමුතුම විදිහේ යෝජනාවක් ලැබෙනවා. ඒ තමයි අතිශය භයානක අපරාධකාරයින් ඉන්න හිරගෙදරකට ගිහින්, එහෙ ඉන්න සීරියල් කිලර් කෙනෙක් (Serial Killer) කියලා සැකකරන පුද්ගලයෙක් එක්ක යහළුවෙලා එයාගෙන් රහස් තොරතුරු ලබාගන්න එක. එහෙම කළොත් Jimmy ගේ සිරදඬුවම සම්පූර්ණයෙන්ම නිදහස් කරන්න රජයෙන් පොරොන්දු වෙනවා.

හැබැයි මේ භයානක මානසික සටන ඇතුළේ ජීවිතයත් මරණයත් අතර සටනක් කරන්න Jimmy ට සිද්ධ වෙනවා. True Crime සහ Crime Mystery කතා වලට ආස අයට එක හුස්මට බලලා ඉවර කරන්න පුළුවන් සුපිරිම කතා මාලාවක් තමයි මේක.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (Zip) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p WEB-DL වීඩියෝ පිටපත් Telegram චැනලය හරහා ලබාගත හැක.', '2022-01-01', 50, 8.1, 'https://image.tmdb.org/t/p/original/qu312pwM61NPTr7nexvovCClDNP.jpg', '2026-08-06 10:35:58.56554+00', '2026-08-06 10:35:58.56554+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('f6476299-fb90-441d-a3d1-c530d7acc08d', '6d68cd70-3068-491f-a91e-e8e5bbbd03ff', 2, 'Episode 2', '🕵️‍♂️ Black Bird - සිංහල උපසිරැසි 🎬

Black Bird is an acclaimed Apple TV+ crime drama miniseries based on true events. Starring Taron Egerton and Paul Walter Hauser, this intense psychological thriller follows a convicted drug dealer offered freedom in exchange for coaxing a confession from an alleged serial killer inside a maximum-security prison. Download high-quality 720p  WEB-DL video files via Telegram. Experience this gripping masterpiece on pixelpoplk.

ඇත්තම සිදුවීමක් ඇසුරෙන් නිර්මාණය වුණු Black Bird කියන්නේ Apple TV+ නාලිකාවෙන් එළියට ආපු, ලෝකයේම ලොකු කතාබහකට ලක්වුණු Crime / Psychological Thriller කතා මාලාවක්. Taron Egerton, Paul Walter Hauser සහ ප්‍රසිද්ධ රංගන ශිල්පී Ray Liotta ගේ විශිෂ්ට රංගනයන්ගෙන් මේ කතාව අතිශය සාර්ථක එකක් බවට පත්වුණා.

කතාව ගැන කිසිම දෙයක් ස්පොයිල් කරන්නේ නැතුව කිව්වොත්, අවුරුදු 10ක සිරදඬුවමක් ලැබෙන Jimmy Keene කියන තරුණයාට අමුතුම විදිහේ යෝජනාවක් ලැබෙනවා. ඒ තමයි අතිශය භයානක අපරාධකාරයින් ඉන්න හිරගෙදරකට ගිහින්, එහෙ ඉන්න සීරියල් කිලර් කෙනෙක් (Serial Killer) කියලා සැකකරන පුද්ගලයෙක් එක්ක යහළුවෙලා එයාගෙන් රහස් තොරතුරු ලබාගන්න එක. එහෙම කළොත් Jimmy ගේ සිරදඬුවම සම්පූර්ණයෙන්ම නිදහස් කරන්න රජයෙන් පොරොන්දු වෙනවා.

හැබැයි මේ භයානක මානසික සටන ඇතුළේ ජීවිතයත් මරණයත් අතර සටනක් කරන්න Jimmy ට සිද්ධ වෙනවා. True Crime සහ Crime Mystery කතා වලට ආස අයට එක හුස්මට බලලා ඉවර කරන්න පුළුවන් සුපිරිම කතා මාලාවක් තමයි මේක.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (Zip) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p WEB-DL වීඩියෝ පිටපත් Telegram චැනලය හරහා ලබාගත හැක.', '2022-01-01', 50, 8.1, 'https://image.tmdb.org/t/p/original/qu312pwM61NPTr7nexvovCClDNP.jpg', '2026-08-06 10:35:58.56554+00', '2026-08-06 10:35:58.56554+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('29697cb3-9f83-45c5-acde-b6bb98d04f18', '6d68cd70-3068-491f-a91e-e8e5bbbd03ff', 3, 'Episode 3', '🕵️‍♂️ Black Bird - සිංහල උපසිරැසි 🎬

Black Bird is an acclaimed Apple TV+ crime drama miniseries based on true events. Starring Taron Egerton and Paul Walter Hauser, this intense psychological thriller follows a convicted drug dealer offered freedom in exchange for coaxing a confession from an alleged serial killer inside a maximum-security prison. Download high-quality 720p  WEB-DL video files via Telegram. Experience this gripping masterpiece on pixelpoplk.

ඇත්තම සිදුවීමක් ඇසුරෙන් නිර්මාණය වුණු Black Bird කියන්නේ Apple TV+ නාලිකාවෙන් එළියට ආපු, ලෝකයේම ලොකු කතාබහකට ලක්වුණු Crime / Psychological Thriller කතා මාලාවක්. Taron Egerton, Paul Walter Hauser සහ ප්‍රසිද්ධ රංගන ශිල්පී Ray Liotta ගේ විශිෂ්ට රංගනයන්ගෙන් මේ කතාව අතිශය සාර්ථක එකක් බවට පත්වුණා.

කතාව ගැන කිසිම දෙයක් ස්පොයිල් කරන්නේ නැතුව කිව්වොත්, අවුරුදු 10ක සිරදඬුවමක් ලැබෙන Jimmy Keene කියන තරුණයාට අමුතුම විදිහේ යෝජනාවක් ලැබෙනවා. ඒ තමයි අතිශය භයානක අපරාධකාරයින් ඉන්න හිරගෙදරකට ගිහින්, එහෙ ඉන්න සීරියල් කිලර් කෙනෙක් (Serial Killer) කියලා සැකකරන පුද්ගලයෙක් එක්ක යහළුවෙලා එයාගෙන් රහස් තොරතුරු ලබාගන්න එක. එහෙම කළොත් Jimmy ගේ සිරදඬුවම සම්පූර්ණයෙන්ම නිදහස් කරන්න රජයෙන් පොරොන්දු වෙනවා.

හැබැයි මේ භයානක මානසික සටන ඇතුළේ ජීවිතයත් මරණයත් අතර සටනක් කරන්න Jimmy ට සිද්ධ වෙනවා. True Crime සහ Crime Mystery කතා වලට ආස අයට එක හුස්මට බලලා ඉවර කරන්න පුළුවන් සුපිරිම කතා මාලාවක් තමයි මේක.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (Zip) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p WEB-DL වීඩියෝ පිටපත් Telegram චැනලය හරහා ලබාගත හැක.', '2022-01-01', 50, 8.1, 'https://image.tmdb.org/t/p/original/qu312pwM61NPTr7nexvovCClDNP.jpg', '2026-08-06 10:35:58.56554+00', '2026-08-06 10:35:58.56554+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('404f1629-37fd-4d77-ad55-8a148be43f8b', '6d68cd70-3068-491f-a91e-e8e5bbbd03ff', 4, 'Episode 4', '🕵️‍♂️ Black Bird - සිංහල උපසිරැසි 🎬

Black Bird is an acclaimed Apple TV+ crime drama miniseries based on true events. Starring Taron Egerton and Paul Walter Hauser, this intense psychological thriller follows a convicted drug dealer offered freedom in exchange for coaxing a confession from an alleged serial killer inside a maximum-security prison. Download high-quality 720p  WEB-DL video files via Telegram. Experience this gripping masterpiece on pixelpoplk.

ඇත්තම සිදුවීමක් ඇසුරෙන් නිර්මාණය වුණු Black Bird කියන්නේ Apple TV+ නාලිකාවෙන් එළියට ආපු, ලෝකයේම ලොකු කතාබහකට ලක්වුණු Crime / Psychological Thriller කතා මාලාවක්. Taron Egerton, Paul Walter Hauser සහ ප්‍රසිද්ධ රංගන ශිල්පී Ray Liotta ගේ විශිෂ්ට රංගනයන්ගෙන් මේ කතාව අතිශය සාර්ථක එකක් බවට පත්වුණා.

කතාව ගැන කිසිම දෙයක් ස්පොයිල් කරන්නේ නැතුව කිව්වොත්, අවුරුදු 10ක සිරදඬුවමක් ලැබෙන Jimmy Keene කියන තරුණයාට අමුතුම විදිහේ යෝජනාවක් ලැබෙනවා. ඒ තමයි අතිශය භයානක අපරාධකාරයින් ඉන්න හිරගෙදරකට ගිහින්, එහෙ ඉන්න සීරියල් කිලර් කෙනෙක් (Serial Killer) කියලා සැකකරන පුද්ගලයෙක් එක්ක යහළුවෙලා එයාගෙන් රහස් තොරතුරු ලබාගන්න එක. එහෙම කළොත් Jimmy ගේ සිරදඬුවම සම්පූර්ණයෙන්ම නිදහස් කරන්න රජයෙන් පොරොන්දු වෙනවා.

හැබැයි මේ භයානක මානසික සටන ඇතුළේ ජීවිතයත් මරණයත් අතර සටනක් කරන්න Jimmy ට සිද්ධ වෙනවා. True Crime සහ Crime Mystery කතා වලට ආස අයට එක හුස්මට බලලා ඉවර කරන්න පුළුවන් සුපිරිම කතා මාලාවක් තමයි මේක.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (Zip) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p WEB-DL වීඩියෝ පිටපත් Telegram චැනලය හරහා ලබාගත හැක.', '2022-01-01', 50, 8.1, 'https://image.tmdb.org/t/p/original/qu312pwM61NPTr7nexvovCClDNP.jpg', '2026-08-06 10:35:58.56554+00', '2026-08-06 10:35:58.56554+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('7ca0d09a-8ef1-475a-ac9f-47662ef8fe1d', '6d68cd70-3068-491f-a91e-e8e5bbbd03ff', 5, 'Episode 5', '🕵️‍♂️ Black Bird - සිංහල උපසිරැසි 🎬

Black Bird is an acclaimed Apple TV+ crime drama miniseries based on true events. Starring Taron Egerton and Paul Walter Hauser, this intense psychological thriller follows a convicted drug dealer offered freedom in exchange for coaxing a confession from an alleged serial killer inside a maximum-security prison. Download high-quality 720p  WEB-DL video files via Telegram. Experience this gripping masterpiece on pixelpoplk.

ඇත්තම සිදුවීමක් ඇසුරෙන් නිර්මාණය වුණු Black Bird කියන්නේ Apple TV+ නාලිකාවෙන් එළියට ආපු, ලෝකයේම ලොකු කතාබහකට ලක්වුණු Crime / Psychological Thriller කතා මාලාවක්. Taron Egerton, Paul Walter Hauser සහ ප්‍රසිද්ධ රංගන ශිල්පී Ray Liotta ගේ විශිෂ්ට රංගනයන්ගෙන් මේ කතාව අතිශය සාර්ථක එකක් බවට පත්වුණා.

කතාව ගැන කිසිම දෙයක් ස්පොයිල් කරන්නේ නැතුව කිව්වොත්, අවුරුදු 10ක සිරදඬුවමක් ලැබෙන Jimmy Keene කියන තරුණයාට අමුතුම විදිහේ යෝජනාවක් ලැබෙනවා. ඒ තමයි අතිශය භයානක අපරාධකාරයින් ඉන්න හිරගෙදරකට ගිහින්, එහෙ ඉන්න සීරියල් කිලර් කෙනෙක් (Serial Killer) කියලා සැකකරන පුද්ගලයෙක් එක්ක යහළුවෙලා එයාගෙන් රහස් තොරතුරු ලබාගන්න එක. එහෙම කළොත් Jimmy ගේ සිරදඬුවම සම්පූර්ණයෙන්ම නිදහස් කරන්න රජයෙන් පොරොන්දු වෙනවා.

හැබැයි මේ භයානක මානසික සටන ඇතුළේ ජීවිතයත් මරණයත් අතර සටනක් කරන්න Jimmy ට සිද්ධ වෙනවා. True Crime සහ Crime Mystery කතා වලට ආස අයට එක හුස්මට බලලා ඉවර කරන්න පුළුවන් සුපිරිම කතා මාලාවක් තමයි මේක.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (Zip) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p WEB-DL වීඩියෝ පිටපත් Telegram චැනලය හරහා ලබාගත හැක.', '2022-01-01', 50, 8.1, 'https://image.tmdb.org/t/p/original/qu312pwM61NPTr7nexvovCClDNP.jpg', '2026-08-06 10:35:58.56554+00', '2026-08-06 10:35:58.56554+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('277b2b37-35f3-4a97-a0d9-4da2f5c78e59', '6d68cd70-3068-491f-a91e-e8e5bbbd03ff', 6, 'Episode 6', '🕵️‍♂️ Black Bird (2022) - සිංහල උපසිරැසි 🎬

Black Bird is an acclaimed Apple TV+ crime drama miniseries based on true events. Starring Taron Egerton and Paul Walter Hauser, this intense psychological thriller follows a convicted drug dealer offered freedom in exchange for coaxing a confession from an alleged serial killer inside a maximum-security prison. Download high-quality 720p  WEB-DL video files via Telegram. Experience this gripping masterpiece on pixelpoplk.

ඇත්තම සිදුවීමක් ඇසුරෙන් නිර්මාණය වුණු Black Bird කියන්නේ Apple TV+ නාලිකාවෙන් එළියට ආපු, ලෝකයේම ලොකු කතාබහකට ලක්වුණු Crime / Psychological Thriller කතා මාලාවක්. Taron Egerton, Paul Walter Hauser සහ ප්‍රසිද්ධ රංගන ශිල්පී Ray Liotta ගේ විශිෂ්ට රංගනයන්ගෙන් මේ කතාව අතිශය සාර්ථක එකක් බවට පත්වුණා.

කතාව ගැන කිසිම දෙයක් ස්පොයිල් කරන්නේ නැතුව කිව්වොත්, අවුරුදු 10ක සිරදඬුවමක් ලැබෙන Jimmy Keene කියන තරුණයාට අමුතුම විදිහේ යෝජනාවක් ලැබෙනවා. ඒ තමයි අතිශය භයානක අපරාධකාරයින් ඉන්න හිරගෙදරකට ගිහින්, එහෙ ඉන්න සීරියල් කිලර් කෙනෙක් (Serial Killer) කියලා සැකකරන පුද්ගලයෙක් එක්ක යහළුවෙලා එයාගෙන් රහස් තොරතුරු ලබාගන්න එක. එහෙම කළොත් Jimmy ගේ සිරදඬුවම සම්පූර්ණයෙන්ම නිදහස් කරන්න රජයෙන් පොරොන්දු වෙනවා.

හැබැයි මේ භයානක මානසික සටන ඇතුළේ ජීවිතයත් මරණයත් අතර සටනක් කරන්න Jimmy ට සිද්ධ වෙනවා. True Crime සහ Crime Mystery කතා වලට ආස අයට එක හුස්මට බලලා ඉවර කරන්න පුළුවන් සුපිරිම කතා මාලාවක් තමයි මේක.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (Zip) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p WEB-DL වීඩියෝ පිටපත් Telegram චැනලය හරහා ලබාගත හැක.', '2022-01-01', 50, 8.1, 'https://image.tmdb.org/t/p/original/qu312pwM61NPTr7nexvovCClDNP.jpg', '2026-08-06 10:35:58.56554+00', '2026-08-06 10:35:58.56554+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('4362e2ea-881e-443e-afac-e31cff51c169', '6d2489a4-b5aa-49c4-a658-5e50fa711912', 1, 'Episode 1', '🕵️‍♂️ Our Sticky Love (2026) - සිංහල උපසිරැසි 🎬

Our Sticky Love delivers a sweet yet action-packed romantic comedy centered on an unexpected cohabitation. An ambitious prosecutor loses her memory and finds herself hiding in a countryside village with a mysterious boxing coach who claims to be her boyfriend to protect her from a crime syndicate. Download high-quality 720p, 1080p WEB-DL video files directly or via Telegram on pixelpoplk.

ඔන්න අරගෙන ආවා Romantic Comedy, Action සහ Thriller කියන හැම රසයක්ම එකතු කරපු, Netflix හරහා නිකුත් වුණු අලුත්ම සුපිරි කොරියානු කතා මාලාව. D.P. සහ Love Next Door කතා මාලා හරහා අතිශය ජනප්‍රිය වුණු Jung Hae-in සහ දක්ෂ නිළි Ha Young ප්‍රධාන චරිත නිරූපණය කරන Our Sticky Love කියන්නේ නිකුත් වුණු දවසේ ඉඳලම ලෝකයේම ලොකු ප්‍රේක්ෂක අවධානයක් දිනාගත්තු අපූරු නිර්මාණයක්.

කතාව ගැන කිසිම දෙයක් ස්පොයිල් කරන්නේ නැතුව සරලවම කිව්වොත්, දූෂිත දේශපාලකයින් සහ මැර කල්ලියක් ගැන පරීක්ෂණ පවත්වන දක්ෂ රජයේ නීතිඥවරියක් වන Go Eun-sae ට මුහුණ දීමට සිදුවන අනතුරකින් පසුව ඇගේ මතකය සම්පූර්ණයෙන්ම අහිමි වෙනවා. ඇයව මරා දැමීමට මැර කල්ලියක් ලුහුබඳින අතරතුර, බොක්සිං පුහුණුකරුවෙකු සහ හිටපු මැරයෙකු වන Jang Tae-ha ඇයට හමුවෙනවා. ඇයව බේරාගැනීමේ අරමුණින් ඔහු තමන් ඇගේ පෙම්වතා බව පවසමින් බොරුවක් ගොතා ඇයව සාම්ප්‍රදායික පැණිරස රසකැවිලි සදන අපූරු ගම්මානයකට රැගෙන යනවා. මතකය අහිමි වූ ඇය සහ බොරු පෙම්වතෙක් වූ ඔහු අතර ඇතිවන මේ "ඇලෙන සුළු" ආදර කතාව මැරයින්ගෙන් බේරී අවසාන වන්නේ කෙසේද?

Kim Jang-han ගේ අධ්‍යක්ෂණයෙන් හැඩවුණු, හාස්‍යය, ආදරය මෙන්ම කුතුහලය පිරි මේ කතා මාලාව අනිවාර්යයෙන්ම ඔයාගේ Must Watch ලිස්ට් එකට එකතු කරගන්න ඕනේ එකක්.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: වීඩියෝව සමඟ උපසිරැසි නැරඹීමට කැමති අය සඳහා 720p, 1080p උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2026-01-01', 50, 8.4, 'https://image.tmdb.org/t/p/original/tSZ4aFpTGc8Oj52SuzPUUZ7WKL0.jpg', '2026-08-08 08:30:23.609856+00', '2026-08-08 08:30:23.609856+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('c077b68a-7209-46bb-a2a5-0c6f34d726c0', '4e2222e6-e565-426a-a473-df805e1bdcbe', 1, 'Episode 1', '🕵️‍♂️ The Night Of - සිංහල උපසිරැසි 🎬

The Night Of delivers a gripping, award-winning crime drama miniseries from HBO. After a night of partying with a mysterious stranger, a Pakistani-American student wakes up to find her stabbed to death and becomes the prime suspect in a complex murder trial. Download high-quality 720p Blu-Ray video files directly or via Telegram on pixelpoplk.

ඔන්න අරගෙන ආවා Crime, Mystery සහ Thriller ගණයේ රසිකයින්ට මඟහැරගන්නම බැරි, HBO නාලිකාව හරහා විකාශනය වුණු අතිශය ජනප්‍රිය වගේම සම්මානනීය මිනි-කතා මාලාවක්. එමී සම්මාන (Emmy Awards) පහක් දිනාගත්, IMDb හි 8.4/10 ක ඉහළම අගයක් හිමිකරගත් The Night Of කියන්නේ මුල සිට අගටම කුතුහලය උපරිමයෙන්ම පවත්වාගෙන යන විශිෂ්ටතම නිර්මාණයක්.👈

කතාව ගැන කිසිම දෙයක් ස්පොයිල් කරන්නේ නැතුව සරලවම කිව්වොත්, නිව්යෝර්ක් නුවර ජීවත් වන පකිස්ථාන-ඇමරිකානු තරුණයෙක් වන නසීර් "නෑස්" ඛාන් (Riz Ahmed), සාදයකට යාම සඳහා තමන්ගේ පියාගේ කුලී රථය රැගෙන යනවා. මඟදී ඔහුට මුණගැසෙන අද්භූත තරුණියක් සමඟ ගතකරන රාත්‍රියකින් පසු ඔහු නින්දෙන් ඇහැරෙන්නේ ඇය කෲර ලෙස ඝාතනය කර තිබෙනවා දකිමින්. කිසිවක් කරකියාගත නොහැකි වන ඔහු පොලිස් අත්අඩංගුවට පත්වෙන අතර, නීතීඥ ජෝන් ස්ටෝන් (John Turturro) ඔහු වෙනුවෙන් පෙනී සිටීමට ඉදිරිපත් වෙනවා. නසීර් ඇත්තටම ඝාතකයාද? නැතහොත් ඔහු සැඟවුණු දේශපාලන හා සාමාජීය කුමන්ත්‍රණයක ගොදුරක්ද?🤔

Riz Ahmed සහ John Turturro ගේ විශිෂ්ටතම රංගනයෙන් හැඩවුණු, මොහොතින් මොහොත උද්වේගකර බව වැඩිවන මේ කතා මාලාව අනිවාර්යයෙන්ම නැරඹිය යුතු එකක්.✅

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p  උසස් තත්ත්වයේ Bluray වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2016-01-01', 50, 8.4, 'https://image.tmdb.org/t/p/original/q13XJHdnsmxQL9rXRcnNDrZGHjO.jpg', '2026-08-08 11:01:21.636301+00', '2026-08-08 11:01:21.636301+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('5d70828e-c365-4aed-a64f-2f6582f9cd0b', '40101ea4-8f61-4afe-a5ce-836fee184982', 8, 'Episode 8', '🐉 House of the Dragon: Season 3 (Episode 08 - Season Finale) - සිංහල උපසිරැසි 🎬

The epic Dance of the Dragons reaches its jaw-dropping conclusion in Episode 08, the highly anticipated Season Finale of House of the Dragon Season 3. Before witnessing the climax, remember the devastating dragon battles, tragic deaths, and shocking betrayals that brought Westeros to the brink of ashes. Download high-quality 720p and 1080p WEB-DL video files with Sinhala subtitles directly or via Telegram. Witness the fire and blood on pixelpoplk.

ඔන්න මචංලා, මුළු ලෝකයක්ම පිස්සුවෙන් වගේ මඟබලන් හිටපු House of the Dragon 3 වෙනි සීසන් එකේ අවසාන එපිසෝඩ් එක (Episode 08) තමයි මේ අරගෙන එන්නේ. 

මේ දැවැන්ත අවසාන කොටස බලන්න කලින්, පහුගිය කොටස් 7 පුරාවටම වුණු ප්‍රධාන සිදුවීම් ටිකක් අපි මතක් කරගමු. අමතක වෙලා තියෙනවා නම් මේ ටික කියවලාම Finale එක බලන්න යන්න.

පහුගිය කොටස් වලදී අපි දැක්කා Greens ලගේ පැත්තේ හිටපු ප්‍රබලයෙක් වුණු Sir Criston Cole ට Butcher''s Ball වලදී අවාසනාවන්ත විදිහට තමන්ගේ ජීවිතයෙන් සමුගන්න සිද්ධ වෙනවා. ඒ වගේම ඒමන්ඩ් (Aemond) Harrenhal වලට ගිහින් Alys Rivers එක්ක එකතුවෙලා අලුත් මකර බිත්තර 5ක් හොයාගන්න හැටිත් අපි දැක්කා. කිසිම කෙනෙක් බලාපොරොත්තු නොවුණු විදිහට මුහුදු සර්පයා, ඒ කියන්නේ Corlys Velaryon ව සතුරන්ගේ අත්අඩංගුවට පත් වුණා.

අනිත් පැත්තෙන් ඩේමන් වෙස්වළාගෙන රහසිගතව King''s Landing වලට ඇවිත් සතුරන්ව දඩයම් කරන අලුත් මෙහෙයුම් දියත් කළා. රේනිරා Iron Throne එකේ බලය අල්ලගෙන හිටියත්, ඇයටත් ඒකෙන් තුවාල වෙලා සිහසුනෙන් ප්‍රතික්ෂේප වෙන ලකුණු තමයි පහළ වුණේ. ඒ මදිවට අලුතින් ඩ්‍රැගන්ලා ලබාගත්ත Ulf සහ Hugh ගේ හැසිරීම් නිසාත් රේනිරාගේ කඳවුර ඇතුළේ අලුත් ප්‍රශ්න මතු වෙන්න පටන් ගත්තා. මේ අතරේ හෙලේනා දකින හීන සහ ඇයගේ හැසිරීම් කතාවේ ලොකු අභිරහසක් ඉතුරු කළා.

මේ හැම සිදුවීමක්ම එකතුවෙලා, දැන් ආපහු හැරෙන්න බැරි මහා විනාශයකට තමයි පාර හැදිලා තියෙන්නේ. මේ ඔක්කොම ගැටුම් වල අවසාන ප්‍රතිඵලය විදිහට මුළු වෙස්ටරෝස් මහද්වීපයම ගිනි ගන්න මහා යුද්ධයේ තීරණාත්මකම කඩඉම තමයි මේ ෆිනාලේ එපිසෝඩ් එකෙන් බලාගන්න පුළුවන් වෙන්නේ. 

වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

✅Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✅Telegram Download: 720p, 1080p සහ 4K උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2026-01-01', 50, 8.5, 'https://image.tmdb.org/t/p/original/7V0Ebks0GgpKvQ7QbLAIdX5dos4.jpg', '2026-08-09 18:17:04.550544+00', '2026-08-09 18:17:04.550544+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('f89bcda6-40d8-412f-a0b3-09a8f1a0f9cb', '73c3fd9e-1f00-4fe7-a156-e1dc0ae06a9f', 3, 'Episode 3', '🕵️‍♂️ The Walking Dead: Dead City (Season 03, Episode 03) - සිංහල උපසිරැසි 🎬🧟‍♂️

​The Walking Dead: Dead City returns with an intense, action-packed third episode in Season 3! As Maggie and Negan navigate the brutal, walker-infested ruins of post-apocalyptic Manhattan, new threats emerge and fragile alliances are pushed to the absolute limit. Expect high-stakes tension, brutal survival choices, and shocking twists in this latest chapter. Download high-quality 720p and 1080p WEB-DL video files directly or via Telegram on pixelpoplk!

📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

1. වෙබ් අඩවියෙන් Subtitles ලබාගැනීමට:

පියවර 01: මුලින්ම Dirrect Download Button එක ක්ලික් කරන්න.

පියවර 02: ඉන්පසු තත්පර 5ක් රැඳී සිට Ad එක ටිකක් වෙලා බලලා Back උනාම කොලපාට  download button එකක් එයි.

පියවර 03: දැන් Start Download ක්ලික් කරන්න. එවිට Subtitle ෆයිල් එක Zip File එකක් ලෙස ඩවුන්ලෝඩ් වේවි.

භාවිතා කරන ආකාරය: එම Zip ෆයිල් එක Extract (Unzip) කර, ඔබගේ Video Player එකට Add කරගෙන උපසිරැසි සමඟින් රසවිඳින්න.

2. Telegram හරහා Direct ලබාගැනීමට:
මෙහි ඇති Telegram Download Button එක ක්ලික් කරන්න.

එවිට අපගේ Telegram Bot මඟින් Movie  එක්හෝ TV Series Episode එක සෘජුවම ඔබට ලබා දෙනු ඇත.

එතැනින් ඉතා පහසුවෙන් ඩවුන්ලෝඩ් කර නැරඹීමේ හැකියාව පවතී.

📌 අලුත්ම Updates ලබාගැනීමට:

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', '2023-01-01', 50, 7, 'https://image.tmdb.org/t/p/original/seYokxOjFyTVX13XgD2FNjWIry8.jpg', '2026-08-10 13:02:14.876293+00', '2026-08-10 13:02:14.876293+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('6500a301-1ada-468c-ad26-7c954834a971', '18944e7f-ca0e-4ec1-aa46-83a127da60fc', 1, 'Episode 1', '🕵️‍♂️ The Sopranos Season 3 - සිංහල උපසිරැසි 🎬

The Sopranos Season 3 returns with the aftermath of an intense second season. After dealing with shocking family pressure, tragic losses, and inside informants, Tony Soprano must now face new federal threats, rising tensions within his crew, and fresh challenges at home. Download high-quality 720p, 1080p bluray video files directly or via Telegram on pixelpoplk.

ඔන්න යාළුවනේ, සර්වකාලීන විශිෂ්ටතම Crime-Drama ටෙලි කතා මාලාව විදිහට සැලකෙන HBO හි ''The Sopranos'' හි 3 වැනි කතා සමයට (Season 3) සිංහල උපසිරැසි අරගෙන ආවා. 3 වැනි කතා සමය බලන්න කලින්, කලින් කතා සමයේ (Season 2) සිද්ධ වුණු ප්‍රධාන සිදුවීම් ටිකක් මතක් කරගන්න එක ඔයාලට ගොඩක් වටිනවා. IMDb හි 9.2/10 ක අති විශාල අගයක් ලබාගෙන තියෙන මේ කතා මාලාව හැමෝම අනිවාර්යයෙන්ම නැරඹිය යුතු එකක්.

පසුගිය කතා සමයේදී (Season 2) ටෝනි සෝප්‍රානෝට තමන්ගේ පවුල ඇතුළෙන්ම වගේම මැර කල්ලිය ඇතුළෙන් ලොකු ප්‍රශ්න රැසකට මුහුණ දෙන්න වුණා. විශේෂයෙන්ම හිරෙන් නිදහස් වෙලා එන රිචී ඇප්‍රිල් (Richie Aprile) ගේ ආගමනය සහ ටෝනිගේ සහෝදරිය වන ජැනිස් (Janice) සමඟ ඔහු ඇති කරගන්නා සබඳතාවය මුළු කල්ලියම කැළඹීමට පත් කළා. ඒ වගේම ටෝනිගේ ළඟම මිතුරෙකු වූ බිග් පුසී (Big Pussy) එෆ්.බී.අයි (FBI) ඔත්තුකරුවෙකු බව හෙළිවීම සහ ඔහුගේ අවසානය පසුගිය සමයේ දකින්න ලැබුණු වඩාත්ම සංවේදී සිදුවීමක් වුණා.

මෙන්න මේ වගේ සංකීර්ණ සිදුවීම් දාමයකින් පස්සේ ආරම්භ වෙන 3 වැනි කතා සමයෙන්, ටෝනිට තමන්ගේ පවුල රැකගන්න, දරුවන්ගේ ප්‍රශ්න විසඳන්න වගේම එෆ්.බී.අයි එකෙන් එල්ල වන දැඩි පීඩනය හමුවේ තමන්ගේ අධිරාජ්‍යය රැකගන්න සිද්ධ වෙනවා. අලුත් සතුරන් සහ තවත් නොසිතූ පාවාදීම් රැසක් එක්ක ගලාගෙන යන The Sopranos Season 3 අනිවාර්යයෙන්ම ඔයාලගේ කුතුහලය උපරිමයටම ගෙන යනවා නොඅනුමානයි.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p, 1080p උසස් තත්ත්වයේ bluray වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2001-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/fg2sTwO5FglA1S6prL7GlCo124n.jpg', '2026-08-11 13:42:49.900781+00', '2026-08-11 13:42:49.900781+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('79a6a3d1-abe2-48c2-a772-614c0993c91e', '18944e7f-ca0e-4ec1-aa46-83a127da60fc', 2, 'Episode 2', '🕵️‍♂️ The Sopranos Season 3 Episode 2 - සිංහල උපසිරැසි 🎬

In The Sopranos Season 3 Episode 2, Tony Soprano faces new federal threats, rising tensions within his crew, and fresh challenges at home. Download high-quality 720p, 1080p bluray video files directly or via Telegram on pixelpoplk.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p, 1080p උසස් තත්ත්වයේ bluray වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2001-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/fg2sTwO5FglA1S6prL7GlCo124n.jpg', '2026-08-11 13:42:49.900781+00', '2026-08-11 13:42:49.900781+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('2a6b5e0f-9f75-4c5e-a309-4f6c7796893a', '18944e7f-ca0e-4ec1-aa46-83a127da60fc', 3, 'Episode 3', '🕵️‍♂️ The Sopranos Season 3 Episode 3 - සිංහල උපසිරැසි 🎬

In The Sopranos Season 3 Episode 3, Tony Soprano and his crew deal with shocking family pressure, tragic losses, and inside informants. Download high-quality 720p, 1080p bluray video files directly or via Telegram on pixelpoplk.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p, 1080p උසස් තත්ත්වයේ bluray වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2001-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/fg2sTwO5FglA1S6prL7GlCo124n.jpg', '2026-08-11 13:42:49.900781+00', '2026-08-11 13:42:49.900781+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('84df7b6b-7c82-4c60-a33e-36f05ae56adb', '18944e7f-ca0e-4ec1-aa46-83a127da60fc', 4, 'Episode 4', '🕵️‍♂️ The Sopranos Season 3 Episode 4 - සිංහල උපසිරැසි 🎬

In The Sopranos Season 3 Episode 4, new federal threats and rising tensions within his crew challenge Tony Soprano. Download high-quality 720p, 1080p bluray video files directly or via Telegram on pixelpoplk.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p, 1080p උසස් තත්ත්වයේ bluray වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2001-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/fg2sTwO5FglA1S6prL7GlCo124n.jpg', '2026-08-11 13:42:49.900781+00', '2026-08-11 13:42:49.900781+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('3690aa9b-b712-4704-a57b-3c692eb0e81f', '18944e7f-ca0e-4ec1-aa46-83a127da60fc', 5, 'Episode 5', '🕵️‍♂️ The Sopranos Season 3 Episode 5 - සිංහල උපසිරැසි 🎬

In The Sopranos Season 3 Episode 5, Tony Soprano must face fresh challenges at home and rise above the pressure. Download high-quality 720p, 1080p bluray video files directly or via Telegram on pixelpoplk.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p, 1080p උසස් තත්ත්වයේ bluray වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2001-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/fg2sTwO5FglA1S6prL7GlCo124n.jpg', '2026-08-11 13:42:49.900781+00', '2026-08-11 13:42:49.900781+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('94d992a4-af51-4c35-a399-a9d6fb095f2c', '672b0d61-4b51-4c36-a1ac-0e59ba524723', 1, 'Episode 1', '🕵️‍♂️ Reacher Season 4 Episode 1 - සිංහල උපසිරැසි 🎬

Reacher Season 4 Episode 1 delivers the highly anticipated return of television''s ultimate wanderer. Before diving into this brand new chapter of conspiracy and action, let''s take a quick journey back to Reacher''s past adventures—from uncovering the corruption in Margrave, to avenging his fallen military comrades, and surviving a deadly undercover mission. Download high-quality 720p, 1080p WEB-DL video files directly or via Telegram on pixelpoplk.

ඔන්න යාළුවනේ, ලෝක පුරා අතිශය ජනප්‍රිය වුණු, ඇමසන් ප්‍රයිම් (Prime Video) හරහා විකාශනය ආරම්භ වුණු Reacher කතා මාලාවේ 4 වැනි කතා සමයේ (Season 4) පළමු වැනි කොටසට (Episode 1) සිංහල උපසිරැසි අරගෙන ආවා. මේ අලුත්ම සීසන් එක බලන්න පටන් ගන්න කලින්, කලින් කතා සමයන් 1, 2 සහ 3 තුළින් රීචර් ආපු ගමන කෙටියෙන් මතක් කරගන්න එක ඔයාලට ගොඩක් වටිනවා.

පළමු කතා සමයේදී (Season 1) මාග්‍රේව් (Margrave) නම් කුඩා නගරයේ සිදුවූ තමන්ගේ සහෝදරයාගේ ඝාතනයට පලිගැනීම සඳහා නගරයේ රහස්‍ය කල්ලියක් සහ දූෂිත පොලිසියක් මුළුමනින්ම විනාශ කිරීමට රීචර් සමත් වුණා. දෙවන කතා සමයේදී (Season 2) තමන්ගේ පැරණි හමුදා ඒකකයේ (110th Special Investigators) මිතුරන් පාවාදී මරා දැමූ දූෂිත ආයුධ ජාවාරම්කරුවන් කල්ලියක් සොයා ගොස් තමන්ගේ මිතුරන් වෙනුවෙන් යුක්තිය ඉටු කරන්න ඔහුට සිද්ධ වුණා. පසුගිය තුන්වන කතා සමයේදී (Season 3) දරුණු ජාවාරම්කරුවන් පිරිසක් කොටු කරගැනීම සඳහා රීචර් අතිශය අවදානම් සහගත රහසිගත මෙහෙයුමකට (Undercover) සම්බන්ධ වෙමින් දැවැන්ත සටනක් දියත් කළා.

මෙන්න මේ විදිහට හැම තැනකදීම තමන්ගේ ශාරීරික ශක්තිය සහ අසමසම බුද්ධිය උපයෝගී කරගෙන සතුරන් මෙල්ල කරපු ජැක් රීචර්, මේ 4 වැනි කතා සමයෙන් තවත් අලුත්ම දේශපාලන සහ රහස් ඔත්තු සේවා කුමන්ත්‍රණයකට මැදි වෙනවා. Alan Ritchson ගේ සුපිරි රංගනය සහ සුපිරි සටන් දර්ශන රැසක් සමඟින් ඇරඹෙන Reacher Season 4 හි පළමු කොටස කිසිසේත්ම මඟහැරගන්න එපා.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: වීඩියෝව සමඟ උපසිරැසි නැරඹීමට කැමති අය සඳහා 720p, 1080p උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2026-01-01', 50, 8.1, 'https://image.tmdb.org/t/p/original/wkKJHC34dIw9cJwAfNEEgDdb2ol.jpg', '2026-08-12 08:51:51.598699+00', '2026-08-12 08:51:51.598699+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('81d0c1d0-e77e-40a9-af58-d1897beeb4b2', '672b0d61-4b51-4c36-a1ac-0e59ba524723', 2, 'Episode 2', '🕵️‍♂️ Reacher Season 4 Episode 2 - සිංහල උපසිරැසි 🎬

Reacher Season 4 Episode 2 continues the thrilling adventure of television''s ultimate wanderer. Jack Reacher dives deeper into a web of conspiracy, lies, and high-stakes action. Download high-quality 720p, 1080p WEB-DL video files directly or via Telegram on pixelpoplk.

ඔන්න යාළුවනේ, ඇමසන් ප්‍රයිම් (Prime Video) හරහා විකාශනය වන Reacher කතා මාලාවේ 4 වැනි කතා සමයේ (Season 4) දෙවැනි කොටසට (Episode 2) සිංහල උපසිරැසි අරගෙන ආවා. Alan Ritchson ගේ සුපිරි රංගනය සහ සුපිරි ක්‍රියාදාම දර්ශන රැසක් සමඟින් දිගහැරෙන මෙම කොටස කිසිසේත්ම මඟහැරගන්න එපා.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: වීඩියෝව සමඟ උපසිරැසි නැරඹීමට කැමති අය සඳහා 720p, 1080p උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2026-01-01', 50, 8.1, 'https://image.tmdb.org/t/p/original/wkKJHC34dIw9cJwAfNEEgDdb2ol.jpg', '2026-08-12 11:07:22.290595+00', '2026-08-12 11:07:22.290595+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('e45f5826-f0c8-4c03-a1b7-965bc93c55c3', '672b0d61-4b51-4c36-a1ac-0e59ba524723', 3, 'Episode 3', '🕵️‍♂️ Reacher Season 4 Episode 3 - සිංහල උපසිරැසි 🎬

Reacher Season 4 Episode 3 delivers more heart-pounding action and suspense as television''s ultimate wanderer faces new challenges. Dive into the intense and gripping mystery in this brand new episode. Download high-quality 720p, 1080p WEB-DL video files directly or via Telegram on pixelpoplk.

ඔන්න යාළුවනේ, ඇමසන් ප්‍රයිම් (Prime Video) හරහා විකාශනය වන Reacher කතා මාලාවේ 4 වැනි කතා සමයේ (Season 4) තුන්වැනි කොටසට (Episode 3) සිංහල උපසිරැසි අරගෙන ආවා. Alan Ritchson ගේ සුපිරි රංගනය සහ සුපිරි ක්‍රියාදාම දර්ශන රැසක් සමඟින් දිගහැරෙන මෙම කොටස කිසිසේත්ම මඟහැරගන්න එපා.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: වීඩියෝව සමඟ උපසිරැසි නැරඹීමට කැමති අය සඳහා 720p, 1080p උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2026-01-01', 50, 8.1, 'https://image.tmdb.org/t/p/original/wkKJHC34dIw9cJwAfNEEgDdb2ol.jpg', '2026-08-12 11:07:22.290595+00', '2026-08-12 11:07:22.290595+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('bb9f99cd-84be-4c37-a09c-43beb05b4723', '4e2222e6-e565-426a-a473-df805e1bdcbe', 2, 'Episode 2', '🕵️‍♂️ The Night Of Season 1 Episode 2 - සිංහල උපසිරැසි 🎬

The Night Of Season 1 Episode 2 continues the gripping crime drama series. Follow Nasir Khan as he faces the daunting realities of the criminal justice system after a fateful night. Download high-quality 720p Blu-Ray video files directly or via Telegram on pixelpoplk.

ඔන්න අරගෙන ආවා Crime, Mystery සහ Thriller ගණයේ රසිකයින්ට මඟහැරගන්නම බැරි, HBO නාලිකාව හරහා විකාශනය වුණු අතිශය ජනප්‍රිය වගේම සම්මානනීය මිනි-කතා මාලාවක් වන The Night Of හි දෙවැනි කොටසට (Episode 2) සිංහල උපසිරැසි. මුල සිට අගටම කුතුහලය උපරිමයෙන්ම පවත්වාගෙන යන මෙම විශිෂ්ටතම නිර්මාණය කිසිසේත්ම මඟහැරගන්න එපා.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p උසස් තත්ත්වයේ Bluray වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2016-01-01', 50, 8.1, 'https://image.tmdb.org/t/p/original/q13XJHdnsmxQL9rXRcnNDrZGHjO.jpg', '2026-08-12 17:01:42.133751+00', '2026-08-12 17:01:42.133751+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('9ddbbbbf-0b44-43fb-a1cd-ea6fc3734bbc', '4e2222e6-e565-426a-a473-df805e1bdcbe', 3, 'Episode 3', '🕵️‍♂️ The Night Of Season 1 Episode 3 - සිංහල උපසිරැසි 🎬

The Night Of Season 1 Episode 3 dives deeper into the complex trial of Nasir Khan. As John Stone works on the defense, tension rises inside the prison. Download high-quality 720p Blu-Ray video files directly or via Telegram on pixelpoplk.

ඔන්න අරගෙන ආවා Crime, Mystery සහ Thriller ගණයේ රසිකයින්ට මඟහැරගන්නම බැරි, HBO නාලිකාව හරහා විකාශනය වුණු අතිශය ජනප්‍රිය වගේම සම්මානනීය මිනි-කතා මාලාවක් වන The Night Of හි තුන්වැනි කොටසට (Episode 3) සිංහල උපසිරැසි. මුල සිට අගටම කුතුහලය උපරිමයෙන්ම පවත්වාගෙන යන මෙම විශිෂ්ටතම නිර්මාණය කිසිසේත්ම මඟහැරගන්න එපා.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p උසස් තත්ත්වයේ Bluray වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2016-01-01', 50, 8.1, 'https://image.tmdb.org/t/p/original/q13XJHdnsmxQL9rXRcnNDrZGHjO.jpg', '2026-08-12 17:01:42.133751+00', '2026-08-12 17:01:42.133751+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('df2f8ff2-24eb-4eb6-a50c-c12e5809856e', '4e2222e6-e565-426a-a473-df805e1bdcbe', 4, 'Episode 4', '🕵️‍♂️ The Night Of Season 1 Episode 4 - සිංහල උපසිරැසි 🎬

The Night Of Season 1 Episode 4 explores the escalating stakes of Nasir Khan''s legal defense. The investigation uncovers new angles in this mystery. Download high-quality 720p Blu-Ray video files directly or via Telegram on pixelpoplk.

ඔන්න අරගෙන ආවා Crime, Mystery සහ Thriller ගණයේ රසිකයින්ට මඟහැරගන්නම බැරි, HBO නාලිකාව හරහා විකාශනය වුණු අතිශය ජනප්‍රිය වගේම සම්මානනීය මිනි-කතා මාලාවක් වන The Night Of හි හතරවැනි කොටසට (Episode 4) සිංහල උපසිරැසි. මුල සිට අගටම කුතුහලය උපරිමයෙන්ම පවත්වාගෙන යන මෙම විශිෂ්ටතම නිර්මාණය කිසිසේත්ම මඟහැරගන්න එපා.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p උසස් තත්ත්වයේ Bluray වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2016-01-01', 50, 8.1, 'https://image.tmdb.org/t/p/original/q13XJHdnsmxQL9rXRcnNDrZGHjO.jpg', '2026-08-12 17:01:42.133751+00', '2026-08-12 17:01:42.133751+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('165260e9-751f-4b6d-a88c-c40ca426993d', '4e2222e6-e565-426a-a473-df805e1bdcbe', 5, 'Episode 5', '🕵️‍♂️ The Night Of Season 1 Episode 5 - සිංහල උපසිරැසි 🎬

The Night Of Season 1 Episode 5 presents new challenges inside Nasir Khan''s defense team. The prosecution sharpens its case as secrets are revealed. Download high-quality 720p Blu-Ray video files directly or via Telegram on pixelpoplk.

ඔන්න අරගෙන ආවා Crime, Mystery සහ Thriller ගණයේ රසිකයින්ට මඟහැරගන්නම බැරි, HBO නාලිකාව හරහා විකාශනය වුණු අතිශය ජනප්‍රිය වගේම සම්මානනීය මිනි-කතා මාලාවක් වන The Night Of හි පස්වැනි කොටසට (Episode 5) සිංහල උපසිරැසි. මුල සිට අගටම කුතුහලය උපරිමයෙන්ම පවත්වාගෙන යන මෙම විශිෂ්ටතම නිර්මාණය කිසිසේත්ම මඟහැරගන්න එපා.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p උසස් තත්ත්වයේ Bluray වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2016-01-01', 50, 8.1, 'https://image.tmdb.org/t/p/original/q13XJHdnsmxQL9rXRcnNDrZGHjO.jpg', '2026-08-12 17:01:42.133751+00', '2026-08-12 17:01:42.133751+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('77306a79-aa9d-4c6c-a2c4-18ded6a8a449', '4e2222e6-e565-426a-a473-df805e1bdcbe', 6, 'Episode 6', '🕵️‍♂️ The Night Of Season 1 Episode 6 - සිංහල උපසිරැසි 🎬

The Night Of Season 1 Episode 6 unfolds intense courtroom developments. The truth remains elusive as different perspectives clash. Download high-quality 720p Blu-Ray video files directly or via Telegram on pixelpoplk.

ඔන්න අරගෙන ආවා Crime, Mystery සහ Thriller ගණයේ රසිකයින්ට මඟහැරගන්නම බැරි, HBO නාලිකාව හරහා විකාශනය වුණු අතිශය ජනප්‍රිය වගේම සම්මානනීය මිනි-කතා මාලාවක් වන The Night Of හි හයවැනි කොටසට (Episode 6) සිංහල උපසිරැසි. මුල සිට අගටම කුතුහලය උපරිමයෙන්ම පවත්වාගෙන යන මෙම විශිෂ්ටතම නිර්මාණය කිසිසේත්ම මඟහැරගන්න එපා.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p උසස් තත්ත්වයේ Bluray වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2016-01-01', 50, 8.1, 'https://image.tmdb.org/t/p/original/q13XJHdnsmxQL9rXRcnNDrZGHjO.jpg', '2026-08-12 17:01:42.133751+00', '2026-08-12 17:01:42.133751+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('fdc7af4b-e7bb-48ea-af1e-f0e8ea3558e9', '4e2222e6-e565-426a-a473-df805e1bdcbe', 7, 'Episode 7', '🕵️‍♂️ The Night Of Season 1 Episode 7 - සිංහල උපසිරැසි 🎬

The Night Of Season 1 Episode 7 reaches high-stakes courtroom testimony. The defense fights against growing odds to protect Nasir. Download high-quality 720p Blu-Ray video files directly or via Telegram on pixelpoplk.

ඔන්න අරගෙන ආවා Crime, Mystery සහ Thriller ගණයේ රසිකයින්ට මඟහැරගන්නම බැරි, HBO නාලිකාව හරහා විකාශනය වුණු අතිශය ජනප්‍රිය වගේම සම්මානනීය මිනි-කතා මාලාවක් වන The Night Of හි හත්වැනි කොටසට (Episode 7) සිංහල උපසිරැසි. මුල සිට අගටම කුතුහලය උපරිමයෙන්ම පවත්වාගෙන යන මෙම විශිෂ්ටතම නිර්මාණය කිසිසේත්ම මඟහැරගන්න එපා.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p උසස් තත්ත්වයේ Bluray වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2016-01-01', 50, 8.1, 'https://image.tmdb.org/t/p/original/q13XJHdnsmxQL9rXRcnNDrZGHjO.jpg', '2026-08-12 17:01:42.133751+00', '2026-08-12 17:01:42.133751+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('f0e86235-31eb-4885-acfa-a4d6efd59db4', '4e2222e6-e565-426a-a473-df805e1bdcbe', 8, 'Episode 8', '🕵️‍♂️ The Night Of Season 1 Episode 8 - සිංහල උපසිරැසි 🎬

The Night Of Season 1 Episode 8 delivers the dramatic and stunning conclusion to Nasir Khan''s trial. Experience the final verdict of this acclaimed HBO masterpiece. Download high-quality 720p Blu-Ray video files directly or via Telegram on pixelpoplk.

ඔන්න අරගෙන ආවා Crime, Mystery සහ Thriller ගණයේ රසිකයින්ට මඟහැරගන්නම බැරි, HBO නාලිකාව හරහා විකාශනය වුණු අතිශය ජනප්‍රිය වගේම සම්මානනීය මිනි-කතා මාලාවක් වන The Night Of හි අටවැනි කොටසට (Episode 8) සිංහල උපසිරැසි. මුල සිට අගටම කුතුහලය උපරිමයෙන්ම පවත්වාගෙන යන මෙම විශිෂ්ටතම නිර්මාණය කිසිසේත්ම මඟහැරගන්න එපා.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p උසස් තත්ත්වයේ Bluray වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2016-01-01', 50, 8.1, 'https://image.tmdb.org/t/p/original/q13XJHdnsmxQL9rXRcnNDrZGHjO.jpg', '2026-08-12 17:01:42.133751+00', '2026-08-12 17:01:42.133751+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('6eeca922-3fd7-4d28-ae70-1f429bfacaf0', '18944e7f-ca0e-4ec1-aa46-83a127da60fc', 6, 'Episode 6', '🕵️‍♂️ The Sopranos Season 3 Episode 6 - සිංහල උපසිරැසි 🎬

The Sopranos Season 3 Episode 6 continues the outstanding drama from HBO. As the stakes rise, Tony Soprano must manage complex conflicts inside his crew while balancing family pressure. Download high-quality 720p, 1080p bluray video files directly or via Telegram on pixelpoplk.

ඔන්න යාළුවනේ, සර්වකාලීන විශිෂ්ටතම Crime-Drama ටෙලි කතා මාලාව විදිහට සැලකෙන HBO හි ''The Sopranos'' හි 3 වැනි කතා සමයේ (Season 3) හයවැනි කොටසට (Episode 6) සිංහල උපසිරැසි අරගෙන ආවා. IMDb හි 9.2/10 ක අති විශාල අගයක් ලබාගෙන තියෙන මේ කතා මාලාව හැමෝම අනිවාර්යයෙන්ම නැරඹිය යුතු එකක්.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p, 1080p උසස් තත්ත්වයේ bluray වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2001-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/fg2sTwO5FglA1S6prL7GlCo124n.jpg', '2026-08-13 13:52:53.403139+00', '2026-08-13 13:52:53.403139+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('c67c45ba-2ea7-4ba8-aff5-107a9ba10726', '18944e7f-ca0e-4ec1-aa46-83a127da60fc', 7, 'Episode 7', '🕵️‍♂️ The Sopranos Season 3 Episode 7 - සිංහල උපසිරැසි 🎬

The Sopranos Season 3 Episode 7 brings another captivating hour of premium television. Watch as the personal lives and business networks of Jersey''s most famous family cross paths. Download high-quality 720p, 1080p bluray video files directly or via Telegram on pixelpoplk.

ඔන්න යාළුවනේ, සර්වකාලීන විශිෂ්ටතම Crime-Drama ටෙලි කතා මාලාව විදිහට සැලකෙන HBO හි ''The Sopranos'' හි 3 වැනි කතා සමයේ (Season 3) හත්වැනි කොටසට (Episode 7) සිංහල උපසිරැසි අරගෙන ආවා. IMDb හි 9.2/10 ක අති විශාල අගයක් ලබාගෙන තියෙන මේ කතා මාලාව හැමෝම අනිවාර්යයෙන්ම නැරඹිය යුතු එකක්.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p, 1080p උසස් තත්ත්වයේ bluray වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2001-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/fg2sTwO5FglA1S6prL7GlCo124n.jpg', '2026-08-13 13:52:53.403139+00', '2026-08-13 13:52:53.403139+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('5989881b-eda7-446e-a368-1257ad207e89', '18944e7f-ca0e-4ec1-aa46-83a127da60fc', 8, 'Episode 8', '🕵️‍♂️ The Sopranos Season 3 Episode 8 - සිංහල උපසිරැසි 🎬

The Sopranos Season 3 Episode 8 delivers highly intense drama and outstanding character-driven suspense. Tony faces challenging decisions as rivals test his limits. Download high-quality 720p, 1080p bluray video files directly or via Telegram on pixelpoplk.

ඔන්න යාළුවනේ, සර්වකාලීන විශිෂ්ටතම Crime-Drama ටෙලි කතා මාලාව විදිහට සැලකෙන HBO හි ''The Sopranos'' හි 3 වැනි කතා සමයේ (Season 3) අටවැනි කොටසට (Episode 8) සිංහල උපසිරැසි අරගෙන ආවා. IMDb හි 9.2/10 ක අති විශාල අගයක් ලබාගෙන තියෙන මේ කතා මාලාව හැමෝම අනිවාර්යයෙන්ම නැරඹිය යුතු එකක්.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p, 1080p උසස් තත්ත්වයේ bluray වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2001-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/fg2sTwO5FglA1S6prL7GlCo124n.jpg', '2026-08-13 13:52:53.403139+00', '2026-08-13 13:52:53.403139+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('00de4c80-2277-49b6-a5b5-1441e7bb5659', '18944e7f-ca0e-4ec1-aa46-83a127da60fc', 9, 'Episode 9', '🕵️‍♂️ The Sopranos Season 3 Episode 9 - සිංහල උපසිරැසි 🎬

The Sopranos Season 3 Episode 9 uncovers new secrets as federal investigators tighten their scope. The family struggles to maintain control amidst internal changes. Download high-quality 720p, 1080p bluray video files directly or via Telegram on pixelpoplk.

ඔන්න යාළුවනේ, සර්වකාලීන විශිෂ්ටතම Crime-Drama ටෙලි කතා මාලාව විදිහට සැලකෙන HBO හි ''The Sopranos'' හි 3 වැනි කතා සමයේ (Season 3) නවවැනි කොටසට (Episode 9) සිංහල උපසිරැසි අරගෙන ආවා. IMDb හි 9.2/10 ක අති විශාල අගයක් ලබාගෙන තියෙන මේ කතා මාලාව හැමෝම අනිවාර්යයෙන්ම නැරඹිය යුතු එකක්.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p, 1080p උසස් තත්ත්වයේ bluray වීඩියෝ  පිටපත්  ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2001-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/fg2sTwO5FglA1S6prL7GlCo124n.jpg', '2026-08-13 13:52:53.403139+00', '2026-08-13 13:52:53.403139+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('ebd0346d-7959-4331-a968-b1261dc03288', '18944e7f-ca0e-4ec1-aa46-83a127da60fc', 10, 'Episode 10', '🕵️‍♂️ The Sopranos Season 3 Episode 10 - සිංහල උපසිරැසි 🎬

The Sopranos Season 3 Episode 10 offers a compelling and tense look at Tony''s complex business world. Personal relationships reach a critical turning point. Download high-quality 720p, 1080p bluray video files directly or via Telegram on pixelpoplk.

ඔන්න යාළුවනේ, සර්වකාලීන විශිෂ්ටතම Crime-Drama ටෙලි කතා මාලාව විදිහට සැලකෙන HBO හි ''The Sopranos'' හි 3 වැනි කතා සමයේ (Season 3) දහවැනි කොටසට (Episode 10) සිංහල උපසිරැසි අරගෙන ආවා. IMDb හි 9.2/10 ක අති විශාල අගයක් ලබාගෙන තියෙන මේ කතා මාලාව හැමෝම අනිවාර්යයෙන්ම නැරඹිය යුතු එකක්.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p, 1080p උසස් තත්ත්වයේ bluray වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2001-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/fg2sTwO5FglA1S6prL7GlCo124n.jpg', '2026-08-13 13:52:53.403139+00', '2026-08-13 13:52:53.403139+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('61068b2c-cf11-4257-aba6-6262003d0d66', '18944e7f-ca0e-4ec1-aa46-83a127da60fc', 11, 'Episode 11', '🕵️‍♂️ The Sopranos Season 3 Episode 11 - සිංහල උපසිරැසි 🎬

The Sopranos Season 3 Episode 11 follows Tony Soprano as he handles unforeseen issues inside his organization. Trust becomes a luxury few can afford. Download high-quality 720p, 1080p bluray video files directly or via Telegram on pixelpoplk.

ඔන්න යාළුවනේ, සර්වකාලීන විශිෂ්ටතම Crime-Drama ටෙලි කතා මාලාව විදිහට සැලකෙන HBO හි ''The Sopranos'' හි 3 වැනි කතා සමයේ (Season 3) එකොළොස්වැනි කොටසට (Episode 11) සිංහල උපසිරැසි අරගෙන ආවා. IMDb හි 9.2/10 ක අති විශාල අගයක් ලබාගෙන තියෙන මේ කතා මාලාව හැමෝම අනිවාර්යයෙන්ම නැරඹිය යුතු එකක්.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p, 1080p උසස් තත්ත්වයේ bluray වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2001-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/fg2sTwO5FglA1S6prL7GlCo124n.jpg', '2026-08-13 13:52:53.403139+00', '2026-08-13 13:52:53.403139+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('101f0c6c-9b1f-4675-aa3f-dc1ad435d2d9', '18944e7f-ca0e-4ec1-aa46-83a127da60fc', 12, 'Episode 12', '🕵️‍♂️ The Sopranos Season 3 Episode 12 - සිංහල උපසිරැසි 🎬

The Sopranos Season 3 Episode 12 sets the stage for a dramatic climax. Tensions rise to an all-time high as secrets threaten to shatter Tony''s authority. Download high-quality 720p, 1080p bluray video files directly or via Telegram on pixelpoplk.

ඔන්න යාළුවනේ, සර්වකාලීන විශිෂ්ටතම Crime-Drama ටෙලි කතා මාලාව විදිහට සැලකෙන HBO හි ''The Sopranos'' හි 3 වැනි කතා සමයේ (Season 3) දොළොස්වැනි කොටසට (Episode 12) සිංහල උපසිරැසි අරගෙන ආවා. IMDb හි 9.2/10 ක අති විශාල අගයක් ලබාගෙන තියෙන මේ කතා මාලාව හැමෝම අනිවාර්යයෙන්ම නැරඹිය යුතු එකක්.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p, 1080p උසස් තත්ත්වයේ bluray වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2001-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/fg2sTwO5FglA1S6prL7GlCo124n.jpg', '2026-08-13 13:52:53.403139+00', '2026-08-13 13:52:53.403139+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('c43533be-e96f-4176-a484-3cc4e71efb0f', '18944e7f-ca0e-4ec1-aa46-83a127da60fc', 13, 'Episode 13', '🕵️‍♂️ The Sopranos Season 3 Episode 13 - සිංහල උපසිරැසි 🎬

The Sopranos Season 3 Episode 13 brings the spectacular and unforgettable season finale. Experience the resolution of major conflicts that set a new path for the family. Download high-quality 720p, 1080p bluray video files directly or via Telegram on pixelpoplk.

ඔන්න යාළුවනේ, සර්වකාලීන විශිෂ්ටතම Crime-Drama ටෙලි කතා මාලාව විදිහට සැලකෙන HBO හි ''The Sopranos'' හි 3 වැනි කතා සමයේ (Season 3) දහතුන්වැනි කොටසට (Episode 13) සිංහල උපසිරැසි අරගෙන ආවා. IMDb හි 9.2/10 ක අති විශාල අගයක් ලබාගෙන තියෙන මේ කතා මාලාව හැමෝම අනිවාර්යයෙන්ම නැරඹිය යුතු එකක්.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p, 1080p උසස් තත්ත්වයේ bluray වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', '2001-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/fg2sTwO5FglA1S6prL7GlCo124n.jpg', '2026-08-13 13:52:53.403139+00', '2026-08-13 13:52:53.403139+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('ae13a875-cf00-446d-a7bf-00a30ac3cbce', '0ad44dce-04c9-49e5-ab78-a0f85ebdbe45', 1, 'Episode 1', '🕵️‍♂️ The Sopranos Season 4 Episode 1 - සිංහල උපසිරැසි 🎬

The Sopranos Season 4 returns with the aftermath of three legendary seasons of intense mob wars, complex therapy sessions, and brutal betrayals. As his marriage with Carmela faces its toughest trial, Christopher struggles with his demons, and the FBI closes in, Tony Soprano must fight to keep both his family and his criminal empire from falling apart. Download high-quality 720p, 1080p Bluray video files directly on pixelpoplk.

ඔන්න යාළුවනේ, හැමදාමත් ලෝකයේ හොඳම ටීවී සීරීස් එකක් විදිහට කතා වෙන, HBO එකෙන් නිකුත් කරපු ''The Sopranos'' කතා මාලාවේ 4 වැනි කතා සමයට (Season 4) සිංහල උපසිරැසි අරගෙන ආවා. මේ අලුත්ම සීසන් එක බලන්න කලින්, කලින් කතා සමයන් 3න් සිද්ධ වුණු දේවල් කෙටියෙන් මතක් කරගන්න එක ඔයාලට ගොඩක් වටිනවා.

පළමු කතා සමයෙන් (Season 1) අපි දැක්කා නිව් ජර්සිවල මාෆියා ලොක්කෙක් වෙන ටෝනි සෝප්‍රානෝ, තමන්ට හැදෙන පැනික් ඇටෑක්ස් (Panic Attacks) නිසා රහසින්ම මනෝවිද්‍යාඥවරියක් (Dr. Melfi) ළඟට ප්‍රතිකාර ගන්න යන හැටි. එතන ඉඳන් එයාට තමන්ගේම අම්මා (Livia) සහ බාප්පා (Uncle Junior) එක්ක ලොකු බල අරගලයකට මුහුණ දෙන්න වුණා. දෙවැනි කතා සමයේදී (Season 2) හිරෙන් නිදහස් වෙලා එන රිචී ඇප්‍රිල් කරදර ඇති කරද්දී, ටෝනිගේ ළඟම මිතුරෙක් වුණු බිග් පුසී එෆ්.බී.අයි (FBI) ඔත්තුකරුවෙක් කියලා හෙළිවෙලා ඔහුගේ අවසානය සිදුවීමට මඟ පෑදුණා. තුන්වැනි කතා සමයෙන් (Season 3) දරුණු ගනයේ මැරයෙක් වෙන රැල්ෆ් සිෆරෙටෝගේ ආගමනයත්, ටෝනිගේ දරුවන්ගේ ප්‍රශ්නත්, එෆ්.බී.අයි එකෙන් ටෝනිගේ නිවසට රහස් කැමරා සහ මයික්‍රෆෝන සවිකරන හැටිත් අපි දැක්කා.

මෙන්න මේ හැම ප්‍රශ්නයක් මැදින්ම ආපු ටෝනි සෝප්‍රානෝට, මේ 4 වැනි කතා සමයෙන් (Season 4) මුහුණ දෙන්න වෙන්නේ වෙනස්ම විදිහේ ප්‍රශ්න වැලකට. මේ සීසන් එකේදී ටෝනි සහ කාමලෙලාගේ විවාහ ජීවිතය බිඳී යාමේ ලොකුම අවදානමකට ලක්වෙනවා. ඒ වගේම ක්‍රිස්ටෝපර් (Christopher) ලොකු වගකීම් කරට ගත්තත් එයාගේ මත්ද්‍රව්‍ය ඇබ්බැහිය නිසා ප්‍රශ්න ඇතිවෙනවා. නිව්යෝර්ක් මාෆියා කල්ලියත් එක්ක තියෙන ගනුදෙනු තවත් සංකීර්ණ වෙන අතරේ, එෆ්.බී.අයි එකෙන් එල්ල වෙන තර්ජනය හැමදාටම වඩා දරුණු වෙනවා.

ටෝනි තමන්ගේ පවුලත්, ව්‍යාපාරයත් දෙකම බේරගන්නේ කොහොමද කියලා බලාගන්න මේ පට්ටම සීසන් එක අනිවාර්යයෙන්ම බලන්න.

මෙම උපසිරැසි Bluray පිටපත් වලට පමණක් ගැලපේ.💯

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නේ මෙහෙමයි:

📄 Direct Download: කිසිම කරදරයක් නැතුව සිංහල උපසිරැසි ගොනුව (SRT) කෙලින්ම ඩවුන්ලෝඩ් කරගන්න පුළුවන්.

✈️ Telegram Download: 720p, 1080p bluray කොපි ටෙලිග්‍රෑම් චැනල් එක හරහා ගන්න පුළුවන්.', '2002-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/EwMBNMUIx9kKf0DpijNF1bncJT.jpg', '2026-08-15 23:36:34.227099+00', '2026-08-15 23:36:34.227099+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('6cb38ff8-f904-4798-a8de-c16ddae10c01', '0ad44dce-04c9-49e5-ab78-a0f85ebdbe45', 2, 'Episode 2', '🕵️‍♂️ The Sopranos Season 4 Episode 2 - සිංහල උපසිරැසි 🎬

The Sopranos Season 4 Episode 2 delivers another legendary installment of this acclaimed drama. Follow Tony Soprano as he manages increasing complications within his inner circle while navigating a fragile marriage. Download high-quality 720p, 1080p WEB-DL video files directly on pixelpoplk.

ඔන්න යාළුවනේ, ''The Sopranos'' කතා මාලාවේ 4 වැනි කතා සමයේ (Season 4) දෙවැනි කොටසට (Episode 2) සිංහල උපසිරැසි අරගෙන ආවා. මෙම උපසිරැසි Bluray පිටපත් වලට පමණක් ගැලපේ.💯

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නේ මෙහෙමයි:

📄 Direct Download: කිසිම කරදරයක් නැතුව සිංහල උපසිරැසි ගොනුව (SRT) කෙලින්ම ඩවුන්ලෝඩ් කරගන්න පුළුවන්.

✈️ Telegram Download: 720p, 1080p bluray කොපි ටෙලිග්‍රෑම් චැනල් එක හරහා ගන්න පුළුවන්.', '2002-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/EwMBNMUIx9kKf0DpijNF1bncJT.jpg', '2026-08-15 23:36:34.227099+00', '2026-08-15 23:36:34.227099+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('f62ec38b-d850-4c1f-af4b-3dc935480af1', '0ad44dce-04c9-49e5-ab78-a0f85ebdbe45', 3, 'Episode 3', '🕵️‍♂️ The Sopranos Season 4 Episode 3 - සිංහල උපසිරැසි 🎬

The Sopranos Season 4 Episode 3 brings highly engaging conflicts to the forefront. Christopher continues to face personal struggles as new business arrangements cause friction. Download high-quality 720p, 1080p WEB-DL video files directly on pixelpoplk.

ඔන්න යාළුවනේ, ''The Sopranos'' කතා මාලාවේ 4 වැනි කතා සමයේ (Season 4) තුන්වැනි කොටසට (Episode 3) සිංහල උපසිරැසි අරගෙන ආවා. මෙම උපසිරැසි Bluray පිටපත් වලට පමණක් ගැලපේ.💯

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නේ මෙහෙමයි:

📄 Direct Download: කිසිම කරදරයක් නැතුව සිංහල උපසිරැසි ගොනුව (SRT) කෙලින්ම ඩවුන්ලෝඩ් කරගන්න පුළුවන්.

✈️ Telegram Download: 720p, 1080p bluray කොපි ටෙලිග්‍රෑම් චැනල් එක හරහා ගන්න පුළුවන්.', '2002-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/EwMBNMUIx9kKf0DpijNF1bncJT.jpg', '2026-08-15 23:36:34.227099+00', '2026-08-15 23:36:34.227099+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('8d5421c6-211a-4005-a822-51c7d0bdb4b3', '0ad44dce-04c9-49e5-ab78-a0f85ebdbe45', 4, 'Episode 4', '🕵️‍♂️ The Sopranos Season 4 Episode 4 - සිංහල උපසිරැසි 🎬

The Sopranos Season 4 Episode 4 offers an outstanding perspective on the rising pressures from New York. Tony remains vigilant as federal investigators compile critical details. Download high-quality 720p, 1080p WEB-DL video files directly on pixelpoplk.

ඔන්න යාළුවනේ, ''The Sopranos'' කතා මාලාවේ 4 වැනි කතා සමයේ (Season 4) හතරවැනි කොටසට (Episode 4) සිංහල උපසිරැසි අරගෙන ආවා. මෙම උපසිරැසි Bluray පිටපත් වලට පමණක් ගැලපේ.💯

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නේ මෙහෙමයි:

📄 Direct Download: කිසිම කරදරයක් නැතුව සිංහල උපසිරැසි ගොනුව (SRT) කෙලින්ම ඩවුන්ලෝඩ් කරගන්න පුළුවන්.

✈️ Telegram Download: 720p, 1080p bluray කොපි ටෙලිග්‍රෑම් චැනල් එක හරහා ගන්න පුළුවන්.', '2002-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/EwMBNMUIx9kKf0DpijNF1bncJT.jpg', '2026-08-15 23:36:34.227099+00', '2026-08-15 23:36:34.227099+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('6873c06e-a235-4cca-a6f3-5155f1904aaf', '0ad44dce-04c9-49e5-ab78-a0f85ebdbe45', 5, 'Episode 5', '🕵️‍♂️ The Sopranos Season 4 Episode 5 - සිංහල උපසිරැසි 🎬

The Sopranos Season 4 Episode 5 continues the captivating sequence of events. New financial arrangements put Tony''s strategic mind to the test as tensions flare up. Download high-quality 720p, 1080p WEB-DL video files directly on pixelpoplk.

ඔන්න යාළුවනේ, ''The Sopranos'' කතා මාලාවේ 4 වැනි කතා සමයේ (Season 4) පස්වැනි කොටසට (Episode 5) සිංහල උපසිරැසි අරගෙන ආවා. මෙම උපසිරැසි Bluray පිටපත් වලට පමණක් ගැලපේ.💯

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නේ මෙහෙමයි:

📄 Direct Download: කිසිම කරදරයක් නැතුව සිංහල උපසිරැසි ගොනුව (SRT) කෙලින්ම ඩවුන්ලෝඩ් කරගන්න පුළුවන්.

✈️ Telegram Download: 720p, 1080p bluray කොපි ටෙලිග්‍රෑම් චැනල් එක හරහා ගන්න පුළුවන්.', '2002-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/EwMBNMUIx9kKf0DpijNF1bncJT.jpg', '2026-08-15 23:36:34.227099+00', '2026-08-15 23:36:34.227099+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('db924be3-1faf-4e5d-a55e-970208ec6509', '0ad44dce-04c9-49e5-ab78-a0f85ebdbe45', 6, 'Episode 6', '🕵️‍♂️ The Sopranos Season 4 Episode 6 - සිංහල උපසිරැසි 🎬

The Sopranos Season 4 Episode 6 explores Christopher''s growing responsibilities and the burdens they carry. Tony strives to maintain order inside his syndicate. Download high-quality 720p, 1080p WEB-DL video files directly on pixelpoplk.

ඔන්න යාළුවනේ, ''The Sopranos'' කතා මාලාවේ 4 වැනි කතා සමයේ (Season 4) හයවැනි කොටසට (Episode 6) සිංහල උපසිරැසි අරගෙන ආවා. මෙම උපසිරැසි Bluray පිටපත් වලට පමණක් ගැලපේ.💯

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නේ මෙහෙමයි:

📄 Direct Download: කිසිම කරදරයක් නැතුව සිංහල උපසිරැසි ගොනුව (SRT) කෙලින්ම ඩවුන්ලෝඩ් කරගන්න පුළුවන්.

✈️ Telegram Download: 720p, 1080p bluray කොපි ටෙලිග්‍රෑම් චැනල් එක හරහා ගන්න පුළුවන්.', '2002-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/EwMBNMUIx9kKf0DpijNF1bncJT.jpg', '2026-08-15 23:36:34.227099+00', '2026-08-15 23:36:34.227099+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('5c527043-9a69-437e-a169-4f41dba9a82c', '0ad44dce-04c9-49e5-ab78-a0f85ebdbe45', 7, 'Episode 7', '🕵️‍♂️ The Sopranos Season 4 Episode 7 - සිංහල උපසිරැසි 🎬

The Sopranos Season 4 Episode 7 delivers exceptional drama as personal conflicts overlap with organizational goals. Trust remains a scarce resource for Jersey''s finest. Download high-quality 720p, 1080p WEB-DL video files directly on pixelpoplk.

ඔන්න යාළුවනේ, ''The Sopranos'' කතා මාලාවේ 4 වැනි කතා සමයේ (Season 4) හත්වැනි කොටසට (Episode 7) සිංහල උපසිරැසි අරගෙන ආවා. මෙම උපසිරැසි Bluray පිටපත් වලට පමණක් ගැලපේ.💯

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නේ මෙහෙමයි:

📄 Direct Download: කිසිම කරදරයක් නැතුව සිංහල උපසිරැසි ගොනුව (SRT) කෙලින්ම ඩවුන්ලෝඩ් කරගන්න පුළුවන්.

✈️ Telegram Download: 720p, 1080p bluray කොපි ටෙලිග්‍රෑම් චැනල් එක හරහා ගන්න පුළුවන්.', '2002-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/EwMBNMUIx9kKf0DpijNF1bncJT.jpg', '2026-08-15 23:36:34.227099+00', '2026-08-15 23:36:34.227099+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('8c9f91c8-3bf7-4dfa-a3fb-50c6c13f5326', '0ad44dce-04c9-49e5-ab78-a0f85ebdbe45', 8, 'Episode 8', '🕵️‍♂️ The Sopranos Season 4 Episode 8 - සිංහල උපසිරැසි 🎬

The Sopranos Season 4 Episode 8 deals with shifting loyalties and strategic moves. Tony''s leadership faces critical evaluations from key figures in the network. Download high-quality 720p, 1080p WEB-DL video files directly on pixelpoplk.

ඔන්න යාළුවනේ, ''The Sopranos'' කතා මාලාවේ 4 වැනි කතා සමයේ (Season 4) අටවැනි කොටසට (Episode 8) සිංහල උපසිරැසි අරගෙන ආවා. මෙම උපසිරැසි Bluray පිටපත් වලට පමණක් ගැලපේ.💯

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නේ මෙහෙමයි:

📄 Direct Download: කිසිම කරදරයක් නැතුව සිංහල උපසිරැසි ගොනුව (SRT) කෙලින්ම ඩවුන්ලෝඩ් කරගන්න පුළුවන්.

✈️ Telegram Download: 720p, 1080p bluray කොපි ටෙලිග්‍රෑම් චැනල් එක හරහා ගන්න පුළුවන්.', '2002-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/EwMBNMUIx9kKf0DpijNF1bncJT.jpg', '2026-08-15 23:36:34.227099+00', '2026-08-15 23:36:34.227099+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('250c590e-8d7a-437f-a298-9c02376ce6bf', '0ad44dce-04c9-49e5-ab78-a0f85ebdbe45', 9, 'Episode 9', '🕵️‍♂️ The Sopranos Season 4 Episode 9 - සිංහල උපසිරැසි 🎬

The Sopranos Season 4 Episode 9 highlights the increasing pressure of the FBI''s meticulous surveillance. The family has to walk a very fine line to avoid exposure. Download high-quality 720p, 1080p WEB-DL video files directly on pixelpoplk.

ඔන්න යාළුවනේ, ''The Sopranos'' කතා මාලාවේ 4 වැනි කතා සමයේ (Season 4) නවවැනි කොටසට (Episode 9) සිංහල උපසිරැසි අරගෙන ආවා. මෙම උපසිරැසි Bluray පිටපත් වලට පමණක් ගැලපේ.💯

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නේ මෙහෙමයි:

📄 Direct Download: කිසිම කරදරයක් නැතුව සිංහල උපසිරැසි ගොනුව (SRT) කෙලින්ම ඩවුන්ලෝඩ් කරගන්න පුළුවන්.

✈️ Telegram Download: 720p, 1080p bluray කොපි ටෙලිග්‍රෑම් චැනල් එක හරහා ගන්න පුළුවන්.', '2002-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/EwMBNMUIx9kKf0DpijNF1bncJT.jpg', '2026-08-15 23:36:34.227099+00', '2026-08-15 23:36:34.227099+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('238f4b1b-2207-46f4-a556-3068b3631ded', '0ad44dce-04c9-49e5-ab78-a0f85ebdbe45', 10, 'Episode 10', '🕵️‍♂️ The Sopranos Season 4 Episode 10 - සිංහල උපසිරැසි 🎬

The Sopranos Season 4 Episode 10 brings critical decisions as old arrangements are questioned. Tony finds himself resolving disputes that could change the power balance. Download high-quality 720p, 1080p WEB-DL video files directly on pixelpoplk.

ඔන්න යාළුවනේ, ''The Sopranos'' කතා මාලාවේ 4 වැනි කතා සමයේ (Season 4) දහවැනි කොටසට (Episode 10) සිංහල උපසිරැසි අරගෙන ආවා. මෙම උපසිරැසි Bluray පිටපත් වලට පමණක් ගැලපේ.💯

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නේ මෙහෙමයි:

📄 Direct Download: කිසිම කරදරයක් නැතුව සිංහල උපසිරැසි ගොනුව (SRT) කෙලින්ම ඩවුන්ලෝඩ් කරගන්න පුළුවන්.

✈️ Telegram Download: 720p, 1080p bluray කොපි ටෙලිග්‍රෑම් චැනල් එක හරහා ගන්න පුළුවන්.', '2002-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/EwMBNMUIx9kKf0DpijNF1bncJT.jpg', '2026-08-15 23:36:34.227099+00', '2026-08-15 23:36:34.227099+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('ecdc33de-770b-44fb-aa6f-30fe78f7babc', '0ad44dce-04c9-49e5-ab78-a0f85ebdbe45', 11, 'Episode 11', '🕵️‍♂️ The Sopranos Season 4 Episode 11 - සිංහල උපසිරැසි 🎬

The Sopranos Season 4 Episode 11 leads towards the season''s climax. Personal relations reach a breaking point, demanding immediate attention from Tony Soprano. Download high-quality 720p, 1080p WEB-DL video files directly on pixelpoplk.

ඔන්න යාළුවනේ, ''The Sopranos'' කතා මාලාවේ 4 වැනි කතා සමයේ (Season 4) එකොළොස්වැනි කොටසට (Episode 11) සිංහල උපසිරැසි අරගෙන ආවා. මෙම උපසිරැසි Bluray පිටපත් වලට පමණක් ගැලපේ.💯

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නේ මෙහෙමයි:

📄 Direct Download: කිසිම කරදරයක් නැතුව සිංහල උපසිරැසි ගොනුව (SRT) කෙලින්ම ඩවුන්ලෝඩ් කරගන්න පුළුවන්.

✈️ Telegram Download: 720p, 1080p bluray කොපි ටෙලිග්‍රෑම් චැනල් එක හරහා ගන්න පුළුවන්.', '2002-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/EwMBNMUIx9kKf0DpijNF1bncJT.jpg', '2026-08-15 23:36:34.227099+00', '2026-08-15 23:36:34.227099+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('760404ec-0186-4835-af09-bc889348e456', '0ad44dce-04c9-49e5-ab78-a0f85ebdbe45', 12, 'Episode 12', '🕵️‍♂️ The Sopranos Season 4 Episode 12 - සිංහල උපසිරැසි 🎬

The Sopranos Season 4 Episode 12 presents a highly emotional and intense pre-finale chapter. Loyalty is pushed to its absolute limits as consequences loom large. Download high-quality 720p, 1080p WEB-DL video files directly on pixelpoplk.

ඔන්න යාළුවනේ, ''The Sopranos'' කතා මාලාවේ 4 වැනි කතා සමයේ (Season 4) දොළොස්වැනි කොටසට (Episode 12) සිංහල උපසිරැසි අරගෙන ආවා. මෙම උපසිරැසි Bluray පිටපත් වලට පමණක් ගැලපේ.💯

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නේ මෙහෙමයි:

📄 Direct Download: කිසිම කරදරයක් නැතුව සිංහල උපසිරැසි ගොනුව (SRT) කෙලින්ම ඩවුන්ලෝඩ් කරගන්න පුළුවන්.

✈️ Telegram Download: 720p, 1080p bluray කොපි ටෙලිග්‍රෑම් චැනල් එක හරහා ගන්න පුළුවන්.', '2002-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/EwMBNMUIx9kKf0DpijNF1bncJT.jpg', '2026-08-15 23:36:34.227099+00', '2026-08-15 23:36:34.227099+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('4adbc120-bd9a-4659-abaa-dfe6758d73fd', '0ad44dce-04c9-49e5-ab78-a0f85ebdbe45', 13, 'Episode 13', '🕵️‍♂️ The Sopranos Season 4 Episode 13 - සිංහල උපසිරැසි 🎬

The Sopranos Season 4 Episode 13 brings the monumental season finale. Uncover the dramatic resolutions of major storylines that set a completely new path for the family. Download high-quality 720p, 1080p WEB-DL video files directly on pixelpoplk.

ඔන්න යාළුවනේ, ''The Sopranos'' කතා මාලාවේ 4 වැනි කතා සමයේ (Season 4) දහතුන්වැනි කොටසට (Episode 13) සිංහල උපසිරැසි අරගෙන ආවා. මෙම උපසිරැසි Bluray පිටපත් වලට පමණක් ගැලපේ.💯

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නේ මෙහෙමයි:

📄 Direct Download: කිසිම කරදරයක් නැතුව සිංහල උපසිරැසි ගොනුව (SRT) කෙලින්ම ඩවුන්ලෝඩ් කරගන්න පුළුවන්.

✈️ Telegram Download: 720p, 1080p bluray කොපි ටෙලිග්‍රෑම් චැනල් එක හරහා ගන්න පුළුවන්.', '2002-01-01', 50, 9.2, 'https://image.tmdb.org/t/p/original/EwMBNMUIx9kKf0DpijNF1bncJT.jpg', '2026-08-15 23:36:34.227099+00', '2026-08-15 23:36:34.227099+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('13146e83-5b56-4172-ad65-da96fff927aa', 'e51f6dc2-9dc4-470d-a724-3dc29628ffa2', 1, 'Episode 1', '🕵️‍♂️ Lanterns (2026) - සිංහල උපසිරැසි 🎬

Lanterns delivers a gritty, grounded, and cosmic detective thriller from HBO. When a legendary, grizzled Green Lantern is forced to train a defiant new recruit, the two intergalactic cops find themselves drawn into a dark, small-town murder mystery with massive, universe-altering implications. Download high-quality 720p, 1080p WEB-DL video files directly or via Telegram on pixelpoplk.

ඔන්න යාළුවනේ, DC රසිකයෝ හැමෝම අතිශය උනන්දුවෙන් බලාගෙන හිටපු, HBO සහ Max හරහා අදම විකාශනය ආරම්භ වුණු "Lanterns" අලුත්ම සජීවීකරණ නොවන (Live-action) සුපිරි කතා මාලාවට සිංහල උපසිරැසි අරගෙන ආවා. James Gunn ගේ අලුත්ම DC විශ්වයට (DCU) අයත් වෙන මේ කතාව, සාමාන්‍ය සුපිරි වීර කතාවලට වඩා හාත්පසින්ම වෙනස් "True Detective" වගේ අඳුරු රහස් පරීක්ෂණ (Grounded Detective Thriller) විලාසිතාවකින් තමයි නිර්මාණය කරලා තියෙන්නේ.

කතාව පැත්තට ගියොත්, වසර ගණනාවක අත්දැකීම් තියෙන ප්‍රබල මෙන්ම වයස්ගත ග්‍රීන් ලැන්ටර්න් කෙනෙක් වෙන හැල් ජෝර්ඩන්ට (Kyle Chandler), අලුතින්ම මේ කණ්ඩායමට එකතු වෙන මුරණ්ඩු හිටපු මැරීන් සෙබළෙක් වන ජෝන් ස්ටුවර්ට්ව (Aaron Pierre) පුහුණු කරන්න සිද්ධ වෙනවා. මෙයාලා දෙන්නා ඇමරිකාවේ කුඩා ගමක සිද්ධ වෙන අමුතුම විදිහේ මිනීමැරුමක් ගැන පරීක්ෂණ පවත්වන්න එකතු වෙනවා. හැබැයි සාමාන්‍ය එකක් විදිහට පේන මේ මිනීමැරුම පිටුපස මුළු විශ්වයම උඩුයටිකුරු කරන්න පුළුවන් තරමේ අභ්‍යවකාශ සහ පිටසක්වල කුමන්ත්‍රණයක් හැංගිලා තියෙනවා කියලා මෙයාලට තේරුම් යනවා.

Ozark කතා මාලාවේ Chris Mundy, Lost සහ Watchmen නිර්මාණය කරපු Damon Lindelof වැනි අති දක්ෂ පිරිසකගේ තිර රචනයෙන් හැඩවුණු මේ සුපිරි කතා මාලාව, DC ලෝලීන් විතරක් නෙවෙයි හොඳ රහස් පරීක්ෂණ කතාවලට ආස කරන හැමෝම අනිවාර්යයෙන්ම බලන්න ඕනේ එකක්.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නේ මෙහෙමයි:

📄 Direct Download: කිසිම කරදරයක් නැතුව සිංහල උපසිරැසි ගොනුව (SRT) කෙලින්ම ඩවුන්ලෝඩ් කරගන්න පුළුවන්.

✈️ Telegram Download: 720p, 1080p WEB-DL කොපි ටෙලිග්‍රෑම් චැනල් එක හරහා ගන්න පුළුවන්.', '2026-01-01', 50, 8, 'https://image.tmdb.org/t/p/original/isYpgPQdjxJ0Ht04uKgilVYGPp9.jpg', '2026-08-17 00:43:29.237961+00', '2026-08-17 00:43:29.237961+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('bcf388b1-7318-4d56-a3ec-a28e8f1b81bc', 'd8cfb2ad-122c-4233-a3c4-1e5273a7950a', 1, 'Episode 1', '🕵️‍♂️ Dexter Season 1 Episode 1 - සිංහල උපසිරැසි 🎬

Dexter Season 1 delivers a brilliant, darkly comedic psychological crime thriller from Showtime. A brilliant Miami forensics expert leads a double life as a meticulous vigilante serial killer who only hunts down other murderers. When a mysterious new killer begins leaving bloodless clues just for him, a high-stakes psychological game of cat-and-mouse begins.

ඔන්න අරගෙන ආවා Crime, Mystery වගේම Psychological Thriller කතාවලට ආස කරන අය හැමෝම අනිවාර්යයෙන්ම බලන්න ඕනේ, Showtime නාලිකාවෙන් නිකුත් කරපු ලෝක ප්‍රසිද්ධ ''Dexter'' කතා මාලාවේ පළමු කතා සමයේ (Season 1) පළමු වැනි කොටසට (Episode 1) සිංහල උපසිරැසි. IMDb එකේ 8.6/10ක ඉහළම රේටින් එකක් ගත්ත මේ සීරීස් එක, මුල ඉඳන් අගටම කුතුහලය උපරිමයෙන්ම තියාගෙන බලන්න පුළුවන් විශිෂ්ටතම නිර්මාණයක්.

කතාව පැත්තට ගියොත්, ඩෙක්ස්ටර් මෝගන් (Michael C. Hall) කියන්නේ මියාමි පොලිසියේ වැඩ කරන, ලේ පැල්ලම් ගැන පරීක්ෂණ පවත්වන දක්ෂ නිලධාරියෙක්. හැබැයි හැමෝටම පේන මේ සාමාන්‍ය ජීවිතයට අමතරව ඩෙක්ස්ටර්ට තව අඳුරු රහස් ජීවිතයක් තියෙනවා. ඒ තමයි එයා රෑට නීතියෙන් බේරිලා යන දරුණු වැරදිකරුවන් සොයාගෙන ඔවුන්ට දඬුවම් කරන රහසිගත ක්‍රියාකාරියෙක් (Vigilante) විදිහට වැඩ කරන එක. එයා මේ දේ කරන්නේ එයාගේ හදාගත්ත තාත්තා කියලා දුන්න දැඩි සීමාවන් සහ නීති මාලාවකට (The Code of Harry) අනුවයි.

මේ අතරේ මියාමි නගරයේ අමුතුම විදිහට අපරාධකරන අලුත් කෙනෙක් මතුවෙනවා. ''Ice Truck Killer'' විදිහට හඳුන්වන මේ පුද්ගලයා, තමන්ගේ ඉලක්කයන් ලේ බිඳක්වත් නැතිව සකසා පොදු ස්ථානවල දාලා යනවා. ඒ වගේම එයා ඩෙක්ස්ටර්ට විතරක් තේරෙන රහස් ඉඟි ඉතුරු කරමින් ඩෙක්ස්ටර් එක්ක අමුතුම මානසික සෙල්ලමක් කරන්න පටන් ගන්නවා. මේ රහස්‍ය පුද්ගලයා කවුද? එයා ඩෙක්ස්ටර් ගැන දන්නේ කොහොමද?

Michael C. Hall ගේ සුපිරිම රංගනයෙන් හැඩවුණු, හැම තත්පරේම කුතුහලයෙන් වගේම දරුණු suspense එකකින් බලන්න පුළුවන් මේ පට්ටම කතාව ඔයාගේ Must Watch ලිස්ට් එකට අනිවාර්යයෙන්ම එකතු කරගන්න.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නේ මෙහෙමයි:

📄 Direct Subtitle Download: කිසිම කරදරයක් නැතුව සිංහල උපසිරැසි ගොනුව (.zip) කෙලින්ම ඩවුන්ලෝඩ් කරගන්න පුළුවන්.

✈️ Telegram Download: 720p, 1080p Bluray කොපි ටෙලිග්‍රෑම් චැනල් එක හරහා ගන්න පුළුවන්.', '2006-01-01', 50, 8.6, 'https://image.tmdb.org/t/p/original/rmhoMEHK3ZP2EAXX2VpxuKpW3Bf.jpg', '2026-08-22 06:41:53.87792+00', '2026-08-22 06:41:53.87792+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('095f8705-8c1d-49cc-a4ba-e948a1ba34f3', 'd8cfb2ad-122c-4233-a3c4-1e5273a7950a', 2, 'Episode 2', '🕵️‍♂️ Dexter Season 1 Episode 2 - සිංහල උපසිරැසි 🎬

Dexter Season 1 delivers a brilliant, darkly comedic psychological crime thriller from Showtime. A brilliant Miami forensics expert leads a double life as a meticulous vigilante serial killer who only hunts down other murderers. When a mysterious new killer begins leaving bloodless clues just for him, a high-stakes psychological game of cat-and-mouse begins.

ඔන්න අරගෙන ආවා Crime, Mystery වගේම Psychological Thriller කතාවලට ආස කරන අය හැමෝම අනිවාර්යයෙන්ම බලන්න ඕනේ, Showtime නාලිකාවෙන් නිකුත් කරපු ලෝක ප්‍රසිද්ධ ''Dexter'' කතා මාලාවේ පළමු කතා සමයේ (Season 1) දෙවැනි කොටසට (Episode 2) සිංහල උපසිරැසි. IMDb එකේ 8.6/10ක ඉහළම රේටින් එකක් ගත්ත මේ සීරීස් එක, මුල ඉඳන් අගටම කුතුහලය උපරිමයෙන්ම තියාගෙන බලන්න පුළුවන් විශිෂ්ටතම නිර්මාණයක්.

කතාව පැත්තට ගියොත්, ඩෙක්ස්ටර් මෝගන් (Michael C. Hall) කියන්නේ මියාමි පොලිසියේ වැඩ කරන, ලේ පැල්ලම් ගැන පරීක්ෂණ පවත්වන දක්ෂ නිලධාරියෙක්. හැබැයි හැමෝටම පේන මේ සාමාන්‍ය ජීවිතයට අමතරව ඩෙක්ස්ටර්ට තව අඳුරු රහස් ජීවිතයක් තියෙනවා. ඒ තමයි එයා රෑට නීතියෙන් බේරිලා යන දරුණු වැරදිකරුවන් සොයාගෙන ඔවුන්ට දඬුවම් කරන රහසිගත ක්‍රියාකාරියෙක් (Vigilante) විදිහට වැඩ කරන එක. එයා මේ දේ කරන්නේ එයාගේ හදාගත්ත තාත්තා කියලා දුන්න දැඩි සීමාවන් සහ නීති මාලාවකට (The Code of Harry) අනුවයි.

මේ අතරේ මියාමි නගරයේ අමුතුම විදිහට අපරාධකරන අලුත් කෙනෙක් මතුවෙනවා. ''Ice Truck Killer'' විදිහට හඳුන්වන මේ පුද්ගලයා, තමන්ගේ ඉලක්කයන් ලේ බිඳක්වත් නැතිව සකසා පොදු ස්ථානවල දාලා යනවා. ඒ වගේම එයා ඩෙක්ස්ටර්ට විතරක් තේරෙන රහස් ඉඟි ඉතුරු කරමින් ඩෙක්ස්ටර් එක්ක අමුතුම මානසික සෙල්ලමක් කරන්න පටන් ගන්නවා. මේ රහස්‍ය පුද්ගලයා කවුද? එයා ඩෙක්ස්ටර් ගැන දන්නේ කොහොමද?

Michael C. Hall ගේ සුපිරිම රංගනයෙන් හැඩවුණු, හැම තත්පරේම කුතුහලයෙන් වගේම දරුණු suspense එකකින් බලන්න පුළුවන් මේ පට්ටම කතාව ඔයාගේ Must Watch ලිස්ට් එකට අනිවාර්යයෙන්ම එකතු කරගන්න.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නේ මෙහෙමයි:

📄 Direct Subtitle Download: කිසිම කරදරයක් නැතුව සිංහල උපසිරැසි ගොනුව (.zip) කෙලින්ම ඩවුන්ලෝඩ් කරගන්න පුළුවන්.

✈️ Telegram Download: 720p, 1080p Bluray කොපි ටෙලිග්‍රෑම් චැනල් එක හරහා ගන්න පුළුවන්.', '2006-01-01', 50, 8.6, 'https://image.tmdb.org/t/p/original/rmhoMEHK3ZP2EAXX2VpxuKpW3Bf.jpg', '2026-08-22 06:41:53.87792+00', '2026-08-22 06:41:53.87792+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('57ac433d-5b5c-45e5-a691-c3417ae68162', 'd8cfb2ad-122c-4233-a3c4-1e5273a7950a', 3, 'Episode 3', '🕵️‍♂️ Dexter Season 1 Episode 3 - සිංහල උපසිරැසි 🎬

Dexter Season 1 delivers a brilliant, darkly comedic psychological crime thriller from Showtime. A brilliant Miami forensics expert leads a double life as a meticulous vigilante serial killer who only hunts down other murderers. When a mysterious new killer begins leaving bloodless clues just for him, a high-stakes psychological game of cat-and-mouse begins.

ඔන්න අරගෙන ආවා Crime, Mystery වගේම Psychological Thriller කතාවලට ආස කරන අය හැමෝම අනිවාර්යයෙන්ම බලන්න ඕනේ, Showtime නාලිකාවෙන් නිකුත් කරපු ලෝක ප්‍රසිද්ධ ''Dexter'' කතා මාලාවේ පළමු කතා සමයේ (Season 1) තුන්වැනි කොටසට (Episode 3) සිංහල උපසිරැසි. IMDb එකේ 8.6/10ක ඉහළම රේටින් එකක් ගත්ත මේ සීරීස් එක, මුල ඉඳන් අගටම කුතුහලය උපරිමයෙන්ම තියාගෙන බලන්න පුළුවන් විශිෂ්ටතම නිර්මාණයක්.

කතාව පැත්තට ගියොත්, ඩෙක්ස්ටර් මෝගන් (Michael C. Hall) කියන්නේ මියාමි පොලිසියේ වැඩ කරන, ලේ පැල්ලම් ගැන පරීක්ෂණ පවත්වන දක්ෂ නිලධාරියෙක්. හැබැයි හැමෝටම පේන මේ සාමාන්‍ය ජීවිතයට අමතරව ඩෙක්ස්ටර්ට තව අඳුරු රහස් ජීවිතයක් තියෙනවා. ඒ තමයි එයා රෑට නීතියෙන් බේරිලා යන දරුණු වැරදිකරුවන් සොයාගෙන ඔවුන්ට දඬුවම් කරන රහසිගත ක්‍රියාකාරියෙක් (Vigilante) විදිහට වැඩ කරන එක. එයා මේ දේ කරන්නේ එයාගේ හදාගත්ත තාත්තා කියලා දුන්න දැඩි සීමාවන් සහ නීති මාලාවකට (The Code of Harry) අනුවයි.

මේ අතරේ මියාමි නගරයේ අමුතුම විදිහට අපරාධකරන අලුත් කෙනෙක් මතුවෙනවා. ''Ice Truck Killer'' විදිහට හඳුන්වන මේ පුද්ගලයා, තමන්ගේ ඉලක්කයන් ලේ බිඳක්වත් නැතිව සකසා පොදු ස්ථානවල දාලා යනවා. ඒ වගේම එයා ඩෙක්ස්ටර්ට විතරක් තේරෙන රහස් ඉඟි ඉතුරු කරමින් ඩෙක්ස්ටර් එක්ක අමුතුම මානසික සෙල්ලමක් කරන්න පටන් ගන්නවා. මේ රහස්‍ය පුද්ගලයා කවුද? එයා ඩෙක්ස්ටර් ගැන දන්නේ කොහොමද?

Michael C. Hall ගේ සුපිරිම රංගනයෙන් හැඩවුණු, හැම තත්පරේම කුතුහලයෙන් වගේම දරුණු suspense එකකින් බලන්න පුළුවන් මේ පට්ටම කතාව ඔයාගේ Must Watch ලිස්ට් එකට අනිවාර්යයෙන්ම එකතු කරගන්න.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නේ මෙහෙමයි:

📄 Direct Subtitle Download: කිසිම කරදරයක් නැතුව සිංහල උපසිරැසි ගොනුව (.zip) කෙලින්ම ඩවුන්ලෝඩ් කරගන්න පුළුවන්.

✈️ Telegram Download: 720p, 1080p Bluray කොපි ටෙලිග්‍රෑම් චැනල් එක හරහා ගන්න පුළුවන්.', '2006-01-01', 50, 8.6, 'https://image.tmdb.org/t/p/original/rmhoMEHK3ZP2EAXX2VpxuKpW3Bf.jpg', '2026-08-22 06:41:53.87792+00', '2026-08-22 06:41:53.87792+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('b22aa0de-467b-4425-a56c-590afa035476', 'd8cfb2ad-122c-4233-a3c4-1e5273a7950a', 4, 'Episode 4', '🕵️‍♂️ Dexter Season 1 Episode 4 - සිංහල උපසිරැසි 🎬

Dexter Season 1 delivers a brilliant, darkly comedic psychological crime thriller from Showtime. A brilliant Miami forensics expert leads a double life as a meticulous vigilante serial killer who only hunts down other murderers. When a mysterious new killer begins leaving bloodless clues just for him, a high-stakes psychological game of cat-and-mouse begins.

ඔන්න අරගෙන ආවා Crime, Mystery වගේම Psychological Thriller කතාවලට ආස කරන අය හැමෝම අනිවාර්යයෙන්ම බලන්න ඕනේ, Showtime නාලිකාවෙන් නිකුත් කරපු ලෝක ප්‍රසිද්ධ ''Dexter'' කතා මාලාවේ පළමු කතා සමයේ (Season 1) හතරවැනි කොටසට (Episode 4) සිංහල උපසිරැසි. IMDb එකේ 8.6/10ක ඉහළම රේටින් එකක් ගත්ත මේ සීරීස් එක, මුල ඉඳන් අගටම කුතුහලය උපරිමයෙන්ම තියාගෙන බලන්න පුළුවන් විශිෂ්ටතම නිර්මාණයක්.

කතාව පැත්තට ගියොත්, ඩෙක්ස්ටර් මෝගන් (Michael C. Hall) කියන්නේ මියාමි පොලිසියේ වැඩ කරන, ලේ පැල්ලම් ගැන පරීක්ෂණ පවත්වන දක්ෂ නිලධාරියෙක්. හැබැයි හැමෝටම පේන මේ සාමාන්‍ය ජීවිතයට අමතරව ඩෙක්ස්ටර්ට තව අඳුරු රහස් ජීවිතයක් තියෙනවා. ඒ තමයි එයා රෑට නීතියෙන් බේරිලා යන දරුණු වැරදිකරුවන් සොයාගෙන ඔවුන්ට දඬුවම් කරන රහසිගත ක්‍රියාකාරියෙක් (Vigilante) විදිහට වැඩ කරන එක. එයා මේ දේ කරන්නේ එයාගේ හදාගත්ත තාත්තා කියලා දුන්න දැඩි සීමාවන් සහ නීති මාලාවකට (The Code of Harry) අනුවයි.

මේ අතරේ මියාමි නගරයේ අමුතුම විදිහට අපරාධකරන අලුත් කෙනෙක් මතුවෙනවා. ''Ice Truck Killer'' විදිහට හඳුන්වන මේ පුද්ගලයා, තමන්ගේ ඉලක්කයන් ලේ බිඳක්වත් නැතිව සකසා පොදු ස්ථානවල දාලා යනවා. ඒ වගේම එයා ඩෙක්ස්ටර්ට විතරක් තේරෙන රහස් ඉඟි ඉතුරු කරමින් ඩෙක්ස්ටර් එක්ක අමුතුම මානසික සෙල්ලමක් කරන්න පටන් ගන්නවා. මේ රහස්‍ය පුද්ගලයා කවුද? එයා ඩෙක්ස්ටර් ගැන දන්නේ කොහොමද?

Michael C. Hall ගේ සුපිරිම රංගනයෙන් හැඩවුණු, හැම තත්පරේම කුතුහලයෙන් වගේම දරුණු suspense එකකින් බලන්න පුළුවන් මේ පට්ටම කතාව ඔයාගේ Must Watch ලිස්ට් එකට අනිවාර්යයෙන්ම එකතු කරගන්න.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නේ මෙහෙමයි:

📄 Direct Subtitle Download: කිසිම කරදරයක් නැතුව සිංහල උපසිරැසි ගොනුව (.zip) කෙලින්ම ඩවුන්ලෝඩ් කරගන්න පුළුවන්.

✈️ Telegram Download: 720p, 1080p Bluray කොපි ටෙලිග්‍රෑම් චැනල් එක හරහා ගන්න පුළුවන්.', '2006-01-01', 50, 8.6, 'https://image.tmdb.org/t/p/original/rmhoMEHK3ZP2EAXX2VpxuKpW3Bf.jpg', '2026-08-22 06:41:53.87792+00', '2026-08-22 06:41:53.87792+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('d5678a26-1b9e-4296-a8a9-0f8d09d19e6d', 'd8cfb2ad-122c-4233-a3c4-1e5273a7950a', 5, 'Episode 5', '🕵️‍♂️ Dexter Season 1 Episode 5 - සිංහල උපසිරැසි 🎬

Dexter Season 1 delivers a brilliant, darkly comedic psychological crime thriller from Showtime. A brilliant Miami forensics expert leads a double life as a meticulous vigilante serial killer who only hunts down other murderers. When a mysterious new killer begins leaving bloodless clues just for him, a high-stakes psychological game of cat-and-mouse begins.

ඔන්න අරගෙන ආවා Crime, Mystery වගේම Psychological Thriller කතාවලට ආස කරන අය හැමෝම අනිවාර්යයෙන්ම බලන්න ඕනේ, Showtime නාලිකාවෙන් නිකුත් කරපු ලෝක ප්‍රසිද්ධ ''Dexter'' කතා මාලාවේ පළමු කතා සමයේ (Season 1) පස්වැනි කොටසට (Episode 5) සිංහල උපසිරැසි. IMDb එකේ 8.6/10ක ඉහළම රේටින් එකක් ගත්ත මේ සීරීස් එක, මුල ඉඳන් අගටම කුතුහලය උපරිමයෙන්ම තියාගෙන බලන්න පුළුවන් විශිෂ්ටතම නිර්මාණයක්.

කතාව පැත්තට ගියොත්, ඩෙක්ස්ටර් මෝගන් (Michael C. Hall) කියන්නේ මියාමි පොලිසියේ වැඩ කරන, ලේ පැල්ලම් ගැන පරීක්ෂණ පවත්වන දක්ෂ නිලධාරියෙක්. හැබැයි හැමෝටම පේන මේ සාමාන්‍ය ජීවිතයට අමතරව ඩෙක්ස්ටර්ට තව අඳුරු රහස් ජීවිතයක් තියෙනවා. ඒ තමයි එයා රෑට නීතියෙන් බේරිලා යන දරුණු වැරදිකරුවන් සොයාගෙන ඔවුන්ට දඬුවම් කරන රහසිගත ක්‍රියාකාරියෙක් (Vigilante) විදිහට වැඩ කරන එක. එයා මේ දේ කරන්නේ එයාගේ හදාගත්ත තාත්තා කියලා දුන්න දැඩි සීමාවන් සහ නීති මාලාවකට (The Code of Harry) අනුවයි.

මේ අතරේ මියාමි නගරයේ අමුතුම විදිහට අපරාධකරන අලුත් කෙනෙක් මතුවෙනවා. ''Ice Truck Killer'' විදිහට හඳුන්වන මේ පුද්ගලයා, තමන්ගේ ඉලක්කයන් ලේ බිඳක්වත් නැතිව සකසා පොදු ස්ථානවල දාලා යනවා. ඒ වගේම එයා ඩෙක්ස්ටර්ට විතරක් තේරෙන රහස් ඉඟි ඉතුරු කරමින් ඩෙක්ස්ටර් එක්ක අමුතුම මානසික සෙල්ලමක් කරන්න පටන් ගන්නවා. මේ රහස්‍ය පුද්ගලයා කවුද? එයා ඩෙක්ස්ටර් ගැන දන්නේ කොහොමද?

Michael C. Hall ගේ සුපිරිම රංගනයෙන් හැඩවුණු, හැම තත්පරේම කුතුහලයෙන් වගේම දරුණු suspense එකකින් බලන්න පුළුවන් මේ පට්ටම කතාව ඔයාගේ Must Watch ලිස්ට් එකට අනිවාර්යයෙන්ම එකතු කරගන්න.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නේ මෙහෙමයි:

📄 Direct Subtitle Download: කිසිම කරදරයක් නැතුව සිංහල උපසිරැසි ගොනුව (.zip) කෙලින්ම ඩවුන්ලෝඩ් කරගන්න පුළුවන්.

✈️ Telegram Download: 720p, 1080p Bluray කොපි ටෙලිග්‍රෑම් චැනල් එක හරහා ගන්න පුළුවන්.', '2006-01-01', 50, 8.6, 'https://image.tmdb.org/t/p/original/rmhoMEHK3ZP2EAXX2VpxuKpW3Bf.jpg', '2026-08-22 06:41:53.87792+00', '2026-08-22 06:41:53.87792+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('89c562af-0cc8-4ce5-a6a6-93770d8b3b47', 'd8cfb2ad-122c-4233-a3c4-1e5273a7950a', 6, 'Episode 6', '🕵️‍♂️ Dexter Season 1 Episode 6 - සිංහල උපසිරැසි 🎬

Dexter Season 1 delivers a brilliant, darkly comedic psychological crime thriller from Showtime. A brilliant Miami forensics expert leads a double life as a meticulous vigilante serial killer who only hunts down other murderers. When a mysterious new killer begins leaving bloodless clues just for him, a high-stakes psychological game of cat-and-mouse begins.

ඔන්න අරගෙන ආවා Crime, Mystery වගේම Psychological Thriller කතාවලට ආස කරන අය හැමෝම අනිවාර්යයෙන්ම බලන්න ඕනේ, Showtime නාලිකාවෙන් නිකුත් කරපු ලෝක ප්‍රසිද්ධ ''Dexter'' කතා මාලාවේ පළමු කතා සමයේ (Season 1) හයවැනි කොටසට (Episode 6) සිංහල උපසිරැසි. IMDb එකේ 8.6/10ක ඉහළම රේටින් එකක් ගත්ත මේ සීරීස් එක, මුල ඉඳන් අගටම කුතුහලය උපරිමයෙන්ම තියාගෙන බලන්න පුළුවන් විශිෂ්ටතම නිර්මාණයක්.

කතාව පැත්තට ගියොත්, ඩෙක්ස්ටර් මෝගන් (Michael C. Hall) කියන්නේ මියාමි පොලිසියේ වැඩ කරන, ලේ පැල්ලම් ගැන පරීක්ෂණ පවත්වන දක්ෂ නිලධාරියෙක්. හැබැයි හැමෝටම පේන මේ සාමාන්‍ය ජීවිතයට අමතරව ඩෙක්ස්ටර්ට තව අඳුරු රහස් ජීවිතයක් تියෙනවා. ඒ තමයි එයා රෑට නීතියෙන් බේරිලා යන දරුණු වැරදිකරුවන් සොයාගෙන ඔවුන්ට දඬුවම් කරන රහසිගත ක්‍රියාකාරියෙක් (Vigilante) විදිහට වැඩ කරන එක. එයා මේ දේ කරන්නේ එයාගේ හදාගත්ත තාත්තා කියලා දුන්න දැඩි සීමාවන් සහ නීති මාලාවකට (The Code of Harry) අනුවයි.

මේ අතරේ මියාමි නගරයේ අමුතුම විදිහට අපරාධකරන අලුත් කෙනෙක් මතුවෙනවා. ''Ice Truck Killer'' විදිහට හඳුන්වන මේ පුද්ගලයා, තමන්ගේ ඉලක්කයන් ලේ බිඳක්වත් නැතිව සකසා පොදු ස්ථානවල දාලා යනවා. ඒ වගේම එයා ඩෙක්ස්ටර්ට විතරක් තේරෙන රහස් ඉඟි ඉතුරු කරමින් ඩෙක්ස්ටර් එක්ක අමුතුම මානසික සෙල්ලමක් කරන්න පටන් ගන්නවා. මේ රහස්‍ය පුද්ගලයා කවුද? එයා ඩෙක්ස්ටර් ගැන දන්නේ කොහොමද?

Michael C. Hall ගේ සුපිරිම රංගනයෙන් හැඩවුණු, හැම තත්පරේම කුතුහලයෙන් වගේම දරුණු suspense එකකින් බලන්න පුළුවන් මේ පට්ටම කතාව ඔයාගේ Must Watch ලිස්ට් එකට අනිවාර්යයෙන්ම එකතු කරගන්න.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නේ මෙහෙමයි:

📄 Direct Subtitle Download: කිසිම කරදරයක් නැතුව සිංහල උපසිරැසි ගොනුව (.zip) කෙලින්ම ඩවුන්ලෝඩ් කරගන්න පුළුවන්.

✈️ Telegram Download: 720p, 1080p Bluray කොපි ටෙලිග්‍රෑම් චැනල් එක හරහා ගන්න පුළුවන්.', '2006-01-01', 50, 8.6, 'https://image.tmdb.org/t/p/original/rmhoMEHK3ZP2EAXX2VpxuKpW3Bf.jpg', '2026-08-22 06:41:53.87792+00', '2026-08-22 06:41:53.87792+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('4ec1c75a-4cf9-46fd-a477-7c7683148c58', 'd8cfb2ad-122c-4233-a3c4-1e5273a7950a', 7, 'Episode 7', '🕵️‍♂️ Dexter Season 1 Episode 7 - සිංහල උපසිරැසි 🎬

Dexter Season 1 delivers a brilliant, darkly comedic psychological crime thriller from Showtime. A brilliant Miami forensics expert leads a double life as a meticulous vigilante serial killer who only hunts down other murderers. When a mysterious new killer begins leaving bloodless clues just for him, a high-stakes psychological game of cat-and-mouse begins.

ඔන්න අරගෙන ආවා Crime, Mystery වගේම Psychological Thriller කතාවලට ආස කරන අය හැමෝම අනිවාර්යයෙන්ම බලන්න ඕනේ, Showtime නාලිකාවෙන් නිකුත් කරපු ලෝක ප්‍රසිද්ධ ''Dexter'' කතා මාලාවේ පළමු කතා සමයේ (Season 1) හත්වැනි කොටසට (Episode 7) සිංහල උපසිරැසි. IMDb එකේ 8.6/10ක ඉහළම රේටින් එකක් ගත්ත මේ සීරීස් එක, මුල ඉඳන් අගටම කුතුහලය උපරිමයෙන්ම තියාගෙන බලන්න පුළුවන් විශිෂ්ටතම නිර්මාණයක්.

කතාව පැත්තට ගියොත්, ඩෙක්ස්ටර් මෝගන් (Michael C. Hall) කියන්නේ මියාමි පොලිසියේ වැඩ කරන, ලේ පැල්ලම් ගැන පරීක්ෂණ පවත්වන දක්ෂ නිලධාරියෙක්. හැබැයි හැමෝටම පේන මේ සාමාන්‍ය ජීවිතයට අමතරව ඩෙක්ස්ටර්ට තව අඳුරු රහස් ජීවිතයක් තියෙනවා. ඒ තමයි එයා රෑට නීතියෙන් බේරිලා යන දරුණු වැරදිකරුවන් සොයාගෙන ඔවුන්ට දඬුවම් කරන රහසිගත ක්‍රියාකාරියෙක් (Vigilante) විදිහට වැඩ කරන එක. එයා මේ දේ කරන්නේ එයාගේ හදාගත්ත තාත්තා කියලා දුන්න දැඩි සීමාවන් සහ නීති මාලාවකට (The Code of Harry) අනුවයි.

මේ අතරේ මියාමි නගරයේ අමුතුම විදිහට අපරාධකරන අලුත් කෙනෙක් මතුවෙනවා. ''Ice Truck Killer'' විදිහට හඳුන්වන මේ පුද්ගලයා, තමන්ගේ ඉලක්කයන් ලේ බිඳක්වත් නැතිව සකසා පොදු ස්ථානවල දාලා යනවා. ඒ වගේම එයා ඩෙක්ස්ටර්ට විතරක් තේරෙන රහස් ඉඟි ඉතුරු කරමින් ඩෙක්ස්ටර් එක්ක අමුතුම මානසික සෙල්ලමක් කරන්න පටන් ගන්නවා. මේ රහස්‍ය පුද්ගලයා කවුද? එයා ඩෙක්ස්ටර් ගැන දන්නේ කොහොමද?

Michael C. Hall ගේ සුපිරිම රංගනයෙන් හැඩවුණු, හැම තත්පරේම කුතුහලයෙන් වගේම දරුණු suspense එකකින් බලන්න පුළුවන් මේ පට්ටම කතාව ඔයාගේ Must Watch ලිස්ට් එකට අනිවාර්යයෙන්ම එකතු කරගන්න.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නේ මෙහෙමයි:

📄 Direct Subtitle Download: කිසිම කරදරයක් නැතුව සිංහල උපසිරැසි ගොනුව (.zip) කෙලින්ම ඩවුන්ලෝඩ් කරගන්න පුළුවන්.

✈️ Telegram Download: 720p, 1080p Bluray කොපි ටෙලිග්‍රෑම් චැනල් එක හරහා ගන්න පුළුවන්.', '2006-01-01', 50, 8.6, 'https://image.tmdb.org/t/p/original/rmhoMEHK3ZP2EAXX2VpxuKpW3Bf.jpg', '2026-08-22 06:41:53.87792+00', '2026-08-22 06:41:53.87792+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('c85df387-a5c7-4fcc-ac58-0dac48370ba7', 'd8cfb2ad-122c-4233-a3c4-1e5273a7950a', 8, 'Episode 8', '🕵️‍♂️ Dexter Season 1 Episode 8 - සිංහල උපසිරැසි 🎬

Dexter Season 1 delivers a brilliant, darkly comedic psychological crime thriller from Showtime. A brilliant Miami forensics expert leads a double life as a meticulous vigilante serial killer who only hunts down other murderers. When a mysterious new killer begins leaving bloodless clues just for him, a high-stakes psychological game of cat-and-mouse begins.

ඔන්න අරගෙන ආවා Crime, Mystery වගේම Psychological Thriller කතාවලට ආස කරන අය හැමෝම අනිවාර්යයෙන්ම බලන්න ඕනේ, Showtime නාලිකාවෙන් නිකුත් කරපු ලෝක ප්‍රසිද්ධ ''Dexter'' කතා මාලාවේ පළමු කතා සමයේ (Season 1) අටවැනි කොටසට (Episode 8) සිංහල උපසිරැසි. IMDb එකේ 8.6/10ක ඉහළම රේටින් එකක් ගත්ත මේ සීරීස් එක, මුල ඉඳන් අගටම කුතුහලය උපරිමයෙන්ම තියාගෙන බලන්න පුළුවන් විශිෂ්ටතම නිර්මාණයක්.

කතාව පැත්තට ගියොත්, ඩෙක්ස්ටර් මෝගන් (Michael C. Hall) කියන්නේ මියාමි පොලිසියේ වැඩ කරන, ලේ පැල්ලම් ගැන පරීක්ෂණ පවත්වන දක්ෂ නිලධාරියෙක්. හැබැයි හැමෝටම පේන මේ සාමාන්‍ය ජීවිතයට අමතරව ඩෙක්ස්ටර්ට තව අඳුරු රහස් ජීවිතයක් තියෙනවා. ඒ තමයි එයා රෑට නීතියෙන් බේරිලා යන දරුණු වැරදිකරුවන් සොයාගෙන ඔවුන්ට දඬුවම් කරන රහසිගත ක්‍රියාකාරියෙක් (Vigilante) විදිහට වැඩ කරන එක. එයා මේ දේ කරන්නේ එයාගේ හදාගත්ත තාත්තා කියලා දුන්න දැඩි සීමාවන් සහ නීති මාලාවකට (The Code of Harry) අනුවයි.

මේ අතරේ මියාමි නගරයේ අමුතුම විදිහට අපරාධකරන අලුත් කෙනෙක් මතුවෙනවා. ''Ice Truck Killer'' විදිහට හඳුන්වන මේ පුද්ගලයා, තමන්ගේ ඉලක්කයන් ලේ බිඳක්වත් නැතිව සකසා පොදු ස්ථානවල දාලා යනවා. ඒ වගේම එයා ඩෙක්ස්ටර්ට විතරක් තේරෙන රහස් ඉඟි ඉතුරු කරමින් ඩෙක්ස්ටර් එක්ක අමුතුම මානසික සෙල්ලමක් කරන්න පටන් ගන්නවා. මේ රහස්‍ය පුද්ගලයා කවුද? එයා ඩෙක්ස්ටර් ගැන දන්නේ කොහොමද?

Michael C. Hall ගේ සුපිරිම රංගනයෙන් හැඩවුණු, හැම තත්පරේම කුතුහලයෙන් වගේම දරුණු suspense එකකින් බලන්න පුළුවන් මේ පට්ටම කතාව ඔයාගේ Must Watch ලිස්ට් එකට අනිවාර්යයෙන්ම එකතු කරගන්න.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නේ මෙහෙමයි:

📄 Direct Subtitle Download: කිසිම කරදරයක් නැතුව සිංහල උපසිරැසි ගොනුව (.zip) කෙලින්ම ඩවුන්ලෝඩ් කරගන්න පුළුවන්.

✈️ Telegram Download: 720p, 1080p Bluray කොපි ටෙලිග්‍රෑම් චැනල් එක හරහා ගන්න පුළුවන්.', '2006-01-01', 50, 8.6, 'https://image.tmdb.org/t/p/original/rmhoMEHK3ZP2EAXX2VpxuKpW3Bf.jpg', '2026-08-22 06:41:53.87792+00', '2026-08-22 06:41:53.87792+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('62a065a7-aa16-4c78-a9d2-fa369d94442f', 'd8cfb2ad-122c-4233-a3c4-1e5273a7950a', 9, 'Episode 9', '🕵️‍♂️ Dexter Season 1 Episode 9 - සිංහල උපසිරැසි 🎬

Dexter Season 1 delivers a brilliant, darkly comedic psychological crime thriller from Showtime. A brilliant Miami forensics expert leads a double life as a meticulous vigilante serial killer who only hunts down other murderers. When a mysterious new killer begins leaving bloodless clues just for him, a high-stakes psychological game of cat-and-mouse begins.

ඔන්න අරගෙන ආවා Crime, Mystery වගේම Psychological Thriller කතාවලට ආස කරන අය හැමෝම අනිවාර්යයෙන්ම බලන්න ඕනේ, Showtime නාලිකාවෙන් නිකුත් කරපු ලෝක ප්‍රසිද්ධ ''Dexter'' කතා මාලාවේ පළමු කතා සමයේ (Season 1) නවවැනි කොටසට (Episode 9) සිංහල උපසිරැසි. IMDb එකේ 8.6/10ක ඉහළම රේටින් එකක් ගත්ත මේ සීරීස් එක, මුල ඉඳන් අගටම කුතුහලය උපරිමයෙන්ම තියාගෙන බලන්න පුළුවන් විශිෂ්ටතම නිර්මාණයක්.

කතාව පැත්තට ගියොත්, ඩෙක්ස්ටර් මෝගන් (Michael C. Hall) කියන්නේ මියාමි පොලිසියේ වැඩ කරන, ලේ පැල්ලම් ගැන පරීක්ෂණ පවත්වන දක්ෂ නිලධාරියෙක්. හැබැයි හැමෝටම පේන මේ සාමාන්‍ය ජීවිතයට අමතරව ඩෙක්ස්ටර්ට තව අඳුරු රහස් ජීවිතයක් තියෙනවා. ඒ තමයි එයා රෑට නීතියෙන් බේරිලා යන දරුණු වැරදිකරුවන් සොයාගෙන ඔවුන්ට දඬුවම් කරන රහසිගත ක්‍රියාකාරියෙක් (Vigilante) විදිහට වැඩ කරන එක. එයා මේ දේ කරන්නේ එයාගේ හදාගත්ත තාත්තා කියලා දුන්න දැඩි සීමාවන් සහ නීති මාලාවකට (The Code of Harry) අනුවයි.

මේ අතරේ මියාමි නගරයේ අමුතුම විදිහට අපරාධකරන අලුත් කෙනෙක් මතුවෙනවා. ''Ice Truck Killer'' විදිහට හඳුන්වන මේ පුද්ගලයා, තමන්ගේ ඉලක්කයන් ලේ බිඳක්වත් නැතිව සකසා පොදු ස්ථානවල දාලා යනවා. ඒ වගේම එයා ඩෙක්ස්ටර්ට විතරක් තේරෙන රහස් ඉඟි ඉතුරු කරමින් ඩෙක්ස්ටර් එක්ක අමුතුම මානසික සෙල්ලමක් කරන්න පටන් ගන්නවා. මේ රහස්‍ය පුද්ගලයා කවුද? එයා ඩෙක්ස්ටර් ගැන දන්නේ කොහොමද?

Michael C. Hall ගේ සුපිරිම රංගනයෙන් හැඩවුණු, හැම තත්පරේම කුතුහලයෙන් වගේම දරුණු suspense එකකින් බලන්න පුළුවන් මේ පට්ටම කතාව ඔයාගේ Must Watch ලිස්ට් එකට අනිවාර්යයෙන්ම එකතු කරගන්න.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නේ මෙහෙමයි:

📄 Direct Subtitle Download: කිසිම කරදරයක් නැතුව සිංහල උපසිරැසි ගොනුව (.zip) කෙලින්ම ඩවුන්ලෝඩ් කරගන්න පුළුවන්.

✈️ Telegram Download: 720p, 1080p Bluray කොපි ටෙලිග්‍රෑම් චැනල් එක හරහා ගන්න පුළුවන්.', '2006-01-01', 50, 8.6, 'https://image.tmdb.org/t/p/original/rmhoMEHK3ZP2EAXX2VpxuKpW3Bf.jpg', '2026-08-22 06:41:53.87792+00', '2026-08-22 06:41:53.87792+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('c76266a7-b1af-495b-a285-639c3c6c757a', 'd8cfb2ad-122c-4233-a3c4-1e5273a7950a', 10, 'Episode 10', '🕵️‍♂️ Dexter Season 1 Episode 10 - සිංහල උපසිරැසි 🎬

Dexter Season 1 delivers a brilliant, darkly comedic psychological crime thriller from Showtime. A brilliant Miami forensics expert leads a double life as a meticulous vigilante serial killer who only hunts down other murderers. When a mysterious new killer begins leaving bloodless clues just for him, a high-stakes psychological game of cat-and-mouse begins.

ඔන්න අරගෙන ආවා Crime, Mystery වගේම Psychological Thriller කතාවලට ආස කරන අය හැමෝම අනිවාර්යයෙන්ම බලන්න ඕනේ, Showtime නාලිකාවෙන් නිකුත් කරපු ලෝක ප්‍රසිද්ධ ''Dexter'' කතා මාලාවේ පළමු කතා සමයේ (Season 1) දහවැනි කොටසට (Episode 10) සිංහල උපසිරැසි. IMDb එකේ 8.6/10ක ඉහළම රේටින් එකක් ගත්ත මේ සීරීස් එක, මුල ඉඳන් අගටම කුතුහලය උපරිමයෙන්ම තියාගෙන බලන්න පුළුවන් විශිෂ්ටතම නිර්මාණයක්.

කතාව පැත්තට ගියොත්, ඩෙක්ස්ටර් මෝගන් (Michael C. Hall) කියන්නේ මියාමි පොලිසියේ වැඩ කරන, ලේ පැල්ලම් ගැන පරීක්ෂණ පවත්වන දක්ෂ නිලධාරියෙක්. හැබැයි හැමෝටම පේන මේ සාමාන්‍ය ජීවිතයට අමතරව ඩෙක්ස්ටර්ට තව අඳුරු රහස් ජීවිතයක් තියෙනවා. ඒ තමයි එයා රෑට නීතියෙන් බේරිලා යන දරුණු වැරදිකරුවන් සොයාගෙන ඔවුන්ට දඬුවම් කරන රහසිගත ක්‍රියාකාරියෙක් (Vigilante) විදිහට වැඩ කරන එක. එයා මේ දේ කරන්නේ එයාගේ හදාගත්ත තාත්තා කියලා දුන්න දැඩි සීමාවන් සහ නීති මාලාවකට (The Code of Harry) අනුවයි.

මේ අතරේ මියාමි නගරයේ අමුතුම විදිහට අපරාධකරන අලුත් කෙනෙක් මතුවෙනවා. ''Ice Truck Killer'' විදිහට හඳුන්වන මේ පුද්ගලයා, තමන්ගේ ඉලක්කයන් ලේ බිඳක්වත් නැතිව සකසා පොදු ස්ථානවල දාලා යනවා. ඒ වගේම එයා ඩෙක්ස්ටර්ට විතරක් තේරෙන රහස් ඉඟි ඉතුරු කරමින් ඩෙක්ස්ටර් එක්ක අමුතුම මානසික සෙල්ලමක් කරන්න පටන් ගන්නවා. මේ රහස්‍ය පුද්ගලයා කවුද? එයා ඩෙක්ස්ටර් ගැන දන්නේ කොහොමද?

Michael C. Hall ගේ සුපිරිම රංගනයෙන් හැඩවුණු, හැම තත්පරේම කුතුහලයෙන් වගේම දරුණු suspense එකකින් බලන්න පුළුවන් මේ පට්ටම කතාව ඔයාගේ Must Watch ලිස්ට් එකට අනිවාර්යයෙන්ම එකතු කරගන්න.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නේ මෙහෙමයි:

📄 Direct Download: කිසිම කරදරයක් නැතුව සිංහල උපසිරැසි ගොනුව (.zip) කෙලින්ම ඩවුන්ලෝඩ් කරගන්න පුළුවන්.

✈️ Telegram Download: 720p, 1080p Bluray කොපි ටෙලිග්‍රෑම් චැනල් එක හරහා ගන්න පුළුවන්.', '2006-01-01', 50, 8.6, 'https://image.tmdb.org/t/p/original/rmhoMEHK3ZP2EAXX2VpxuKpW3Bf.jpg', '2026-08-22 06:41:53.87792+00', '2026-08-22 06:41:53.87792+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('26d98b77-da16-4f1c-a97b-7c006c9c9961', 'd8cfb2ad-122c-4233-a3c4-1e5273a7950a', 11, 'Episode 11', '🕵️‍♂️ Dexter Season 1 Episode 11 - සිංහල උපසිරැසි 🎬

Dexter Season 1 delivers a brilliant, darkly comedic psychological crime thriller from Showtime. A brilliant Miami forensics expert leads a double life as a meticulous vigilante serial killer who only hunts down other murderers. When a mysterious new killer begins leaving bloodless clues just for him, a high-stakes psychological game of cat-and-mouse begins.

ඔන්න අරගෙන ආවා Crime, Mystery වගේම Psychological Thriller කතාවලට ආස කරන අය හැමෝම අනිවාර්යයෙන්ම බලන්න ඕනේ, Showtime නාලිකාවෙන් නිකුත් කරපු ලෝක ප්‍රසිද්ධ ''Dexter'' කතා මාලාවේ පළමු කතා සමයේ (Season 1) එකොළොස්වැනි කොටසට (Episode 11) සිංහල උපසිරැසි. IMDb එකේ 8.6/10ක ඉහළම රේටින් එකක් ගත්ත මේ සීරීස් එක, මුල ඉඳන් අගටම කුතුහලය උපරිමයෙන්ම තියාගෙන බලන්න පුළුවන් විශිෂ්ටතම නිර්මාණයක්.

කතාව පැත්තට ගියොත්, ඩෙක්ස්ටර් මෝගන් (Michael C. Hall) කියන්නේ මියාමි පොලිසියේ වැඩ කරන, ලේ පැල්ලම් ගැන පරීක්ෂණ පවත්වන දක්ෂ නිලධාරියෙක්. හැබැයි හැමෝටම පේන මේ සාමාන්‍ය ජීවිතයට අමතරව ඩෙක්ස්ටර්ට තව අඳුරු රහස් ජීවිතයක් තියෙනවා. ඒ තමයි එයා රෑට නීතියෙන් බේරිලා යන දරුණු වැරදිකරුවන් සොයාගෙන ඔවුන්ට දඬුවම් කරන රහසිගත ක්‍රියාකාරියෙක් (Vigilante) විදිහට වැඩ කරන එක. එයා මේ දේ කරන්නේ එයාගේ හදාගත්ත තාත්තා කියලා දුන්න දැඩි සීමාවන් සහ නීති මාලාවකට (The Code of Harry) අනුවයි.

මේ අතරේ මියාමි නගරයේ අමුතුම විදිහට අපරාධකරන අලුත් කෙනෙක් මතුවෙනවා. ''Ice Truck Killer'' විදිහට හඳුන්වන මේ පුද්ගලයා, තමන්ගේ ඉලක්කයන් ලේ බිඳක්වත් නැතිව සකසා පොදු ස්ථානවල දාලා යනවා. ඒ වගේම එයා ඩෙක්ස්ටර්ට විතරක් තේරෙන රහස් ඉඟි ඉතුරු කරමින් ඩෙක්ස්ටර් එක්ක අමුතුම මානසික සෙල්ලමක් කරන්න පටන් ගන්නවා. මේ රහස්‍ය පුද්ගලයා කවුද? එයා ඩෙක්ස්ටර් ගැන දන්නේ කොහොමද?

Michael C. Hall ගේ සුපිරිම රංගනයෙන් හැඩවුණු, හැම තත්පරේම කුතුහලයෙන් වගේම දරුණු suspense එකකින් බලන්න පුළුවන් මේ පට්ටම කතාව ඔයාගේ Must Watch ලිස්ට් එකට අනිවාර්යයෙන්ම එකතු කරගන්න.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නේ මෙහෙමයි:

📄 Direct Subtitle Download: කිසිම කරදරයක් නැතුව සිංහල උපසිරැසි ගොනුව (.zip) කෙලින්ම ඩවුන්ලෝඩ් කරගන්න පුළුවන්.

✈️ Telegram Download: 720p, 1080p Bluray කොපි ටෙලිග්‍රෑම් චැනල් එක හරහා ගන්න පුළුවන්.', '2006-01-01', 50, 8.6, 'https://image.tmdb.org/t/p/original/rmhoMEHK3ZP2EAXX2VpxuKpW3Bf.jpg', '2026-08-22 06:41:53.87792+00', '2026-08-22 06:41:53.87792+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;
INSERT INTO episodes (id, season_id, episode_number, title, description, air_date, runtime, imdb_rating, still_path, created_at, updated_at) VALUES ('68dc79b9-258e-4dde-aee1-9f97be5e997e', 'd8cfb2ad-122c-4233-a3c4-1e5273a7950a', 12, 'Episode 12', '🕵️‍♂️ Dexter Season 1 Episode 12 - සිංහල උපසිරැසි 🎬

Dexter Season 1 delivers a brilliant, darkly comedic psychological crime thriller from Showtime. A brilliant Miami forensics expert leads a double life as a meticulous vigilante serial killer who only hunts down other murderers. When a mysterious new killer begins leaving bloodless clues just for him, a high-stakes psychological game of cat-and-mouse begins.

ඔන්න අරගෙන ආවා Crime, Mystery වගේම Psychological Thriller කතාවලට ආස කරන අය හැමෝම අනිවාර්යයෙන්ම බලන්න ඕනේ, Showtime නාලිකාවෙන් නිකුත් කරපු ලෝක ප්‍රසිද්ධ ''Dexter'' කතා මාලාවේ පළමු කතා සමයේ (Season 1) දොළොස්වැනි කොටසට (Episode 12) සිංහල උපසිරැසි. IMDb එකේ 8.6/10ක ඉහළම රේටින් එකක් ගත්ත මේ සීරීස් එක, මුල ඉඳන් අගටම කුතුහලය උපරිමයෙන්ම තියාගෙන බලන්න පුළුවන් විශිෂ්ටතම නිර්මාණයක්.

කතාව පැත්තට ගියොත්, ඩෙක්ස්ටර් මෝගන් (Michael C. Hall) කියන්නේ මියාමි පොලිසියේ වැඩ කරන, ලේ පැල්ලම් ගැන පරීක්ෂණ පවත්වන දක්ෂ නිලධාරියෙක්. හැබැයි හැමෝටම පේන මේ සාමාන්‍ය ජීවිතයට අමතරව ඩෙක්ස්ටර්ට තව අඳුරු රහස් ජීවිතයක් තියෙනවා. ඒ තමයි එයා රෑට නීතියෙන් බේරිලා යන දරුණු වැරදිකරුවන් සොයාගෙන ඔවුන්ට දඬුවම් කරන රහසිගත ක්‍රියාකාරියෙක් (Vigilante) විදිහට වැඩ කරන එක. එයා මේ දේ කරන්නේ එයාගේ හදාගත්ත තාත්තා කියලා දුන්න දැඩි සීමාවන් සහ නීති මාලාවකට (The Code of Harry) අනුවයි.

මේ අතරේ මියාමි නගරයේ අමුතුම විදිහට අපරාධකරන අලුත් කෙනෙක් මතුවෙනවා. ''Ice Truck Killer'' විදිහට හඳුන්වන මේ පුද්ගලයා, තමන්ගේ ඉලක්කයන් ලේ බිඳක්වත් නැතිව සකසා පොදු ස්ථානවල දාලා යනවා. ඒ වගේම එයා ඩෙක්ස්ටර්ට විතරක් තේරෙන රහස් ඉඟි ඉතුරු කරමින් ඩෙක්ස්ටර් එක්ක අමුතුම මානසික සෙල්ලමක් කරන්න පටන් ගන්නවා. මේ රහස්‍ය පුද්ගලයා කවුද? එයා ඩෙක්ස්ටර් ගැන දන්නේ කොහොමද?

Michael C. Hall ගේ සුපිරිම රංගනයෙන් හැඩවුණු, හැම තත්පරේම කුතුහලයෙන් වගේම දරුණු suspense එකකින් බලන්න පුළුවන් මේ පට්ටම කතාව ඔයාගේ Must Watch ලිස්ට් එකට අනිවාර්යයෙන්ම එකතු කරගන්න.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නේ මෙහෙමයි:

📄 Direct Subtitle Download: කිසිම කරදරයක් නැතුව සිංහල උපසිරැසි ගොනුව (.zip) කෙලින්ම ඩවුන්ලෝඩ් කරගන්න පුළුවන්.

✈️ Telegram Download: 720p, 1080p Bluray කොපි ටෙලිග්‍රෑම් චැනල් එක හරහා ගන්න පුළුවන්.', '2006-01-01', 50, 8.6, 'https://image.tmdb.org/t/p/original/rmhoMEHK3ZP2EAXX2VpxuKpW3Bf.jpg', '2026-08-22 06:41:53.87792+00', '2026-08-22 06:41:53.87792+00') ON CONFLICT (season_id, episode_number) DO UPDATE SET description = EXCLUDED.description;

-- 4. SUBTITLES
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('36124c1c-3504-4a91-ac8e-abbce556743e', NULL, '912b2ab3-2322-42ae-a212-39b1028bfe63', 'Sinhala', 'https://vtzndlehoqopaxdxmwim.supabase.co/storage/v1/object/public/pixelpoplk/SOA_S01_E01_Sinhala.zip?download', 'SOA_S01_E01_Sinhala.zip', 'WEB-DL', 23, '00000000-0000-0000-0000-000000000001', '2026-07-02 20:20:47.74712+00', '2026-07-02 20:20:47.74712+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('7720a4f3-766b-467b-a601-039080ca1d03', NULL, 'd7d2a13f-ed0a-452d-a330-aa6b930a31ec', 'Sinhala', 'https://vtzndlehoqopaxdxmwim.supabase.co/storage/v1/object/public/pixelpoplk/House%20of%20the%20dragon/House_of_the_Dragon_S03E03_57837.zip?download', 'House_of_the_Dragon_S03E03_57837.zip', 'WEB-DL', 5, '00000000-0000-0000-0000-000000000001', '2026-07-05 19:07:04.212977+00', '2026-07-05 19:07:04.212977+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('c2943c10-1476-4c36-a069-ce979b0dc98c', NULL, 'e9ec4820-ae59-4c5d-a2d2-a0bfeb571b49', 'Sinhala', 'https://vtzndlehoqopaxdxmwim.supabase.co/storage/v1/object/public/pixelpoplk/SOA/Sons_Of_Anarchy_S01E02_3691.zip?download', 'Sons_Of_Anarchy_S01E02_3691.zip', 'WEB-DL', 11, '00000000-0000-0000-0000-000000000001', '2026-07-06 17:23:49.258164+00', '2026-07-06 17:23:49.258164+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('d2864337-1b97-4f01-a412-e2a070183980', NULL, '130421e6-7fff-48bc-acbc-b6413b7d7f95', 'Sinhala', 'https://vtzndlehoqopaxdxmwim.supabase.co/storage/v1/object/public/pixelpoplk/SOA/Sons_Of_Anarchy_S01E03_3616.zip?download', 'Sons_Of_Anarchy_S01E03_3616.zip', 'WEB-DL', 8, '00000000-0000-0000-0000-000000000001', '2026-07-06 18:51:33.429257+00', '2026-07-06 18:51:33.429257+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('91642223-c2e7-42f0-aab0-5e9154274867', NULL, '6eab0a74-a85c-43d3-adde-3708df59e4fa', 'Sinhala', 'https://vtzndlehoqopaxdxmwim.supabase.co/storage/v1/object/public/pixelpoplk/SOA/Sons_Of_Anarchy_S01E04_4855.zip?download', 'Sons_Of_Anarchy_S01E04_4855.zip', 'WEB-DL', 9, '00000000-0000-0000-0000-000000000001', '2026-07-06 18:51:33.429257+00', '2026-07-06 18:51:33.429257+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('df32efe0-4689-4233-a14c-d156020a576b', NULL, '80cbe5f1-9a04-4c31-a897-2ad12135327c', 'Sinhala', 'https://vtzndlehoqopaxdxmwim.supabase.co/storage/v1/object/public/pixelpoplk/SOA/Sons_Of_Anarchy_S01E05_1485.zip?download', 'Sons_Of_Anarchy_S01E05_1485.zip', 'WEB-DL', 8, '00000000-0000-0000-0000-000000000001', '2026-07-06 18:51:33.429257+00', '2026-07-06 18:51:33.429257+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('8223ab00-e98d-4d71-addc-14161e0014fc', NULL, '08367973-c5da-4826-a0c3-50c6b8ea613b', 'Sinhala', 'https://vtzndlehoqopaxdxmwim.supabase.co/storage/v1/object/public/pixelpoplk/SOA/Sons_Of_Anarchy_S01E06_6892.zip?download', 'Sons_Of_Anarchy_S01E06_6892.zip', 'WEB-DL', 7, '00000000-0000-0000-0000-000000000001', '2026-07-06 18:51:33.429257+00', '2026-07-06 18:51:33.429257+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('62d2c09b-2a56-49fa-a4bb-837c4a72d906', NULL, '7b534471-5ec0-428a-a903-a492f0bac484', 'Sinhala', 'https://vtzndlehoqopaxdxmwim.supabase.co/storage/v1/object/public/pixelpoplk/SOA/Sons_Of_Anarchy_S01E07_8763.zip?download', 'Sons_Of_Anarchy_S01E07_8763.zip', 'WEB-DL', 9, '00000000-0000-0000-0000-000000000001', '2026-07-06 18:51:33.429257+00', '2026-07-06 18:51:33.429257+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('44c918db-3ae3-4202-a795-71725e0a4e96', NULL, '4d044d42-83db-4d92-ab9d-5e844d46af80', 'Sinhala', 'https://vtzndlehoqopaxdxmwim.supabase.co/storage/v1/object/public/pixelpoplk/SOA/Sons_Of_Anarchy_S01E08_7873.zip?download', 'Sons_Of_Anarchy_S01E08_7873.zip', 'WEB-DL', 9, '00000000-0000-0000-0000-000000000001', '2026-07-06 18:51:33.429257+00', '2026-07-06 18:51:33.429257+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('5aeb99cb-3b64-42dd-aedc-e031ec9b4ab7', NULL, '7e74aa1f-e5a1-404b-afad-d34277775c00', 'Sinhala', 'https://vtzndlehoqopaxdxmwim.supabase.co/storage/v1/object/public/pixelpoplk/SOA/Sons_Of_Anarchy_S01E09_1648.zip?download', 'Sons_Of_Anarchy_S01E09_1648.zip', 'WEB-DL', 9, '00000000-0000-0000-0000-000000000001', '2026-07-06 18:51:33.429257+00', '2026-07-06 18:51:33.429257+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('57eb357f-718b-4c41-a49b-729e60567fa1', NULL, 'ccf25e3d-dce1-489e-a7e3-887f3e3684a4', 'Sinhala', 'https://vtzndlehoqopaxdxmwim.supabase.co/storage/v1/object/public/pixelpoplk/SOA/Sons_Of_Anarchy_S01E10_7404.zip?download', 'Sons_Of_Anarchy_S01E10_7404.zip', 'WEB-DL', 8, '00000000-0000-0000-0000-000000000001', '2026-07-06 18:51:33.429257+00', '2026-07-06 18:51:33.429257+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('e4ae03a3-4e20-4241-ae39-b7fea5ef16a3', NULL, '9b1833d7-6b9d-450e-a1e1-c8c474fac864', 'Sinhala', 'https://vtzndlehoqopaxdxmwim.supabase.co/storage/v1/object/public/pixelpoplk/SOA/Sons_Of_Anarchy_S01E11_1885.zip?download', 'Sons_Of_Anarchy_S01E11_1885.zip', 'WEB-DL', 8, '00000000-0000-0000-0000-000000000001', '2026-07-06 18:51:33.429257+00', '2026-07-06 18:51:33.429257+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('f360ad6e-1ae8-4232-ac8a-e26466913486', NULL, '0080317b-1392-475f-a627-015e66067c91', 'Sinhala', 'https://vtzndlehoqopaxdxmwim.supabase.co/storage/v1/object/public/pixelpoplk/SOA/Sons_Of_Anarchy_S01E12_4957.zip?download', 'Sons_Of_Anarchy_S01E12_4957.zip', 'WEB-DL', 8, '00000000-0000-0000-0000-000000000001', '2026-07-06 18:51:33.429257+00', '2026-07-06 18:51:33.429257+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('079e666f-0659-40a7-ad9f-44ca2369ba9c', NULL, '0ce713eb-5148-4a97-a6e0-76a1beebc49f', 'Sinhala', 'https://vtzndlehoqopaxdxmwim.supabase.co/storage/v1/object/public/pixelpoplk/SOA/Sons_Of_Anarchy_S01E13_9695.zip?download', 'Sons_Of_Anarchy_S01E13_9695.zip', 'WEB-DL', 8, '00000000-0000-0000-0000-000000000001', '2026-07-06 18:51:33.429257+00', '2026-07-06 18:51:33.429257+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('dcab1b05-ace9-439b-a3a0-11fc1dbf45a9', NULL, '501b9add-7c98-4b1f-a385-fde8dfc42fa5', 'Sinhala', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%201/Sons_Of_Anarchy_S02E01_7168.zip?download', 'Sons_Of_Anarchy_S02E01_7168.zip', 'WEB-DL', 39, '00000000-0000-0000-0000-000000000001', '2026-07-10 21:03:45.984807+00', '2026-07-10 21:03:45.984807+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('45e03762-3623-4dd5-a832-d46d9873e899', NULL, '2d08b8d2-2930-4b28-ac73-1d109580fda9', 'Sinhala', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%201/Sons_Of_Anarchy_S02E02_7183.zip?download', 'Sons_Of_Anarchy_S02E02_7183.zip', 'WEB-DL', 13, '00000000-0000-0000-0000-000000000001', '2026-07-10 21:03:45.984807+00', '2026-07-10 21:03:45.984807+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('cb95be8f-64cc-4945-a63b-b7bda3d03154', NULL, '7776b392-0042-4380-aba5-edd834ecd8c1', 'Sinhala', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%201/Sons_Of_Anarchy_S02E03_7683.zip?download', 'Sons_Of_Anarchy_S02E03_7683.zip', 'WEB-DL', 13, '00000000-0000-0000-0000-000000000001', '2026-07-10 21:03:45.984807+00', '2026-07-10 21:03:45.984807+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('ab1daf74-3181-4f54-a920-a1ffb4ce6636', NULL, 'fe745258-41e9-440d-ac56-9089056e8162', 'Sinhala', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%201/Sons_Of_Anarchy_S02E04_4852.zip?download', 'Sons_Of_Anarchy_S02E04_4852.zip', 'WEB-DL', 10, '00000000-0000-0000-0000-000000000001', '2026-07-10 21:03:45.984807+00', '2026-07-10 21:03:45.984807+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('d1bd2a3e-d883-4b19-ac1c-85685967e902', NULL, 'b076b5cd-62f0-45cd-a063-a84af0ed7dcb', 'Sinhala', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%201/Sons_Of_Anarchy_S02E05_4480.zip?download', 'Sons_Of_Anarchy_S02E05_4480.zip', 'WEB-DL', 11, '00000000-0000-0000-0000-000000000001', '2026-07-10 21:03:45.984807+00', '2026-07-10 21:03:45.984807+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('aa676648-b4ff-4173-a6e7-711ffc4d64b8', NULL, '9fa4c5a1-d432-4f13-a729-a8f1ee92775a', 'Sinhala', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%201/Sons_Of_Anarchy_S02E06_1294.zip?download', 'Sons_Of_Anarchy_S02E06_1294.zip', 'WEB-DL', 9, '00000000-0000-0000-0000-000000000001', '2026-07-10 21:03:45.984807+00', '2026-07-10 21:03:45.984807+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('ecbd2e57-36f1-41b8-a60c-e79bbb285738', NULL, 'fee1a5ec-118e-4f40-a7dd-dbf61b9b671d', 'Sinhala', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Hotd/House.of.the.Dragon.S03E04.WEBRip.Sinhala_2054.zip?download', 'House.of.the.Dragon.S03E04.WEBRip.Sinhala_2054.zip', 'WEB-DL', 12, '00000000-0000-0000-0000-000000000001', '2026-07-13 01:46:09.988815+00', '2026-07-13 01:46:09.988815+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('5be46e98-030d-42f6-a9fc-28234f408bb3', '8990c886-92d6-4bc3-a5bb-2bca8f3a9a8a', NULL, 'Sinhala', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Movies/Backrooms%202026/Backrooms.2026.WEBRip.HEVC-PSA.mkv3_sinhala-646474.zip?download', 'Backrooms.2026.WEBRip.HEVC-PSA.mkv3_sinhala-646474.zip', 'WEB-DL', 0, '00000000-0000-0000-0000-000000000001', '2026-07-14 05:32:34.672294+00', '2026-07-14 05:32:34.672294+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('8c40211c-05e4-43a9-a471-b15733efea9a', NULL, '5865956a-2dea-490d-aca4-e12a48b4052c', 'Sinhala', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%202/Sons_Of_Anarchy_S02E07_8737.zip?download', 'Sons_Of_Anarchy_S02E07_8737.zip', 'WEB-DL', 7, '00000000-0000-0000-0000-000000000001', '2026-07-14 11:59:44.37195+00', '2026-07-14 11:59:44.37195+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('10718d30-82f7-4beb-a38b-e4f5c9b63ad3', NULL, 'e9b7dc41-4868-4e77-af89-5bf4f29c0b78', 'Sinhala', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%202/Sons_Of_Anarchy_S02E08_2643.zip?download', 'Sons_Of_Anarchy_S02E08_2643.zip', 'WEB-DL', 8, '00000000-0000-0000-0000-000000000001', '2026-07-14 11:59:44.37195+00', '2026-07-14 11:59:44.37195+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('52df90ec-e681-47e8-a974-48fe0606a352', NULL, 'ec3e5305-ec7d-47f1-a8a7-98ee6baca31f', 'Sinhala', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%202/Sons_Of_Anarchy_S02E09_2950.zip?download', 'Sons_Of_Anarchy_S02E09_2950.zip', 'WEB-DL', 8, '00000000-0000-0000-0000-000000000001', '2026-07-14 11:59:44.37195+00', '2026-07-14 11:59:44.37195+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('1c986f8a-f90e-4678-a4d3-5cdcb0f62e29', NULL, '455acaea-abe3-4ef2-a545-cf518a7d60cb', 'Sinhala', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%202/Sons_Of_Anarchy_S02E10_4053.zip?download', 'Sons_Of_Anarchy_S02E10_4053.zip', 'WEB-DL', 8, '00000000-0000-0000-0000-000000000001', '2026-07-14 11:59:44.37195+00', '2026-07-14 11:59:44.37195+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('af52fef8-3f80-4f32-a8a0-14f5a499bd6a', NULL, '3bc7f956-2b03-447e-af1b-30679dddddc9', 'Sinhala', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%202/Sons_Of_Anarchy_S02E11_4099.zip?download', 'Sons_Of_Anarchy_S02E11_4099.zip', 'WEB-DL', 7, '00000000-0000-0000-0000-000000000001', '2026-07-14 11:59:44.37195+00', '2026-07-14 11:59:44.37195+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('6742b275-661a-4bd6-a973-9a4ecabcb62e', NULL, '72b6fbc9-3c36-443a-a6b5-1e337dec79d5', 'Sinhala', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%202/Sons_Of_Anarchy_S02E12_1658.zip?download', 'Sons_Of_Anarchy_S02E12_1658.zip', 'WEB-DL', 8, '00000000-0000-0000-0000-000000000001', '2026-07-14 11:59:44.37195+00', '2026-07-14 11:59:44.37195+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('b876d769-1808-45bf-a3c0-9339fd8aee7d', NULL, '47bed304-d417-4d22-a9a4-46ff0c3ca728', 'Sinhala', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%202/Sons_Of_Anarchy_S02E13_7779.zip?download', 'Sons_Of_Anarchy_S02E13_7779.zip', 'WEB-DL', 9, '00000000-0000-0000-0000-000000000001', '2026-07-14 11:59:44.37195+00', '2026-07-14 11:59:44.37195+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('2832fde1-721a-416c-aa74-ab9566cddf88', NULL, 'd2606136-6589-4216-a7d7-c921c52d8391', 'Sinhala', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%203/Sons_Of_Anarchy_S03E01_580550.zip', 'Sons_Of_Anarchy_S03E01_580550.zip', 'WEB-DL', 8, '00000000-0000-0000-0000-000000000001', '2026-07-16 15:21:01.297081+00', '2026-07-16 15:21:01.297081+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('87d20106-907b-476f-a83e-eb3c05fe65fa', NULL, 'c372ba8b-3837-47ca-a53c-0358a144f9b3', 'Sinhala', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%203/Sons_Of_Anarchy_S03E02_115537.zip', 'Sons_Of_Anarchy_S03E02_115537.zip', 'WEB-DL', 7, '00000000-0000-0000-0000-000000000001', '2026-07-16 15:21:01.297081+00', '2026-07-16 15:21:01.297081+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('dfd7b290-492d-4734-ab93-1297ab098f96', NULL, '94cfd6ac-c1e9-43ba-ac16-a9c366bdfdff', 'Sinhala', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%203/Sons_Of_Anarchy_S03E03_148829.zip', 'Sons_Of_Anarchy_S03E03_148829.zip', 'WEB-DL', 8, '00000000-0000-0000-0000-000000000001', '2026-07-16 15:21:01.297081+00', '2026-07-16 15:21:01.297081+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('53c444fc-27e1-4387-ac7e-e7c88667f9ab', NULL, 'd4f49640-ccda-488e-a7f9-c4000d59fb2c', 'Sinhala', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%203/Sons_Of_Anarchy_S03E04_789789.zip', 'Sons_Of_Anarchy_S03E04_789789.zip', 'WEB-DL', 8, '00000000-0000-0000-0000-000000000001', '2026-07-16 15:21:01.297081+00', '2026-07-16 15:21:01.297081+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('c6f95653-0552-4e98-a621-40b129a84d82', NULL, 'eb619e4d-c2a6-4733-afa2-695c040bbb71', 'Sinhala', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%203/Sons_Of_Anarchy_S03E05_586816.zip', 'Sons_Of_Anarchy_S03E05_586816.zip', 'WEB-DL', 11, '00000000-0000-0000-0000-000000000001', '2026-07-16 15:21:01.297081+00', '2026-07-16 15:21:01.297081+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('8bbebc7c-bc08-4c16-a0de-290be4dac7cb', NULL, '98fa1ea1-770d-4fff-acf6-d188e48d4edd', 'Sinhala', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%203/Sons_Of_Anarchy_S03E06_7243.zip?download', 'Sons_Of_Anarchy_S03E06_7243.zip', 'WEB-DL', 8, '00000000-0000-0000-0000-000000000001', '2026-07-17 13:58:47.835069+00', '2026-07-17 13:58:47.835069+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('4600e276-9c15-4d40-a37a-5f391bfa4993', NULL, 'bac9e140-45d0-4d60-a9e7-65013015e9a6', 'Sinhala', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%203/Sons_Of_Anarchy_S03E07_6877.zip?download', 'Sons_Of_Anarchy_S03E07_6877.zip', 'WEB-DL', 8, '00000000-0000-0000-0000-000000000001', '2026-07-17 13:58:47.835069+00', '2026-07-17 13:58:47.835069+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('f89c85a1-d73b-419a-a11b-7ca9da1f0942', NULL, 'aad2f5ff-8b1a-4227-a69d-738f6fd09262', 'Sinhala', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%203/Sons_Of_Anarchy_S03E08_1329.zip?download', 'Sons_Of_Anarchy_S03E08_1329.zip', 'WEB-DL', 7, '00000000-0000-0000-0000-000000000001', '2026-07-17 13:58:47.835069+00', '2026-07-17 13:58:47.835069+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('a4e91b5a-683e-424e-a1e0-8d8f0b63ae6f', NULL, 'b5e206f2-b7b4-463d-a793-aa55f5fc5203', 'Sinhala', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%203/Sons_Of_Anarchy_S03E09_5879.zip?download', 'Sons_Of_Anarchy_S03E09_5879.zip', 'WEB-DL', 21, '00000000-0000-0000-0000-000000000001', '2026-07-17 13:58:47.835069+00', '2026-07-17 13:58:47.835069+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('d737d99a-b134-4662-aa84-883261de9d4c', NULL, '17d1f196-4d18-4d69-aefc-4b0ae10dd230', 'Sinhala', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%203/Sons_Of_Anarchy_S03E10_3995.zip?download', 'Sons_Of_Anarchy_S03E10_3995.zip', 'WEB-DL', 11, '00000000-0000-0000-0000-000000000001', '2026-07-17 13:58:47.835069+00', '2026-07-17 13:58:47.835069+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('909c58f3-f9c0-4501-af3a-0cfff8d96fef', NULL, 'eeeb736f-887f-4f3b-aa8f-57e090848623', 'Sinhala', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%203/Sons_Of_Anarchy_S03E11_5255.zip?download', 'Sons_Of_Anarchy_S03E11_5255.zip', 'WEB-DL', 8, '00000000-0000-0000-0000-000000000001', '2026-07-17 13:58:47.835069+00', '2026-07-17 13:58:47.835069+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('dd7adc8c-6a8f-43dd-a4c0-4a0a334bffdb', NULL, 'a5dff875-a09a-4e56-af63-63bce732bf92', 'Sinhala', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%203/Sons_Of_Anarchy_S03E12_2901.zip?download', 'Sons_Of_Anarchy_S03E12_2901.zip', 'WEB-DL', 12, '00000000-0000-0000-0000-000000000001', '2026-07-17 13:58:47.835069+00', '2026-07-17 13:58:47.835069+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('23d57ba3-e5f5-432b-ae27-87207ce1cb3b', NULL, '1fe002bc-e2d9-46da-abc4-32ef92d71d6b', 'Sinhala', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%203/Sons_Of_Anarchy_S03E13_3764.zip?download', 'Sons_Of_Anarchy_S03E13_3764.zip', 'WEB-DL', 10, '00000000-0000-0000-0000-000000000001', '2026-07-17 13:58:47.835069+00', '2026-07-17 13:58:47.835069+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('ee723d68-4be6-4e0b-ae66-f59f7d00825c', NULL, 'f3bdae01-5b44-4098-a794-4703410f491c', 'Sinhala', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/The%20east%20palace%202026/Season%201/The.East.Palace.2026.S01E01.NF.WEB-DL_Sinhala.17637.zip?download', 'The.East.Palace.2026.S01E01.NF.WEB-DL_Sinhala.17637.zip', 'WEB-DL', 0, '00000000-0000-0000-0000-000000000001', '2026-07-18 06:07:52.262353+00', '2026-07-18 06:07:52.262353+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('f46a4aff-9a7a-4b62-a014-5179a3fb8c0e', NULL, '22c151e6-99ac-4fce-a987-8437b8e36a56', 'Sinhala', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/The%20east%20palace%202026/Season%201/The.East.Palace.2026.S01E02.NF.WEB-DL_Sinhala.573636.zip?download', 'The.East.Palace.2026.S01E02.NF.WEB-DL_Sinhala.573636.zip', 'WEB-DL', 0, '00000000-0000-0000-0000-000000000001', '2026-07-18 06:09:35.713148+00', '2026-07-18 06:09:35.713148+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('2dc2f7e8-9774-40fd-a1a2-e1afeb1fcf0d', NULL, 'dc7822df-1754-4be2-aed8-add4988a3e02', 'Sinhala', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/The%20east%20palace%202026/Season%201/The_East_Palace_2026_S01E03_825657.zip?download', 'The_East_Palace_2026_S01E03_825657.zip', 'WEB-DL', 0, '00000000-0000-0000-0000-000000000001', '2026-07-18 17:41:59.995576+00', '2026-07-18 17:41:59.995576+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('00e62995-120f-462c-a278-a3b5941389b5', NULL, 'b1794662-3545-48b5-ab09-f0694d94b947', 'Sinhala', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/The%20east%20palace%202026/Season%201/The_East_Palace_2026_S01E04_855866.zip?download', 'The_East_Palace_2026_S01E04_855866.zip', 'WEB-DL', 0, '00000000-0000-0000-0000-000000000001', '2026-07-18 17:41:59.995576+00', '2026-07-18 17:41:59.995576+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('65bcd59a-07fe-4105-a294-dc068bf4ddca', NULL, '3d5128aa-b66b-4def-adb5-e834b398b028', 'Sinhala', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/The%20east%20palace%202026/Season%201/The_East_Palace_2026_S01E05_465698.zip?download', 'The_East_Palace_2026_S01E05_465698.zip', 'WEB-DL', 0, '00000000-0000-0000-0000-000000000001', '2026-07-18 17:41:59.995576+00', '2026-07-18 17:41:59.995576+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('f326f2fd-254c-4ac8-aab5-a432912413c9', NULL, '413fcb34-2c58-4f47-ac85-9d81465233d6', 'Sinhala', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/The%20east%20palace%202026/Season%201/The_East_Palace_2026_S01E06_248056.zip?download', 'The_East_Palace_2026_S01E06_248056.zip', 'WEB-DL', 0, '00000000-0000-0000-0000-000000000001', '2026-07-18 17:41:59.995576+00', '2026-07-18 17:41:59.995576+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('028851e3-76e2-445a-a83c-1b20ac924878', NULL, '74eeabd1-00f9-4c43-a0d7-e3aff995fa5f', 'Sinhala', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/The%20east%20palace%202026/Season%201/The_East_Palace_2026_S01E07_286656.zip?download', 'The_East_Palace_2026_S01E07_286656.zip', 'WEB-DL', 0, '00000000-0000-0000-0000-000000000001', '2026-07-18 17:41:59.995576+00', '2026-07-18 17:41:59.995576+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('a5c180d4-a26c-4a2c-a85a-ea3b3dd381cc', NULL, '81b3aec6-8271-4258-ad06-a768a577b139', 'Sinhala', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/The%20east%20palace%202026/Season%201/The_East_Palace_2026_S01E08_769245.zip?download', 'The_East_Palace_2026_S01E08_769245.zip', 'WEB-DL', 0, '00000000-0000-0000-0000-000000000001', '2026-07-18 17:41:59.995576+00', '2026-07-18 17:41:59.995576+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('4a2a8fc8-0ecd-4f3e-a02c-df7485be60ea', NULL, 'e2653cfb-e48d-48b6-a5a4-089b70420785', 'Sinhala', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Hotd/House_of_the_Dragon_S03E01_WEBRip_PSA_Sinhala.srt?download', 'House_of_the_Dragon_S03E01_WEBRip_PSA_Sinhala.srt', 'WEB-DL', 7, '00000000-0000-0000-0000-000000000001', '2026-07-18 18:03:31.96276+00', '2026-07-18 18:03:31.96276+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('fc5f4b2c-4775-466d-a880-56ae429bffba', NULL, '9a2076e3-ab74-45b0-a531-2f1c5107a11b', 'Sinhala', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Hotd/House_of_the_Dragon_S03E01_WEBRip_PSA_Sinhala.srt', 'House_of_the_Dragon_S03E01_WEBRip_PSA_Sinhala.srt', 'WEB-DL', 17, '00000000-0000-0000-0000-000000000001', '2026-07-18 18:05:34.87458+00', '2026-07-18 18:05:34.87458+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('e659a5e1-53a9-4149-a016-584b67cbbe49', NULL, 'd9d4f053-4098-4a04-a98c-12d316731311', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S04e01%203180767/Sons_of_Anarchy_S04E01_3180767.zip?download', 'Sons_of_Anarchy_S04E01_3180767.zip', 'WEB-DL', 7, '00000000-0000-0000-0000-000000000001', '2026-07-19 18:04:00.986472+00', '2026-07-19 18:04:00.986472+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('f12f72d0-5472-4b62-a51f-3191df2b8bc9', NULL, '584d05cf-344d-40e2-a516-a59ef8c9f405', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S04e02%206308576/Sons_of_Anarchy_S04E02_6308576.zip?download', 'Sons_of_Anarchy_S04E02_6308576.zip', 'WEB-DL', 7, '00000000-0000-0000-0000-000000000001', '2026-07-19 18:04:00.986472+00', '2026-07-19 18:04:00.986472+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('070895ce-6419-4855-a126-977250abc47c', NULL, '03e6ba2d-e2ad-43d4-a63f-00fa5981cc0a', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S04e03%205399575/Sons_of_Anarchy_S04E03_5399575.zip?download', 'Sons_of_Anarchy_S04E03_5399575.zip', 'WEB-DL', 13, '00000000-0000-0000-0000-000000000001', '2026-07-19 18:04:00.986472+00', '2026-07-19 18:04:00.986472+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('12cce90b-4725-4db5-a335-fa6a709793b9', NULL, '164e67e9-f105-4bd5-a53f-300713a4c798', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S04e04%208766464/Sons_of_Anarchy_S04E04_8766464.zip?download', 'Sons_of_Anarchy_S04E04_8766464.zip', 'WEB-DL', 11, '00000000-0000-0000-0000-000000000001', '2026-07-19 18:04:00.986472+00', '2026-07-19 18:04:00.986472+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('93bb2334-c624-46ea-a64a-d21284a56c09', NULL, 'ae823c98-696b-4815-a6ac-824d6cb70553', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S04e05%203204565/Sons_of_Anarchy_S04E05_3204565.zip?download', 'Sons_of_Anarchy_S04E05_3204565.zip', 'WEB-DL', 6, '00000000-0000-0000-0000-000000000001', '2026-07-19 18:04:00.986472+00', '2026-07-19 18:04:00.986472+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('7522c967-ae12-4f98-a031-d6a3abe8dc44', NULL, 'ff5100c5-3704-4805-a6f3-22680b085332', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S04e06%206948575/Sons_of_Anarchy_S04E06_6948575.zip?download', 'Sons_of_Anarchy_S04E06_6948575.zip', 'WEB-DL', 4, '00000000-0000-0000-0000-000000000001', '2026-07-19 18:04:00.986472+00', '2026-07-19 18:04:00.986472+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('6416f935-10f6-445b-ae85-f8d7d067e07e', NULL, '2620c6d3-5a7c-437a-ad25-8e540e35f11b', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/House%20of%20the%20Dragon%20S03e05%202819756%20(/House_of_the_Dragon_S03E05_2819756%20(1).zip?download', 'House_of_the_Dragon_S03E05_2819756 (1).zip', 'WEB-DL', 9, '00000000-0000-0000-0000-000000000001', '2026-07-20 02:26:00.42846+00', '2026-07-20 02:26:00.42846+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('d715f9e9-f91a-4877-ab7e-fa8fd084f71e', '4419eb72-7023-4654-ab76-5d1c72a1306f', NULL, 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Disclosure%20Day/Disclosure.Day.2026.WEBRip.@pixelpoplk.6464646.zip?download', 'Disclosure.Day.2026.WEBRip.@pixelpoplk.6464646.zip', 'WEB-DL', 1, '00000000-0000-0000-0000-000000000001', '2026-07-21 08:01:41.770922+00', '2026-07-21 08:01:41.770922+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('f64f37c6-1207-4235-a32e-cefbb101400e', NULL, 'ff5ed374-49c1-433f-a96e-f0ec63cda0e9', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S04e07%205251/Sons_of_Anarchy_S04E07_5251.zip?download', 'Sons_of_Anarchy_S04E07_5251.zip', 'WEB-DL', 4, '00000000-0000-0000-0000-000000000001', '2026-07-21 11:40:15.630722+00', '2026-07-21 11:40:15.630722+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('9a14ef95-ff4c-45ec-a710-eefb38c4827b', NULL, '5d34ecf3-7cdb-4cef-af19-6de2d3d9ffbd', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S04e08%206510/Sons_of_Anarchy_S04E08_6510.zip?download', 'Sons_of_Anarchy_S04E08_6510.zip', 'WEB-DL', 4, '00000000-0000-0000-0000-000000000001', '2026-07-21 11:40:15.630722+00', '2026-07-21 11:40:15.630722+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('0b3f2250-ad61-4ff6-a90c-5111a94cad8b', NULL, '157e7c9b-0cfe-456e-a209-6a7f39104c6b', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S04e09%204320/Sons_of_Anarchy_S04E09_4320.zip?download', 'Sons_of_Anarchy_S04E09_4320.zip', 'WEB-DL', 4, '00000000-0000-0000-0000-000000000001', '2026-07-21 11:40:15.630722+00', '2026-07-21 11:40:15.630722+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('eb63289a-7fbd-4b57-a265-45c526e41eec', NULL, '048dc99f-6e98-40b0-aee8-99c4744c3fa3', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S04e10%207286/Sons_of_Anarchy_S04E10_7286.zip?download', 'Sons_of_Anarchy_S04E10_7286.zip', 'WEB-DL', 4, '00000000-0000-0000-0000-000000000001', '2026-07-21 11:40:15.630722+00', '2026-07-21 11:40:15.630722+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('a917abd9-a79e-4413-a16e-f5032d7819be', NULL, 'a5accf34-bbe8-4ec9-ad35-5d5586911ede', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S04e11%209798/Sons_of_Anarchy_S04E11_9798.zip?download', 'Sons_of_Anarchy_S04E11_9798.zip', 'WEB-DL', 4, '00000000-0000-0000-0000-000000000001', '2026-07-21 11:40:15.630722+00', '2026-07-21 11:40:15.630722+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('10382bab-64b6-494a-afa3-a5a420f5b31a', NULL, '0da19ae5-fa09-42ae-a07b-3f7df1a138fb', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S04e12%201909/Sons_of_Anarchy_S04E12_1909.zip?download', 'Sons_of_Anarchy_S04E12_1909.zip', 'WEB-DL', 3, '00000000-0000-0000-0000-000000000001', '2026-07-21 11:40:15.630722+00', '2026-07-21 11:40:15.630722+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('5bbf2c8c-a956-4d4a-addf-c516570590ac', NULL, 'b671121c-bb64-487d-a9fc-fc8a43896b3b', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S04e13%202358/Sons_of_Anarchy_S04E13_2358.zip?download', 'Sons_of_Anarchy_S04E13_2358.zip', 'WEB-DL', 3, '00000000-0000-0000-0000-000000000001', '2026-07-21 11:40:15.630722+00', '2026-07-21 11:40:15.630722+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('d21c761f-3c09-4599-af1d-5accc1e8bf01', NULL, 'ae98a8da-38d7-457c-ad73-f3fa36b05e71', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S04e14%207267/Sons_of_Anarchy_S04E14_7267.zip?download', 'Sons_of_Anarchy_S04E14_7267.zip', 'WEB-DL', 3, '00000000-0000-0000-0000-000000000001', '2026-07-21 11:40:15.630722+00', '2026-07-21 11:40:15.630722+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('bb91873a-92f4-443b-ac7b-4f143083321d', NULL, '71cdb260-6189-4909-a982-408b53b4a527', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Dune%20Prophecy%20S01e01%207379/Dune_Prophecy_S01E01_7379.zip?download', 'Dune_Prophecy_S01E01_7379.zip', 'WEB-DL', 0, '00000000-0000-0000-0000-000000000001', '2026-07-21 11:40:57.426392+00', '2026-07-21 11:40:57.426392+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('3da3144a-0307-40c0-a75b-8399812d683e', NULL, '2e3c75b7-62f9-4016-aeb3-0db275e4694e', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Dune%20Prophecy%20S01e02%204146/Dune_Prophecy_S01E02_4146.zip?download', 'Dune_Prophecy_S01E02_4146.zip', 'WEB-DL', 0, '00000000-0000-0000-0000-000000000001', '2026-07-21 11:40:57.426392+00', '2026-07-21 11:40:57.426392+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('893fbb63-501f-4c42-a326-0b02afa9d110', NULL, 'd75a210a-6176-46c7-a9b0-72c8257b7c94', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Dune%20Prophecy%20S01e03%203381/Dune_Prophecy_S01E03_3381.zip?download', 'Dune_Prophecy_S01E03_3381.zip', 'WEB-DL', 0, '00000000-0000-0000-0000-000000000001', '2026-07-21 11:40:57.426392+00', '2026-07-21 11:40:57.426392+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('0c56c391-53e7-4479-afec-d41676efeb3f', NULL, 'd3dc4e95-a048-45fe-a465-79f7eca86a41', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Dune%20Prophecy%20S01e04%206817/Dune_Prophecy_S01E04_6817.zip?download', 'Dune_Prophecy_S01E04_6817.zip', 'WEB-DL', 0, '00000000-0000-0000-0000-000000000001', '2026-07-21 11:40:57.426392+00', '2026-07-21 11:40:57.426392+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('7cde0acb-71f3-409d-a624-643d8785e1e8', NULL, 'd079e06d-f5c7-4b22-adcc-4a2f4660fe20', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Dune%20Prophecy%20S01e05%207821/Dune_Prophecy_S01E05_7821.zip?download', 'Dune_Prophecy_S01E05_7821.zip', 'WEB-DL', 0, '00000000-0000-0000-0000-000000000001', '2026-07-21 11:40:57.426392+00', '2026-07-21 11:40:57.426392+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('c25d1491-1229-4d9f-a151-b0846c99106c', NULL, 'd11bf2e7-32fb-4bae-a23f-6eafe1eebec4', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Dune%20Prophecy%20S01e06%206804/Dune_Prophecy_S01E06_6804.zip?download', 'Dune_Prophecy_S01E06_6804.zip', 'WEB-DL', 0, '00000000-0000-0000-0000-000000000001', '2026-07-21 11:40:57.426392+00', '2026-07-21 11:40:57.426392+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('9ababe5c-23e9-4fda-afcb-ca8680b0944e', NULL, '64d587f8-1fc9-44ee-a2bc-7c3c946f94a1', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S05e01@pixelpoplk%20697767/Sons_of_Anarchy_S05E01@pixelpoplk_697767.zip?download', 'Sons_of_Anarchy_S05E01@pixelpoplk_697767.zip', 'WEB-DL', 4, '00000000-0000-0000-0000-000000000001', '2026-07-22 15:20:11.306013+00', '2026-07-22 15:20:11.306013+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('72198254-2fd6-4c1b-a1c0-dbbf2984a18a', NULL, 'f1ab93cd-7fb1-429f-ac72-d5a9575b58f8', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S05e02@pixelpoplk%2012760/Sons_of_Anarchy_S05E02@pixelpoplk_12760.zip?download', 'Sons_of_Anarchy_S05E02@pixelpoplk_12760.zip', 'WEB-DL', 4, '00000000-0000-0000-0000-000000000001', '2026-07-22 15:20:11.306013+00', '2026-07-22 15:20:11.306013+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('360fcf47-0e7b-44d0-a2b6-dd441329b045', NULL, 'cb90507c-99dd-47f9-a469-73a47bb820c6', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S05e03@pixelpoplk%2095787/Sons_of_Anarchy_S05E03@pixelpoplk_95787.zip?download', 'Sons_of_Anarchy_S05E03@pixelpoplk_95787.zip', 'WEB-DL', 4, '00000000-0000-0000-0000-000000000001', '2026-07-22 15:20:11.306013+00', '2026-07-22 15:20:11.306013+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('fbacc2d3-8360-4da3-a316-14296748cc1c', NULL, '109da833-6129-446c-ae6e-e2af0895c68c', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S05e04@pixelpoplk%20126789/Sons_of_Anarchy_S05E04@pixelpoplk_126789.zip?download', 'Sons_of_Anarchy_S05E04@pixelpoplk_126789.zip', 'WEB-DL', 4, '00000000-0000-0000-0000-000000000001', '2026-07-22 15:20:11.306013+00', '2026-07-22 15:20:11.306013+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('8f64d0a9-d3f9-411d-af5f-8b6a5f70294b', NULL, 'c5d5fa30-2fa9-428e-a43d-c6acaa09817f', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S05e05@pixelpoplk%20305612/Sons_of_Anarchy_S05E05@pixelpoplk_305612.zip?download', 'Sons_of_Anarchy_S05E05@pixelpoplk_305612.zip', 'WEB-DL', 4, '00000000-0000-0000-0000-000000000001', '2026-07-22 15:20:11.306013+00', '2026-07-22 15:20:11.306013+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('000c249d-3461-4f8c-ae9d-134df4ca8af8', NULL, '5e98ed7d-def9-4406-a85d-75f5b3f3f934', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S05e06%20@pixelpoplk105756/Sons_of_Anarchy_S05E06_@pixelpoplk105756.zip?download', 'Sons_of_Anarchy_S05E06_@pixelpoplk105756.zip', 'WEB-DL', 4, '00000000-0000-0000-0000-000000000001', '2026-07-23 15:20:45.443248+00', '2026-07-23 15:20:45.443248+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('c6005db6-6fac-4438-a34b-7330dedc08aa', NULL, '71a464db-5dbe-4456-ae84-175736c13c0e', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S05e07%20@pixelpoplk673141/Sons_of_Anarchy_S05E07_@pixelpoplk673141.zip?download', 'Sons_of_Anarchy_S05E07_@pixelpoplk673141.zip', 'WEB-DL', 4, '00000000-0000-0000-0000-000000000001', '2026-07-23 15:20:45.443248+00', '2026-07-23 15:20:45.443248+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('9b686a22-b206-4b85-ad70-b91c7f2c214b', NULL, '30e31621-fe73-4d9f-ac06-0883b308948b', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S05e08%20@pixelpoplk566086/Sons_of_Anarchy_S05E08_@pixelpoplk566086.zip?download', 'Sons_of_Anarchy_S05E08_@pixelpoplk566086.zip', 'WEB-DL', 4, '00000000-0000-0000-0000-000000000001', '2026-07-23 15:20:45.443248+00', '2026-07-23 15:20:45.443248+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('d1cb20d4-c14d-4db2-a1f9-9a52e44d80d1', NULL, 'f7ff5cd9-3e7a-4854-a839-f08b1e796d03', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S05e09%20@pixelpoplk568727/Sons_of_Anarchy_S05E09_@pixelpoplk568727.zip?download', 'Sons_of_Anarchy_S05E09_@pixelpoplk568727.zip', 'WEB-DL', 5, '00000000-0000-0000-0000-000000000001', '2026-07-23 15:20:45.443248+00', '2026-07-23 15:20:45.443248+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('06c5a1c4-f6f2-40f1-a348-811eb1b4512c', NULL, '90c2c1ce-3149-4420-acc4-5e1137a9f04b', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S05e10%20@pixelpoplk568155/Sons_of_Anarchy_S05E10_@pixelpoplk568155.zip?download', 'Sons_of_Anarchy_S05E10_@pixelpoplk568155.zip', 'WEB-DL', 5, '00000000-0000-0000-0000-000000000001', '2026-07-23 15:20:45.443248+00', '2026-07-23 15:20:45.443248+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('e39fbc32-4c39-4e46-a54f-55b0916258ff', NULL, 'd754f593-8f53-478a-a516-0a5d7dce1f13', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S05e11%20@pixelpoplk564166/Sons_of_Anarchy_S05E11_@pixelpoplk564166.zip?download', 'Sons_of_Anarchy_S05E11_@pixelpoplk564166.zip', 'WEB-DL', 5, '00000000-0000-0000-0000-000000000001', '2026-07-23 15:20:45.443248+00', '2026-07-23 15:20:45.443248+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('5f4161e4-faab-4635-a21d-7de07ca93edf', NULL, '9362b49e-c6a7-438e-abd0-e5d5ee591bcf', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S05e12%20@pixelpoplk567449/Sons_of_Anarchy_S05E12_@pixelpoplk567449.zip?download', 'Sons_of_Anarchy_S05E12_@pixelpoplk567449.zip', 'WEB-DL', 5, '00000000-0000-0000-0000-000000000001', '2026-07-23 15:20:45.443248+00', '2026-07-23 15:20:45.443248+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('09772db8-403b-4d30-a39b-6be234e4ae1f', NULL, 'fc4e3466-8657-4b65-a78c-5b09ff582980', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S05e13%20@pixelpoplk567855/Sons_of_Anarchy_S05E13_@pixelpoplk567855.zip?download', 'Sons_of_Anarchy_S05E13_@pixelpoplk567855.zip', 'WEB-DL', 5, '00000000-0000-0000-0000-000000000001', '2026-07-23 15:20:45.443248+00', '2026-07-23 15:20:45.443248+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('a2b10aaf-d036-41b8-abab-61bc97ba5ddf', 'a6eb09ea-0a4e-4a2e-a5df-9f7214592ab2', NULL, 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Coiony%202026%20720p%20Web%20Dl%20Sinhala%20Pixelpoplk/CoIony_2026_720p_WEB-DL%20Sinhala.pixelpoplk.zip?download', 'CoIony_2026_720p_WEB-DL Sinhala.pixelpoplk.zip', 'WEB-DL', 3, '00000000-0000-0000-0000-000000000001', '2026-07-23 19:35:18.298072+00', '2026-07-23 19:35:18.298072+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('f0aff6a2-b142-4fb9-a8c4-5c1c99672463', '4b94c16b-3dfb-40d2-a0a3-587c25306447', NULL, 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Anomie/Anomie.2026.720p.AMZN.WEB-DL_sinhala%20(1).zip?download', 'Anomie.2026.720p.AMZN.WEB-DL_sinhala (1).zip', 'WEB-DL', 2, '00000000-0000-0000-0000-000000000001', '2026-07-24 12:04:54.624116+00', '2026-07-24 12:04:54.624116+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('37c3ed07-7aa8-430b-ab16-111e5483ebb3', NULL, 'a282c926-810d-4deb-a0e5-966d01049ea3', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S06e01%20@pixelpoplk761163/Sons_of_Anarchy_S06E01_@pixelpoplk761163.zip?download', 'Sons_of_Anarchy_S06E01_@pixelpoplk761163.zip', 'WEB-DL', 5, '00000000-0000-0000-0000-000000000001', '2026-07-25 11:21:03.246098+00', '2026-07-25 11:21:03.246098+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('2521d147-3f4a-46f5-a2b7-eaf4b6a5ce22', NULL, '4ebb547e-53ad-4d57-a144-4d675d22a6a6', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S06e02%20@pixelpoplk767345/Sons_of_Anarchy_S06E02_@pixelpoplk767345.zip?download', 'Sons_of_Anarchy_S06E02_@pixelpoplk767345.zip', 'WEB-DL', 4, '00000000-0000-0000-0000-000000000001', '2026-07-25 11:21:03.246098+00', '2026-07-25 11:21:03.246098+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('af99e2ce-9412-4986-a3b0-532db52d5d92', NULL, '58ec2e1a-2d6a-4a3e-a0dc-68bb6db32cde', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S06e03%20@pixelpoplk765210/Sons_of_Anarchy_S06E03_@pixelpoplk765210.zip?download', 'Sons_of_Anarchy_S06E03_@pixelpoplk765210.zip', 'WEB-DL', 4, '00000000-0000-0000-0000-000000000001', '2026-07-25 11:21:03.246098+00', '2026-07-25 11:21:03.246098+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('28d6429b-c085-46a1-a0f8-ebc844e29f1b', NULL, '78a5ef5c-d105-4c5d-a2da-650571142053', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S06e04%20@pixelpoplk768406/Sons_of_Anarchy_S06E04_@pixelpoplk768406.zip?download', 'Sons_of_Anarchy_S06E04_@pixelpoplk768406.zip', 'WEB-DL', 4, '00000000-0000-0000-0000-000000000001', '2026-07-25 11:21:03.246098+00', '2026-07-25 11:21:03.246098+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('ae805ea0-1db2-4d70-a3b2-aef2ccaec574', NULL, '05f355ee-ec0b-43ac-aa33-0100facea393', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S06e05%20@pixelpoplk766524/Sons_of_Anarchy_S06E05_@pixelpoplk766524.zip?download', 'Sons_of_Anarchy_S06E05_@pixelpoplk766524.zip', 'WEB-DL', 4, '00000000-0000-0000-0000-000000000001', '2026-07-25 11:21:03.246098+00', '2026-07-25 11:21:03.246098+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('59b3213c-d1a4-4441-a042-ef4b484cca84', NULL, '917763f5-b2e9-4ffd-aa72-e0f0d0f15044', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S06e06%20@pixelpoplk764136/Sons_of_Anarchy_S06E06_@pixelpoplk764136.zip?download', 'Sons_of_Anarchy_S06E06_@pixelpoplk764136.zip', 'WEB-DL', 4, '00000000-0000-0000-0000-000000000001', '2026-07-25 11:21:03.246098+00', '2026-07-25 11:21:03.246098+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('41fe69e1-2b3c-4e65-a01f-e0db050b2cfc', '97dc5ae0-49c8-4620-aa67-4b78022b9e44', NULL, 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/72%20Hours%202026%20Webrip%20Hevc%20Psa%20Sinhala%20@pixelpoplk/72.Hours.2026.WEBRip.HEVC-PSA.sinhala.@pixelpoplk.zip?download', '72.Hours.2026.WEBRip.HEVC-PSA.sinhala.@pixelpoplk.zip', 'WEB-DL', 5, '00000000-0000-0000-0000-000000000001', '2026-07-26 08:15:56.089476+00', '2026-07-26 08:15:56.089476+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('864d8996-c525-4363-a2bc-803219c4d380', NULL, '1aaebabc-8c9d-442a-af05-8378c46ac108', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Walking%20Dead%20Dead%20City%20S03e01%20@pixelpoplk9609/The_Walking_Dead_Dead_City_S03E01_@pixelpoplk9609.zip?download', 'The_Walking_Dead_Dead_City_S03E01_@pixelpoplk9609.zip', 'WEB-DL', 1, '00000000-0000-0000-0000-000000000001', '2026-07-26 09:14:46.57961+00', '2026-07-26 09:14:46.57961+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('05847af1-64ac-41ae-a157-ec01031876a9', NULL, '6ac90a7e-a532-41ef-a8d2-904c6919461d', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S06e07%205954/Sons_of_Anarchy_S06E07_5954.zip?download', 'Sons_of_Anarchy_S06E07_5954.zip', 'WEB-DL', 4, '00000000-0000-0000-0000-000000000001', '2026-07-26 15:57:14.899352+00', '2026-07-26 15:57:14.899352+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('bc8a0ab0-2b34-4c96-a63a-95f944f49ccb', NULL, '0f5f4ada-fd4d-43a9-a3e3-3073a506c2c9', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S06e08%203997/Sons_of_Anarchy_S06E08_3997.zip?download', 'Sons_of_Anarchy_S06E08_3997.zip', 'WEB-DL', 4, '00000000-0000-0000-0000-000000000001', '2026-07-26 15:57:14.899352+00', '2026-07-26 15:57:14.899352+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('20181371-b5b4-4901-afe3-b007d1a21794', NULL, '33429f0e-4254-46c7-a0a8-51beb0ce4203', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S06e09%207748/Sons_of_Anarchy_S06E09_7748.zip?download', 'Sons_of_Anarchy_S06E09_7748.zip', 'WEB-DL', 4, '00000000-0000-0000-0000-000000000001', '2026-07-26 15:57:14.899352+00', '2026-07-26 15:57:14.899352+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('04e0c9b3-a4cd-4621-a8cf-d7734a8201d9', NULL, '521ed8de-1fb7-45e4-a56e-f4a92cf90982', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S06e10%208344/Sons_of_Anarchy_S06E10_8344.zip?download', 'Sons_of_Anarchy_S06E10_8344.zip', 'WEB-DL', 4, '00000000-0000-0000-0000-000000000001', '2026-07-26 15:57:14.899352+00', '2026-07-26 15:57:14.899352+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('fbabd2c2-10c4-401d-ac6d-5f7af928adb7', NULL, 'acf32d87-d3ce-46ba-a80a-337540ee3473', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S06e11%204513/Sons_of_Anarchy_S06E11_4513.zip?download', 'Sons_of_Anarchy_S06E11_4513.zip', 'WEB-DL', 4, '00000000-0000-0000-0000-000000000001', '2026-07-26 15:57:14.899352+00', '2026-07-26 15:57:14.899352+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('ae5ac9c7-123f-4d8f-a50f-7fb85b2cd401', NULL, '77f4da9c-a2cc-48ef-a2fa-cf5f32292ca3', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S06e12%207409/Sons_of_Anarchy_S06E12_7409.zip?download', 'Sons_of_Anarchy_S06E12_7409.zip', 'WEB-DL', 4, '00000000-0000-0000-0000-000000000001', '2026-07-26 15:57:14.899352+00', '2026-07-26 15:57:14.899352+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('fb30934d-9284-4f60-a4be-18cd0b6d6396', NULL, 'b5ab48e7-40fe-4633-a06d-8414f9699a65', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S06e13%205682/Sons_of_Anarchy_S06E13_5682.zip?download', 'Sons_of_Anarchy_S06E13_5682.zip', 'WEB-DL', 4, '00000000-0000-0000-0000-000000000001', '2026-07-26 15:57:14.899352+00', '2026-07-26 15:57:14.899352+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('2d26959a-9221-4ffa-a6ce-c66fa0a41cf9', NULL, '65b19554-c989-4991-abea-9231e8c70423', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/House%20of%20the%20Dragon%20S03e06%202991/House_of_the_Dragon_S03E06_2991.zip?download', 'House_of_the_Dragon_S03E06_2991.zip', 'WEB-DL', 71, '00000000-0000-0000-0000-000000000001', '2026-07-26 19:36:34.146575+00', '2026-07-26 19:36:34.146575+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('02917fa0-81dc-43c9-ad22-758729602c85', '1dfeef95-9101-40ab-ace3-f15fe887772a', NULL, 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Supergirl/Supergirl.2026.720p.WEBRip_sinhala.zip?download', 'Supergirl.2026.720p.WEBRip_sinhala.zip', 'WEB-DL', 1, '00000000-0000-0000-0000-000000000001', '2026-07-27 06:46:17.212937+00', '2026-07-27 06:46:17.212937+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('0c46491e-35ef-48ac-a0fb-bd49afbeed73', NULL, '35f6fe55-6311-49b9-ab9b-0114ce81eb1a', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S01e01%209451/The_Sopranos_S01E01_9451.zip?download', 'The_Sopranos_S01E01_9451.zip', 'WEB-DL', 114, '00000000-0000-0000-0000-000000000001', '2026-07-28 16:58:59.501453+00', '2026-07-28 16:58:59.501453+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('8c96ec16-ef38-4c32-afcd-427eda740079', NULL, '036066a4-ce3f-4abd-a925-7cf80865a47e', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S07e01%202778/Sons_of_Anarchy_S07E01_2778.zip?download', 'Sons_of_Anarchy_S07E01_2778.zip', 'WEB-DL', 3, '00000000-0000-0000-0000-000000000001', '2026-07-28 17:47:57.477299+00', '2026-07-28 17:47:57.477299+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('27b96623-8a61-4549-a367-58a1d5222382', NULL, 'e251ab8b-a146-49fb-ace4-8ac6999f9c52', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S07e02%206601/Sons_of_Anarchy_S07E02_6601.zip?download', 'Sons_of_Anarchy_S07E02_6601.zip', 'WEB-DL', 3, '00000000-0000-0000-0000-000000000001', '2026-07-28 17:47:57.477299+00', '2026-07-28 17:47:57.477299+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('1895d7ac-84dc-4a0e-ab15-0af3432a2dd3', NULL, 'a9d7d420-367a-41ac-a08f-cfb2c57c7c01', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S07e03%205551/Sons_of_Anarchy_S07E03_5551.zip?download', 'Sons_of_Anarchy_S07E03_5551.zip', 'WEB-DL', 3, '00000000-0000-0000-0000-000000000001', '2026-07-28 17:47:57.477299+00', '2026-07-28 17:47:57.477299+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('039712fe-967f-4467-ae01-3aa01fbbac65', '60c54a53-ba5f-4932-ae6a-e0f88f89b0d8', NULL, 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Demon%20Slayer%20Infinity%20Castle%202025%20Bluray%20Sinhala%2045454/Demon_Slayer_Infinity_Castle_2025.BluRay_sinhala_45454.zip?download', 'Demon_Slayer_Infinity_Castle_2025.BluRay_sinhala_45454.zip', 'WEB-DL', 0, '00000000-0000-0000-0000-000000000001', '2026-07-28 20:01:07.145515+00', '2026-07-28 20:01:07.145515+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('52dd5ac7-d355-4cf3-a2d7-e39e613911fc', NULL, '08978a86-7c5d-40a9-ab7d-c7a9bfaf51e9', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S07e04%202108/Sons_of_Anarchy_S07E04_2108.zip?download', 'Sons_of_Anarchy_S07E04_2108.zip', 'WEB-DL', 3, '00000000-0000-0000-0000-000000000001', '2026-07-29 15:47:39.376403+00', '2026-07-29 15:47:39.376403+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('de464bf3-8834-43a5-ab44-a8005e47a052', NULL, 'ecbaec1b-caa1-4d69-a91a-78c4f4697795', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S07e05%204215/Sons_of_Anarchy_S07E05_4215.zip?download', 'Sons_of_Anarchy_S07E05_4215.zip', 'WEB-DL', 3, '00000000-0000-0000-0000-000000000001', '2026-07-29 15:47:39.376403+00', '2026-07-29 15:47:39.376403+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('b9183e3b-3acf-4b86-a7af-3ed1b21e3f76', NULL, '41046440-3189-46b3-a8fa-740fa6db1693', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S07e06%201715/Sons_of_Anarchy_S07E06_1715.zip?download', 'Sons_of_Anarchy_S07E06_1715.zip', 'WEB-DL', 3, '00000000-0000-0000-0000-000000000001', '2026-07-29 15:47:39.376403+00', '2026-07-29 15:47:39.376403+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('f40e4ace-43a7-441d-a6bd-3f84784ab64b', NULL, '9fb72ef2-edfc-4785-ac04-12c1aca3e338', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S07e07%206809/Sons_of_Anarchy_S07E07_6809.zip?download', 'Sons_of_Anarchy_S07E07_6809.zip', 'WEB-DL', 3, '00000000-0000-0000-0000-000000000001', '2026-07-29 15:47:39.376403+00', '2026-07-29 15:47:39.376403+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('fa4c5bc3-a832-469e-ae6f-57e71561ae5a', NULL, 'e8c4c40c-76e2-4e5e-ae88-8f0b32a3b979', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S01e02%202845/The_Sopranos_S01E02_2845.zip?download', 'The_Sopranos_S01E02_2845.zip', 'WEB-DL', 71, '00000000-0000-0000-0000-000000000001', '2026-07-29 16:57:22.390038+00', '2026-07-29 16:57:22.390038+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('0d74ffd0-0c73-4d99-a72e-2009f421559a', NULL, '53a8a58d-9d48-42e3-ac68-e01620c6baf7', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S07e08%201620/Sons_of_Anarchy_S07E08_1620.zip?download', 'Sons_of_Anarchy_S07E08_1620.zip', 'WEB-DL', 3, '00000000-0000-0000-0000-000000000001', '2026-07-30 09:44:00.617394+00', '2026-07-30 09:44:00.617394+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('86705a18-6c43-482e-a7e4-8ca8ff66113a', NULL, 'f63e74e5-57f1-4b88-a874-98af749ad9ba', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S07e09%202852/Sons_of_Anarchy_S07E09_2852.zip?download', 'Sons_of_Anarchy_S07E09_2852.zip', 'WEB-DL', 3, '00000000-0000-0000-0000-000000000001', '2026-07-30 09:44:00.617394+00', '2026-07-30 09:44:00.617394+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('35fb861a-ca4d-437b-ac2d-7e20c95d3a93', NULL, '65144140-f36e-46ce-a66b-3f62e6cd8a54', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S07e10%208615/Sons_of_Anarchy_S07E10_8615.zip?download', 'Sons_of_Anarchy_S07E10_8615.zip', 'WEB-DL', 3, '00000000-0000-0000-0000-000000000001', '2026-07-30 09:44:00.617394+00', '2026-07-30 09:44:00.617394+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('54b3d4de-c694-4694-a864-809c00e3ba2a', NULL, 'ba267558-45f5-4e0f-aa45-e12fdbf2e3cd', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S07e11%203040/Sons_of_Anarchy_S07E11_3040.zip?download', 'Sons_of_Anarchy_S07E11_3040.zip', 'WEB-DL', 3, '00000000-0000-0000-0000-000000000001', '2026-07-30 09:44:00.617394+00', '2026-07-30 09:44:00.617394+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('0d25cc14-d47c-4542-a678-9f432356f679', NULL, '8e18b46e-16da-49d6-aa93-e1a334593e1d', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S07e12%206642/Sons_of_Anarchy_S07E12_6642.zip?download', 'Sons_of_Anarchy_S07E12_6642.zip', 'WEB-DL', 5, '00000000-0000-0000-0000-000000000001', '2026-07-30 09:44:00.617394+00', '2026-07-30 09:44:00.617394+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('006abe16-fbe2-4877-a858-b85a4c4783ea', NULL, '2417b2ef-dd12-414e-a010-9b14a0948b47', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S07e13%201168/Sons_of_Anarchy_S07E13_1168.zip?download', 'Sons_of_Anarchy_S07E13_1168.zip', 'WEB-DL', 4, '00000000-0000-0000-0000-000000000001', '2026-07-30 09:44:00.617394+00', '2026-07-30 09:44:00.617394+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('18feff4a-5bf3-4bc9-a8ed-151cd36fab46', 'a0fe85f4-925d-4476-adb9-a37da947b1c4', NULL, 'Sinhala', 'https://vegamoviess.cc/56319-spiderman-brand-new-day-2026-english-audio-hdtc-720p-480p-1080p.html', '56319-spiderman-brand-new-day-2026-english-audio-hdtc-720p-480p-1080p.html', 'WEB-DL', 34, '00000000-0000-0000-0000-000000000001', '2026-07-30 10:11:12.178415+00', '2026-07-30 10:11:12.178415+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('63bee922-9755-47ec-aa3a-2e0940ea5a38', NULL, 'a9fab54f-7d32-40a3-a8c7-ea7f2c6ac230', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S01e03%20197956%20(/The_Sopranos_S01E03_197956%20(1).zip?download', 'The_Sopranos_S01E03_197956 (1).zip', 'WEB-DL', 17, '00000000-0000-0000-0000-000000000001', '2026-07-30 17:16:11.526432+00', '2026-07-30 17:16:11.526432+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('f6d55624-c64b-4d7b-ae5d-3268a8c76f58', NULL, '80444a0d-09f0-4108-ab58-1d91d73f0011', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Batman%20Caped%20Crusader%20S01e01%20852284/Batman_Caped_Crusader_S01E01_852284.zip?download', 'Batman_Caped_Crusader_S01E01_852284.zip', 'WEB-DL', 4, '00000000-0000-0000-0000-000000000001', '2026-07-31 09:09:26.160221+00', '2026-07-31 09:09:26.160221+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('579bdf9d-55b6-448d-ac0b-f539a0f86c79', NULL, 'e6b409ef-70f8-4c35-aefa-89af278eebc2', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Batman%20Caped%20Crusader%20S01e02%20658105/Batman_Caped_Crusader_S01E02_658105.zip?download', 'Batman_Caped_Crusader_S01E02_658105.zip', 'WEB-DL', 1, '00000000-0000-0000-0000-000000000001', '2026-07-31 09:09:26.160221+00', '2026-07-31 09:09:26.160221+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('0543ffcb-e9d1-4256-a3cb-6559e054d9aa', NULL, '4b5d654a-6290-4155-a9b7-3b97dfe35911', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Batman%20Caped%20Crusader%20S01e03%20445345/Batman_Caped_Crusader_S01E03_445345.zip?download', 'Batman_Caped_Crusader_S01E03_445345.zip', 'WEB-DL', 1, '00000000-0000-0000-0000-000000000001', '2026-07-31 09:09:26.160221+00', '2026-07-31 09:09:26.160221+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('4a3ae75f-020e-46fe-a39f-75a1e4da0734', NULL, 'fc321ceb-143e-4aa2-a525-9936fceb4ca6', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Batman%20Caped%20Crusader%20S01e04%20959128/Batman_Caped_Crusader_S01E04_959128.zip?download', 'Batman_Caped_Crusader_S01E04_959128.zip', 'WEB-DL', 3, '00000000-0000-0000-0000-000000000001', '2026-07-31 09:09:26.160221+00', '2026-07-31 09:09:26.160221+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('4ce042bb-3917-479a-a84b-d42ffd774afc', NULL, 'dc8d1497-fa15-477d-ac20-2adf75dfe81e', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Batman%20Caped%20Crusader%20S01e05%20205699/Batman_Caped_Crusader_S01E05_205699.zip?download', 'Batman_Caped_Crusader_S01E05_205699.zip', 'WEB-DL', 1, '00000000-0000-0000-0000-000000000001', '2026-07-31 09:09:26.160221+00', '2026-07-31 09:09:26.160221+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('aab3d95a-1488-4fda-aa27-7d36f0e8395b', NULL, 'a2b2f7e7-78c7-4f3a-abff-a535a82c1a08', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S01e04%20907241/The_Sopranos_S01E04_907241.zip?download', 'The_Sopranos_S01E04_907241.zip', 'WEB-DL', 14, '00000000-0000-0000-0000-000000000001', '2026-07-31 15:59:35.827563+00', '2026-07-31 15:59:35.827563+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('3f79e2c9-7796-4646-aded-e5f1c365f044', NULL, '05719008-186f-46bd-ad7a-dfa00f934cb6', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S01e05%20940875/The_Sopranos_S01E05_940875.zip?download', 'The_Sopranos_S01E05_940875.zip', 'WEB-DL', 9, '00000000-0000-0000-0000-000000000001', '2026-07-31 17:35:43.965012+00', '2026-07-31 17:35:43.965012+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('223d00af-1a44-4021-a7b3-a9457fb8597a', NULL, '549b2796-9dd2-468f-ab9c-28c70312dc07', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S01e06%20865595/The_Sopranos_S01E06_865595.zip?download', 'The_Sopranos_S01E06_865595.zip', 'WEB-DL', 10, '00000000-0000-0000-0000-000000000001', '2026-08-01 18:42:43.72199+00', '2026-08-01 18:42:43.72199+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('46e7f488-6ad4-4e31-a31a-e5526e22e5bf', NULL, '1a753b91-dcf4-47e6-ac93-5415111aeb4f', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S01e07%20285423/The_Sopranos_S01E07_285423.zip?download', 'The_Sopranos_S01E07_285423.zip', 'WEB-DL', 10, '00000000-0000-0000-0000-000000000001', '2026-08-01 18:42:43.72199+00', '2026-08-01 18:42:43.72199+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('69aaf486-68b5-4daa-aeb1-fd79b6bab227', NULL, '28e5ebf9-a675-4e01-af74-021ee06a6b85', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S01e08%20104983/The_Sopranos_S01E08_104983.zip?download', 'The_Sopranos_S01E08_104983.zip', 'WEB-DL', 10, '00000000-0000-0000-0000-000000000001', '2026-08-01 18:42:43.72199+00', '2026-08-01 18:42:43.72199+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('e9f97418-8565-476c-a479-ea426a992c01', 'e38e1231-d3a8-489f-ac3e-7b7ae6832722', NULL, 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Soulm8te/Soulm8te.2026.720p.WEB-DL.x265.10Bit-Pahe.sinhala@pixelpoplk.zip?download', 'Soulm8te.2026.720p.WEB-DL.x265.10Bit-Pahe.sinhala@pixelpoplk.zip', 'WEB-DL', 1, '00000000-0000-0000-0000-000000000001', '2026-08-02 10:40:16.846602+00', '2026-08-02 10:40:16.846602+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('ff72f3a3-6b80-4167-a116-62cf284e2b7e', NULL, '734420f6-3943-4eee-a22c-cf1cb905a96d', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S01e09%20944054/The_Sopranos_S01E09_944054.zip?download', 'The_Sopranos_S01E09_944054.zip', 'WEB-DL', 8, '00000000-0000-0000-0000-000000000001', '2026-08-02 11:53:59.619015+00', '2026-08-02 11:53:59.619015+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('8fbeec8b-9b4a-4387-a939-2d1d04486c8c', NULL, '78ce7f43-6636-46f0-a55a-193958f3dd9d', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S01e10%20720818/The_Sopranos_S01E10_720818.zip?download', 'The_Sopranos_S01E10_720818.zip', 'WEB-DL', 10, '00000000-0000-0000-0000-000000000001', '2026-08-02 11:53:59.619015+00', '2026-08-02 11:53:59.619015+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('4c03a4f9-4081-4ee0-a413-9a7ae10322bf', NULL, 'ea6dea3d-fe91-401a-a94c-d36f75b13947', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S01e11%20794463/The_Sopranos_S01E11_794463.zip?download', 'The_Sopranos_S01E11_794463.zip', 'WEB-DL', 7, '00000000-0000-0000-0000-000000000001', '2026-08-02 11:53:59.619015+00', '2026-08-02 11:53:59.619015+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('56a70441-29a8-4b70-a5a7-92074e8b4db9', NULL, '08225473-5860-4a5d-ab4d-2d41843fecff', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S01e12%20781430/The_Sopranos_S01E12_781430.zip?download', 'The_Sopranos_S01E12_781430.zip', 'WEB-DL', 8, '00000000-0000-0000-0000-000000000001', '2026-08-02 11:53:59.619015+00', '2026-08-02 11:53:59.619015+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('d86175b7-0d76-45b5-a84e-2549e5cddbd3', NULL, 'bc1005bd-12af-4957-a65f-ee1fbe7554ba', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S01e13%20740206/The_Sopranos_S01E13_740206.zip?download', 'The_Sopranos_S01E13_740206.zip', 'WEB-DL', 9, '00000000-0000-0000-0000-000000000001', '2026-08-02 11:53:59.619015+00', '2026-08-02 11:53:59.619015+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('c13d0a60-f282-4fe3-ab90-f24c7b5cd026', NULL, '96d63812-eeae-4131-a276-c3a5edf2efac', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/House%20of%20the%20Dragon%20S03e07%20234347/House_of_the_Dragon_S03E07_234347.zip?download', 'House_of_the_Dragon_S03E07_234347.zip', 'WEB-DL', 24, '00000000-0000-0000-0000-000000000001', '2026-08-03 02:22:22.473636+00', '2026-08-03 02:22:22.473636+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('7a2e14b2-d689-433f-a548-f97891360fc0', NULL, '351c770e-05fc-441a-aa76-4a2616b0b506', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Walking%20Dead%20Dead%20City%20S03e02%20880775/The_Walking_Dead_Dead_City_S03E02_880775.zip?download', 'The_Walking_Dead_Dead_City_S03E02_880775.zip', 'WEB-DL', 0, '00000000-0000-0000-0000-000000000001', '2026-08-03 09:03:10.202106+00', '2026-08-03 09:03:10.202106+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('e1b97565-b186-4e97-a63b-f843f1937de0', '5f87f198-cd0f-44e3-a8d0-a5fdf9c552c1', NULL, 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Evil%20Dead%20Burn/Evil.Dead.Burn.2026.WEBRip_sinhala.srt.zip?download', 'Evil.Dead.Burn.2026.WEBRip_sinhala.srt.zip', 'WEB-DL', 9, '00000000-0000-0000-0000-000000000001', '2026-08-04 08:00:52.849475+00', '2026-08-04 08:00:52.849475+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('c212e69f-e3ca-4f24-a437-2fd26b49c1be', NULL, '1615a249-5dbb-426e-a17f-ffd3a1d7600a', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S02e01%20394561/The_Sopranos_S02E01_394561.zip?download', 'The_Sopranos_S02E01_394561.zip', 'WEB-DL', 5, '00000000-0000-0000-0000-000000000001', '2026-08-04 13:03:55.568064+00', '2026-08-04 13:03:55.568064+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('c3db29c6-ea21-493c-a946-d1a80d8f6f02', NULL, 'a7b3691d-be6c-4727-acf0-289c5cdcebc0', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S02e02%20713497/The_Sopranos_S02E02_713497.zip?download', 'The_Sopranos_S02E02_713497.zip', 'WEB-DL', 4, '00000000-0000-0000-0000-000000000001', '2026-08-04 13:03:55.568064+00', '2026-08-04 13:03:55.568064+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('8952bb5a-e8af-4984-a185-b16eaa2959d4', NULL, 'eef9047f-c1c3-4980-a62a-d7cb0510f8fa', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S02e03%20564981/The_Sopranos_S02E03_564981.zip?download', 'The_Sopranos_S02E03_564981.zip', 'WEB-DL', 3, '00000000-0000-0000-0000-000000000001', '2026-08-04 13:03:55.568064+00', '2026-08-04 13:03:55.568064+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('4ba237b2-278d-4751-a06e-c5caa9cd3159', NULL, '79b18af7-251b-49d7-a5d3-b6f01110179c', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S02e04%20190095/The_Sopranos_S02E04_190095.zip?download', 'The_Sopranos_S02E04_190095.zip', 'WEB-DL', 4, '00000000-0000-0000-0000-000000000001', '2026-08-04 13:03:55.568064+00', '2026-08-04 13:03:55.568064+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('70e2b723-0b4c-4c01-a733-60007dd05510', NULL, 'f7aff376-6900-44c6-a6b2-d3bac58ad610', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S02e05%20797662/The_Sopranos_S02E05_797662.zip?download', 'The_Sopranos_S02E05_797662.zip', 'WEB-DL', 3, '00000000-0000-0000-0000-000000000001', '2026-08-04 13:03:55.568064+00', '2026-08-04 13:03:55.568064+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('6dee1216-83a0-4745-a329-b5b00d39afba', NULL, '5dc47798-fc74-4c44-a337-4fae7c9ef7e2', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S02e06%20535651/The_Sopranos_S02E06_535651.zip?download', 'The_Sopranos_S02E06_535651.zip', 'WEB-DL', 3, '00000000-0000-0000-0000-000000000001', '2026-08-04 13:03:55.568064+00', '2026-08-04 13:03:55.568064+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('4f902b23-f31c-4813-a069-d3882b71e888', NULL, '2a8682e5-292d-47ae-ab77-2de7656b6fcb', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S02e07%20303750/The_Sopranos_S02E07_303750.zip?download', 'The_Sopranos_S02E07_303750.zip', 'WEB-DL', 4, '00000000-0000-0000-0000-000000000001', '2026-08-04 13:03:55.568064+00', '2026-08-04 13:03:55.568064+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('caeb1ab3-0d61-4a8e-a7d5-3d5b44a22e65', 'de89fa81-9fb4-4728-ae08-770da32cd8ff', NULL, 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Isolate%20Thief/The.Isolate.Thief.2026.WEB-DL_sinhala.zip?download', 'The.Isolate.Thief.2026.WEB-DL_sinhala.zip', 'WEB-DL', 5, '00000000-0000-0000-0000-000000000001', '2026-08-05 06:34:07.587586+00', '2026-08-05 06:34:07.587586+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('3bfc6375-6e30-4eb8-a0d2-9edb982f6da6', NULL, '9d64d3f6-bb77-4d39-a811-9c02dc4c973c', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Batman%20Caped%20Crusader%20S01e06%20311606/Batman_Caped_Crusader_S01E06_311606.zip?download', 'Batman_Caped_Crusader_S01E06_311606.zip', 'WEB-DL', 1, '00000000-0000-0000-0000-000000000001', '2026-08-05 06:40:15.262255+00', '2026-08-05 06:40:15.262255+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('5e957edc-466d-4e1e-af5d-80f39ad18d03', NULL, '5335fd6c-f2d4-4023-ae55-c46ba31bbbce', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Batman%20Caped%20Crusader%20S01e07%20955765/Batman_Caped_Crusader_S01E07_955765.zip?download', 'Batman_Caped_Crusader_S01E07_955765.zip', 'WEB-DL', 1, '00000000-0000-0000-0000-000000000001', '2026-08-05 06:40:15.262255+00', '2026-08-05 06:40:15.262255+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('882d48c2-71cb-4930-a36a-24b0e18d44ea', NULL, '172164d7-f03e-4dde-a6fc-d745cbf52b0c', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Batman%20Caped%20Crusader%20S01e08%20817274/Batman_Caped_Crusader_S01E08_817274.zip?download', 'Batman_Caped_Crusader_S01E08_817274.zip', 'WEB-DL', 1, '00000000-0000-0000-0000-000000000001', '2026-08-05 06:40:15.262255+00', '2026-08-05 06:40:15.262255+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('ad300316-823c-41db-ad4e-33b4be1aa3e4', NULL, '5e18c1a7-9145-46b0-a1b1-6cd8d8ae7c80', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Batman%20Caped%20Crusader%20S01e09%20177201/Batman_Caped_Crusader_S01E09_177201.zip?download', 'Batman_Caped_Crusader_S01E09_177201.zip', 'WEB-DL', 1, '00000000-0000-0000-0000-000000000001', '2026-08-05 06:40:15.262255+00', '2026-08-05 06:40:15.262255+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('4bca7999-4fb9-417f-a644-c4e14a906dbb', NULL, 'ca6224a3-7235-413e-afb1-b993d63010e5', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Batman%20Caped%20Crusader%20S01e10%20918984/Batman_Caped_Crusader_S01E10_918984.zip?download', 'Batman_Caped_Crusader_S01E10_918984.zip', 'WEB-DL', 1, '00000000-0000-0000-0000-000000000001', '2026-08-05 06:40:15.262255+00', '2026-08-05 06:40:15.262255+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('b6fe3ad5-7613-453d-a65c-86633b491a50', NULL, 'c10e6331-100b-45da-a62a-bb4d9c8dfe2e', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S02e08%20397981/The_Sopranos_S02E08_397981.zip?download', 'The_Sopranos_S02E08_397981.zip', 'WEB-DL', 3, '00000000-0000-0000-0000-000000000001', '2026-08-05 14:04:25.09645+00', '2026-08-05 14:04:25.09645+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('466619e4-1d44-442d-ae28-09c7c5861768', NULL, 'e1312426-8a25-4ae5-af0d-1990021252ca', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S02e09%20375801/The_Sopranos_S02E09_375801.zip?download', 'The_Sopranos_S02E09_375801.zip', 'WEB-DL', 1, '00000000-0000-0000-0000-000000000001', '2026-08-05 14:04:25.09645+00', '2026-08-05 14:04:25.09645+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('3dc8130b-904f-475c-ab4d-b5e71d96ae3d', NULL, 'cc49279f-7804-4ab9-ad06-b0088a2d6af3', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S02e10%20504007/The_Sopranos_S02E10_504007.zip?download', 'The_Sopranos_S02E10_504007.zip', 'WEB-DL', 1, '00000000-0000-0000-0000-000000000001', '2026-08-05 14:04:25.09645+00', '2026-08-05 14:04:25.09645+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('6c1abe21-53fe-40b5-a4d2-7cc7c7629088', NULL, '29400325-859d-4550-ab10-9e19342a3559', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S02e11%20326649/The_Sopranos_S02E11_326649.zip?download', 'The_Sopranos_S02E11_326649.zip', 'WEB-DL', 1, '00000000-0000-0000-0000-000000000001', '2026-08-05 14:04:25.09645+00', '2026-08-05 14:04:25.09645+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('eb07acdd-93b8-4ca6-a857-e7f8fc7f6d0c', NULL, '4d6866db-8002-4ee6-a361-a2ed37c50650', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S02e12%20646366/The_Sopranos_S02E12_646366.zip?download', 'The_Sopranos_S02E12_646366.zip', 'WEB-DL', 1, '00000000-0000-0000-0000-000000000001', '2026-08-05 14:04:25.09645+00', '2026-08-05 14:04:25.09645+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('5d1d9fda-2403-41be-ab5d-681d7c627f16', NULL, '9df4b35e-2508-4a00-adc6-d59fc0460a56', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S02e13%20327223/The_Sopranos_S02E13_327223.zip?download', 'The_Sopranos_S02E13_327223.zip', 'WEB-DL', 1, '00000000-0000-0000-0000-000000000001', '2026-08-05 14:04:25.09645+00', '2026-08-05 14:04:25.09645+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('10bfe648-6a13-4ef9-ade5-f46999fb1963', NULL, 'c76bb82b-9e39-4060-aa4c-f050b8c6e2e2', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Black%20Bird%20S01e01%20720813/Black_Bird_S01E01_720813.zip?download', 'Black_Bird_S01E01_720813.zip', 'WEB-DL', 12, '00000000-0000-0000-0000-000000000001', '2026-08-06 10:35:58.56554+00', '2026-08-06 10:35:58.56554+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('51820aab-abe7-4e47-ac2b-0d66f760cafc', NULL, 'f6476299-fb90-441d-a3d1-c530d7acc08d', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Black%20Bird%20S01e02%20748252/Black_Bird_S01E02_748252.zip?download', 'Black_Bird_S01E02_748252.zip', 'WEB-DL', 12, '00000000-0000-0000-0000-000000000001', '2026-08-06 10:35:58.56554+00', '2026-08-06 10:35:58.56554+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('a5e2d254-9f38-4db5-a732-77c968397177', NULL, '29697cb3-9f83-45c5-acde-b6bb98d04f18', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Black%20Bird%20S01e03%20897257/Black_Bird_S01E03_897257.zip?download', 'Black_Bird_S01E03_897257.zip', 'WEB-DL', 9, '00000000-0000-0000-0000-000000000001', '2026-08-06 10:35:58.56554+00', '2026-08-06 10:35:58.56554+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('c2cd43e8-e683-4f24-a3df-ce0385331f71', NULL, '404f1629-37fd-4d77-ad55-8a148be43f8b', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Black%20Bird%20S01e04%20489323/Black_Bird_S01E04_489323.zip?download', 'Black_Bird_S01E04_489323.zip', 'WEB-DL', 6, '00000000-0000-0000-0000-000000000001', '2026-08-06 10:35:58.56554+00', '2026-08-06 10:35:58.56554+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('193e8200-c09f-4d75-a8e6-d5e5393dce58', NULL, '7ca0d09a-8ef1-475a-ac9f-47662ef8fe1d', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Black%20Bird%20S01e05%20471717/Black_Bird_S01E05_471717.zip?download', 'Black_Bird_S01E05_471717.zip', 'WEB-DL', 3, '00000000-0000-0000-0000-000000000001', '2026-08-06 10:35:58.56554+00', '2026-08-06 10:35:58.56554+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('baa0bff6-c8ed-471b-a4d4-c59620f47f1c', NULL, '277b2b37-35f3-4a97-a0d9-4da2f5c78e59', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Black%20Bird%20S01e06%20728697/Black_Bird_S01E06_728697.zip?download', 'Black_Bird_S01E06_728697.zip', 'WEB-DL', 3, '00000000-0000-0000-0000-000000000001', '2026-08-06 10:35:58.56554+00', '2026-08-06 10:35:58.56554+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('9d7f0536-6a75-46b0-a456-7e91914d2a1e', 'd8624299-504e-4135-a8b6-bb91d0217b72', NULL, 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Lenin/Lenin.2026.720p.ZEE5.WEB-DL_sinhala.zip?download', 'Lenin.2026.720p.ZEE5.WEB-DL_sinhala.zip', 'WEB-DL', 3, '00000000-0000-0000-0000-000000000001', '2026-08-07 07:34:34.672569+00', '2026-08-07 07:34:34.672569+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('63fbb1e6-f2ec-4ab9-a02d-a5c6f754d28d', '046422c0-37bd-4d89-ab53-fb06e6e5da6d', NULL, 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Idhayam%20Murali%20(/Idhayam%20Murali%20(2026)%20HQ%20HDRip%20-%20sinhala.zip?download', 'Idhayam Murali (2026) HQ HDRip - sinhala.zip', 'WEB-DL', 19, '00000000-0000-0000-0000-000000000001', '2026-08-07 09:54:02.964215+00', '2026-08-07 09:54:02.964215+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('1ea694d8-4a76-4f3b-a340-a206002c8b2c', NULL, '4362e2ea-881e-443e-afac-e31cff51c169', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Our%20Sticky%20Love%20S01e01%20993851/Our_Sticky_Love_S01E01_993851.zip?download', 'Our_Sticky_Love_S01E01_993851.zip', 'WEB-DL', 2, '00000000-0000-0000-0000-000000000001', '2026-08-08 08:30:23.609856+00', '2026-08-08 08:30:23.609856+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('3d801499-90f5-45c1-ab66-b33028198113', NULL, 'c077b68a-7209-46bb-a2a5-0c6f34d726c0', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Night%20of%20S01e01%20867272/The_Night_Of_S01E01_867272.zip?download', 'The_Night_Of_S01E01_867272.zip', 'WEB-DL', 12, '00000000-0000-0000-0000-000000000001', '2026-08-08 11:01:21.636301+00', '2026-08-08 11:01:21.636301+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('f985fd04-6992-41dc-a22c-9ed02de15f65', NULL, '5d70828e-c365-4aed-a64f-2f6582f9cd0b', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/House%20of%20the%20Dragon%20S03e08%20394614/House_of_the_Dragon_S03E08_394614.zip?download', 'House_of_the_Dragon_S03E08_394614.zip', 'WEB-DL', 352, '00000000-0000-0000-0000-000000000001', '2026-08-09 18:17:04.550544+00', '2026-08-09 18:17:04.550544+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('9614edb9-3ba3-4bc6-a852-c2f632b0d4f4', '8fd23983-4862-4cc1-a7f5-77a8409fe8b4', NULL, 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Invite/The.Invite.2026.WEBRip.sinhala.zip?download', 'The.Invite.2026.WEBRip.sinhala.zip', 'WEB-DL', 12, '00000000-0000-0000-0000-000000000001', '2026-08-10 12:27:21.523628+00', '2026-08-10 12:27:21.523628+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('b5b42158-85b7-436f-a73a-b30d0bd22311', NULL, 'f89bcda6-40d8-412f-a0b3-09a8f1a0f9cb', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Walking%20Dead%20Dead%20City%20S03e03%20138024/The_Walking_Dead_Dead_City_S03E03_138024.zip?download', 'The_Walking_Dead_Dead_City_S03E03_138024.zip', 'WEB-DL', 3, '00000000-0000-0000-0000-000000000001', '2026-08-10 13:02:14.876293+00', '2026-08-10 13:02:14.876293+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('697bb4c9-3c95-4bbd-af0e-85961fe73d9d', NULL, '6500a301-1ada-468c-ad26-7c954834a971', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S03e01%20909109/The_Sopranos_S03E01_909109.zip?download', 'The_Sopranos_S03E01_909109.zip', 'WEB-DL', 7, '00000000-0000-0000-0000-000000000001', '2026-08-11 13:42:49.900781+00', '2026-08-11 13:42:49.900781+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('edfed200-c5fc-4c33-ac87-c5605eed8a33', NULL, '79a6a3d1-abe2-48c2-a772-614c0993c91e', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S03e02%20933482/The_Sopranos_S03E02_933482.zip?download', 'The_Sopranos_S03E02_933482.zip', 'WEB-DL', 3, '00000000-0000-0000-0000-000000000001', '2026-08-11 13:42:49.900781+00', '2026-08-11 13:42:49.900781+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('c85bff24-40ad-46ea-a98c-b3982e01c0ee', NULL, '2a6b5e0f-9f75-4c5e-a309-4f6c7796893a', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S03e03%20474854/The_Sopranos_S03E03_474854.zip?download', 'The_Sopranos_S03E03_474854.zip', 'WEB-DL', 3, '00000000-0000-0000-0000-000000000001', '2026-08-11 13:42:49.900781+00', '2026-08-11 13:42:49.900781+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('ea8954be-8c30-4e0c-afe1-872553bc2cbf', NULL, '84df7b6b-7c82-4c60-a33e-36f05ae56adb', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S03e04%20852059/The_Sopranos_S03E04_852059.zip?download', 'The_Sopranos_S03E04_852059.zip', 'WEB-DL', 4, '00000000-0000-0000-0000-000000000001', '2026-08-11 13:42:49.900781+00', '2026-08-11 13:42:49.900781+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('a36955f6-a467-473f-a58f-47b252757563', NULL, '3690aa9b-b712-4704-a57b-3c692eb0e81f', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S03e05%20718927/The_Sopranos_S03E05_718927.zip?download', 'The_Sopranos_S03E05_718927.zip', 'WEB-DL', 3, '00000000-0000-0000-0000-000000000001', '2026-08-11 13:42:49.900781+00', '2026-08-11 13:42:49.900781+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('b6f3be48-9240-44e5-aca4-83000b593c72', NULL, '94d992a4-af51-4c35-a399-a9d6fb095f2c', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Reacher%20S04e01%20605767/Reacher_S04E01_605767.zip?download', 'Reacher_S04E01_605767.zip', 'WEB-DL', 50, '00000000-0000-0000-0000-000000000001', '2026-08-12 08:51:51.598699+00', '2026-08-12 08:51:51.598699+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('b750cf97-90ba-42a8-a595-95fc458aa172', NULL, '81d0c1d0-e77e-40a9-af58-d1897beeb4b2', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Reacher%20S04e02%20764263/Reacher_S04E02_764263.zip?download', 'Reacher_S04E02_764263.zip', 'WEB-DL', 33, '00000000-0000-0000-0000-000000000001', '2026-08-12 11:07:22.290595+00', '2026-08-12 11:07:22.290595+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('05da217a-6dbf-49ed-aa4c-8bb412f3787b', NULL, 'e45f5826-f0c8-4c03-a1b7-965bc93c55c3', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Reacher%20S04e03%20133069/Reacher_S04E03_133069.zip?download', 'Reacher_S04E03_133069.zip', 'WEB-DL', 29, '00000000-0000-0000-0000-000000000001', '2026-08-12 11:07:22.290595+00', '2026-08-12 11:07:22.290595+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('6f520de9-f395-47a9-a23b-6993f4f0e920', NULL, 'bb9f99cd-84be-4c37-a09c-43beb05b4723', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Night%20of%20S01e02%20106730/The_Night_Of_S01E02_106730.zip?download', 'The_Night_Of_S01E02_106730.zip', 'WEB-DL', 4, '00000000-0000-0000-0000-000000000001', '2026-08-12 17:01:42.133751+00', '2026-08-12 17:01:42.133751+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('96f55440-07cc-4abf-abd4-275c0beb8dc4', NULL, '9ddbbbbf-0b44-43fb-a1cd-ea6fc3734bbc', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Night%20of%20S01e03%20630715/The_Night_Of_S01E03_630715.zip?download', 'The_Night_Of_S01E03_630715.zip', 'WEB-DL', 3, '00000000-0000-0000-0000-000000000001', '2026-08-12 17:01:42.133751+00', '2026-08-12 17:01:42.133751+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('481a718e-65b8-48af-ac90-22cdbf2c88d5', NULL, 'df2f8ff2-24eb-4eb6-a50c-c12e5809856e', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Night%20of%20S01e04%20112317/The_Night_Of_S01E04_112317.zip?download', 'The_Night_Of_S01E04_112317.zip', 'WEB-DL', 3, '00000000-0000-0000-0000-000000000001', '2026-08-12 17:01:42.133751+00', '2026-08-12 17:01:42.133751+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('c933f6ef-3f28-45b1-aad9-2f9e5fab95fc', NULL, '165260e9-751f-4b6d-a88c-c40ca426993d', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Night%20of%20S01e05%20899873/The_Night_Of_S01E05_899873.zip?download', 'The_Night_Of_S01E05_899873.zip', 'WEB-DL', 3, '00000000-0000-0000-0000-000000000001', '2026-08-12 17:01:42.133751+00', '2026-08-12 17:01:42.133751+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('02f463b9-2986-4ce2-a57d-4d431b55fc5a', NULL, '77306a79-aa9d-4c6c-a2c4-18ded6a8a449', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Night%20of%20S01e06%20156862/The_Night_Of_S01E06_156862.zip?download', 'The_Night_Of_S01E06_156862.zip', 'WEB-DL', 3, '00000000-0000-0000-0000-000000000001', '2026-08-12 17:01:42.133751+00', '2026-08-12 17:01:42.133751+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('33dd7e50-cdb4-49e1-a3de-26af9bca27f3', NULL, 'fdc7af4b-e7bb-48ea-af1e-f0e8ea3558e9', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Night%20of%20S01e07%20341151/The_Night_Of_S01E07_341151.zip?download', 'The_Night_Of_S01E07_341151.zip', 'WEB-DL', 3, '00000000-0000-0000-0000-000000000001', '2026-08-12 17:01:42.133751+00', '2026-08-12 17:01:42.133751+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('276ec994-d060-47ea-a320-e5a08e0d34df', NULL, 'f0e86235-31eb-4885-acfa-a4d6efd59db4', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Night%20of%20S01e08%20561344/The_Night_Of_S01E08_561344.zip?download', 'The_Night_Of_S01E08_561344.zip', 'WEB-DL', 4, '00000000-0000-0000-0000-000000000001', '2026-08-12 17:01:42.133751+00', '2026-08-12 17:01:42.133751+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('63cfbb04-54a3-4a78-a39f-70cfe5b20c24', NULL, '6eeca922-3fd7-4d28-ae70-1f429bfacaf0', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S03e06%20795011/The_Sopranos_S03E06_795011.zip?download', 'The_Sopranos_S03E06_795011.zip', 'WEB-DL', 3, '00000000-0000-0000-0000-000000000001', '2026-08-13 13:52:53.403139+00', '2026-08-13 13:52:53.403139+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('36e38656-365e-482e-a2b1-86586211f395', NULL, 'c67c45ba-2ea7-4ba8-aff5-107a9ba10726', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S03e07%20725705/The_Sopranos_S03E07_725705.zip?download', 'The_Sopranos_S03E07_725705.zip', 'WEB-DL', 4, '00000000-0000-0000-0000-000000000001', '2026-08-13 13:52:53.403139+00', '2026-08-13 13:52:53.403139+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('34843851-bf14-48c0-a6e6-92326902ea3b', NULL, '5989881b-eda7-446e-a368-1257ad207e89', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S03e08%20321435/The_Sopranos_S03E08_321435.zip?download', 'The_Sopranos_S03E08_321435.zip', 'WEB-DL', 3, '00000000-0000-0000-0000-000000000001', '2026-08-13 13:52:53.403139+00', '2026-08-13 13:52:53.403139+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('e575a95a-e697-4303-ae5e-52eadd2e43c2', NULL, '00de4c80-2277-49b6-a5b5-1441e7bb5659', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S03e09%20392346/The_Sopranos_S03E09_392346.zip?download', 'The_Sopranos_S03E09_392346.zip', 'WEB-DL', 3, '00000000-0000-0000-0000-000000000001', '2026-08-13 13:52:53.403139+00', '2026-08-13 13:52:53.403139+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('3e47578c-081a-4ef1-aa68-326e67f303ef', NULL, 'ebd0346d-7959-4331-a968-b1261dc03288', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S03e10%20864968/The_Sopranos_S03E10_864968.zip?download', 'The_Sopranos_S03E10_864968.zip', 'WEB-DL', 3, '00000000-0000-0000-0000-000000000001', '2026-08-13 13:52:53.403139+00', '2026-08-13 13:52:53.403139+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('e582dc10-11d9-4844-a43e-eda7fdbb8632', NULL, '61068b2c-cf11-4257-aba6-6262003d0d66', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S03e11%20942041/The_Sopranos_S03E11_942041.zip?download', 'The_Sopranos_S03E11_942041.zip', 'WEB-DL', 3, '00000000-0000-0000-0000-000000000001', '2026-08-13 13:52:53.403139+00', '2026-08-13 13:52:53.403139+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('8ea00e7d-80d8-4710-ace8-b74166592d51', NULL, '101f0c6c-9b1f-4675-aa3f-dc1ad435d2d9', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S03e12%20846554/The_Sopranos_S03E12_846554.zip?download', 'The_Sopranos_S03E12_846554.zip', 'WEB-DL', 3, '00000000-0000-0000-0000-000000000001', '2026-08-13 13:52:53.403139+00', '2026-08-13 13:52:53.403139+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('eb48bc7e-55db-45cd-ac35-2c10227ee52f', NULL, 'c43533be-e96f-4176-a484-3cc4e71efb0f', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S03e13%20997585/The_Sopranos_S03E13_997585.zip?download', 'The_Sopranos_S03E13_997585.zip', 'WEB-DL', 3, '00000000-0000-0000-0000-000000000001', '2026-08-13 13:52:53.403139+00', '2026-08-13 13:52:53.403139+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('992e5ed8-1ad8-4e58-adb2-00b7de76d56e', '1de2af9b-9c53-4c39-a3b6-07c77210bbb0', NULL, 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Cocktail/Cocktail.2.2026.NF.WEB-DL.Hindi.ExtraFlix_sinhala.zip?download', 'Cocktail.2.2026.NF.WEB-DL.Hindi.ExtraFlix_sinhala.zip', 'WEB-DL', 65, '00000000-0000-0000-0000-000000000001', '2026-08-14 18:39:26.460286+00', '2026-08-14 18:39:26.460286+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('d0bad91e-babd-469b-a93f-fbbe985b06e1', NULL, 'ae13a875-cf00-446d-a7bf-00a30ac3cbce', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S04e01%20445127/The_Sopranos_S04E01_445127.zip?download', 'The_Sopranos_S04E01_445127.zip', 'WEB-DL', 2, '00000000-0000-0000-0000-000000000001', '2026-08-15 23:36:34.227099+00', '2026-08-15 23:36:34.227099+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('6e57bd88-f8b4-4fa7-a308-3e30bb4e2d68', NULL, '6cb38ff8-f904-4798-a8de-c16ddae10c01', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S04e02%20699287/The_Sopranos_S04E02_699287.zip?download', 'The_Sopranos_S04E02_699287.zip', 'WEB-DL', 2, '00000000-0000-0000-0000-000000000001', '2026-08-15 23:36:34.227099+00', '2026-08-15 23:36:34.227099+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('8f15d881-a7aa-48f9-a8c6-c0e7bdc8d3f9', NULL, 'f62ec38b-d850-4c1f-af4b-3dc935480af1', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S04e03%20457351/The_Sopranos_S04E03_457351.zip?download', 'The_Sopranos_S04E03_457351.zip', 'WEB-DL', 2, '00000000-0000-0000-0000-000000000001', '2026-08-15 23:36:34.227099+00', '2026-08-15 23:36:34.227099+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('f7cb0bce-0c17-4b32-abd9-503912a0a262', NULL, '8d5421c6-211a-4005-a822-51c7d0bdb4b3', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S04e04%20475444/The_Sopranos_S04E04_475444.zip?download', 'The_Sopranos_S04E04_475444.zip', 'WEB-DL', 2, '00000000-0000-0000-0000-000000000001', '2026-08-15 23:36:34.227099+00', '2026-08-15 23:36:34.227099+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('81bd3d76-1a62-4c3d-a2ea-7df846eac69b', NULL, '6873c06e-a235-4cca-a6f3-5155f1904aaf', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S04e05%20506471/The_Sopranos_S04E05_506471.zip?download', 'The_Sopranos_S04E05_506471.zip', 'WEB-DL', 2, '00000000-0000-0000-0000-000000000001', '2026-08-15 23:36:34.227099+00', '2026-08-15 23:36:34.227099+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('2200dfa7-a09c-49cf-aeaf-12212facd195', NULL, 'db924be3-1faf-4e5d-a55e-970208ec6509', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S04e06%20177333/The_Sopranos_S04E06_177333.zip?download', 'The_Sopranos_S04E06_177333.zip', 'WEB-DL', 2, '00000000-0000-0000-0000-000000000001', '2026-08-15 23:36:34.227099+00', '2026-08-15 23:36:34.227099+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('96e209a1-bbbc-4809-a9c1-7ac1a9d51b41', NULL, '5c527043-9a69-437e-a169-4f41dba9a82c', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S04e07%20404453/The_Sopranos_S04E07_404453.zip?download', 'The_Sopranos_S04E07_404453.zip', 'WEB-DL', 2, '00000000-0000-0000-0000-000000000001', '2026-08-15 23:36:34.227099+00', '2026-08-15 23:36:34.227099+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('2899e57c-5818-4acf-a108-905607f2cf7d', NULL, '8c9f91c8-3bf7-4dfa-a3fb-50c6c13f5326', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S04e08%20264067/The_Sopranos_S04E08_264067.zip?download', 'The_Sopranos_S04E08_264067.zip', 'WEB-DL', 2, '00000000-0000-0000-0000-000000000001', '2026-08-15 23:36:34.227099+00', '2026-08-15 23:36:34.227099+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('b078f152-5847-4266-afce-e6b28aab9f4d', NULL, '250c590e-8d7a-437f-a298-9c02376ce6bf', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S04e09%20958349/The_Sopranos_S04E09_958349.zip?download', 'The_Sopranos_S04E09_958349.zip', 'WEB-DL', 2, '00000000-0000-0000-0000-000000000001', '2026-08-15 23:36:34.227099+00', '2026-08-15 23:36:34.227099+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('6a073877-9831-429c-a276-7bc6d271132a', NULL, '238f4b1b-2207-46f4-a556-3068b3631ded', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S04e10%20929685/The_Sopranos_S04E10_929685.zip?download', 'The_Sopranos_S04E10_929685.zip', 'WEB-DL', 2, '00000000-0000-0000-0000-000000000001', '2026-08-15 23:36:34.227099+00', '2026-08-15 23:36:34.227099+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('2720d28b-7540-458f-a307-8fae5833785c', NULL, 'ecdc33de-770b-44fb-aa6f-30fe78f7babc', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S04e11%20405043/The_Sopranos_S04E11_405043.zip?download', 'The_Sopranos_S04E11_405043.zip', 'WEB-DL', 2, '00000000-0000-0000-0000-000000000001', '2026-08-15 23:36:34.227099+00', '2026-08-15 23:36:34.227099+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('59b716d1-b979-4ef1-a6e6-f8f0f73d2ca3', NULL, '760404ec-0186-4835-af09-bc889348e456', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S04e12%20690200/The_Sopranos_S04E12_690200.zip?download', 'The_Sopranos_S04E12_690200.zip', 'WEB-DL', 2, '00000000-0000-0000-0000-000000000001', '2026-08-15 23:36:34.227099+00', '2026-08-15 23:36:34.227099+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('4ef0cf72-41cc-4162-a342-3358b290b680', NULL, '4adbc120-bd9a-4659-abaa-dfe6758d73fd', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S04e13%20322504/The_Sopranos_S04E13_322504.zip?download', 'The_Sopranos_S04E13_322504.zip', 'WEB-DL', 2, '00000000-0000-0000-0000-000000000001', '2026-08-15 23:36:34.227099+00', '2026-08-15 23:36:34.227099+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('a23604c8-628d-4407-a5ca-58505613e31c', NULL, '13146e83-5b56-4172-ad65-da96fff927aa', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Lanterns%20S01e01%20488132/Lanterns_S01E01_488132.zip?download', 'Lanterns_S01E01_488132.zip', 'WEB-DL', 18, '00000000-0000-0000-0000-000000000001', '2026-08-17 00:43:29.237961+00', '2026-08-17 00:43:29.237961+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('de63fe17-8b92-4240-af18-bb090646850d', NULL, 'bcf388b1-7318-4d56-a3ec-a28e8f1b81bc', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Dexter%20S01e01%20166599/Dexter_S01E01_166599.zip?download', 'Dexter_S01E01_166599.zip', 'WEB-DL', 2, '00000000-0000-0000-0000-000000000001', '2026-08-22 06:41:53.87792+00', '2026-08-22 06:41:53.87792+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('5a9ff825-932b-4026-ae03-7fc57ac588d9', NULL, '095f8705-8c1d-49cc-a4ba-e948a1ba34f3', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Dexter%20S01e02%20432343/Dexter_S01E02_432343.zip?download', 'Dexter_S01E02_432343.zip', 'WEB-DL', 0, '00000000-0000-0000-0000-000000000001', '2026-08-22 06:41:53.87792+00', '2026-08-22 06:41:53.87792+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('7f7e8321-5b2b-493b-a87f-01b979f83226', NULL, '57ac433d-5b5c-45e5-a691-c3417ae68162', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Dexter%20S01e03%20335630/Dexter_S01E03_335630.zip?download', 'Dexter_S01E03_335630.zip', 'WEB-DL', 0, '00000000-0000-0000-0000-000000000001', '2026-08-22 06:41:53.87792+00', '2026-08-22 06:41:53.87792+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('628d5fa2-0843-4e6d-abcf-cec60ccce33e', NULL, 'b22aa0de-467b-4425-a56c-590afa035476', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Dexter%20S01e04%20573244/Dexter_S01E04_573244.zip?download', 'Dexter_S01E04_573244.zip', 'WEB-DL', 0, '00000000-0000-0000-0000-000000000001', '2026-08-22 06:41:53.87792+00', '2026-08-22 06:41:53.87792+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('0265ac78-7e0e-488e-adf8-1a5d2b5b8576', NULL, 'd5678a26-1b9e-4296-a8a9-0f8d09d19e6d', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Dexter%20S01e05%20797012/Dexter_S01E05_797012.zip?download', 'Dexter_S01E05_797012.zip', 'WEB-DL', 0, '00000000-0000-0000-0000-000000000001', '2026-08-22 06:41:53.87792+00', '2026-08-22 06:41:53.87792+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('a7012045-ac66-426c-a613-ad7056a6ffc3', NULL, '89c562af-0cc8-4ce5-a6a6-93770d8b3b47', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Dexter%20S01e06%20941990/Dexter_S01E06_941990.zip?download', 'Dexter_S01E06_941990.zip', 'WEB-DL', 0, '00000000-0000-0000-0000-000000000001', '2026-08-22 06:41:53.87792+00', '2026-08-22 06:41:53.87792+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('e3435ff2-045f-48fa-a592-79fb979c5c12', NULL, '4ec1c75a-4cf9-46fd-a477-7c7683148c58', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Dexter%20S01e07%20925571/Dexter_S01E07_925571.zip?download', 'Dexter_S01E07_925571.zip', 'WEB-DL', 0, '00000000-0000-0000-0000-000000000001', '2026-08-22 06:41:53.87792+00', '2026-08-22 06:41:53.87792+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('5090f920-506c-43d6-ace9-dcb3a7a0daf9', NULL, 'c85df387-a5c7-4fcc-ac58-0dac48370ba7', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Dexter%20S01e08%20342473/Dexter_S01E08_342473.zip?download', 'Dexter_S01E08_342473.zip', 'WEB-DL', 0, '00000000-0000-0000-0000-000000000001', '2026-08-22 06:41:53.87792+00', '2026-08-22 06:41:53.87792+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('eb07c2a3-3627-4f2f-a981-04cd9524d407', NULL, '62a065a7-aa16-4c78-a9d2-fa369d94442f', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Dexter%20S01e09%20552431/Dexter_S01E09_552431.zip?download', 'Dexter_S01E09_552431.zip', 'WEB-DL', 0, '00000000-0000-0000-0000-000000000001', '2026-08-22 06:41:53.87792+00', '2026-08-22 06:41:53.87792+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('ebbad126-8cda-4ca3-a595-e38ff58bfe9d', NULL, 'c76266a7-b1af-495b-a285-639c3c6c757a', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Dexter%20S01e10%20461467/Dexter_S01E10_461467.zip?download', 'Dexter_S01E10_461467.zip', 'WEB-DL', 0, '00000000-0000-0000-0000-000000000001', '2026-08-22 06:41:53.87792+00', '2026-08-22 06:41:53.87792+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('c7d01634-f912-40c0-ad4c-182c291f18c5', NULL, '26d98b77-da16-4f1c-a97b-7c006c9c9961', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Dexter%20S01e11%20683849/Dexter_S01E11_683849.zip?download', 'Dexter_S01E11_683849.zip', 'WEB-DL', 0, '00000000-0000-0000-0000-000000000001', '2026-08-22 06:41:53.87792+00', '2026-08-22 06:41:53.87792+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_url, file_name, version, downloads_count, uploader_id, created_at, updated_at) VALUES ('f2cfa0af-68f3-4928-ae0e-573241065953', NULL, '68dc79b9-258e-4dde-aee1-9f97be5e997e', 'Sinhala', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Dexter%20S01e12%20784715/Dexter_S01E12_784715.zip?download', 'Dexter_S01E12_784715.zip', 'WEB-DL', 0, '00000000-0000-0000-0000-000000000001', '2026-08-22 06:41:53.87792+00', '2026-08-22 06:41:53.87792+00') ON CONFLICT (id) DO NOTHING;

-- 5. TELEGRAM LINKS
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('45aa097e-72fb-4b89-a568-809bb9471480', NULL, '912b2ab3-2322-42ae-a212-39b1028bfe63', '1080p / 720p', NULL, 'https://telegram.me/PixelPopLk_bot?start=f4665c39-c37c-4b24-81aa-b8c839a45e6d', 'Telegram Bot', 46, '2026-07-02 20:20:47.74712+00', '2026-07-02 20:20:47.74712+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('a1db5ed3-f130-43c0-ad14-8f4c2041dd60', NULL, 'd7d2a13f-ed0a-452d-a330-aa6b930a31ec', '1080p / 720p', NULL, 'https://telegram.me/PixelPopLk_bot?start=f9e601f7-50c8-43e8-9141-3b0c257224c5', 'Telegram Bot', 10, '2026-07-05 19:07:04.212977+00', '2026-07-05 19:07:04.212977+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('d3ceb7a1-42a9-45f3-a655-bf5bd1efd9fa', NULL, 'e9ec4820-ae59-4c5d-a2d2-a0bfeb571b49', '1080p / 720p', NULL, 'https://telegram.me/PixelPopLk_bot?start=7ff27dce-8815-46de-945d-f82fd1cabeba', 'Telegram Bot', 22, '2026-07-06 17:23:49.258164+00', '2026-07-06 17:23:49.258164+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('b785b4d2-044b-4851-a426-4afcbd5b3b10', NULL, '130421e6-7fff-48bc-acbc-b6413b7d7f95', '1080p / 720p', NULL, 'https://telegram.me/PixelPopLk_bot?start=918d3874-2498-4380-9c70-f1602024c58e', 'Telegram Bot', 16, '2026-07-06 18:51:33.429257+00', '2026-07-06 18:51:33.429257+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('ef229caa-449a-4fd8-a90f-b95a3e1a61f6', NULL, '6eab0a74-a85c-43d3-adde-3708df59e4fa', '1080p / 720p', NULL, 'https://telegram.me/PixelPopLk_bot?start=5aacabbc-f883-47b3-8574-4d7449843821', 'Telegram Bot', 18, '2026-07-06 18:51:33.429257+00', '2026-07-06 18:51:33.429257+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('5f56d1a0-2601-4bba-a239-a6ef4ba5c5c8', NULL, '80cbe5f1-9a04-4c31-a897-2ad12135327c', '1080p / 720p', NULL, 'https://telegram.me/PixelPopLk_bot?start=185c4b26-b940-4d53-8bf2-d61a519f6c36', 'Telegram Bot', 16, '2026-07-06 18:51:33.429257+00', '2026-07-06 18:51:33.429257+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('6a8a90f0-8ed4-49f2-a82e-285f8f3161a9', NULL, '08367973-c5da-4826-a0c3-50c6b8ea613b', '1080p / 720p', NULL, 'https://telegram.me/PixelPopLk_bot?start=0de80f22-fdd8-478d-98c0-ea2b07e736a5', 'Telegram Bot', 14, '2026-07-06 18:51:33.429257+00', '2026-07-06 18:51:33.429257+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('23eeb0c8-21b4-49ff-a59d-efb98b06325f', NULL, '7b534471-5ec0-428a-a903-a492f0bac484', '1080p / 720p', NULL, 'https://telegram.me/PixelPopLk_bot?start=80a78a9e-758a-4de6-b390-bd65223d9a6d', 'Telegram Bot', 18, '2026-07-06 18:51:33.429257+00', '2026-07-06 18:51:33.429257+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('b86f50ac-920e-42fe-a712-9fd102fb6c94', NULL, '4d044d42-83db-4d92-ab9d-5e844d46af80', '1080p / 720p', NULL, 'https://telegram.me/PixelPopLk_bot?start=d2ea6765-f918-47ee-8d84-b5bbc6a2a9e8', 'Telegram Bot', 18, '2026-07-06 18:51:33.429257+00', '2026-07-06 18:51:33.429257+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('36267d7c-29cb-4be8-aa55-2cfb4755f778', NULL, '7e74aa1f-e5a1-404b-afad-d34277775c00', '1080p / 720p', NULL, 'https://telegram.me/PixelPopLk_bot?start=e71241ff-72a9-4cae-ad14-50583c0dc5c0', 'Telegram Bot', 18, '2026-07-06 18:51:33.429257+00', '2026-07-06 18:51:33.429257+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('a67a3368-bb39-4039-ae7f-59e8906fb1d6', NULL, 'ccf25e3d-dce1-489e-a7e3-887f3e3684a4', '1080p / 720p', NULL, 'https://telegram.me/PixelPopLk_bot?start=cb083040-bcd9-4e4d-80a8-c9245f19cc62', 'Telegram Bot', 16, '2026-07-06 18:51:33.429257+00', '2026-07-06 18:51:33.429257+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('aeb2953b-c3af-48ca-a768-6d37c9dfcdc9', NULL, '9b1833d7-6b9d-450e-a1e1-c8c474fac864', '1080p / 720p', NULL, 'https://telegram.me/PixelPopLk_bot?start=ebff73b8-00dd-4658-98c4-fc37feba518c', 'Telegram Bot', 16, '2026-07-06 18:51:33.429257+00', '2026-07-06 18:51:33.429257+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('7c5654b1-a7c1-4524-aeec-498aac373c2a', NULL, '0080317b-1392-475f-a627-015e66067c91', '1080p / 720p', NULL, 'https://telegram.me/PixelPopLk_bot?start=84bc7d3b-16ab-4242-843e-930443b68382', 'Telegram Bot', 16, '2026-07-06 18:51:33.429257+00', '2026-07-06 18:51:33.429257+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('34b36922-ef2f-427f-a4dc-4a214757d2ec', NULL, '0ce713eb-5148-4a97-a6e0-76a1beebc49f', '1080p / 720p', NULL, 'https://telegram.me/PixelPopLk_bot?start=a234283e-f3ba-452d-b5a6-b580b65c0e69', 'Telegram Bot', 16, '2026-07-06 18:51:33.429257+00', '2026-07-06 18:51:33.429257+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('0c887c83-ea78-4d64-a995-05ab50e4cca4', NULL, '501b9add-7c98-4b1f-a385-fde8dfc42fa5', '1080p / 720p', NULL, 'https://telegram.me/Pixelpopnew_bot?start=bZLcfBOHyGo', 'Telegram Bot', 78, '2026-07-10 21:03:45.984807+00', '2026-07-10 21:03:45.984807+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('752992ad-27b6-4c53-af00-f7c52d1b4e8f', NULL, '2d08b8d2-2930-4b28-ac73-1d109580fda9', '1080p / 720p', NULL, 'https://telegram.me/Pixelpopnew_bot?start=wSdi9dygo7c', 'Telegram Bot', 26, '2026-07-10 21:03:45.984807+00', '2026-07-10 21:03:45.984807+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('14d1a766-4c4e-4ee0-aba2-023569c26eff', NULL, '7776b392-0042-4380-aba5-edd834ecd8c1', '1080p / 720p', NULL, 'https://telegram.me/Pixelpopnew_bot?start=bz5FEqL7Alw', 'Telegram Bot', 26, '2026-07-10 21:03:45.984807+00', '2026-07-10 21:03:45.984807+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('cf647c0d-7329-4dd0-a5d1-c24da26908ab', NULL, 'fe745258-41e9-440d-ac56-9089056e8162', '1080p / 720p', NULL, 'https://telegram.me/Pixelpopnew_bot?start=kwpKKX_0HMc', 'Telegram Bot', 20, '2026-07-10 21:03:45.984807+00', '2026-07-10 21:03:45.984807+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('fa3d407c-c1c7-40a2-a8e5-f5ca52e26bef', NULL, 'b076b5cd-62f0-45cd-a063-a84af0ed7dcb', '1080p / 720p', NULL, 'https://telegram.me/Pixelpopnew_bot?start=8sVvr3oJCC8', 'Telegram Bot', 22, '2026-07-10 21:03:45.984807+00', '2026-07-10 21:03:45.984807+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('a59cc469-749c-4beb-a182-6ec8405de380', NULL, '9fa4c5a1-d432-4f13-a729-a8f1ee92775a', '1080p / 720p', NULL, 'https://telegram.me/Pixelpopnew_bot?start=tQBSfGa8rbE', 'Telegram Bot', 18, '2026-07-10 21:03:45.984807+00', '2026-07-10 21:03:45.984807+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('6f1e38bf-791a-432e-a5a8-efe77c845d53', NULL, 'fee1a5ec-118e-4f40-a7dd-dbf61b9b671d', '1080p / 720p', NULL, 'https://telegram.me/PixelPopLk_bot?start=3f71a5c6-3156-4e93-a371-98383cd89447', 'Telegram Bot', 24, '2026-07-13 01:46:09.988815+00', '2026-07-13 01:46:09.988815+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('1ca42725-d42e-4401-a94e-e0008a64bb21', '8990c886-92d6-4bc3-a5bb-2bca8f3a9a8a', NULL, '1080p Full HD', NULL, 'https://telegram.me/PixelPopLk_bot?start=ce1f51a1-b727-428d-996f-5232dbe1d1ae', 'Telegram Bot', 0, '2026-07-14 05:32:34.672294+00', '2026-07-14 05:32:34.672294+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('13efaed6-2d30-4317-a92e-cb768fde679f', NULL, '5865956a-2dea-490d-aca4-e12a48b4052c', '1080p / 720p', NULL, 'https://telegram.me/Pixelpopnew_bot?start=QKnz2FD0oMU', 'Telegram Bot', 14, '2026-07-14 11:59:44.37195+00', '2026-07-14 11:59:44.37195+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('5705a88c-98ff-4636-a718-cc363a0184cd', NULL, 'e9b7dc41-4868-4e77-af89-5bf4f29c0b78', '1080p / 720p', NULL, 'https://telegram.me/Pixelpopnew_bot?start=_E8XvNCEomU', 'Telegram Bot', 16, '2026-07-14 11:59:44.37195+00', '2026-07-14 11:59:44.37195+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('bef586d9-530d-49f0-af40-57252529981a', NULL, 'ec3e5305-ec7d-47f1-a8a7-98ee6baca31f', '1080p / 720p', NULL, 'https://telegram.me/Pixelpopnew_bot?start=IF7-4W1JVvI', 'Telegram Bot', 16, '2026-07-14 11:59:44.37195+00', '2026-07-14 11:59:44.37195+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('3616b1ac-ea62-45f2-ac53-cd878ba6d473', NULL, '455acaea-abe3-4ef2-a545-cf518a7d60cb', '1080p / 720p', NULL, 'https://telegram.me/Pixelpopnew_bot?start=AdomEMXm41g', 'Telegram Bot', 16, '2026-07-14 11:59:44.37195+00', '2026-07-14 11:59:44.37195+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('94c3e500-786a-4dd8-a3da-4e197b13a727', NULL, '3bc7f956-2b03-447e-af1b-30679dddddc9', '1080p / 720p', NULL, 'https://telegram.me/Pixelpopnew_bot?start=KbYzqf3-Xj4', 'Telegram Bot', 14, '2026-07-14 11:59:44.37195+00', '2026-07-14 11:59:44.37195+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('e340ac8a-8129-4c5f-aa34-eef64a3c2e15', NULL, '72b6fbc9-3c36-443a-a6b5-1e337dec79d5', '1080p / 720p', NULL, 'https://telegram.me/Pixelpopnew_bot?start=Us5MJCmH9uU', 'Telegram Bot', 16, '2026-07-14 11:59:44.37195+00', '2026-07-14 11:59:44.37195+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('6e76ccd1-2a55-42b8-a87f-e66789a59829', NULL, '47bed304-d417-4d22-a9a4-46ff0c3ca728', '1080p / 720p', NULL, 'https://telegram.me/Pixelpopnew_bot?start=5DSSmuf-tWA', 'Telegram Bot', 18, '2026-07-14 11:59:44.37195+00', '2026-07-14 11:59:44.37195+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('6d350d23-b135-4d73-ad44-07b0ee756aee', NULL, 'd2606136-6589-4216-a7d7-c921c52d8391', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=Nj1jum1zo8Y', 'Telegram Bot', 16, '2026-07-16 15:21:01.297081+00', '2026-07-16 15:21:01.297081+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('e452b0da-22ed-4b66-acae-ae5fb4bb0060', NULL, 'c372ba8b-3837-47ca-a53c-0358a144f9b3', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=ctyEt5nRX4w', 'Telegram Bot', 14, '2026-07-16 15:21:01.297081+00', '2026-07-16 15:21:01.297081+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('9b787a7c-0e28-4627-a444-66de7e982301', NULL, '94cfd6ac-c1e9-43ba-ac16-a9c366bdfdff', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=ffye6Opt8Fc', 'Telegram Bot', 16, '2026-07-16 15:21:01.297081+00', '2026-07-16 15:21:01.297081+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('bcc70728-0309-4ceb-a269-a9d301b92333', NULL, 'd4f49640-ccda-488e-a7f9-c4000d59fb2c', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=t-q8BmS57c4', 'Telegram Bot', 16, '2026-07-16 15:21:01.297081+00', '2026-07-16 15:21:01.297081+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('fb3e9223-e844-462a-aa8e-19c92b5fa2aa', NULL, 'eb619e4d-c2a6-4733-afa2-695c040bbb71', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=Xdoh5cdJPcQ', 'Telegram Bot', 22, '2026-07-16 15:21:01.297081+00', '2026-07-16 15:21:01.297081+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('5caa0d85-0f41-4033-a558-2ebcba12b23f', NULL, '98fa1ea1-770d-4fff-acf6-d188e48d4edd', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=_We7V_I4Djo', 'Telegram Bot', 16, '2026-07-17 13:58:47.835069+00', '2026-07-17 13:58:47.835069+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('303ddbae-27ff-4eb8-afc6-4a2f1a9af804', NULL, 'bac9e140-45d0-4d60-a9e7-65013015e9a6', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=db0aM82iT14', 'Telegram Bot', 16, '2026-07-17 13:58:47.835069+00', '2026-07-17 13:58:47.835069+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('1000448c-c338-4a76-a7d1-dcd9d34d4a19', NULL, 'aad2f5ff-8b1a-4227-a69d-738f6fd09262', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=wvrsZR5C0Wc', 'Telegram Bot', 14, '2026-07-17 13:58:47.835069+00', '2026-07-17 13:58:47.835069+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('93ce796d-3e87-47e5-a544-4a28b7231fb5', NULL, 'b5e206f2-b7b4-463d-a793-aa55f5fc5203', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=gZoo5fAVeGs', 'Telegram Bot', 42, '2026-07-17 13:58:47.835069+00', '2026-07-17 13:58:47.835069+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('0ebe76fe-69c8-4a5c-afff-4ce6829ed37d', NULL, '17d1f196-4d18-4d69-aefc-4b0ae10dd230', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=SHnUyOO_Qus', 'Telegram Bot', 22, '2026-07-17 13:58:47.835069+00', '2026-07-17 13:58:47.835069+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('8da63ffd-67ee-4718-aa1a-b7c42ecc1d1b', NULL, 'eeeb736f-887f-4f3b-aa8f-57e090848623', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=TYB9eVLhTkM', 'Telegram Bot', 16, '2026-07-17 13:58:47.835069+00', '2026-07-17 13:58:47.835069+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('9353f3c7-2df1-4af5-a582-045e74e2bde7', NULL, 'a5dff875-a09a-4e56-af63-63bce732bf92', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=v1-7amMjLhs', 'Telegram Bot', 24, '2026-07-17 13:58:47.835069+00', '2026-07-17 13:58:47.835069+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('802dafb2-b8a7-4ce9-a29f-f67d627a6bb9', NULL, '1fe002bc-e2d9-46da-abc4-32ef92d71d6b', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=F-0GG-6qGoI', 'Telegram Bot', 20, '2026-07-17 13:58:47.835069+00', '2026-07-17 13:58:47.835069+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('e5ffe42c-a0a6-4a10-afda-6b1c6409d368', NULL, 'f3bdae01-5b44-4098-a794-4703410f491c', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=_aUcpqo3YPI', 'Telegram Bot', 0, '2026-07-18 06:07:52.262353+00', '2026-07-18 06:07:52.262353+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('f83fdb90-091b-47be-aeb1-596d3f18d1b5', NULL, '22c151e6-99ac-4fce-a987-8437b8e36a56', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=XlsNCjz8mcs', 'Telegram Bot', 0, '2026-07-18 06:09:35.713148+00', '2026-07-18 06:09:35.713148+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('b4d6f235-83c8-40e5-aaf8-9388d1df3a08', NULL, 'dc7822df-1754-4be2-aed8-add4988a3e02', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=SDnkstXheBg', 'Telegram Bot', 0, '2026-07-18 17:41:59.995576+00', '2026-07-18 17:41:59.995576+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('0de59eae-a287-439c-ac16-c02336b6e740', NULL, 'b1794662-3545-48b5-ab09-f0694d94b947', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=6w9Dk8VNhrE', 'Telegram Bot', 0, '2026-07-18 17:41:59.995576+00', '2026-07-18 17:41:59.995576+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('3553dcf5-b60b-4048-a50a-820505b6fffd', NULL, '3d5128aa-b66b-4def-adb5-e834b398b028', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=RgSSdU9Tg3Q', 'Telegram Bot', 0, '2026-07-18 17:41:59.995576+00', '2026-07-18 17:41:59.995576+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('0f5e083f-f6eb-48e3-aa05-0bcb8da4055e', NULL, '413fcb34-2c58-4f47-ac85-9d81465233d6', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=0ZF18F5WoCs', 'Telegram Bot', 0, '2026-07-18 17:41:59.995576+00', '2026-07-18 17:41:59.995576+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('e956d5e0-3ef5-4cd9-a17a-324a290039f7', NULL, '74eeabd1-00f9-4c43-a0d7-e3aff995fa5f', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=qYF_IcYwgCM', 'Telegram Bot', 0, '2026-07-18 17:41:59.995576+00', '2026-07-18 17:41:59.995576+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('e2bd7bad-0187-4ab8-a1b8-4d509ae52ea1', NULL, '81b3aec6-8271-4258-ad06-a768a577b139', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=d__-ZYvsyM4', 'Telegram Bot', 0, '2026-07-18 17:41:59.995576+00', '2026-07-18 17:41:59.995576+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('e17bee6c-f4d1-4f08-a50b-26c1be299b1f', NULL, 'e2653cfb-e48d-48b6-a5a4-089b70420785', '1080p / 720p', NULL, 'https://t.me/PixelPopLk_bot?start=497ab715-57ac-4a68-b482-61f84bd17159', 'Telegram Bot', 14, '2026-07-18 18:03:31.96276+00', '2026-07-18 18:03:31.96276+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('18e5592e-1c68-4964-a152-f4859e305567', NULL, '9a2076e3-ab74-45b0-a531-2f1c5107a11b', '1080p / 720p', NULL, 'https://t.me/PixelPopLk_bot?start=810c4d64-4c91-42a5-9ae3-3124e18bb189', 'Telegram Bot', 34, '2026-07-18 18:05:34.87458+00', '2026-07-18 18:05:34.87458+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('3c07fbca-56ba-4c55-a5d5-5bf70a21ec26', NULL, 'd9d4f053-4098-4a04-a98c-12d316731311', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=8NEJwzLMMMk', 'Telegram Bot', 14, '2026-07-19 18:04:00.986472+00', '2026-07-19 18:04:00.986472+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('60fe869d-e753-4b95-ac0f-1892703a7ab8', NULL, '584d05cf-344d-40e2-a516-a59ef8c9f405', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=EKDdwz2kDnI', 'Telegram Bot', 14, '2026-07-19 18:04:00.986472+00', '2026-07-19 18:04:00.986472+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('e18b4b8b-8958-491d-a0cb-60b32bba45c5', NULL, '03e6ba2d-e2ad-43d4-a63f-00fa5981cc0a', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=5cEwOHO6gXE', 'Telegram Bot', 26, '2026-07-19 18:04:00.986472+00', '2026-07-19 18:04:00.986472+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('8a377ff9-c63b-49e7-a625-f7c3929ee377', NULL, '164e67e9-f105-4bd5-a53f-300713a4c798', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=0QWzapTw4CE', 'Telegram Bot', 22, '2026-07-19 18:04:00.986472+00', '2026-07-19 18:04:00.986472+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('70a0cbf6-db45-4fb7-a0b6-b1c19a78515e', NULL, 'ae823c98-696b-4815-a6ac-824d6cb70553', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=hgX23awWEhc', 'Telegram Bot', 12, '2026-07-19 18:04:00.986472+00', '2026-07-19 18:04:00.986472+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('c15f875a-05a4-43b4-a3cd-1183aeda7baa', NULL, 'ff5100c5-3704-4805-a6f3-22680b085332', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=yQo2hMHgRa8', 'Telegram Bot', 8, '2026-07-19 18:04:00.986472+00', '2026-07-19 18:04:00.986472+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('7fe75b70-4983-4021-ac13-9df3fff22079', NULL, '2620c6d3-5a7c-437a-ad25-8e540e35f11b', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=jcPBAK9DK_g', 'Telegram Bot', 18, '2026-07-20 02:26:00.42846+00', '2026-07-20 02:26:00.42846+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('c92cf06e-edb0-4919-a277-88d305b5425f', '4419eb72-7023-4654-ab76-5d1c72a1306f', NULL, '1080p Full HD', NULL, 'https://t.me/PixelPopLk_bot?start=a0795f91-288e-48c9-8e87-257726a3cae5', 'Telegram Bot', 2, '2026-07-21 08:01:41.770922+00', '2026-07-21 08:01:41.770922+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('84b3c11d-8455-4a3d-acb2-6733d67d5ace', NULL, 'ff5ed374-49c1-433f-a96e-f0ec63cda0e9', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=KtkDN-42odc', 'Telegram Bot', 8, '2026-07-21 11:40:15.630722+00', '2026-07-21 11:40:15.630722+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('87a4b9ec-2c19-43f6-a370-1278ce016d97', NULL, '5d34ecf3-7cdb-4cef-af19-6de2d3d9ffbd', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=8fDnjFpoY0Y', 'Telegram Bot', 8, '2026-07-21 11:40:15.630722+00', '2026-07-21 11:40:15.630722+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('5ee2785a-65ff-4c28-a6bc-3f29dff209b2', NULL, '157e7c9b-0cfe-456e-a209-6a7f39104c6b', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=UfFdUVG6RFE', 'Telegram Bot', 8, '2026-07-21 11:40:15.630722+00', '2026-07-21 11:40:15.630722+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('78ef5846-799e-4b94-aa11-1095a145ff19', NULL, '048dc99f-6e98-40b0-aee8-99c4744c3fa3', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=3cEG-0FdiAU', 'Telegram Bot', 8, '2026-07-21 11:40:15.630722+00', '2026-07-21 11:40:15.630722+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('7f1bd56c-f36e-46aa-a231-4c52fbb94201', NULL, 'a5accf34-bbe8-4ec9-ad35-5d5586911ede', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=SIgmPxUPMp4', 'Telegram Bot', 8, '2026-07-21 11:40:15.630722+00', '2026-07-21 11:40:15.630722+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('0c2da18d-2176-46fa-a00b-7dc123f07cda', NULL, '0da19ae5-fa09-42ae-a07b-3f7df1a138fb', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=dzLuyeorNsg', 'Telegram Bot', 6, '2026-07-21 11:40:15.630722+00', '2026-07-21 11:40:15.630722+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('7ea9a757-35f9-4367-a8a2-b171859c35a8', NULL, 'b671121c-bb64-487d-a9fc-fc8a43896b3b', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=V0GgpWU7F84', 'Telegram Bot', 6, '2026-07-21 11:40:15.630722+00', '2026-07-21 11:40:15.630722+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('27dac3da-278f-43fa-abaf-18f87a0ec957', NULL, 'ae98a8da-38d7-457c-ad73-f3fa36b05e71', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=vmPMRGqvj-Y', 'Telegram Bot', 6, '2026-07-21 11:40:15.630722+00', '2026-07-21 11:40:15.630722+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('d774f157-2fec-4b1f-a876-7911baf781d9', NULL, '71cdb260-6189-4909-a982-408b53b4a527', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=0dXvvBaQSb4', 'Telegram Bot', 0, '2026-07-21 11:40:57.426392+00', '2026-07-21 11:40:57.426392+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('111ddd1a-8a4a-4a58-a31f-e3518e790d5f', NULL, '2e3c75b7-62f9-4016-aeb3-0db275e4694e', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=3glZV3fPr7M', 'Telegram Bot', 0, '2026-07-21 11:40:57.426392+00', '2026-07-21 11:40:57.426392+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('79f3db9e-4226-4e87-a301-384b62aa9e72', NULL, 'd75a210a-6176-46c7-a9b0-72c8257b7c94', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=4zHu9uNt7k8', 'Telegram Bot', 0, '2026-07-21 11:40:57.426392+00', '2026-07-21 11:40:57.426392+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('92275cb7-8d45-41cd-a8d6-dc7bf6c152ce', NULL, 'd3dc4e95-a048-45fe-a465-79f7eca86a41', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=IDYDagRDWRc', 'Telegram Bot', 0, '2026-07-21 11:40:57.426392+00', '2026-07-21 11:40:57.426392+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('bebcfcdb-4e15-4d80-a326-27ded8defb1e', NULL, 'd079e06d-f5c7-4b22-adcc-4a2f4660fe20', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=5Vhp0WJ3nDQ', 'Telegram Bot', 0, '2026-07-21 11:40:57.426392+00', '2026-07-21 11:40:57.426392+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('15338687-e115-470b-a912-c54fe6b65ad0', NULL, 'd11bf2e7-32fb-4bae-a23f-6eafe1eebec4', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=RPyqWmuqi8g', 'Telegram Bot', 0, '2026-07-21 11:40:57.426392+00', '2026-07-21 11:40:57.426392+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('7c9b2095-39b8-448b-a6f9-13a778832088', NULL, '64d587f8-1fc9-44ee-a2bc-7c3c946f94a1', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=_pC3ossCHzM', 'Telegram Bot', 8, '2026-07-22 15:20:11.306013+00', '2026-07-22 15:20:11.306013+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('afb85d76-2b7a-44c0-a2cb-4c47215cbe12', NULL, 'f1ab93cd-7fb1-429f-ac72-d5a9575b58f8', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=QeDzBAr5sqA', 'Telegram Bot', 8, '2026-07-22 15:20:11.306013+00', '2026-07-22 15:20:11.306013+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('443d556a-c03d-4347-a9c7-c0b4487fe6eb', NULL, 'cb90507c-99dd-47f9-a469-73a47bb820c6', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=001N-5kET58', 'Telegram Bot', 8, '2026-07-22 15:20:11.306013+00', '2026-07-22 15:20:11.306013+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('9bb64ab9-6ba8-4953-a6f7-bd726c1f6564', NULL, '109da833-6129-446c-ae6e-e2af0895c68c', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=eYot5P-7oSU', 'Telegram Bot', 8, '2026-07-22 15:20:11.306013+00', '2026-07-22 15:20:11.306013+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('d30decd2-67bb-4a2d-ac10-7475bd3b2088', NULL, 'c5d5fa30-2fa9-428e-a43d-c6acaa09817f', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=uXcSz7_TwLg', 'Telegram Bot', 8, '2026-07-22 15:20:11.306013+00', '2026-07-22 15:20:11.306013+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('0cd84153-0d90-4b2e-afd4-0d90b7e2c007', NULL, '5e98ed7d-def9-4406-a85d-75f5b3f3f934', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=5Gz2t4qHCUk', 'Telegram Bot', 8, '2026-07-23 15:20:45.443248+00', '2026-07-23 15:20:45.443248+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('00983386-c410-46b5-a320-23e42433a4c1', NULL, '71a464db-5dbe-4456-ae84-175736c13c0e', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=eDpR9igtdjc', 'Telegram Bot', 8, '2026-07-23 15:20:45.443248+00', '2026-07-23 15:20:45.443248+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('58bb43b3-856f-4cab-a4c6-72a475861a93', NULL, '30e31621-fe73-4d9f-ac06-0883b308948b', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=z-6eFCtY7Uw', 'Telegram Bot', 8, '2026-07-23 15:20:45.443248+00', '2026-07-23 15:20:45.443248+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('c23c7708-de43-4385-a0bf-05d802bb07a0', NULL, 'f7ff5cd9-3e7a-4854-a839-f08b1e796d03', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=TuuXkPJL320', 'Telegram Bot', 10, '2026-07-23 15:20:45.443248+00', '2026-07-23 15:20:45.443248+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('4995274b-63f8-41d7-afef-ad3b38b7f347', NULL, '90c2c1ce-3149-4420-acc4-5e1137a9f04b', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=GsRL_Cha5UU', 'Telegram Bot', 10, '2026-07-23 15:20:45.443248+00', '2026-07-23 15:20:45.443248+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('9e80d610-0dbc-4da6-a1ef-0ff3c68af286', NULL, 'd754f593-8f53-478a-a516-0a5d7dce1f13', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=LQ1kcNDHDMo', 'Telegram Bot', 10, '2026-07-23 15:20:45.443248+00', '2026-07-23 15:20:45.443248+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('7748000f-bcec-4401-ade1-845eee415614', NULL, '9362b49e-c6a7-438e-abd0-e5d5ee591bcf', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=UhgiyvxRYu4', 'Telegram Bot', 10, '2026-07-23 15:20:45.443248+00', '2026-07-23 15:20:45.443248+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('fc42ad98-f177-4068-abb3-62f9837ae65e', NULL, 'fc4e3466-8657-4b65-a78c-5b09ff582980', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=jJiJ-GTU3c8', 'Telegram Bot', 10, '2026-07-23 15:20:45.443248+00', '2026-07-23 15:20:45.443248+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('b9a04135-6280-4f00-aa14-82c57d95f3e8', 'a6eb09ea-0a4e-4a2e-a5df-9f7214592ab2', NULL, '1080p Full HD', NULL, 'https://t.me/PixelPopLk_bot?start=690e9734-9a4a-41cb-9810-756ad318327c', 'Telegram Bot', 6, '2026-07-23 19:35:18.298072+00', '2026-07-23 19:35:18.298072+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('6caa9739-47b8-4b92-a7dc-40e97707cab7', '4b94c16b-3dfb-40d2-a0a3-587c25306447', NULL, '1080p Full HD', NULL, 'https://t.me/PixelPopLk_bot?start=4b58a7e9-b428-4b24-99f7-739cda38f7e2', 'Telegram Bot', 4, '2026-07-24 12:04:54.624116+00', '2026-07-24 12:04:54.624116+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('ff8ecb1a-37b8-43f4-afe8-3675874415da', NULL, 'a282c926-810d-4deb-a0e5-966d01049ea3', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=NlMvTfV_O1o', 'Telegram Bot', 10, '2026-07-25 11:21:03.246098+00', '2026-07-25 11:21:03.246098+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('c96876e8-aa22-417a-a206-93321c43c1d1', NULL, '4ebb547e-53ad-4d57-a144-4d675d22a6a6', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=PR_aBdl0xgo', 'Telegram Bot', 8, '2026-07-25 11:21:03.246098+00', '2026-07-25 11:21:03.246098+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('c74e839c-3cb1-487d-a1f0-1c23a377cd8d', NULL, '58ec2e1a-2d6a-4a3e-a0dc-68bb6db32cde', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=m-2l0ZSeECA', 'Telegram Bot', 8, '2026-07-25 11:21:03.246098+00', '2026-07-25 11:21:03.246098+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('c505906e-1e9b-4737-a4c0-3946ae4ee79c', NULL, '78a5ef5c-d105-4c5d-a2da-650571142053', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=k-ac9Q2-TpU', 'Telegram Bot', 8, '2026-07-25 11:21:03.246098+00', '2026-07-25 11:21:03.246098+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('5be19b33-d556-49b3-ab07-bda2ec16cf90', NULL, '05f355ee-ec0b-43ac-aa33-0100facea393', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=L7_onccmLN0', 'Telegram Bot', 8, '2026-07-25 11:21:03.246098+00', '2026-07-25 11:21:03.246098+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('0feda6b8-e620-4c33-abde-06c3fb187dfe', NULL, '917763f5-b2e9-4ffd-aa72-e0f0d0f15044', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=V46RzWEr9M4', 'Telegram Bot', 8, '2026-07-25 11:21:03.246098+00', '2026-07-25 11:21:03.246098+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('d3f37050-4fd7-428a-ad42-1758f24a881e', '97dc5ae0-49c8-4620-aa67-4b78022b9e44', NULL, '1080p Full HD', NULL, 'https://t.me/PixelPopLk_bot?start=289976c7-6918-40dd-a0e4-7e21e8b43121', 'Telegram Bot', 10, '2026-07-26 08:15:56.089476+00', '2026-07-26 08:15:56.089476+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('9d97ee07-093a-476e-acec-a27c9d38a92c', NULL, '1aaebabc-8c9d-442a-af05-8378c46ac108', '1080p / 720p', NULL, 'https://t.me/PixelPopLk_bot?start=d1cf3b6c-6aba-4005-9300-7343433859b1', 'Telegram Bot', 2, '2026-07-26 09:14:46.57961+00', '2026-07-26 09:14:46.57961+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('1f0c0c63-0f2d-4a1b-a1c0-a7d030963653', NULL, '6ac90a7e-a532-41ef-a8d2-904c6919461d', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=WijpIA9Rh3Q', 'Telegram Bot', 8, '2026-07-26 15:57:14.899352+00', '2026-07-26 15:57:14.899352+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('5a5b0984-1eca-4ade-affc-8552bbc1aa2a', NULL, '0f5f4ada-fd4d-43a9-a3e3-3073a506c2c9', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=lKFthgH2gWw', 'Telegram Bot', 8, '2026-07-26 15:57:14.899352+00', '2026-07-26 15:57:14.899352+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('11e482d5-c55d-441b-aeb1-2543e4c5b351', NULL, '33429f0e-4254-46c7-a0a8-51beb0ce4203', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=RYl95u2P_SE', 'Telegram Bot', 8, '2026-07-26 15:57:14.899352+00', '2026-07-26 15:57:14.899352+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('66d304c4-1a31-4b76-a356-c3a17c5ac628', NULL, '521ed8de-1fb7-45e4-a56e-f4a92cf90982', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=3Whk7g9Sjcg', 'Telegram Bot', 8, '2026-07-26 15:57:14.899352+00', '2026-07-26 15:57:14.899352+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('06ff3dcb-c844-4d8d-ac92-b970cf6fd42c', NULL, 'acf32d87-d3ce-46ba-a80a-337540ee3473', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=HeGe8BRK9Xs', 'Telegram Bot', 8, '2026-07-26 15:57:14.899352+00', '2026-07-26 15:57:14.899352+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('1c8ad58d-7165-4b27-a20c-f4c3b4d9cfc2', NULL, '77f4da9c-a2cc-48ef-a2fa-cf5f32292ca3', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=cKSQhKO8W2Y', 'Telegram Bot', 8, '2026-07-26 15:57:14.899352+00', '2026-07-26 15:57:14.899352+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('06cfd861-039c-432f-a9c3-6348dc0ff9e1', NULL, 'b5ab48e7-40fe-4633-a06d-8414f9699a65', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=IvhGcKuOeNU', 'Telegram Bot', 8, '2026-07-26 15:57:14.899352+00', '2026-07-26 15:57:14.899352+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('5eaa2a21-6376-40b7-a2de-9b557d0d8448', NULL, '65b19554-c989-4991-abea-9231e8c70423', '1080p / 720p', NULL, 'https://t.me/PixelPopLk_bot?start=55bfb940-f864-48aa-a391-69a7036b2ea0', 'Telegram Bot', 142, '2026-07-26 19:36:34.146575+00', '2026-07-26 19:36:34.146575+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('7ae440ae-0566-4b4f-ae40-1957c14bcec5', '1dfeef95-9101-40ab-ace3-f15fe887772a', NULL, '1080p Full HD', NULL, 'https://t.me/PixelPopLk_bot?start=e6ee1d93-ba80-41e2-a10d-cf82a81d433b', 'Telegram Bot', 2, '2026-07-27 06:46:17.212937+00', '2026-07-27 06:46:17.212937+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('dad8a1e0-4f79-432c-ab1f-45ef3f7d1c5c', NULL, '35f6fe55-6311-49b9-ab9b-0114ce81eb1a', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=sKu_8Y7f48E', 'Telegram Bot', 228, '2026-07-28 16:58:59.501453+00', '2026-07-28 16:58:59.501453+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('681533b9-db12-4f93-aae6-22b565bc65cc', NULL, '036066a4-ce3f-4abd-a925-7cf80865a47e', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=VPP38LjCqT8', 'Telegram Bot', 6, '2026-07-28 17:47:57.477299+00', '2026-07-28 17:47:57.477299+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('12a73dc0-bed7-4c2e-a876-b36c32ade765', NULL, 'e251ab8b-a146-49fb-ace4-8ac6999f9c52', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=yPknsp-C0O4', 'Telegram Bot', 6, '2026-07-28 17:47:57.477299+00', '2026-07-28 17:47:57.477299+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('1df12af9-00f4-4eb9-a7f1-1e653393b72e', NULL, 'a9d7d420-367a-41ac-a08f-cfb2c57c7c01', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=0o9LdxEFyP4', 'Telegram Bot', 6, '2026-07-28 17:47:57.477299+00', '2026-07-28 17:47:57.477299+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('45ec9471-482a-4a0e-a040-0dfacdc1cea5', '60c54a53-ba5f-4932-ae6a-e0f88f89b0d8', NULL, '1080p Full HD', NULL, 'https://t.me/Pixelpopnew_bot?start=8MejAK2soLo', 'Telegram Bot', 0, '2026-07-28 20:01:07.145515+00', '2026-07-28 20:01:07.145515+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('f6fed381-82a6-4912-a667-708e72887a40', NULL, '08978a86-7c5d-40a9-ab7d-c7a9bfaf51e9', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=pPW4NKswXEo', 'Telegram Bot', 6, '2026-07-29 15:47:39.376403+00', '2026-07-29 15:47:39.376403+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('e3b32360-e740-489b-a6f5-9749f8a8c691', NULL, 'ecbaec1b-caa1-4d69-a91a-78c4f4697795', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=o_kYmabVLvk', 'Telegram Bot', 6, '2026-07-29 15:47:39.376403+00', '2026-07-29 15:47:39.376403+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('7eafc9c7-e72b-4513-a81b-fbfc1a02d4fb', NULL, '41046440-3189-46b3-a8fa-740fa6db1693', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=U2Uuw9kQCZs', 'Telegram Bot', 6, '2026-07-29 15:47:39.376403+00', '2026-07-29 15:47:39.376403+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('0f4a37ca-0d37-4935-ab54-337f2cfac8ec', NULL, '9fb72ef2-edfc-4785-ac04-12c1aca3e338', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=Nk02jll07P0', 'Telegram Bot', 6, '2026-07-29 15:47:39.376403+00', '2026-07-29 15:47:39.376403+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('5edf8537-a666-4c06-a262-c95756c409ce', NULL, 'e8c4c40c-76e2-4e5e-ae88-8f0b32a3b979', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=pfHsCOk5IrU', 'Telegram Bot', 142, '2026-07-29 16:57:22.390038+00', '2026-07-29 16:57:22.390038+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('0b2006e7-65a8-4bc3-aa41-8a3291cdca4e', NULL, '53a8a58d-9d48-42e3-ac68-e01620c6baf7', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=KufqRVs38r4', 'Telegram Bot', 6, '2026-07-30 09:44:00.617394+00', '2026-07-30 09:44:00.617394+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('67065abd-84c7-4c78-ab59-87e19ddec340', NULL, 'f63e74e5-57f1-4b88-a874-98af749ad9ba', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=8exANhaRh9A', 'Telegram Bot', 6, '2026-07-30 09:44:00.617394+00', '2026-07-30 09:44:00.617394+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('a71e8c02-65ed-4329-af2c-5561fa2b2d7c', NULL, '65144140-f36e-46ce-a66b-3f62e6cd8a54', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=fnVLH336XKI', 'Telegram Bot', 6, '2026-07-30 09:44:00.617394+00', '2026-07-30 09:44:00.617394+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('dd3b22cd-6067-4c4d-add2-2b315e3267e9', NULL, 'ba267558-45f5-4e0f-aa45-e12fdbf2e3cd', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=MXMlD5vhRrE', 'Telegram Bot', 6, '2026-07-30 09:44:00.617394+00', '2026-07-30 09:44:00.617394+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('0a205b2c-3f5a-4175-abec-507c9514507d', NULL, '8e18b46e-16da-49d6-aa93-e1a334593e1d', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=xSIqbLgHhOY', 'Telegram Bot', 10, '2026-07-30 09:44:00.617394+00', '2026-07-30 09:44:00.617394+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('5dd2cd8f-d137-4a9c-a53a-3d69d6348e1d', NULL, '2417b2ef-dd12-414e-a010-9b14a0948b47', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=DE7Gjhbj6g4', 'Telegram Bot', 8, '2026-07-30 09:44:00.617394+00', '2026-07-30 09:44:00.617394+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('7a198f80-1a57-4556-a90d-1ada7e922dcc', 'a0fe85f4-925d-4476-adb9-a37da947b1c4', NULL, '1080p Full HD', NULL, 'https://vegamoviess.cc/56319-spiderman-brand-new-day-2026-english-audio-hdtc-720p-480p-1080p.html', 'Telegram Bot', 68, '2026-07-30 10:11:12.178415+00', '2026-07-30 10:11:12.178415+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('46c7cb39-1ea2-4fd3-aa89-0c386be0e3e2', NULL, 'a9fab54f-7d32-40a3-a8c7-ea7f2c6ac230', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=ipU2sVOrHe8', 'Telegram Bot', 34, '2026-07-30 17:16:11.526432+00', '2026-07-30 17:16:11.526432+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('1cf90e01-6756-422e-aacf-9bc8f95e8551', NULL, '80444a0d-09f0-4108-ab58-1d91d73f0011', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=arsDrNcCmQE', 'Telegram Bot', 8, '2026-07-31 09:09:26.160221+00', '2026-07-31 09:09:26.160221+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('86ebdc32-48c6-4076-adc9-cab187068263', NULL, 'e6b409ef-70f8-4c35-aefa-89af278eebc2', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=TXkURLcyE_w', 'Telegram Bot', 2, '2026-07-31 09:09:26.160221+00', '2026-07-31 09:09:26.160221+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('f59eee61-ed79-4231-a565-7dae4b9eef01', NULL, '4b5d654a-6290-4155-a9b7-3b97dfe35911', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=H3yIEBKeZLA', 'Telegram Bot', 2, '2026-07-31 09:09:26.160221+00', '2026-07-31 09:09:26.160221+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('56253f46-6951-4a6d-a9f0-852f2fe6168d', NULL, 'fc321ceb-143e-4aa2-a525-9936fceb4ca6', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=YmJCBCRy4TI', 'Telegram Bot', 6, '2026-07-31 09:09:26.160221+00', '2026-07-31 09:09:26.160221+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('343f6059-2c75-46fa-a1ee-7bf9c7c362fc', NULL, 'dc8d1497-fa15-477d-ac20-2adf75dfe81e', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=Sp-sUyy5zc0', 'Telegram Bot', 2, '2026-07-31 09:09:26.160221+00', '2026-07-31 09:09:26.160221+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('296366c0-2ab1-41c3-a7ea-29fa050ca015', NULL, 'a2b2f7e7-78c7-4f3a-abff-a535a82c1a08', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=40gVwZLFfBE', 'Telegram Bot', 28, '2026-07-31 15:59:35.827563+00', '2026-07-31 15:59:35.827563+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('921a6931-eef0-4325-a2b1-eb9044e9bf8c', NULL, '05719008-186f-46bd-ad7a-dfa00f934cb6', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=bbazHfhb2S8', 'Telegram Bot', 18, '2026-07-31 17:35:43.965012+00', '2026-07-31 17:35:43.965012+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('256a743e-b0af-4c32-af00-e50525da0722', NULL, '549b2796-9dd2-468f-ab9c-28c70312dc07', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=zEXFqU9Fu9c', 'Telegram Bot', 20, '2026-08-01 18:42:43.72199+00', '2026-08-01 18:42:43.72199+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('23545855-4861-4fd2-a584-01ad1895bc9e', NULL, '1a753b91-dcf4-47e6-ac93-5415111aeb4f', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=9PpPcRwzxK4', 'Telegram Bot', 20, '2026-08-01 18:42:43.72199+00', '2026-08-01 18:42:43.72199+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('ab5d4d59-c41c-44ef-aeb2-219f5f6de1f0', NULL, '28e5ebf9-a675-4e01-af74-021ee06a6b85', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=ri4xxuzwwIY', 'Telegram Bot', 20, '2026-08-01 18:42:43.72199+00', '2026-08-01 18:42:43.72199+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('ca5a134e-4afb-4684-a6df-86310ee61361', 'e38e1231-d3a8-489f-ac3e-7b7ae6832722', NULL, '1080p Full HD', NULL, 'https://t.me/Pixelpopnew_bot?start=6wemrhldcjs', 'Telegram Bot', 2, '2026-08-02 10:40:16.846602+00', '2026-08-02 10:40:16.846602+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('2bcd0268-606a-4049-a5fb-17b7d6e36a14', NULL, '734420f6-3943-4eee-a22c-cf1cb905a96d', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=bUAvt3hZby8', 'Telegram Bot', 16, '2026-08-02 11:53:59.619015+00', '2026-08-02 11:53:59.619015+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('4931ebee-d4c6-4823-a74f-7d6392c9ed0d', NULL, '78ce7f43-6636-46f0-a55a-193958f3dd9d', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=KwibnYnLOpU', 'Telegram Bot', 20, '2026-08-02 11:53:59.619015+00', '2026-08-02 11:53:59.619015+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('66032fe9-afa0-45b3-a3ac-92d60e891312', NULL, 'ea6dea3d-fe91-401a-a94c-d36f75b13947', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=LrwOtn8SNjw', 'Telegram Bot', 14, '2026-08-02 11:53:59.619015+00', '2026-08-02 11:53:59.619015+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('b5a42814-25fd-4f10-af63-6bc477b4c021', NULL, '08225473-5860-4a5d-ab4d-2d41843fecff', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=wkzJifBN85E', 'Telegram Bot', 16, '2026-08-02 11:53:59.619015+00', '2026-08-02 11:53:59.619015+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('c4a636c7-4f83-4286-a1c8-2d57d38b6e29', NULL, 'bc1005bd-12af-4957-a65f-ee1fbe7554ba', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=nVMnxz2cFpA', 'Telegram Bot', 18, '2026-08-02 11:53:59.619015+00', '2026-08-02 11:53:59.619015+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('387563b4-fdba-4b67-a3d1-4fceafa140a6', NULL, '96d63812-eeae-4131-a276-c3a5edf2efac', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=dACUTV89r3E', 'Telegram Bot', 48, '2026-08-03 02:22:22.473636+00', '2026-08-03 02:22:22.473636+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('54cbc3a0-4a02-474f-af00-964ca91746a8', NULL, '351c770e-05fc-441a-aa76-4a2616b0b506', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=SoEC2DCU-fU', 'Telegram Bot', 0, '2026-08-03 09:03:10.202106+00', '2026-08-03 09:03:10.202106+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('0149c52b-d14a-4c38-aad4-00abb48ea1b4', '5f87f198-cd0f-44e3-a8d0-a5fdf9c552c1', NULL, '1080p Full HD', NULL, 'https://t.me/Pixelpopnew_bot?start=ooDWzHzv0T0', 'Telegram Bot', 18, '2026-08-04 08:00:52.849475+00', '2026-08-04 08:00:52.849475+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('7403e465-3d40-4585-a5d4-a37598032b0b', NULL, '1615a249-5dbb-426e-a17f-ffd3a1d7600a', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=4R92m467whk', 'Telegram Bot', 10, '2026-08-04 13:03:55.568064+00', '2026-08-04 13:03:55.568064+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('3c02be81-38cc-4062-ac1b-eea395f696db', NULL, 'a7b3691d-be6c-4727-acf0-289c5cdcebc0', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=ONCV16Hzu-g', 'Telegram Bot', 8, '2026-08-04 13:03:55.568064+00', '2026-08-04 13:03:55.568064+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('a9aa70f1-7534-42c3-a090-b1ecbe8ad19b', NULL, 'eef9047f-c1c3-4980-a62a-d7cb0510f8fa', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=r6iZ7SZf7lw', 'Telegram Bot', 6, '2026-08-04 13:03:55.568064+00', '2026-08-04 13:03:55.568064+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('93a59fe0-9e64-49cf-ac6a-3f2ff1031109', NULL, '79b18af7-251b-49d7-a5d3-b6f01110179c', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=8EkhwMK4Tws', 'Telegram Bot', 8, '2026-08-04 13:03:55.568064+00', '2026-08-04 13:03:55.568064+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('402b5c57-27e0-42b0-a6e9-96645e62a919', NULL, 'f7aff376-6900-44c6-a6b2-d3bac58ad610', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=3mxhNy2a_sU', 'Telegram Bot', 6, '2026-08-04 13:03:55.568064+00', '2026-08-04 13:03:55.568064+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('8bc9d627-6e35-44c4-a9bf-0cc646385c62', NULL, '5dc47798-fc74-4c44-a337-4fae7c9ef7e2', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=1NZ3QrMdBj8', 'Telegram Bot', 6, '2026-08-04 13:03:55.568064+00', '2026-08-04 13:03:55.568064+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('dca3acd2-9372-47bd-ab45-c1487ed7fe66', NULL, '2a8682e5-292d-47ae-ab77-2de7656b6fcb', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=CG-FHNqKaKY', 'Telegram Bot', 8, '2026-08-04 13:03:55.568064+00', '2026-08-04 13:03:55.568064+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('3ce9c19c-107d-4563-a5da-c13f93b0ebc9', 'de89fa81-9fb4-4728-ae08-770da32cd8ff', NULL, '1080p Full HD', NULL, 'https://t.me/Pixelpopnew_bot?start=IyXLQl8Vog8', 'Telegram Bot', 10, '2026-08-05 06:34:07.587586+00', '2026-08-05 06:34:07.587586+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('8f45e376-d9aa-4d68-a7b5-bd512caffc1d', NULL, '9d64d3f6-bb77-4d39-a811-9c02dc4c973c', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=aP-YdpMmgZw', 'Telegram Bot', 2, '2026-08-05 06:40:15.262255+00', '2026-08-05 06:40:15.262255+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('369ad090-052c-4f45-a13c-2b1988df4ab3', NULL, '5335fd6c-f2d4-4023-ae55-c46ba31bbbce', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=uAWGS7zYrMQ', 'Telegram Bot', 2, '2026-08-05 06:40:15.262255+00', '2026-08-05 06:40:15.262255+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('ef69c921-fdd7-4261-af11-1ca13c748707', NULL, '172164d7-f03e-4dde-a6fc-d745cbf52b0c', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=-OFIIL8N0bk', 'Telegram Bot', 2, '2026-08-05 06:40:15.262255+00', '2026-08-05 06:40:15.262255+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('ce000a73-dfdb-486a-a2b8-d1810a0bd5e5', NULL, '5e18c1a7-9145-46b0-a1b1-6cd8d8ae7c80', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=y2wHtYalp2Y', 'Telegram Bot', 2, '2026-08-05 06:40:15.262255+00', '2026-08-05 06:40:15.262255+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('5adacd0b-0666-43d5-a97e-b0c9f2262f33', NULL, 'ca6224a3-7235-413e-afb1-b993d63010e5', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=873lLDC5gUQ', 'Telegram Bot', 2, '2026-08-05 06:40:15.262255+00', '2026-08-05 06:40:15.262255+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('6cf985b8-4179-4ae3-a983-4483373712b0', NULL, 'c10e6331-100b-45da-a62a-bb4d9c8dfe2e', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=8mDwdOCxUhA', 'Telegram Bot', 6, '2026-08-05 14:04:25.09645+00', '2026-08-05 14:04:25.09645+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('92162495-2f21-4e19-a9b4-35502c50c2f7', NULL, 'e1312426-8a25-4ae5-af0d-1990021252ca', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=XaKaYZ4OYgw', 'Telegram Bot', 2, '2026-08-05 14:04:25.09645+00', '2026-08-05 14:04:25.09645+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('cef51311-df55-482f-a1bb-2b400b42ce9d', NULL, 'cc49279f-7804-4ab9-ad06-b0088a2d6af3', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=oJ3D1pN4eoI', 'Telegram Bot', 2, '2026-08-05 14:04:25.09645+00', '2026-08-05 14:04:25.09645+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('2b181ee2-a101-45bd-ae09-8d71c4e98c73', NULL, '29400325-859d-4550-ab10-9e19342a3559', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=iqbq-BUrEx4', 'Telegram Bot', 2, '2026-08-05 14:04:25.09645+00', '2026-08-05 14:04:25.09645+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('5659aa78-84e1-4584-a406-bf904fc0cd92', NULL, '4d6866db-8002-4ee6-a361-a2ed37c50650', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=pFj7buRsk_g', 'Telegram Bot', 2, '2026-08-05 14:04:25.09645+00', '2026-08-05 14:04:25.09645+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('fc2bdbab-3427-4f46-a121-ae99506c074f', NULL, '9df4b35e-2508-4a00-adc6-d59fc0460a56', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=KmfdPHTMPf0', 'Telegram Bot', 2, '2026-08-05 14:04:25.09645+00', '2026-08-05 14:04:25.09645+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('d12439dc-a083-4fd8-a24a-2dd24a1505ff', NULL, 'c76bb82b-9e39-4060-aa4c-f050b8c6e2e2', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=mHjCjLg9mMc', 'Telegram Bot', 24, '2026-08-06 10:35:58.56554+00', '2026-08-06 10:35:58.56554+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('42a06868-b5f5-417f-ac0b-287b8c55caba', NULL, 'f6476299-fb90-441d-a3d1-c530d7acc08d', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=zFRARMXn88g', 'Telegram Bot', 24, '2026-08-06 10:35:58.56554+00', '2026-08-06 10:35:58.56554+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('8fda713d-0aca-43cc-a409-d5ccd9f0fd10', NULL, '29697cb3-9f83-45c5-acde-b6bb98d04f18', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=Ig7BUCTE7es', 'Telegram Bot', 18, '2026-08-06 10:35:58.56554+00', '2026-08-06 10:35:58.56554+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('99a2dd8a-0914-414a-a9e4-634473e1b1fc', NULL, '404f1629-37fd-4d77-ad55-8a148be43f8b', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=neY3EQ_L3zw', 'Telegram Bot', 12, '2026-08-06 10:35:58.56554+00', '2026-08-06 10:35:58.56554+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('e25c49d8-64cf-4753-afdc-d21d9cebc57c', NULL, '7ca0d09a-8ef1-475a-ac9f-47662ef8fe1d', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=lVBTeEmTcgU', 'Telegram Bot', 6, '2026-08-06 10:35:58.56554+00', '2026-08-06 10:35:58.56554+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('19d88c8c-cb07-4cac-aa6d-67c8fdf4b31e', NULL, '277b2b37-35f3-4a97-a0d9-4da2f5c78e59', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=IaJFkFVNlW8', 'Telegram Bot', 6, '2026-08-06 10:35:58.56554+00', '2026-08-06 10:35:58.56554+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('6374813a-e55f-4651-af06-6f3c6e828a87', 'd8624299-504e-4135-a8b6-bb91d0217b72', NULL, '1080p Full HD', NULL, 'https://t.me/Pixelpopnew_bot?start=lnHDjEpwOhg', 'Telegram Bot', 6, '2026-08-07 07:34:34.672569+00', '2026-08-07 07:34:34.672569+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('9d6ef2af-4fe4-459a-a8dd-889331454940', '046422c0-37bd-4d89-ab53-fb06e6e5da6d', NULL, '1080p Full HD', NULL, 'https://t.me/Pixelpopnew_bot?start=PJLeftrWSoM', 'Telegram Bot', 38, '2026-08-07 09:54:02.964215+00', '2026-08-07 09:54:02.964215+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('6638c5d8-2ba9-4f21-a5a5-db01e2215e1d', NULL, '4362e2ea-881e-443e-afac-e31cff51c169', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=etyNwuHeSCw', 'Telegram Bot', 4, '2026-08-08 08:30:23.609856+00', '2026-08-08 08:30:23.609856+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('f9b26c01-112f-4469-a8bb-2c573ba0d67e', NULL, 'c077b68a-7209-46bb-a2a5-0c6f34d726c0', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=b5-7tmWYRYs', 'Telegram Bot', 24, '2026-08-08 11:01:21.636301+00', '2026-08-08 11:01:21.636301+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('5b832210-a268-47be-adff-4482137002d8', NULL, '5d70828e-c365-4aed-a64f-2f6582f9cd0b', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=x7Ayw2zp5Sw', 'Telegram Bot', 704, '2026-08-09 18:17:04.550544+00', '2026-08-09 18:17:04.550544+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('c8b40cf6-7cc4-4101-a062-0d5fc5395fc2', '8fd23983-4862-4cc1-a7f5-77a8409fe8b4', NULL, '1080p Full HD', NULL, 'https://t.me/Pixelpopnew_bot?start=bh0r5hKGUQo', 'Telegram Bot', 24, '2026-08-10 12:27:21.523628+00', '2026-08-10 12:27:21.523628+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('b21f2f38-e990-4818-acd9-3b68a7fa77c5', NULL, 'f89bcda6-40d8-412f-a0b3-09a8f1a0f9cb', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=UkpEV1gX-9M', 'Telegram Bot', 6, '2026-08-10 13:02:14.876293+00', '2026-08-10 13:02:14.876293+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('7362da23-d84c-43e1-a05e-7234fcf1b528', NULL, '6500a301-1ada-468c-ad26-7c954834a971', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=8x-ba73m7zg', 'Telegram Bot', 14, '2026-08-11 13:42:49.900781+00', '2026-08-11 13:42:49.900781+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('bc43751a-38c6-4a92-a715-364446269dd0', NULL, '79a6a3d1-abe2-48c2-a772-614c0993c91e', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=vO7vfxcCB9I', 'Telegram Bot', 6, '2026-08-11 13:42:49.900781+00', '2026-08-11 13:42:49.900781+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('4223c3b2-bb66-431f-aebb-061abb03fe46', NULL, '2a6b5e0f-9f75-4c5e-a309-4f6c7796893a', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=3Q7coxFLTSg', 'Telegram Bot', 6, '2026-08-11 13:42:49.900781+00', '2026-08-11 13:42:49.900781+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('cab4745b-c844-422b-a5d4-e7271bc33f76', NULL, '84df7b6b-7c82-4c60-a33e-36f05ae56adb', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=ZwTmXT71QIo', 'Telegram Bot', 8, '2026-08-11 13:42:49.900781+00', '2026-08-11 13:42:49.900781+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('4c38d46a-b112-404d-acc4-44971dff2bf8', NULL, '3690aa9b-b712-4704-a57b-3c692eb0e81f', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=l2YpKZwz1VQ', 'Telegram Bot', 6, '2026-08-11 13:42:49.900781+00', '2026-08-11 13:42:49.900781+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('d182dd45-fa75-4d12-a7d4-77ad6ea86cae', NULL, '94d992a4-af51-4c35-a399-a9d6fb095f2c', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=eN1vvAiL1OE', 'Telegram Bot', 100, '2026-08-12 08:51:51.598699+00', '2026-08-12 08:51:51.598699+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('a72a1374-28f3-4f05-ae0c-e2af31d52071', NULL, '81d0c1d0-e77e-40a9-af58-d1897beeb4b2', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=mxXHA8lgziE', 'Telegram Bot', 66, '2026-08-12 11:07:22.290595+00', '2026-08-12 11:07:22.290595+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('2e5c09e1-ef46-4588-a5b2-ffb3c91de888', NULL, 'e45f5826-f0c8-4c03-a1b7-965bc93c55c3', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=hBiqSXseDeI', 'Telegram Bot', 58, '2026-08-12 11:07:22.290595+00', '2026-08-12 11:07:22.290595+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('bbb1abd4-d39e-492b-aa10-2bccc7ffab94', NULL, 'bb9f99cd-84be-4c37-a09c-43beb05b4723', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=yX1gqQgPwxc', 'Telegram Bot', 8, '2026-08-12 17:01:42.133751+00', '2026-08-12 17:01:42.133751+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('7d267347-e466-42db-a3f1-46a90c19ab16', NULL, '9ddbbbbf-0b44-43fb-a1cd-ea6fc3734bbc', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=xA9IoawyTSM', 'Telegram Bot', 6, '2026-08-12 17:01:42.133751+00', '2026-08-12 17:01:42.133751+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('548dab5f-1ac1-4cde-a659-4eb159378f7d', NULL, 'df2f8ff2-24eb-4eb6-a50c-c12e5809856e', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=PmpxEwt-T4A', 'Telegram Bot', 6, '2026-08-12 17:01:42.133751+00', '2026-08-12 17:01:42.133751+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('76ee71c6-9c08-4867-ad33-b59bac0ced3f', NULL, '165260e9-751f-4b6d-a88c-c40ca426993d', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=ozqvpM7jbq0', 'Telegram Bot', 6, '2026-08-12 17:01:42.133751+00', '2026-08-12 17:01:42.133751+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('70821dc2-4dfb-4440-a556-d34c72f12a0a', NULL, '77306a79-aa9d-4c6c-a2c4-18ded6a8a449', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=arrAWfDY8Ek', 'Telegram Bot', 6, '2026-08-12 17:01:42.133751+00', '2026-08-12 17:01:42.133751+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('da8b5134-f16b-4a65-af72-f6ac5bbb76c4', NULL, 'fdc7af4b-e7bb-48ea-af1e-f0e8ea3558e9', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=u2MjDEWbTjc', 'Telegram Bot', 6, '2026-08-12 17:01:42.133751+00', '2026-08-12 17:01:42.133751+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('523795d2-8ba0-497d-a0b6-44d1d863bddc', NULL, 'f0e86235-31eb-4885-acfa-a4d6efd59db4', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=BW93kHZMsG0', 'Telegram Bot', 8, '2026-08-12 17:01:42.133751+00', '2026-08-12 17:01:42.133751+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('173fe71a-f594-4fa5-aae0-f4ea65c2e62d', NULL, '6eeca922-3fd7-4d28-ae70-1f429bfacaf0', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=PR0ILpvzUhU', 'Telegram Bot', 6, '2026-08-13 13:52:53.403139+00', '2026-08-13 13:52:53.403139+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('0352f517-4168-41cf-a755-2b0e6cdd5b73', NULL, 'c67c45ba-2ea7-4ba8-aff5-107a9ba10726', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=wjhGPS57sYg', 'Telegram Bot', 8, '2026-08-13 13:52:53.403139+00', '2026-08-13 13:52:53.403139+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('4c57d224-cf91-467d-ae47-30150b25aade', NULL, '5989881b-eda7-446e-a368-1257ad207e89', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=NSk95fywFr8', 'Telegram Bot', 6, '2026-08-13 13:52:53.403139+00', '2026-08-13 13:52:53.403139+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('cc7e3d81-ca75-4286-aff5-8a00154a61e8', NULL, '00de4c80-2277-49b6-a5b5-1441e7bb5659', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=MbYsm7SqWAM', 'Telegram Bot', 6, '2026-08-13 13:52:53.403139+00', '2026-08-13 13:52:53.403139+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('f3c3925d-020a-47fb-a51e-74b01e48237a', NULL, 'ebd0346d-7959-4331-a968-b1261dc03288', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=keMEOhtNOkU', 'Telegram Bot', 6, '2026-08-13 13:52:53.403139+00', '2026-08-13 13:52:53.403139+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('7bdba445-3867-4767-a808-2e9ce1b3bac3', NULL, '61068b2c-cf11-4257-aba6-6262003d0d66', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=2t8VDUP2AU8', 'Telegram Bot', 6, '2026-08-13 13:52:53.403139+00', '2026-08-13 13:52:53.403139+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('81345552-1e99-4a79-aa74-5b0852f6ba09', NULL, '101f0c6c-9b1f-4675-aa3f-dc1ad435d2d9', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=6M3XHam7K4s', 'Telegram Bot', 6, '2026-08-13 13:52:53.403139+00', '2026-08-13 13:52:53.403139+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('bb2f815f-f70f-40e5-aeac-3289647a6774', NULL, 'c43533be-e96f-4176-a484-3cc4e71efb0f', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=XSCXhla3zSQ', 'Telegram Bot', 6, '2026-08-13 13:52:53.403139+00', '2026-08-13 13:52:53.403139+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('7421ce44-0bfa-497e-a761-cc4b650d5912', '1de2af9b-9c53-4c39-a3b6-07c77210bbb0', NULL, '1080p Full HD', NULL, 'https://t.me/Pixelpopnew_bot?start=mc0WXoWDnNw', 'Telegram Bot', 130, '2026-08-14 18:39:26.460286+00', '2026-08-14 18:39:26.460286+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('0c596a90-fcb3-4048-a558-e4c225fb1621', NULL, 'ae13a875-cf00-446d-a7bf-00a30ac3cbce', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=5MbFW3jFxLE', 'Telegram Bot', 4, '2026-08-15 23:36:34.227099+00', '2026-08-15 23:36:34.227099+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('49ca8e54-d211-4be0-add5-68b4657a2e07', NULL, '6cb38ff8-f904-4798-a8de-c16ddae10c01', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=FzQGM-H6H30', 'Telegram Bot', 4, '2026-08-15 23:36:34.227099+00', '2026-08-15 23:36:34.227099+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('457b9620-6a0e-4d3c-aca9-d961d97fe659', NULL, 'f62ec38b-d850-4c1f-af4b-3dc935480af1', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=Nky0jSKePLY', 'Telegram Bot', 4, '2026-08-15 23:36:34.227099+00', '2026-08-15 23:36:34.227099+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('c5ca631d-9e3e-418b-a0ea-8a75b25a5d6d', NULL, '8d5421c6-211a-4005-a822-51c7d0bdb4b3', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=5OjMLx9hhl8', 'Telegram Bot', 4, '2026-08-15 23:36:34.227099+00', '2026-08-15 23:36:34.227099+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('ba6af7fb-1fea-4f18-a6e6-aef783cf03e4', NULL, '6873c06e-a235-4cca-a6f3-5155f1904aaf', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=WZlFzPiqAN8', 'Telegram Bot', 4, '2026-08-15 23:36:34.227099+00', '2026-08-15 23:36:34.227099+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('53d2f43a-3eb6-430a-ac48-51f7a93d1b4f', NULL, 'db924be3-1faf-4e5d-a55e-970208ec6509', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=pRLneRPKw2Y', 'Telegram Bot', 4, '2026-08-15 23:36:34.227099+00', '2026-08-15 23:36:34.227099+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('6110d621-63a3-406c-a6ae-3a2b21705d75', NULL, '5c527043-9a69-437e-a169-4f41dba9a82c', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=K3l8RNuemcc', 'Telegram Bot', 4, '2026-08-15 23:36:34.227099+00', '2026-08-15 23:36:34.227099+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('69892a6e-a239-4a94-a98d-919343c95485', NULL, '8c9f91c8-3bf7-4dfa-a3fb-50c6c13f5326', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=FcgDaSUoWec', 'Telegram Bot', 4, '2026-08-15 23:36:34.227099+00', '2026-08-15 23:36:34.227099+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('db45ca32-4ff8-48f9-aa89-4c3ea9b7b40d', NULL, '250c590e-8d7a-437f-a298-9c02376ce6bf', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=y7OkO5qBmds', 'Telegram Bot', 4, '2026-08-15 23:36:34.227099+00', '2026-08-15 23:36:34.227099+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('d8cec75a-2104-4aab-aed2-f0ba77f856be', NULL, '238f4b1b-2207-46f4-a556-3068b3631ded', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=p_gNFWtEl8g', 'Telegram Bot', 4, '2026-08-15 23:36:34.227099+00', '2026-08-15 23:36:34.227099+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('abaf320d-77da-4a1d-a74d-1447492788de', NULL, 'ecdc33de-770b-44fb-aa6f-30fe78f7babc', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=SKjmDw16w4I', 'Telegram Bot', 4, '2026-08-15 23:36:34.227099+00', '2026-08-15 23:36:34.227099+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('85ef92eb-b494-42f5-a2fd-eefd590714bb', NULL, '760404ec-0186-4835-af09-bc889348e456', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=3gkE0r63pZU', 'Telegram Bot', 4, '2026-08-15 23:36:34.227099+00', '2026-08-15 23:36:34.227099+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('21a284f9-6e62-4499-a25a-402ab898b221', NULL, '4adbc120-bd9a-4659-abaa-dfe6758d73fd', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=U13cP5IEmM8', 'Telegram Bot', 4, '2026-08-15 23:36:34.227099+00', '2026-08-15 23:36:34.227099+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('6945d6bc-f90e-4701-a90f-7b2fc1747db3', NULL, '13146e83-5b56-4172-ad65-da96fff927aa', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=LK0J9Gj1yeg', 'Telegram Bot', 36, '2026-08-17 00:43:29.237961+00', '2026-08-17 00:43:29.237961+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('6651c3ba-31dd-4cad-a373-a0ae5555a354', NULL, 'bcf388b1-7318-4d56-a3ec-a28e8f1b81bc', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=5MXH7Xxv9sU', 'Telegram Bot', 4, '2026-08-22 06:41:53.87792+00', '2026-08-22 06:41:53.87792+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('33f3d06f-d07f-43d5-aa45-171616306336', NULL, '095f8705-8c1d-49cc-a4ba-e948a1ba34f3', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=0yTLxwaCxpU', 'Telegram Bot', 0, '2026-08-22 06:41:53.87792+00', '2026-08-22 06:41:53.87792+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('5a133bac-e3d1-43d4-a015-88f5615cbe44', NULL, '57ac433d-5b5c-45e5-a691-c3417ae68162', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=8JDNzCG9IA4', 'Telegram Bot', 0, '2026-08-22 06:41:53.87792+00', '2026-08-22 06:41:53.87792+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('c764ad3f-141f-4536-aa67-71c10968a189', NULL, 'b22aa0de-467b-4425-a56c-590afa035476', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=QkQpBn7JLn8', 'Telegram Bot', 0, '2026-08-22 06:41:53.87792+00', '2026-08-22 06:41:53.87792+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('cb3d9c58-fc4b-4dfb-a197-ada19161e298', NULL, 'd5678a26-1b9e-4296-a8a9-0f8d09d19e6d', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=DN-TEtg0LSA', 'Telegram Bot', 0, '2026-08-22 06:41:53.87792+00', '2026-08-22 06:41:53.87792+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('0e0690f3-6f50-416d-ab35-3d7f91c4ec78', NULL, '89c562af-0cc8-4ce5-a6a6-93770d8b3b47', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=bx_1yKlYYGA', 'Telegram Bot', 0, '2026-08-22 06:41:53.87792+00', '2026-08-22 06:41:53.87792+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('3099b545-27d1-4aa8-add2-e64c29eb4194', NULL, '4ec1c75a-4cf9-46fd-a477-7c7683148c58', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=CBTkwMkiF2I', 'Telegram Bot', 0, '2026-08-22 06:41:53.87792+00', '2026-08-22 06:41:53.87792+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('b5f306c5-fcb4-4f14-a00e-f98f325d8a6e', NULL, 'c85df387-a5c7-4fcc-ac58-0dac48370ba7', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=FwcnL49qN5I', 'Telegram Bot', 0, '2026-08-22 06:41:53.87792+00', '2026-08-22 06:41:53.87792+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('25626ef0-406d-49d8-ad53-bc3faf713b89', NULL, '62a065a7-aa16-4c78-a9d2-fa369d94442f', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=GPOyq0NYqOM', 'Telegram Bot', 0, '2026-08-22 06:41:53.87792+00', '2026-08-22 06:41:53.87792+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('9174ea4d-006b-4493-a60b-5a5ef2e2d3d8', NULL, 'c76266a7-b1af-495b-a285-639c3c6c757a', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=eNXhaCvghW8', 'Telegram Bot', 0, '2026-08-22 06:41:53.87792+00', '2026-08-22 06:41:53.87792+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('842b87a7-b8ed-45a4-ade8-a1b3736d62e5', NULL, '26d98b77-da16-4f1c-a97b-7c006c9c9961', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=RXXfERm1HBM', 'Telegram Bot', 0, '2026-08-22 06:41:53.87792+00', '2026-08-22 06:41:53.87792+00') ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at, updated_at) VALUES ('08804bd8-ee3c-4219-a83f-2b6ceaad4ec1', NULL, '68dc79b9-258e-4dde-aee1-9f97be5e997e', '1080p / 720p', NULL, 'https://t.me/Pixelpopnew_bot?start=a425QnzqPGY', 'Telegram Bot', 0, '2026-08-22 06:41:53.87792+00', '2026-08-22 06:41:53.87792+00') ON CONFLICT (id) DO NOTHING;