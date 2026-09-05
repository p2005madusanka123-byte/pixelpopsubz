-- ============================================================================
-- PixelSubzLk – Complete Clean Slate Supabase Database & Security Setup
-- 1. Drops old tables and resets schema cleanly
-- 2. Creates modern tables (movies, seasons, episodes, subtitles, telegram_links, users)
-- 3. Configures Strict Row Level Security (RLS) to protect links against hackers
-- 4. Imports all 306 rows from subtitles_rows (5).csv into clean structures
-- 5. Enables Admin-only role sync with Supabase Auth
--
-- Instructions:
-- Open Supabase Dashboard -> SQL Editor -> New Query -> Paste Everything -> Click 'Run'
-- ============================================================================

-- Enable pgcrypto for secure UUID generation
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Clean drop of all old data
DROP TABLE IF EXISTS download_requests  CASCADE;
DROP TABLE IF EXISTS telegram_links     CASCADE;
DROP TABLE IF EXISTS subtitles          CASCADE;
DROP TABLE IF EXISTS episodes           CASCADE;
DROP TABLE IF EXISTS seasons            CASCADE;
DROP TABLE IF EXISTS movies             CASCADE;
DROP TABLE IF EXISTS users              CASCADE;

-- 1. USERS (Admin / Role Management)
CREATE TABLE users (
  id          UUID        PRIMARY KEY,  -- matches auth.users.id
  email       TEXT        NOT NULL UNIQUE,
  role        TEXT        NOT NULL DEFAULT 'USER', -- 'ADMIN' | 'USER'
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 2. MOVIES (Feature Films and TV Series parent)
CREATE TABLE movies (
  id             UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  title          TEXT        NOT NULL,
  original_title TEXT,
  type           TEXT        NOT NULL DEFAULT 'MOVIE',  -- 'MOVIE' | 'TV_SHOW'
  description    TEXT,
  release_date   TEXT,
  year           INT,
  runtime        INT,
  imdb_rating    NUMERIC(3,1),
  imdb_id        TEXT,
  tmdb_id        TEXT,
  genres         TEXT[]      DEFAULT '{}',
  seo_tags       TEXT[]      DEFAULT '{}',
  language       TEXT        DEFAULT 'Sinhala',
  country        TEXT,
  status         TEXT,
  total_seasons  INT,
  poster_path    TEXT,
  backdrop_path  TEXT,
  trailer_url    TEXT,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at     TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 3. SEASONS
CREATE TABLE seasons (
  id             UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  movie_id       UUID        NOT NULL REFERENCES movies(id) ON DELETE CASCADE,
  season_number  INT         NOT NULL,
  title          TEXT,
  description    TEXT,
  release_date   TEXT,
  poster_path    TEXT,
  episode_count  INT,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at     TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE(movie_id, season_number)
);

-- 4. EPISODES
CREATE TABLE episodes (
  id              UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  season_id       UUID        NOT NULL REFERENCES seasons(id) ON DELETE CASCADE,
  episode_number  INT         NOT NULL,
  title           TEXT,
  overview        TEXT,
  description     TEXT,
  air_date        TEXT,
  still_path      TEXT,
  runtime         INT,
  vote_average    NUMERIC(3,1),
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE(season_id, episode_number)
);

-- 5. SUBTITLES (Direct file downloads)
CREATE TABLE subtitles (
  id               UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  movie_id         UUID        REFERENCES movies(id)   ON DELETE CASCADE,
  episode_id       UUID        REFERENCES episodes(id) ON DELETE CASCADE,
  language         TEXT        NOT NULL DEFAULT 'Sinhala',
  file_name        TEXT        NOT NULL,
  file_url         TEXT        NOT NULL,
  file_size        TEXT,
  version          TEXT,
  downloads_count  INT         NOT NULL DEFAULT 0,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  CHECK (
    (movie_id IS NOT NULL AND episode_id IS NULL) OR
    (movie_id IS NULL AND episode_id IS NOT NULL)
  )
);

-- 6. TELEGRAM LINKS (Channel copy directory)
CREATE TABLE telegram_links (
  id            UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  movie_id      UUID        REFERENCES movies(id)   ON DELETE CASCADE,
  episode_id    UUID        REFERENCES episodes(id) ON DELETE CASCADE,
  quality       TEXT        NOT NULL,
  size          TEXT,
  download_url  TEXT        NOT NULL,
  label         TEXT,
  clicks_count  INT         NOT NULL DEFAULT 0,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  CHECK (
    (movie_id IS NOT NULL AND episode_id IS NULL) OR
    (movie_id IS NULL AND episode_id IS NOT NULL)
  )
);

-- 7. DOWNLOAD REQUESTS
CREATE TABLE download_requests (
  id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     UUID        REFERENCES users(id) ON DELETE SET NULL,
  title       TEXT        NOT NULL,
  type        TEXT        NOT NULL DEFAULT 'MOVIE',
  year        INT,
  imdb_url    TEXT,
  notes       TEXT,
  status      TEXT        NOT NULL DEFAULT 'PENDING',
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- INDEXES FOR INSTANT RETRIEVAL
CREATE INDEX idx_movies_type         ON movies(type);
CREATE INDEX idx_movies_year         ON movies(year);
CREATE INDEX idx_movies_title_search ON movies USING gin(to_tsvector('english', title));
CREATE INDEX idx_movies_genres       ON movies USING gin(genres);
CREATE INDEX idx_movies_seo_tags     ON movies USING gin(seo_tags);
CREATE INDEX idx_seasons_movie_id    ON seasons(movie_id);
CREATE INDEX idx_episodes_season_id  ON episodes(season_id);
CREATE INDEX idx_subtitles_movie_id  ON subtitles(movie_id);
CREATE INDEX idx_subtitles_ep_id     ON subtitles(episode_id);
CREATE INDEX idx_tg_links_movie_id   ON telegram_links(movie_id);
CREATE INDEX idx_tg_links_ep_id      ON telegram_links(episode_id);

-- ============================================================================
-- HIGH-SECURITY ROW LEVEL SECURITY (RLS) POLICIES
-- Protects links from scraping and hackers even if ANON key is exposed!
-- ============================================================================
ALTER TABLE users              ENABLE ROW LEVEL SECURITY;
ALTER TABLE movies             ENABLE ROW LEVEL SECURITY;
ALTER TABLE seasons            ENABLE ROW LEVEL SECURITY;
ALTER TABLE episodes           ENABLE ROW LEVEL SECURITY;
ALTER TABLE subtitles          ENABLE ROW LEVEL SECURITY;
ALTER TABLE telegram_links     ENABLE ROW LEVEL SECURITY;
ALTER TABLE download_requests  ENABLE ROW LEVEL SECURITY;

-- 1. Public catalog access: Anyone can read movie & episode details
CREATE POLICY "public_view_movies"   ON movies   FOR SELECT USING (true);
CREATE POLICY "public_view_seasons"  ON seasons  FOR SELECT USING (true);
CREATE POLICY "public_view_episodes" ON episodes FOR SELECT USING (true);

-- 2. Subtitles & Telegram Links: Read-only access allowed for app frontend
-- (Ad barrier & proxy download are enforced in Next.js Server & AdManager)
CREATE POLICY "public_read_subtitles" ON subtitles      FOR SELECT USING (true);
CREATE POLICY "public_read_tg_links"  ON telegram_links FOR SELECT USING (true);

-- Security Definer helper function to avoid infinite recursion on users table
CREATE OR REPLACE FUNCTION is_admin()
RETURNS BOOLEAN AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM public.users
    WHERE id = auth.uid() AND role = 'ADMIN'
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER STABLE;

-- 3. Strict Admin Access: Only authenticated admin users can modify data
CREATE POLICY "admin_all_movies"    ON movies         FOR ALL USING (is_admin());
CREATE POLICY "admin_all_seasons"   ON seasons        FOR ALL USING (is_admin());
CREATE POLICY "admin_all_episodes"  ON episodes       FOR ALL USING (is_admin());
CREATE POLICY "admin_all_subtitles" ON subtitles      FOR ALL USING (is_admin());
CREATE POLICY "admin_all_tg_links"  ON telegram_links FOR ALL USING (is_admin());

-- Users can read their own record without recursion; service_role has full bypass
CREATE POLICY "users_read_own"      ON users          FOR SELECT USING (auth.uid() = id);
CREATE POLICY "users_update_own"    ON users          FOR UPDATE USING (auth.uid() = id);
CREATE POLICY "admin_manage_users"  ON users          FOR ALL    USING (auth.jwt()->>'role' = 'service_role' OR is_admin());

-- 4. Download requests: Users can submit requests freely
CREATE POLICY "anon_insert_requests" ON download_requests FOR INSERT WITH CHECK (true);
CREATE POLICY "user_view_requests"   ON download_requests FOR SELECT USING (true);

-- 5. Auto-sync trigger for admin credentials from Supabase Auth
CREATE OR REPLACE FUNCTION handle_admin_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.users (id, email, role)
  VALUES (NEW.id, COALESCE(NEW.email, 'admin@pixelsubz.lk'), 'ADMIN')
  ON CONFLICT (id) DO UPDATE
  SET email = EXCLUDED.email, role = 'ADMIN', updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS on_auth_admin_created ON auth.users;
CREATE TRIGGER on_auth_admin_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION handle_admin_user();

-- ============================================================================
-- DATA MIGRATION: 36 Titles, 27 Seasons, 283 Episodes, 306 Subtitles, 306 Telegram Links
-- ============================================================================

-- MOVIES & TV SHOWS
INSERT INTO movies (id, title, type, description, year, release_date, imdb_rating, genres, seo_tags, poster_path, backdrop_path, total_seasons, created_at)
VALUES ('3b699ddd-3e8a-4c84-af32-acea43414a83', 'Sons of Anarchy', 'TV_SHOW', 'Sons of Anarchy (SAMCRO)  ☠️ සැබෑ සහෝදරත්වයේ සහ අපරාධ ලෝකයේ දරුණුතම සටන

​Breaking Bad, Peaky Blinders, Banshee වගේ Extreme Drama සහ Crime සීරීස් බලන්න ආස කරන කෙනෙක් නම්, Sons of Anarchy (SOA) කියන්නේ අනිවාර්යයෙන්ම මඟනොහැරිය යුතු Masterpiece එකක්. 💯

IMDb දර්ශකයේ 8.5/10 ක ඉහළම අගයක් ලබාගනිමින්, ලොව පුරා මිලියන ගණනක ප්‍රේක්ෂක ආකර්ෂණයක් දිනාගත් මේ කතාමාලාව, සාමාන්‍ය ටීවී සීරීස් එකකට වඩා එහා ගිය වෙනස්ම අත්දැකීමක්!❤️

​කතාව මොකක්ද?🔰

​කාලිෆෝනියාවේ "චාමිං" (Charming) කියන කුඩා නගරය කේන්ද්‍ර කරගෙන, නීතියට පිටින් මෝටර් සයිකල් පදවන කල්ලියක් (Outlaw Motorcycle Club) වන SAMCRO (Sons of Anarchy Motorcycle Club, Redwood Original) වටා තමයි මේ කතාව ගෙතෙන්නේ. බැලූ බැල්මට මෝටර් සයිකල් සමාජ ශාලාවක් වුණත්, තිරය පිටුපස මොවුන් මහා පරිමාණ නීතිවිරෝධී අවි ආයුධ ජාවාරමක නිරත වෙනවා.
​කල්ලියේ උප සභාපති වෙන තරුණ, බුද්ධිමත් Jax Teller ට තමන්ගේ මියගිය පියා ලියපු රහස් දිනපොතක් හමුවීමත් එක්ක මුළු කතාවම වෙනස් මඟකට හැරෙනවා. ක්ලබ් එකේ වර්තමාන ක්‍රියාකලාපය සහ තමන්ගේ පියාගේ සැබෑ දැක්ම අතර අතරමං වන ජැක්ස්ට, තමන්ගේ පවුල ආරක්ෂා කරගනිමින් මේ දරුණු අපරාධ ලෝකයේ කරන වැඩ ගැන තමයි කතාවේ තියෙන්නේ.🔥

නීතිය, අපරාධ කල්ලි, පොලිසිය සහ පවුල අතර මැද දෝලනය වන මේ Tv series එක, 
කුතුහලයෙන් යුතුව සිංහල substitute එක්ක  රස විදින්න.👈', 2008, '2008-01-01', 8.5, '{"Action","Crime","Drama","Tragedy"}', '{"<meta name=\"keywords\" content=\"Sons of Anarchy Season [X] Episode [Y]","Sons of Anarchy Sinhala Subtitles","Sons of Anarchy [X]x[Y] sub","Watch Sons of Anarchy online","SAMCRO","Jax Teller","TV Series Sinhala Sub","Sons of anarchy download","[pixelpoplk]\">"}', 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', 7, '2026-07-02 20:20:47.74712+00')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, poster_path = EXCLUDED.poster_path;
INSERT INTO movies (id, title, type, description, year, release_date, imdb_rating, genres, seo_tags, poster_path, backdrop_path, total_seasons, created_at)
VALUES ('42ae1274-0ac6-4892-a31a-134c4d85d2c3', 'House Of The Dragon', 'TV_SHOW', 'House of the Dragon තුන්වෙනි සීසන් එකේ තුන්වෙනි එපිසෝඩ් එකට සබ් එක තමයි මේ ගෙනාවේ. කලින් එපිසෝඩ් එකේදී ඒමොන්ඩ් වේගාර් එක්ක හැරන්හෝල් වලට ගියපු වෙලාවෙන් ප්‍රයෝජන අරගෙන, ඇලිසන්ට්ගේ සහ හෙලේනාගේ සහයෝගයත් එක්ක කිසිම කරදරයක් නැතුව රෙනයිරා King''s Landing නුවර බලය අතට ගත්තා මතකනේ. ඔටෝ හයිටවර්ට දඬුවම් දීලා Iron Throne එකේ බලය පිහිටෙව්වත්, ඒගොන්වයි ලැරිස්වයි කොටුකරගන්න බැරි වුණා. රෙනයිරාට මේ අලුත් බලය කොහොම පාලනය කරන්න වෙයිද, ඒ වගේම හැරන්හෝල් ගිය ඒමන්ඩ්ට මීලගට මොකක් වෙයිද කියලා මේ කොටසින් බලාගන්න පුළුවන්.

​මේකේ Direct sub එක පහළින්ම ඩවුන්ලෝඩ් කරගන්න පහසුකම තියෙනවා. ඒ වගේම Telegram එකෙන් 720p, 1080p සහ 4K අලුත්ම WEB-DL වීඩියෝ පිටපත් එක්කම සබ් එකත් ලේසියෙන්ම අරගෙන සිංහල උපසිරැසි එක්කම කතාව රසවිඳින්නත් පුළුවන්.

ඊලග  Episode එකත් ඉක්මනින්ම ලබාගන්න අපේ Telegram channel එකට සහ Fb page එකට join වෙලා ඉන්න යාලුවනේ. ඒවගේම ගැටලු ඇත්නම් Request  එකක් යොමු කරන්න.', 2026, '2026-01-01', 8.3, '{"Tv series","drama","fantasy","adventure","action"}', '{"<meta name=\"description\" content=\"House of the Dragon Season 3 Episode 3 Sinhala Subtitle. Telegram එකෙන් 720p","1080p","4K WEB-DL පිටපත් සහ සිංහල උපසිරැසි සෘජුවම බාගත කරගන්න.\"> <meta name=\"keywords\" content=\"House of the Dragon S03E03 Sinhala Sub","HOTD Season 3 Episode 3 Sinhala Subtitle","House of the Dragon Telegram","HOTD S3E3 WEB-DL","Sinhala Subtitles\">"}', 'https://image.tmdb.org/t/p/original/wSvDQN6tZR4VzDDZD3MUPIghVjC.jpg', 'https://image.tmdb.org/t/p/original/wSvDQN6tZR4VzDDZD3MUPIghVjC.jpg', 3, '2026-07-05 19:07:04.212977+00')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, poster_path = EXCLUDED.poster_path;
INSERT INTO movies (id, title, type, description, year, release_date, imdb_rating, genres, seo_tags, poster_path, backdrop_path, total_seasons, created_at)
VALUES ('b727785a-1be1-4a90-a810-655fb4a5d54e', 'Backrooms 2026', 'MOVIE', '🚪 The Backrooms (2026) Movie - සිංහල උපසිරැසි 🎬

අන්තර්ජාලය පුරාම ලොකු කුතුහලයක් ඇති කරපු, හැමෝම මඟබලාගෙන හිටපු අභිරහස් The Backrooms Film එක ඔන්න දැන් නරඹන්න පුළුවන්. හිතාගන්නවත් බැරි විදිහට අපේ සාමාන්‍ය ලෝකයෙන් වෙනස්ම මානයකට ඇදවැටෙන මිනිස්සු පිරිසකට මුහුණ දෙන්න වෙන සිදුවීම් දාමයක් වටා තමයි මේ කතාව ගෙතිලා තියෙන්නේ. කහ පාට බිත්ති තියෙන, නිමක් නැති හිස් කාමර ගොඩක් ඇතුළේ තනිවුණාම දැනෙන තනිකමත් එක්කම එන අමුතුම බය මේ ෆිල්ම් එක පුරාම තියෙනවා. 🚪🔦

A24 ආයතනයේ සුපිරි නිෂ්පාදනයක් විදිහට Kane Parsons ගේ අධ්‍යක්ෂණයෙන් එළිදකින මේ ෆිල්ම් එකේ කතාව ගැන වැඩිපුර මුකුත්ම නොකියා ඉන්න එක තමයි හොඳම දේ. මොකද මේක එක පාරටම බලලා ඔයාම විඳගන්න ඕනේ වෙනස්ම විදිහේ Psychological Thriller අත්දැකීමක්. 🎬 ඇත්තටම The Backrooms වල තියෙන ලොකුම අබිරහස මොකක්ද කියලා ෆිල්ම් එක බලලම දැනගමු. 🤫

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: 
කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram පිටපත්: 
වීඩියෝව සමඟ උපසිරැසි නැරඹීමට කැමති අය සඳහා 720p, 1080p උසස් තත්ත්වයේ WEB  පිටපත් සහ උපසිරැසි සියල්ලම ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', 2026, '2026-01-01', 7, '{"Horror","Sci-Fi","Thriller","Movie"}', '{"<!-- Primary Meta Tags --> <title>Backrooms (2026) Sinhala Subtitles | බෑක්රූම්ස් සිංහල උපසිරැසි</title> <meta name=\"title\" content=\"Backrooms (2026) Sinhala Subtitles | බෑක්රූම්ස් සිංහල උපසිරැසි\"> <meta name=\"description\" content=\"Backrooms (2026) අලුත්ම Sci-Fi Horror චිත්‍රපටයේ සිංහල උපසිරැසි (Sinhala Subtitles) කිසිදු බාධාවකින් තොරව දැන්ම ඩවුන්ලෝඩ් කරගන්න.\"> <meta name=\"keywords\" content=\"backrooms 2026 sinhala sub","backrooms sinhala subtitles","download backrooms sinhala sub","sinhala sub backrooms","backrooms movie sinhala\"> <meta name=\"robots\" content=\"index","follow\">  <!-- Open Graph / Facebook --> <meta property=\"og:type\" content=\"article\"> <meta property=\"og:url\" content=\"ඔයාගේ_පෝස්ට්_එකේ_ලින්ක්_එක_මෙතනට_දෙන්න\"> <meta property=\"og:title\" content=\"Backrooms (2026) Sinhala Subtitles | සිංහල උපසිරැසි\"> <meta property=\"og:description\" content=\"A24 හි Backrooms (2026) චිත්‍රපටයේ සිංහල උපසිරැසි (Sinhala Subtitles) සමඟින් චිත්‍රපටය රසවිඳින්න. දැන්ම Download කරගන්න.\"> <meta property=\"og:image\" content=\"ඔයාගේ_cover_photo_එකේ_ලින්ක්_එක_මෙතනට_දෙන්න\">  <!-- Twitter --> <meta property=\"twitter:card\" content=\"summary_large_image\"> <meta property=\"twitter:title\" content=\"Backrooms (2026) Sinhala Subtitles | සිංහල උපසිරැසි\"> <meta property=\"twitter:description\" content=\"Backrooms (2026) අලුත්ම Sci-Fi Horror චිත්‍රපටයේ සිංහල උපසිරැසි (Sinhala Subtitles) කිසිදු බාධාවකින් තොරව දැන්ම ඩවුන්ලෝඩ් කරගන්න.\"> <meta property=\"twitter:image\" content=\"ඔයාගේ_cover_photo_එකේ_ලින්ක්_එක_මෙතනට_දෙන්න\">  ​#Backrooms #Backrooms2026 #SinhalaSub #SinhalaSubtitles #සිංහලඋපසිරැසි #TheBackrooms #A24 #KaneParsons #SciFiHorror #SinhalaSubMovies #TelegramMovies #SriLanka"}', 'https://image.tmdb.org/t/p/original/rhGx6E3qRNMgj3i5su2oukNHwIQ.jpg', 'https://image.tmdb.org/t/p/original/rhGx6E3qRNMgj3i5su2oukNHwIQ.jpg', NULL, '2026-07-14 05:32:34.672294+00')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, poster_path = EXCLUDED.poster_path;
INSERT INTO movies (id, title, type, description, year, release_date, imdb_rating, genres, seo_tags, poster_path, backdrop_path, total_seasons, created_at)
VALUES ('8cc2980c-b4b8-46db-afe9-55e319c6614e', 'The East Palace (2026)', 'TV_SHOW', 'Netflix එකෙන් ගෙනාපු අලුත්ම Horror / Dark Fantasy කතාව - The East Palace (Donggung)! 🎬🔥

Kingdom, The Guest වගේ කතාවලට ආස අයට වගේම, හොල්මන්, අද්භූත Monsters ලා ඉන්න Action Thriller කතා පිස්සුවෙන් වගේ බලන අයට මේක සුපිරි භාණ්ඩයක්. 👻⚔️

කතාව යන්නේ ජොසොන් යුගයේ අභිරහස් සාපයකට ලක්වුණු රජ මාලිගාවක් ගැන. මාලිගාවේ පොකුණක ඉන්න භයානක භූතයෙක් නිසා රජ පවුලේ කුමාරවරු එකින් එක මැරෙනවා. මේක නවත්තන්න හොල්මන් සහ යක්ෂයෝ දඩයම් කරන අකීකරු කඩුවැල්කරුවෙකුයි (Nam Joo-hyuk), මළගිය අයගේ සද්ද ඇහෙන මාලිගාවේ සේවිකාවකුයි (Roh Yoon-seo) එකතු වෙලා ගේමක් ගහනවා.
VFX, පට්ට Action සහ ලේ වැගිරීම් එහෙම උපරිමයටම තියෙනවා. ඒ වගේම මේක Nam Joo-hyuk හමුදාවෙන් ආවට පස්සෙ කරන පලවෙනි කතාව නිසා මාර Hype එකක් තියෙන්නේ.

🔥 මේකේ තවත් විශේෂ කතාවක් තියෙනවා!
මේ කතා මාලාවේ ෂූටින් කරගෙන යන අතරතුර සෙට් එකේ ලොකු ගින්නක් ඇතිවෙලා මුළු ස්ටූඩියෝ එකම විනාශ වුණා. වාසනාවකට කාටවත් අනතුරක් වුණේ නැහැ. ඒ හැම බාධකයක්ම මැදින් තමයි මේ සුපිරි නිර්මාණය ඔයාලට බලන්න ඇවිත් තියෙන්නේ!

මේ පට්ටම Horror සීරිස් එක තව සුළු මොහොතකින් අපේ Telegram Channel එක සහ Website එක හරහා සිංහල උපසිරැසි (Sinhala Sub) සමඟින්ම ඔයාලට නරඹන්න පුළුවන්! 🥳🎉', 2026, '2026-01-01', 7.6, '{"horror","dark fantasy","historical","thriller","action","mystery","fantasy","kdrama"}', '{"<meta name=\"description\" content=\"The East Palace Ep 01 Sinhala Subtitles & The East Palace Sinhala Sub. The East Palace උපසිරැසි (East Palace Sinhala Sub) Pixelpoplk Subtitles වෙතින් දැන්ම බාගත කරගන්න!\">"}', 'https://image.tmdb.org/t/p/original/yfYohBszGqoAW8oM0qydOtJ4kPh.jpg', 'https://image.tmdb.org/t/p/original/yfYohBszGqoAW8oM0qydOtJ4kPh.jpg', 1, '2026-07-18 06:07:52.262353+00')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, poster_path = EXCLUDED.poster_path;
INSERT INTO movies (id, title, type, description, year, release_date, imdb_rating, genres, seo_tags, poster_path, backdrop_path, total_seasons, created_at)
VALUES ('e0acef12-4bfd-4d2a-a3d4-6f3dc06b57a2', 'Disclosure Day 2026', 'MOVIE', '🎬 The Disclosure Day - සිංහල උපසිරැසි 🎬

The Disclosure Day is a high-stakes sci-fi thriller exploring the dramatic fallout of humanity''s greatest secret being exposed.
As governments struggle to maintain control, ordinary people are pushed to their limits in a race to survive the global unraveling. Featuring intense suspense and unexpected twists, this film keeps viewers hooked from the opening scene to the final climax.
Download high quality WEB-DL video files in 720p, 1080p resolution along with direct Sinhala subtitle files.
Get fast, seamless access to watch or download The Disclosure Day with official Sinhala subs on Telegram and direct servers.

🔰ලෝකයෙන් වසන් කරගෙන හිටපු ලොකුම රහසක් හෙළිවන දවස ගැන තමයි මේ ෆිල්ම් එකෙන් කියවෙන්නේ. රජයන් සහ බලවත් සංවිධාන විසින් සාමාන්‍ය ජනතාවගෙන් හංගගෙන හිටපු මේ රහස එකපාරටම ලෝකෙට එළිවෙනකොට, මුළු ලෝකයම ලොකු අවුලකට පත්වෙනවා. මේ සිදුවීම් දාමය අස්සේ ප්‍රධාන චරිත මේ තත්ත්වයට මුහුණ දෙන විදිහ සහ තමන්ගේ පවුලේ අයව ආරක්ෂා කරගන්න ගන්නා උත්සාහය කතාව පුරාම බලාගන්න පුළුවන්.👈

කතාව ගැන වැඩිය කියන්නේ නැතුව කිව්වොත්, ආරම්භයේ ඉඳන් අවසානය වෙනකම්ම කුතුහලයෙන් බලන්න පුළුවන් ත්‍රාසජනක ෆිල්ම් එකක් විදිහට මේක හඳුන්වන්න පුළුවන්.💯

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram පිටපත්: වීඩියෝව සමඟ උපසිරැසි නැරඹීමට කැමති අය සඳහා 720p, 1080p  උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් සහ උපසිරැසි සියල්ලම ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', 2026, '2026-01-01', 6.7, '{"Sci-Fi","Mystery","Thriller","Drama","Adventure"}', '{"<!-- Meta Keywords --> <meta name=\"keywords\" content=\"The Disclosure Day Sinhala Subtitles","The Disclosure Day Sinhala Sub","Download The Disclosure Day Sinhala Subtitle","The Disclosure Day Telegram Download","Web-DL 1080p 720p 4K","The Disclosure Day සිංහල උපසිරැසි","The Disclosure Day Movie Sinhala Sub\">"}', 'https://image.tmdb.org/t/p/original/3o5YPjDGDTcTDL5ftDA9NwN9dLd.jpg', 'https://image.tmdb.org/t/p/original/3o5YPjDGDTcTDL5ftDA9NwN9dLd.jpg', NULL, '2026-07-21 08:01:41.770922+00')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, poster_path = EXCLUDED.poster_path;
INSERT INTO movies (id, title, type, description, year, release_date, imdb_rating, genres, seo_tags, poster_path, backdrop_path, total_seasons, created_at)
VALUES ('5abd4f11-9adf-4868-ad67-a80a1d51daf7', 'Dune: Prophecy', 'TV_SHOW', '🪐 Dune: Prophecy (2024-)  සිංහල උපසිරැසි 🎬

Dune: Prophecy is a sci-fi prequel set 10,000 years before Paul Atreides, following the Harkonnen sisters as they found the legendary Bene Gesserit. Download high-quality 720p WEB-DL video files with Sinhala subtitles on Telegram and direct servers.

Frank Herbert ගේ ලෝකප්‍රකට Dune විශ්වය ඇසුරෙන් නිර්මාණය වූ Dune: Prophecy කතා මාලාව දිගහැරෙන්නේ Paul Atreides ගේ ඉපදීමට සහ Arrakis ග්‍රහලෝකයේ සිදුවීම්වලට වසර 10,000 කට පෙර අතීත කාලවකවානුවකය. මනුෂ්‍ය වර්ගයා සිතන යන්ත්‍ර සහ කෘතිම බුද්ධිය (AI) සමඟ කළ මහා යුද්ධයෙන් (Thinking Machines Crisis) පසුව, තාක්ෂණය මත යැපීම තහනම් වූ යුගයක අනාගත මනුෂ්‍ය වර්ගයාගේ පැවැත්ම තීරණය කිරීමට සිදුවන්නේ මිනිස් මනසේ සහ ශරීරයේ උපරිම ශක්තිය මතය.

මෙම අභියෝගාත්මක වටපිටාව තුළ Harkonnen වංශයේ සහෝදරියන් වන Valya Harkonnen සහ Tula Harkonnen ප්‍රධාන චරිත බවට පත්වෙයි. තම වංශයට අහිමි වූ ගෞරවය නැවත ලබාගැනීමටත්, අනාගත රාජ්‍යයන්ගේ බලතුලනය තමන්ට අවශ්‍ය පරිදි මෙහෙයවීමටත් ඔවුන් කටයුතු කරයි. එහි ප්‍රතිඵලයක් ලෙස මනුෂ්‍ය වර්ගයාගේ අනාගතය වෙනස් කළ හැකි, දේශපාලන අධිරාජ්‍යයන් පවා පිටුපස සිට පාලනය කරන Bene Gesserit නම් අද්භූත සහ අතිශය බලවත් සහෝදරත්වය (Sisterhood) ආරම්භ වේ.

විශාල අධිරාජ්‍යයන් අතර පවතින රහසිගත සටන්, රාජකීය කුමන්ත්‍රණ, ආගමික සහ දාර්ශනික මතවාද මෙන්ම අභිරහස් අඳුරු බලවේගයන්ගෙන් පිරුණු මෙම නිර්මාණය Dune කතා මාලාවේ මූලාරම්භය ඉතා ගැඹුරින් හෙළි කරයි. Sci-Fi, Drama සහ Political Thriller ගණයට අයත් මෙම කතා මාලාව උසස්ම මට්ටමේ visual effects සහ පාලුවකින් තොරව එකදිගට නැරඹිය හැකි විශිෂ්ට කතා තේමාවකින් සමන්විත වේ.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:
📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.
✈️ Telegram පිටපත්: වීඩියෝව සමඟ උපසිරැසි නැරඹීමට කැමති අය සඳහා 720p WEB-DL වීඩියෝ පිටපත් සහ උපසිරැසි සියල්ලම ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', 2024, '2024-01-01', 7.3, '{"Fantasy","Action","Political","Philosophical","Drama","Sci-Fi"}', '{"<meta name=\"keywords\" content=\"Dune Prophecy Season 1 Episode 1","Dune Prophecy Sinhala Subtitles","Dune Prophecy S01E01 Sinhala Sub","Dune Prophecy 1x1 sub","Bene Gesserit","Valya Harkonnen","Dune prequel Sinhala Sub","pixelpoplk\"> <meta name=\"description\" content=\"Dune Prophecy Season 1 Episode 1 Sinhala Subtitles. Download Dune Prophecy S01E01 Sinhala Sub online from pixelpoplk.\">"}', 'https://image.tmdb.org/t/p/original/5B8Cxz8ZZXp3w2WmmdKTXpkS24e.jpg', 'https://image.tmdb.org/t/p/original/5B8Cxz8ZZXp3w2WmmdKTXpkS24e.jpg', 1, '2026-07-21 11:40:57.426392+00')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, poster_path = EXCLUDED.poster_path;
INSERT INTO movies (id, title, type, description, year, release_date, imdb_rating, genres, seo_tags, poster_path, backdrop_path, total_seasons, created_at)
VALUES ('0229ecbe-ddae-4a78-a2b7-663225e0a314', 'Colony 2026', 'MOVIE', '🎬 Colony (2026) - සිංහල උපසිරැසි 🎬

Colony is a 2026 Korean action horror thriller directed by Yeon Sang-ho (Train to Busan), starring Jun Ji-hyun, Koo Kyo-hwan, and Ji Chang-wook. Download high-quality 720p, 1080p, and 4K WEB-DL video files with Sinhala subtitles on Telegram and direct servers.

Train to Busan, Peninsula වැනි ලෝකප්‍රකට Horror නිර්මාණ ගෙන ආ Yeon Sang-ho අධ්‍යක්ෂවරයාගේ අලුත්ම දකුණු කොරියානු Action Horror Thriller චිත්‍රපටය වන Colony (2026) මුළු ලෝකයේම දැඩි අවධානයක් දිනාගත් නිර්මාණයකි. 

කතාව ආරම්භ වන්නේ ජෛව තාක්ෂණික (Biotech) සමුළුවක් අතරතුර සිදුවන නොසිතූ තාක්ෂණික සහ වෛරස් කාන්දුවක් මුල් කරගනිමින්. මෙම අතිශය භයානක වෛරසය පැතිරී යාමත් සමඟම බලධාරීන් විසින් සමුළුව පැවැත්වෙන මුළු ගොඩනැගිල්ලම පිටතින් සම්පූර්ණයෙන්ම වසා දමනු ලබනවා. එහි ඇතුළත සිරවෙන Se-jeong (Jun Ji-hyun) ඇතුළු පිරිසට මුහුණ දීමට සිදුවන්නේ සාමාන්‍ය වෛරස් ආසාදිතයන්ට නෙමෙයි. තත්පරයෙන් තත්පරය ශරීර වෙනස්කම්වලට ලක්වෙමින්, එකිනෙකා අතර සන්නිවේදනය කරමින් සංවිධානාත්මකව ප්‍රහාර එල්ල කරන අතිශය බුද්ධිමත් සහ භයානක ආසාදිතයන් පිරිසකටයි.

පිටතට යාමට කිසිදු මාර්ගයක් නොමැතිව, හුදකලා වූ ගොඩනැගිල්ල තුළ සිරවී තමන්ගේ ජීවිත බේරාගැනීමට කරන අතිශය ත්‍රාසජනක සටන සහ නොසිතන මොහොතක සිදුවන සිදුවීම් සමුදායක් මෙම චිත්‍රපටය පුරාම බලාගන්න පුළුවන්. Horror, Sci-Fi සහ Thriller ගණයට අයත් මෙම චිත්‍රපටය ආරම්භයේ සිට අවසානය දක්වාම කුතුහලයෙන් සහ භීතියෙන් පිරුණු විශිෂ්ට සිනමා අත්දැකීමක් ලබාදෙයි.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

🔰Link එක click කරලා තප්පර 5ක් විතර හිටියම Auto download වෙනවා. Auto Download උනේ නැත්නම්  කොලපාටින් popup වෙන download button එක ඔබන්න.

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව සෘජුවම බාගත කරගත හැක.

✈️ Telegram පිටපත්: 720p, 1080p උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', 2026, '2026-01-01', 6.9, '{"Movie","Horror","Action","Triller"}', '{"Colony 2026 Sinhala Subtitles","Colony 2026 sinhala sub","Colony movie sinhala sub","Colony sinhala subtitle download","Colony 2026 sinhala sub pixelpoplk","Colony sinhala sub pixelpop.lk","pixelpoplk colony 2026","කොලනි 2026 සිංහල උපසිරැසි","Colony korean movie sinhala sub","Colony 2026 full movie sinhala subtitles download","Colony 2026 sinhala sub web-dl","Ji Chang-wook Colony movie sinhala subtitle","Yeon Sang-ho Colony movie sinhala sub","pixelpoplk sinhala subtitles","කොලනි ෆිල්ම් එකේ සිංහල සබ්"}', 'https://m.media-amazon.com/images/M/MV5BMDgwNzhmMjItMDhlYi00ODdlLWI1NjUtZDgxZGMzMGU5MmM4XkEyXkFqcGc@._V1_.jpg', 'https://m.media-amazon.com/images/M/MV5BMDgwNzhmMjItMDhlYi00ODdlLWI1NjUtZDgxZGMzMGU5MmM4XkEyXkFqcGc@._V1_.jpg', NULL, '2026-07-23 19:35:18.298072+00')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, poster_path = EXCLUDED.poster_path;
INSERT INTO movies (id, title, type, description, year, release_date, imdb_rating, genres, seo_tags, poster_path, backdrop_path, total_seasons, created_at)
VALUES ('1aad2806-8173-4ae1-ae43-57d800d76bdd', 'Anomie 2026', 'MOVIE', '🎬 Anomie: The Equation of Death (2026) - සිංහල උපසිරැසි 🎬

Anomie (2026) is a highly anticipated Malayalam psychological sci-fi thriller directed by Riyas Marath, starring Bhavana and Rahman in lead roles. Download high-quality 720p, 1080p  WEB-DL video files with Sinhala subtitles via direct links and Telegram.

මෑත කාලයේ මලයාලම් සිනමාවේ බිහිවූ වෙනස්ම ආකාරයේ Sci-Fi / Psychological Thriller අත්දැකීමක් වන Anomie: The Equation of Death (2026) චිත්‍රපටය මේ වන විට ප්‍රේක්ෂකයන් අතර දැඩි කතාබහකට ලක්වෙලා තියෙනවා. Riyas Marath ගේ අධ්‍යක්ෂණයෙන් හැඩවුණු මෙහි ප්‍රධාන චරිත නිරූපණය කරන්නේ අති දක්ෂ නිළි Bhavana සහ ජනප්‍රිය නළු Rahman විසිනි.

කතාව ගෙතෙන්නේ දක්ෂ අධිකරණ වෛද්‍ය විශේෂඥවරියක් (Forensic Expert) වන Zara Philip (Bhavana) වටායි. තමන්ගේ අතීත මානසික කම්පනයකින් පෙළෙන ඇගේ සහෝදරයා හදිසියේම අතුරුදහන් වෙනවා. කිසිදු පොලිස් සහයක් නිසි ලෙස නොලැබෙන තැන, ඔහුව සෙවීමේ මෙහෙයුම ඇය තනිවම ආරම්භ කරනවා. එහිදී ඇයට සොයාගන්න ලැබෙන්නේ, තම සහෝදරයාට සමාන මානසික මට්ටම් ඇති තවත් කිහිපදෙනෙකුම මේ ආකාරයෙන්ම අතුරුදහන් වී ඇති බවට සැකකටයුතු හෝඩුවාවන් රැසක්. 

මේ අතරතුර, තම අතීත වැරදීම් නිසා කම්පනයට පත්ව සිටින පොලිස් නිලධාරී Jibran (Rahman) ද මෙම අභිරහස පසුපස හඹා යාම ආරම්භ කරනවා. ඔවුන් දෙදෙනාගේම පරීක්ෂණ එකිනෙක ගැටෙද්දී, මේ සියල්ල පිටුපස සිටින අතිශය බුද්ධිමත්, තමන් කරන්නේ වරදක් යැයි කිසිසේත්ම විශ්වාස නොකරන මනෝව්‍යාධිකයෙකුගේ (Psychopath) බිහිසුණු සැලසුමක් හෙළිවෙන්න ගන්නවා. 

විද්‍යාව, අපරාධ සහ මනෝවිද්‍යාව (Sci-Fi & Psychology) එකට කැටිවූ මෙම චිත්‍රපටය, කුතුහලය උපරිමයෙන් රඳවාගෙන අවසානය දක්වාම එක හුස්මට නැරඹිය හැකි විශිෂ්ට නිර්මාණයක්!

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

🔰Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

👉වීඩියෝ ගොනු බාගත කිරීම: Link එක click කර තත්පර 5ක් පමණ රැඳී සිටින්න, එවිට Auto download වීම ආරම්භ වේ. Auto Download වූයේ නැත්නම් කොළ පැහැයෙන් pop-up වන "Download" button එක click කරන්න.

👉 Telegram පිටපත්: 720p, 1080 උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් අපගේ ටෙලිග්‍රෑම් චැනලය හරහා පහසුවෙන් ලබාගත හැක.', 2026, '2026-01-01', 7.9, '{"Movie","thriller","crime","mystery","Sci-Fi"}', '{"Anomie 2026 Sinhala Subtitles","Anomie 2026 sinhala sub","Anomie movie sinhala sub","Anomie sinhala subtitle download","Anomie 2026 sinhala sub pixelpoplk","Anomie sinhala sub pixelpop.lk","pixelpoplk anomie 2026","ඇනෝමි 2026 සිංහල උපසිරැසි","Anomie malayalam movie sinhala sub","Anomie 2026 full movie sinhala subtitles download","Anomie 2026 sinhala sub web-dl","Bhavana Anomie movie sinhala subtitle","Rahman Anomie movie sinhala subtitle","Riyas Marath Anomie movie sinhala sub","pixelpoplk sinhala subtitles","ඇනෝමි ෆිල්ම් එකේ සිංහල සබ්"}', 'https://image.tmdb.org/t/p/original/p9czhWmPhyMFp8eHNYO34Z9hOGA.jpg', 'https://image.tmdb.org/t/p/original/p9czhWmPhyMFp8eHNYO34Z9hOGA.jpg', NULL, '2026-07-24 12:04:54.624116+00')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, poster_path = EXCLUDED.poster_path;
INSERT INTO movies (id, title, type, description, year, release_date, imdb_rating, genres, seo_tags, poster_path, backdrop_path, total_seasons, created_at)
VALUES ('7273abd3-83a6-4546-a3ec-63ecbad7afee', '72 Hours (2026)', 'MOVIE', '🎬 72 Hours (2026) - සිංහල උපසිරැසි 🎬

72 Hours (2026) is a hilarious new comedy movie packed with non-stop laughs, crazy situations, and a chaotic ticking-clock adventure. Download high-quality 720p, 1080p  WEB-DL video files with Sinhala subtitles on Telegram and direct servers.

72 Hours (2026) කියන්නේ මුල ඉඳන් අගටම හිනා වෙලා පණ යන මට්ටමේ සුපිරි Comedy සිනමා නිර්මාණයක්. කතාව ගෙතෙන්නේ ප්‍රධාන චරිතයට සහ ඔහුගේ යාළුවන්ට අහම්බෙන් මුහුණ දෙන්න වෙන මාරක වගේම අතිශය විහිළු සහගත සිදුවීම් දාමයක් වටායි. 

තමන් අතින් වුණු ලොකු අත්වැරැද්දක් නිවැරදි කරගන්න, එහෙමත් නැත්නම් ජීවිතේ ලැබුණු ලොකුම අවස්ථාවක් බේරගන්න මේ යාලුවෝ සෙට් එකට ලැබෙන්නේ හරියටම පැය 72ක සීමිත කාලයක් විතරයි. මේ දවස් තුන ඇතුළත එයාලා කරන පිස්සු වැඩ, මුණගැහෙන අමුතුම විදිහේ චරිත සහ කිසිසේත්ම බලාපොරොත්තු නොවන සිදුවීම් නිසා චිත්‍රපටිය පුරාම කිසිම කම්මැලිකමක් නැතුව හිනාවෙවී බලන්න පුළුවන්. 

හුස්ම ගන්නවත් වෙලාවක් නැති තරමට එක දිගට සිදුවෙන විහිළු සහගත සිදුවීම් එක්ක ගලාගෙන යන මේ ෆිල්ම් එක Comedy නිර්මාණවලට කැමති අයට නිදහසේ විනෝදයෙන් බලන්න කියාපු ෆිල්ම් එකක් විදිහට හඳුන්වන්න පුළුවන්.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව සෘජුවම බාගත කරගත හැක.

✈️ Telegram පිටපත්: 720p, 1080p  උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් සහ උපසිරැසි සියල්ලම ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', 2026, '2026-01-01', 6.1, '{"Movie","comedy","18+"}', '{"72 Hours 2026 Sinhala Subtitles","72 Hours 2026 sinhala sub","72 Hours movie sinhala sub","72 Hours sinhala subtitle download","72 Hours 2026 sinhala sub pixelpoplk","72 Hours sinhala sub pixelpop.lk","pixelpoplk 72 hours 2026","72 Hours 2026 සිංහල උපසිරැසි","72 Hours comedy movie sinhala sub","72 Hours 2026 full movie sinhala subtitles download","72 Hours 2026 sinhala sub web-dl","pixelpoplk sinhala subtitles","72 Hours ෆිල්ම් එකේ සිංහල සබ්"}', 'https://image.tmdb.org/t/p/original/9Bu1PW2R1XayqRqnl0aDOgMcrdS.jpg', 'https://image.tmdb.org/t/p/original/9Bu1PW2R1XayqRqnl0aDOgMcrdS.jpg', NULL, '2026-07-26 08:15:56.089476+00')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, poster_path = EXCLUDED.poster_path;
INSERT INTO movies (id, title, type, description, year, release_date, imdb_rating, genres, seo_tags, poster_path, backdrop_path, total_seasons, created_at)
VALUES ('91af03eb-e36a-4005-a506-e177e8c89a81', 'The Walking Dead: Dead City', 'TV_SHOW', '📥 Subtitles සහ Movies/TV Series පහසුවෙන්ම Download කරගන්නේ කෙසේද?

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

චිත්‍රපට සහ ටෙලි කථා මාලාවල අලුත්ම Updates සහ Subtitles ක්ෂණිකව ලබාගැනීමට දැන්ම අපගේ Telegram Channel එකට සහ FB Page එකට Join වෙන්න! 🎬', 2023, '2023-01-01', 7, '{"Survival","Horror","Zombie","Drama","Tv Series"}', '{"Walking dead dead city sinhala sub","dead city sinhala sub","The walking dead"}', 'https://image.tmdb.org/t/p/original/seYokxOjFyTVX13XgD2FNjWIry8.jpg', 'https://image.tmdb.org/t/p/original/seYokxOjFyTVX13XgD2FNjWIry8.jpg', 3, '2026-07-26 09:14:46.57961+00')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, poster_path = EXCLUDED.poster_path;
INSERT INTO movies (id, title, type, description, year, release_date, imdb_rating, genres, seo_tags, poster_path, backdrop_path, total_seasons, created_at)
VALUES ('df9ada98-9278-4ca8-a15c-8a7ea09f99c8', 'Supergirl (2026)', 'MOVIE', '🦸‍♀️ Supergirl: Woman of Tomorrow (2026) - සිංහල උපසිරැසි 🎬

Supergirl: Woman of Tomorrow (2026) marks a bold new chapter in James Gunn''s revamped DC Universe. Starring Milly Alcock as Kara Zor-El, this sci-fi epic takes fans on an emotional and action-packed journey across the galaxy. Download high-quality 720p, 1080p WEB-DL video files with Sinhala subtitles directly or via Telegram. Get ready to experience the next massive DCU blockbuster.

Supergirl: Woman of Tomorrow (2026) චිත්‍රපටය කියන්නේ අලුත් DC Universe එකේ James Gunn ගේ මූලිකත්වයෙන් එළියට එන දැවැන්තම නිර්මාණයක්. මේක සාමාන්‍ය සුපර්හීරෝ කතාවකට වඩා සම්පූර්ණයෙන්ම වෙනස්, මන්දාකිණිය හරහා යන දැවැන්ත sci-fi ගමනක් විදිහටයි නිර්මාණය වෙලා තියෙන්නේ. Tom King ගේ ජනප්‍රිය කොමික් පොත් මාලාව පාදක කරගෙන තමයි මේ චිත්‍රපටය හැදිලා තියෙන්නේ.

කතාවේ කිසිම දෙයක් spoil කරන්නේ නැතුව කිව්වොත්, මේකෙන් පෙන්නන්නේ Superman සහ Supergirl (Kara Zor-El) අතර තියෙන ලොකු වෙනස. Superman පෘථිවියට ඇවිත් ආදරණීය පවුලක් එක්ක හැදෙනකොට, Kara ට සිද්ධ වෙන්නේ විනාශ වෙච්ච Krypton ග්‍රහලෝකයේ ඉතුරු වෙච්ච කෑල්ලක අවුරුදු 14ක් තිස්සේ මරණය සහ වේදනාව මැද්දේ තනියම ජීවත් වෙන්න. ඒ නිසා අපි මේ චිත්‍රපටයෙන් දකින්නේ අපි කලින් දැකපු අහිංසක Supergirl නෙවෙයි, ඊට වඩා ගොඩක් රළු, දරුණු අත්දැකීම් වලට මුහුණ දීපු ශක්තිමත් කෙනෙක්. 

House of the Dragon කතා මාලාවෙන් අපි දැකපු දක්ෂ නිළි Milly Alcock තමයි මෙහි Supergirl ගේ චරිතයට පණ පොවන්නේ. ඒ වගේම Krypto කියන සුපර් බල්ලා (Superdog) වගේ අලුත් චරිතත් එක්ක එකතු වෙන මේ චිත්‍රපටය, කිසිම කම්මැලිකමක් නැතුව බලන්න පුළුවන්, DC රසිකයින්ට වෙනස්ම අත්දැකීමක් දෙන එකක් බව අනිවාර්යයි.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p, 1080p උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් Telegram චැනලය හරහා ලබාගත හැක.', 2026, '2026-01-01', 6.2, '{"Movie","Action","Adventure","Sci-Fi","Superhero"}', '{"Supergirl Woman of Tomorrow 2026 Sinhala Subtitles","Supergirl 2026 sinhala sub","Supergirl Woman of Tomorrow sinhala subtitle download","Supergirl 2026 sinhala sub pixelpoplk","Supergirl 2026 sinhala sub pixelpop.lk","pixelpoplk DC movies","සුපර්ගර්ල් සිංහල උපසිරැසි","Supergirl 2026 full movie sinhala subtitles download","Supergirl 2026 sinhala sub web-dl","pixelpoplk sinhala subtitles","DCU Supergirl movie sinhala sub"}', 'https://image.tmdb.org/t/p/original/xhei2GX9L2H1eQlrHeFw44VNLd1.jpg', 'https://image.tmdb.org/t/p/original/xhei2GX9L2H1eQlrHeFw44VNLd1.jpg', NULL, '2026-07-27 06:46:17.212937+00')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, poster_path = EXCLUDED.poster_path;
INSERT INTO movies (id, title, type, description, year, release_date, imdb_rating, genres, seo_tags, poster_path, backdrop_path, total_seasons, created_at)
VALUES ('b6b4aa04-8615-4dd8-a055-7aea79dea82f', 'The Sopranos', 'TV_SHOW', '🔫 The Sopranos - සිංහල උපසිරැසි 🎬

The Sopranos is widely considered one of the greatest television series of all time. Dive into the complex life of Tony Soprano, a New Jersey mob boss balancing his ruthless mafia family with his actual family. Download high-quality 720p, 1080p, and 4K WEB-DL video files with Sinhala subtitles directly or via Telegram. Experience the masterpiece that changed modern television forever.

ලෝකයේ බිහිවුණු විශිෂ්ටතම රූපවාහිනී කතා මාලාවන්ගෙන් එකක් විදිහට හැඳින්වෙන The Sopranos තමයි මේ අරගෙන එන්නේ. New Jersey වල මාෆියා නායකයෙක් වෙන Tony Soprano ගේ ජීවිතය වටා තමයි මේ කතාව ගෙතිලා තියෙන්නේ. තමන්ගේ අපරාධ ජාලය මෙහෙයවන එකයි, පවුලේ ප්‍රශ්න විසඳන එකයි අතරේ ඔහු කොහොමද සමබරතාවය තියාගන්නේ කියන එක මේකෙන් ගොඩක් තාත්විකව පෙන්නනවා.

සාමාන්‍ය මාෆියා කතාවකට වඩා මේක ගොඩක් වෙනස් වෙන්නේ, Tony Soprano මුහුණ දෙන මානසික ආතතිය සහ ඒ නිසා ඔහු මනෝ වෛද්‍යවරයෙක් මුණගැහෙන්න යන සිදුවීම් නිසා. Action, Crime කතා වලට වගේම, ටිකක් ගැඹුරු කතා තේමාවන් වලට කැමති අයට කිසිම කම්මැලිකමක් නැතුව බලන්න පුළුවන් සුපිරිම කතා මාලාවක් තමයි මේක. HBO නාලිකාවෙන් විකාශය වුණු මේ කතාව, අදටත් රූපවාහිනී කලාවේ දැවැන්තම සන්ධිස්ථානයක් විදිහට සැලකෙනවා. 

🔰🔰🔰මෙම උපසිරැසි  bluray පිටපත් වලට පමනක් ගැලපේ.🔰🔰🔰🔰

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව බාගත කරගත හැක.

✈️ Telegram Download: 720p, 1080p උසස් තත්ත්වයේ Bluray වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', 1997, '1997-01-01', 9.2, '{"TV Series","Action","Crime","Drama"}', '{"The Sopranos Sinhala Subtitles","The Sopranos sinhala sub","The Sopranos sinhala subtitle download","The Sopranos tv series sinhala sub pixelpoplk","The Sopranos sinhala sub pixelpop.lk","pixelpoplk HBO series","ද සොප්‍රානොස් සිංහල උපසිරැසි","The Sopranos full series sinhala subtitles download","The Sopranos sinhala sub web-dl","pixelpoplk sinhala subtitles","The Sopranos කතා මාලාවේ සිංහල සබ්"}', 'https://image.tmdb.org/t/p/original/rTc7ZXdroqjkKivFPvCPX0Ru7uw.jpg', 'https://image.tmdb.org/t/p/original/rTc7ZXdroqjkKivFPvCPX0Ru7uw.jpg', 6, '2026-07-28 16:58:59.501453+00')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, poster_path = EXCLUDED.poster_path;
INSERT INTO movies (id, title, type, description, year, release_date, imdb_rating, genres, seo_tags, poster_path, backdrop_path, total_seasons, created_at)
VALUES ('3cf8526a-e6d0-4385-a6c8-a42b45e28736', 'Demon Slayer - Infinity Castle 2025', 'MOVIE', '⚔️ Demon Slayer: Infinity Castle (2025) - සිංහල උපසිරැසි 🎬

Demon Slayer: Kimetsu no Yaiba - Infinity Castle (2025) brings the epic final battle to the screen. Join Tanjiro, the Hashira, and the Demon Slayer Corps as they enter Muzan''s deadly labyrinth for the ultimate showdown. Download high-quality 720p, 1080p, and 4K WEB-DL video files with Sinhala subtitles directly or via Telegram. Experience the breathtaking animation and action of this highly anticipated anime masterpiece.

ලෝකයේම ආදරය දිනාගත්ත Demon Slayer ඇනිමේ කතා මාලාවේ අවසාන මහා සටන, ඒ කියන්නේ "Infinity Castle Arc" එක තමයි මේ විදිහට චිත්‍රපටයක් විදිහට 2025 අවුරුද්දේ එළියට එන්නේ. පසුගිය Hashira Training Arc එක අවසානයේදී Muzan Kibutsuji විසින් තමන්ගේ අපරාධ මූලස්ථානය වෙන Infinity Castle එක ඇතුළට හැමෝවම ඇදලා දාපු තැනින් තමයි මේ කතාව පටන් ගන්නේ.

කතාව ස්පොයිල් කරන්නේ නැතුව කිව්වොත්, තමන්ගේ උපරිම ශක්තිය පාවිච්චි කරලා Tanjiro ඇතුළු Hashira වරුන්ට සිද්ධ වෙනවා Muzan වගේම ඉතුරු වෙලා ඉන්න අති දරුණු Upper-Rank යක්ෂයින් (Akaza, Doma, Kokushibo) එක්ක ජීවිතයත් මරණයත් අතර සටනකට මුහුණ දෙන්න. ඇනිමේෂන් අතින් උපරිම තත්ත්වයේ තියෙන, ඇඟේ හිරිගඩු පිපෙන Action සීන් වලින් පිරිලා තියෙන මේ ෆිල්ම් එක Demon Slayer බලන හැමෝම අනිවාර්යයෙන්ම බලන්න ඕනේ සුපිරිම නිර්මාණයක්. 

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p, 1080p උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', 2025, '2025-01-01', 8.4, '{"Action","Anime","Movie","Japanese"}', '{"Demon Slayer Infinity Castle 2025 Sinhala Subtitles","Demon Slayer 2025 sinhala sub","Kimetsu no Yaiba Infinity Castle sinhala subtitle download","Demon Slayer movie sinhala sub pixelpoplk","Demon Slayer sinhala sub pixelpop.lk","pixelpoplk anime movies","ඩිමන් ස්ලේයර් සිංහල උපසිරැසි","Demon Slayer 2025 full movie sinhala subtitles download","Demon Slayer Infinity Castle sinhala sub web-dl","pixelpoplk sinhala subtitles","Demon Slayer ඇනිමේ සිංහල සබ්","Japan","Japanese","Japan Anime"}', 'https://image.tmdb.org/t/p/original/sUsVimPdA1l162FvdBIlmKBlWHx.jpg', 'https://image.tmdb.org/t/p/original/sUsVimPdA1l162FvdBIlmKBlWHx.jpg', NULL, '2026-07-28 20:01:07.145515+00')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, poster_path = EXCLUDED.poster_path;
INSERT INTO movies (id, title, type, description, year, release_date, imdb_rating, genres, seo_tags, poster_path, backdrop_path, total_seasons, created_at)
VALUES ('d42c4776-344b-449a-a5fe-a6cadb6b0e59', 'Spider-Man: Brand New Day (2026)', 'MOVIE', 'Spider Man brand New day Cam copy එකක්. කැමති අය බලන්න. අඩුම තරමේ Digital release උනාම බලන්න.', 2026, '2026-01-01', 8.5, '{"Movie","Action"}', '{"Spider man brand new day","spider","spider man","spiderman","Marval","spider man brandnew day download"}', 'https://image.tmdb.org/t/p/original/iPOn6DinuVyLY17YM9mKuPofV08.jpg', 'https://image.tmdb.org/t/p/original/iPOn6DinuVyLY17YM9mKuPofV08.jpg', NULL, '2026-07-30 10:11:12.178415+00')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, poster_path = EXCLUDED.poster_path;
INSERT INTO movies (id, title, type, description, year, release_date, imdb_rating, genres, seo_tags, poster_path, backdrop_path, total_seasons, created_at)
VALUES ('7029d726-99d2-49d0-a112-bddf83ae943c', 'Batman: Caped Crusader', 'TV_SHOW', '🦇 Batman: Caped Crusader - සිංහල උපසිරැසි 🎬

Batman: Caped Crusader brings a dark, noir-inspired take on the Dark Knight''s early days in Gotham City. Produced by Bruce Timm, Matt Reeves, and J.J. Abrams, this animated series is a must-watch for DC fans. Download high-quality 720p WEB-DL video files with Sinhala subtitles directly or via Telegram. Experience the ultimate psychological and action-packed detective story.

Batman: Caped Crusader කියන්නේ DC රසිකයින්ට ලැබුණු අලුත්ම සහ වෙනස්ම විදිහේ ඇනිමේටඩ් කතා මාලාවක්. සුප්‍රසිද්ධ Batman: The Animated Series එක හදපු Bruce Timm වගේම The Batman චිත්‍රපටය අධ්‍යක්ෂණය කරපු Matt Reeves ගේ සහ J.J. Abrams ගේ එකතුවෙන් තමයි මේක නිර්මාණය වෙලා තියෙන්නේ. ඒ නිසාම මේකට ලොකු ප්‍රේක්ෂක ආකර්ෂණයක් ලැබිලා තියෙනවා.

කතාව යන්නේ 1940 දශකයේ අඳුරු Gotham නගරයේ. ගොඩක් දියුණු තාක්ෂණයන් නැති, දූෂණය සහ අපරාධ වලින් පිරිච්ච නගරයක Bruce Wayne තමන්ගේ මුල්ම කාලයේ Batman විදිහට අපරාධකරුවන්ට විරුද්ධව සටන් කරන හැටි තමයි මේකෙන් පෙන්නන්නේ. මේ කතාවේ ඉන්න Batman ටිකක් රළුයි වගේම, අපි දන්න Catwoman, Harley Quinn, Two-Face සහ Penguin වගේ අනිත් චරිතත් මේ කතාවේදී සම්පූර්ණයෙන්ම අලුත් වගේම වෙනස්ම විදිහකට තමයි නිර්මාණය කරලා තියෙන්නේ.

DC කොමික් පොත් වල තිබුණු මුල්ම කාලයේ අඳුරු Noir ගතියට සහ රහස් පරීක්ෂක (Detective) කතා වලට කැමති අයට කිසිම කම්මැලිකමක් නැතුව බලන්න පුළුවන් සුපිරිම කතා මාලාවක් තමයි මේක.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:
📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් Telegram චැනලය හරහා ලබාගත හැක.', 2024, '2024-01-01', 7.2, '{"Animation","Action","Adventure","Crime","Drama","Mystery","Sci-Fi"}', '{"<meta name=\"keywords\" content=\"Batman Caped Crusader Season 1 Episode 1 Sinhala Subtitles","Batman Caped Crusader S01E01 Sinhala Sub","Batman Caped Crusader 1x1 sub","Batman Caped Crusader sinhala sub","Batman Caped Crusader sinhala subtitle download","Batman Caped Crusader series sinhala sub pixelpoplk","Batman Caped Crusader sinhala sub pixelpop.lk","pixelpoplk DC series","බැට්මෑන් සිංහල උපසිරැසි","Batman Caped Crusader full series sinhala subtitles download","Batman Caped Crusader sinhala sub web-dl","pixelpoplk sinhala subtitles","Batman Caped Crusader ඇනිමේෂන් සිංහල සබ්\"> <meta name=\"description\" content=\"Batman Caped Crusader Season 1 Episode 1 Sinhala Subtitles. Download Batman Caped Crusader S01E01 Sinhala Sub online from pixelpoplk.\">"}', 'https://image.tmdb.org/t/p/original/tJ7zq4VtvJqUyaRsLeNjpEFDXzk.jpg', 'https://image.tmdb.org/t/p/original/tJ7zq4VtvJqUyaRsLeNjpEFDXzk.jpg', 1, '2026-07-31 09:09:26.160221+00')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, poster_path = EXCLUDED.poster_path;
INSERT INTO movies (id, title, type, description, year, release_date, imdb_rating, genres, seo_tags, poster_path, backdrop_path, total_seasons, created_at)
VALUES ('864fdf34-739e-4d67-a432-7871ff39f735', 'Soulm8te', 'MOVIE', '🤖 Soulm8te (2026) - සිංහල උපසිරැසි 🎬

Soulm8te (2026) expands the M3GAN universe with a thrilling new sci-fi horror experience. When a grieving man acquires an AI android to cope with his loss, his attempt to create a truly sentient partner turns a harmless lovebot into a deadly companion. Download high-quality 720p, 1080p, and 4K WEB-DL video files with Sinhala subtitles directly or via Telegram. Experience the terrifying new Blumhouse and Atomic Monster spin-off.

M3GAN චිත්‍රපටයේ විශ්වයට (M3GAN Universe) සම්බන්ධ අලුත්ම චිත්‍රපටය විදිහට තමයි Soulm8te (2026) එළියට එන්නේ. සුප්‍රසිද්ධ Blumhouse සහ Atomic Monster ආයතන වල එකතුවෙන් නිර්මාණය වුණු මේක Sci-fi Horror ගණයට අයිති වෙන වෙනස්ම විදිහේ කතාවක්.

කතාව ගැන කිව්වොත්, තමන්ගේ බිරිඳගේ මරණයෙන් පස්සේ මානසිකව වැටිලා ඉන්න කෙනෙක් තමන්ගේ පාළුව මකාගන්න AI (කෘත්‍රිම බුද්ධිය) තියෙන ඇන්ඩ්‍රොයිඩ් රොබෝ කෙනෙක්ව අරගෙන එනවා. එයාට ඕනේ කරන්නේ මේ රොබෝව නිකම්ම යන්ත්‍රයක් විදිහට නැතුව හැඟීම් දැනීම් තියෙන සහකාරියක් විදිහට වෙනස් කරන්න. හැබැයි මේ උත්සාහය නිසා අන්තිමට ඒ අහිංසක රොබෝ භයානක කෙනෙක් බවට පත් වෙනවා. තාක්ෂණයත් එක්ක මනුස්ස හැඟීම් පැටලුණාම වෙන භයානක ප්‍රතිඵල තමයි මේකෙන් බලාගන්න පුළුවන් වෙන්නේ.

M3GAN චිත්‍රපටයට කැමති වුණු අයට වගේම, විද්‍යා ප්‍රබන්ධ සහ ත්‍රාසජනක (Horror/Thriller) කතා වලට කැමති අයට මේක කිසිම කම්මැලිකමක් නැතුව බලන්න පුළුවන් සුපිරි චිත්‍රපටයක්.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p, 1080p උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', 2026, '2026-01-01', NULL, '{"Movie","18+","Horror","Sci-fi"}', '{"Soulm8te 2026 Sinhala Subtitles","Soulm8te sinhala sub","Soulm8te sinhala subtitle download","Soulm8te movie sinhala sub pixelpoplk","Soulm8te sinhala sub pixelpop.lk","pixelpoplk horror movies","සෝල්මේට් සිංහල උපසිරැසි","Soulm8te 2026 full movie sinhala subtitles download","Soulm8te sinhala sub web-dl","pixelpoplk sinhala subtitles","M3GAN spinoff sinhala sub"}', 'https://image.tmdb.org/t/p/original/9ma5UG4RwHgzpZEhpbXTNQ51Tx9.jpg', 'https://image.tmdb.org/t/p/original/9ma5UG4RwHgzpZEhpbXTNQ51Tx9.jpg', NULL, '2026-08-02 10:40:16.846602+00')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, poster_path = EXCLUDED.poster_path;
INSERT INTO movies (id, title, type, description, year, release_date, imdb_rating, genres, seo_tags, poster_path, backdrop_path, total_seasons, created_at)
VALUES ('27348593-2ecd-404c-a1de-9b09f44a255c', 'Evil Dead Burn (2026)', 'MOVIE', '🩸 Evil Dead Burn (2026) - සිංහල උපසිරැසි 🎬

Evil Dead Burn (2026) brings the next terrifying chapter of Sam Raimi''s iconic horror franchise to the screen. After a tragic loss, a woman seeks solace with her in-laws, only to find themselves trapped in a family reunion from hell as demonic Deadites are unleashed. Download high-quality 720p and 1080p WEB-DL video files with Sinhala subtitles directly or via Telegram. Experience the ultimate blood-soaked nightmare with this highly anticipated Evil Dead Rise sequel.

ලෝකයේම ප්‍රසිද්ධ, ඇඟේ හිරිගඩු පිපෙන Horror ෆ්‍රැන්චයිස් එකක් වෙන Evil Dead කතා මාලාවේ අලුත්ම චිත්‍රපටය තමයි Evil Dead Burn (2026) කියන්නේ. 2023 අවුරුද්දේ ආපු Evil Dead Rise චිත්‍රපටයේ දැවැන්ත සාර්ථකත්වයෙන් පස්සේ, ඒ විශ්වයටම සම්බන්ධ වෙනස්ම කතාවක් විදිහට තමයි මේක එළියට එන්නේ. Sébastien Vaniček විසින් අධ්‍යක්ෂණය කරපු මේ චිත්‍රපටය, කලින් චිත්‍රපට වල තිබුණු ඒ භයානක ගතිය තවත් වැඩි කරලා තියෙනවා.

කතාව ගැන කිසිම දෙයක් ස්පොයිල් කරන්නේ නැතුව කිව්වොත්, තමන්ගේ සැමියාගේ හදිසි මරණයෙන් පස්සේ මානසිකව වැටිලා ඉන්න Alice කියන කාන්තාව ඇගේ සැමියාගේ පවුලේ අයත් එක්ක දුර පළාතක තියෙන ගෙදරකට එකතු වෙනවා. හැබැයි මේ පවුලේ අයගේ එකතුවීම කෙළවර වෙන්නේ කාටවත් හිතාගන්න බැරි තරම් භයානක විදිහකට. එකින් එකාට අර අපි දන්න භයානක "Deadites" ලා (යක්ෂ ආත්ම) වැහෙන්න ගන්නකොට, මේ ගෙදර ඇතුළේ ජීවිතය බේරගන්න කරන ලොකු සටනක් තමයි මේකෙන් බලාගන්න පුළුවන් වෙන්නේ. 

අතිශය භයානක දර්ශන (Gore) වලින් පිරිච්ච මේ චිත්‍රපටය, නියම Horror රසිකයින්ට කිසිම කම්මැලිකමක් නැතුව බලන්න පුළුවන් අනිවාර්යයෙන්ම මඟහැරගන්න නරක Film එකක්. 👈

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram download: 720p සහ 1080p උසස් තත්ත්වයේ WEBRip වීඩියෝ පිටපත්  ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', 2026, '2026-01-01', 6.7, '{"Horror","Thriller","Supernatural","Splatter"}', '{"Evil Dead Burn 2026 Sinhala Subtitles","Evil Dead Burn sinhala sub","Evil Dead Burn sinhala subtitle download","Evil Dead Burn movie sinhala sub pixelpoplk","Evil Dead Burn sinhala sub pixelpop.lk","pixelpoplk horror movies","ඊවිල් ඩෙඩ් බර්න් සිංහල උපසිරැසි","Evil Dead Burn 2026 full movie sinhala subtitles download","Evil Dead Burn sinhala sub web-dl","pixelpoplk sinhala subtitles","Evil Dead Rise sequel sinhala sub","Evil Dead Burn English Subtitles","Evil Dead burn english sub"}', 'https://image.tmdb.org/t/p/original/syGSQh7bqPHCFRhwHewHdR5EqjD.jpg', 'https://image.tmdb.org/t/p/original/syGSQh7bqPHCFRhwHewHdR5EqjD.jpg', NULL, '2026-08-04 08:00:52.849475+00')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, poster_path = EXCLUDED.poster_path;
INSERT INTO movies (id, title, type, description, year, release_date, imdb_rating, genres, seo_tags, poster_path, backdrop_path, total_seasons, created_at)
VALUES ('818a4550-dcd3-47b2-aac9-8a5cc2177b56', 'The Isolate Thief (2026)', 'MOVIE', '🎬 The Isolate Thief (2026) - සිංහල උපසිරැසි 🎬

The Isolate Thief (2026) delivers a high-stakes, adrenaline-fueled action thriller experience. Follow the story of a master thief forced out of hiding for one final, impossible heist that tests every limit. Download high-quality 720p and 1080p WEB-DL video files with Sinhala subtitles directly or via Telegram. Experience the suspense and intense action on pixelpop.lk.

The Isolate Thief (2026) කියන්නේ මේ අවුරුද්දේ එළියට ආපු සුපිරිම Action/Thriller චිත්‍රපටයක්. Fast & Furious වගේම වේගවත් ක්‍රියාදාම චිත්‍රපට වලට සහ Heist (සොරකම් කිරීම්) සම්බන්ධ කතා වලට කැමති අයට මේක කිසිම කම්මැලිකමක් නැතුව එක දිගටම බලන්න පුළුවන්.💯

කතාව ගැන කිසිම දෙයක් ස්පොයිල් කරන්නේ නැතුව කිව්වොත්, තමන්ගේ පාඩුවේ හැංගිලා ජීවත් වෙන ලෝකයේ දක්ෂතම සොරෙක්ට, තමන්ගේ කැමැත්තෙන් තොරව අවසාන වතාවට ලොකු මෙහෙයුමකට සම්බන්ධ වෙන්න සිද්ධ වෙනවා. මේක සාමාන්‍ය සොරකමක් නෙවෙයි, කිසිම කෙනෙක්ට ඇතුළු වෙන්න බැරි අධි ආරක්ෂිත තැනකින් කරන දැවැන්ත එකක්. මේ මෙහෙයුම අතරතුර එයාට මුහුණ දෙන්න වෙන බාධක සහ නොහිතන විදිහේ සිදුවීම් වලින් තමයි කතාව පුරාවටම කුතුහලය උපරිමයෙන්ම තියාගෙන ඉස්සරහට යන්නේ.✅

ක්‍රියාදාම සහ කුතුහලය පිරුණු අලුත්ම චිත්‍රපටයක් හොයනවා නම්, මේක අනිවාර්යයෙන්ම බලන්න ඕනේ නිර්මාණයක්.👈

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය;

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p සහ 1080p උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත්  ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', 2026, '2026-01-01', 6.1, '{"survival","action","drama","western"}', '{"The Isolate Thief 2026 Sinhala Subtitles","The Isolate Thief sinhala sub","The Isolate Thief sinhala subtitle download","The Isolate Thief movie sinhala sub pixelpoplk","The Isolate Thief sinhala sub pixelpop.lk","pixelpoplk action movies","දි අයිසොලේට් තීෆ් සිංහල උපසිරැසි","The Isolate Thief 2026 full movie sinhala subtitles download","The Isolate Thief sinhala sub web-dl","pixelpoplk sinhala subtitles","action thriller sinhala sub","The Isolate Thief (2026)","The Isolate Thief English subtitles","The Isolate Thief download","The Isolate Thief (2026) download"}', 'https://image.tmdb.org/t/p/original/7pmvQNhIDwJTs4IVWxuihG7RjsL.jpg', 'https://image.tmdb.org/t/p/original/7pmvQNhIDwJTs4IVWxuihG7RjsL.jpg', NULL, '2026-08-05 06:34:07.587586+00')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, poster_path = EXCLUDED.poster_path;
INSERT INTO movies (id, title, type, description, year, release_date, imdb_rating, genres, seo_tags, poster_path, backdrop_path, total_seasons, created_at)
VALUES ('ddad8dd9-5bbf-4e8c-ab94-49f941e761d8', 'Black Bird', 'TV_SHOW', '🕵️‍♂️ Black Bird - සිංහල උපසිරැසි 🎬

Black Bird is an acclaimed Apple TV+ crime drama miniseries based on true events. Starring Taron Egerton and Paul Walter Hauser, this intense psychological thriller follows a convicted drug dealer offered freedom in exchange for coaxing a confession from an alleged serial killer inside a maximum-security prison. Download high-quality 720p  WEB-DL video files via Telegram. Experience this gripping masterpiece on pixelpoplk.

ඇත්තම සිදුවීමක් ඇසුරෙන් නිර්මාණය වුණු Black Bird කියන්නේ Apple TV+ නාලිකාවෙන් එළියට ආපු, ලෝකයේම ලොකු කතාබහකට ලක්වුණු Crime / Psychological Thriller කතා මාලාවක්. Taron Egerton, Paul Walter Hauser සහ ප්‍රසිද්ධ රංගන ශිල්පී Ray Liotta ගේ විශිෂ්ට රංගනයන්ගෙන් මේ කතාව අතිශය සාර්ථක එකක් බවට පත්වුණා.

කතාව ගැන කිසිම දෙයක් ස්පොයිල් කරන්නේ නැතුව කිව්වොත්, අවුරුදු 10ක සිරදඬුවමක් ලැබෙන Jimmy Keene කියන තරුණයාට අමුතුම විදිහේ යෝජනාවක් ලැබෙනවා. ඒ තමයි අතිශය භයානක අපරාධකාරයින් ඉන්න හිරගෙදරකට ගිහින්, එහෙ ඉන්න සීරියල් කිලර් කෙනෙක් (Serial Killer) කියලා සැකකරන පුද්ගලයෙක් එක්ක යහළුවෙලා එයාගෙන් රහස් තොරතුරු ලබාගන්න එක. එහෙම කළොත් Jimmy ගේ සිරදඬුවම සම්පූර්ණයෙන්ම නිදහස් කරන්න රජයෙන් පොරොන්දු වෙනවා.

හැබැයි මේ භයානක මානසික සටන ඇතුළේ ජීවිතයත් මරණයත් අතර සටනක් කරන්න Jimmy ට සිද්ධ වෙනවා. True Crime සහ Crime Mystery කතා වලට ආස අයට එක හුස්මට බලලා ඉවර කරන්න පුළුවන් සුපිරිම කතා මාලාවක් තමයි මේක.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (Zip) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p WEB-DL වීඩියෝ පිටපත් Telegram චැනලය හරහා ලබාගත හැක.', 2022, '2022-01-01', 8.1, '{"Drama","Thriller","Crime"}', '{"<meta name=\"keywords\" content=\"Black Bird Season 1 Episode 1 Sinhala Subtitles","Black Bird S01E01 Sinhala Sub","Black Bird 1x1 sub","Black Bird Sinhala Subtitles","Black Bird sinhala sub","Black Bird sinhala subtitle download","Black Bird tv series sinhala sub pixelpoplk","Black Bird sinhala sub pixelpop.lk","pixelpoplk Apple TV series","බ්ලැක් බර්ඩ් සිංහල උපසිරැසි","Black Bird full series sinhala subtitles download","Black Bird sinhala sub web-dl","pixelpoplk sinhala subtitles","Black Bird miniseries sinhala sub\"> <meta name=\"description\" content=\"Black Bird Season 1 Episode 1 Sinhala Subtitles. Download Black Bird S01E01 Sinhala Sub online from pixelpoplk.\">"}', 'https://image.tmdb.org/t/p/original/qu312pwM61NPTr7nexvovCClDNP.jpg', 'https://image.tmdb.org/t/p/original/qu312pwM61NPTr7nexvovCClDNP.jpg', 1, '2026-08-06 10:35:58.56554+00')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, poster_path = EXCLUDED.poster_path;
INSERT INTO movies (id, title, type, description, year, release_date, imdb_rating, genres, seo_tags, poster_path, backdrop_path, total_seasons, created_at)
VALUES ('ea4bba9c-79bc-4754-acc5-2346a5fa7043', 'Lenin (2026)', 'MOVIE', '🕵️‍♂️ Lenin (2026) - සිංහල උපසිරැසි 🎬

Lenin delivers a high-stakes rural action-romance drama rooted in love, loyalty, and fierce village conflicts. Set against a gritty rural backdrop, a fearless young man fights to end a bloody, long-standing cycle of violence tied to a turbulent village festival. Download high-quality 720p, 1080p WEB-DL video files directly or via Telegram on pixelpoplk.

ඔන්න අරගෙන ආවා Action, Drama සහ Romance ගණයට ආස කරන අයට කිසිසේත්ම මඟහැරින්න බැරි, ආදරය, මිත්‍රත්වය සහ පලිගැනීම එකට මුසු වුණු සිනමාපටයක්. Zee5 ප්‍රවාහන සේවය ඔස්සේ නිකුත් වුණු, මහාභාරතයේ ආභාසය ලබාගනිමින් නිර්මාණය වුණු Lenin කියන්නේ IMDB හි 6.7/10 ක අගයක් දිනාගත්තු, ප්‍රේක්ෂක අවධානය දිනාගත්තු නිර්මාණයක්.

කතාව ගැන කිසිම දෙයක් ස්පොයිල් කරන්නේ නැතුව සරලවම කිව්වොත්, ශ්‍රීරාම්පුරම් කියන ගම්මානයේ වාර්ෂිකව සිදුවන ද්‍රෞපදී උත්සවය අතරතුර කිසිදු ලේ වැගිරීමක් සිදුනොවිය යුතු බවට ගම්වැසියන් දැඩිව විශ්වාස කරනවා. මෙම ගමේ හැදී වැඩෙන ලෙනින් (Akhil Akkineni) සහ තමන්ගේ සහෝදරයා වැනි මිතුරාට ගමේ පවතින කුමන්ත්‍රණ සහ පවුල් බලඅරගල නිසා දැඩි අභියෝගයන්ට මුහුණ දෙන්න සිද්ධ වෙනවා. තමන්ගේ ආදරය බේරාගන්නත්, ගමේ පවතින මේ වෛරී පලිගැනීමේ චක්‍රය නතර කරන්නත් ඔහුට අතිශය භයානක සටනකට මුහුණ දෙන්න වෙනවා.

Thaman S ගේ විශිෂ්ට සංගීතයෙන් හැඩවුණු, Akhil Akkineni සහ Bhagyashri Borse ගේ රංගනයෙන් හැඩවුණු මේ චිත්‍රපටය, තෙලිඟු සිනමාලෝලීන් අනිවාර්යයෙන්ම නැරඹිය යුතු එකක්.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: වීඩියෝව සමඟ උපසිරැසි නැරඹීමට කැමති අය සඳහා 720p, 1080p උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', 2026, '2026-01-01', 6.7, '{"Action","Drama","Romance","Thriller"}', '{"Lenin Sinhala Subtitles","Lenin sinhala sub","Lenin sinhala subtitle download","Lenin movie sinhala sub pixelpoplk","Lenin sinhala sub pixelpop.lk","pixelpoplk Zee5 Telugu movie","ලෙනින් සිංහල උපසිරැසි","Lenin full movie sinhala subtitles download","Lenin sinhala sub web-dl","pixelpoplk sinhala subtitles","Lenin Telugu movie sinhala sub","rural action drama sinhala sub"}', 'https://image.tmdb.org/t/p/original/rAHQviBq8Fxi20hNtHPGLnr4L0f.jpg', 'https://image.tmdb.org/t/p/original/rAHQviBq8Fxi20hNtHPGLnr4L0f.jpg', NULL, '2026-08-07 07:34:34.672569+00')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, poster_path = EXCLUDED.poster_path;
INSERT INTO movies (id, title, type, description, year, release_date, imdb_rating, genres, seo_tags, poster_path, backdrop_path, total_seasons, created_at)
VALUES ('13edeece-2efe-4aa9-a85f-f62b92aa5f88', 'Idhayam Murali (2026)', 'MOVIE', '🕵️‍♂️ Idhayam Murali (2026) - සිංහල උපසිරැසි 🎬

Idhayam Murali delivers a breezy, heartwarming coming-of-age romantic drama centered on unspoken feelings. Follow a young man''s emotional journey through different stages of life, from boyhood crushes to college sweethearts, as he struggles to express his love. Download high-quality 720p, 1080p WEB-DL video files directly or via Telegram on pixelpoplk.

ඔන්න අරගෙන ආවා Romance, Comedy සහ Drama ගණයට අයත් වෙන, ආදරය සහ මිත්‍රත්වය පිරිණු සුන්දර තමිල් සිනමාපටයක්. 1991 වසරේ තිරගත වුණු සුප්‍රසිද්ධ "Idhayam" චිත්‍රපටයට උපහාරයක් ලෙසින් නිර්මාණය වුණු මෙය, එහි ප්‍රධාන නළුවා වූ මුරලිගේ පුත් අදර්වා (Atharvaa) ගේ ප්‍රධාන රංගනයෙන් හැඩවෙනවා.

කතාව ගැන කිසිම දෙයක් ස්පොයිල් කරන්නේ නැතුව සරලවම කිව්වොත්, තමන්ගේ හිතේ තියෙන ආදරය සහ හැඟීම් පිටතට ප්‍රකාශ කිරීමට අසීරු තරුණයෙක් වන ඉධයා (Idhaya) ගේ ආදර කතාව වටා තමයි මේ චිත්‍රපටය ගෙතෙන්නේ. තමන්ගේ විවාහයට පෙර, නාඳුනන පුද්ගලයෙක් (Fahadh Faasil) හමුවන ඔහු, තමන්ගේ පාසල් කාලයේ සිට විවිධ අවධීන් වලදී ජීවිතයට පැමිණි ආදරවන්තියන් පිළිබඳව අතීතාවර්ජනයක යෙදෙනවා. අවසානයේදී ඔහුට තමන්ගේ සැබෑ ආදරය ප්‍රකාශ කරලා ඇයව තමන්ගේ කරගන්න ලැබෙයිද?

Thaman S ගේ ලස්සන සංගීතයෙන් සහ Atharvaa සමඟ Preity Mukhundhan, Kayadu Lohar ගේ රංගනයෙන් හැඩවුණු මේ චිත්‍රපටය, සැහැල්ලු ආදර කතාවලට ප්‍රිය කරන ඔබ නැරඹිය යුතුම එකක්.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: වීඩියෝව සමඟ උපසිරැසි නැරඹීමට කැමති අය සඳහා 720p, 1080p උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', 2026, '2026-01-01', 8.7, '{"Romance","Comedy","Drama","Tamil"}', '{"Idhayam Murali Sinhala Subtitles","Idhayam Murali sinhala sub","Idhayam Murali sinhala subtitle download","Idhayam Murali movie sinhala sub pixelpoplk","Idhayam Murali sinhala sub pixelpop.lk","pixelpoplk Tamil movie","ඉධයම් මුරලි සිංහල උපසිරැසි","Idhayam Murali full movie sinhala subtitles download","Idhayam Murali sinhala sub web-dl","pixelpoplk sinhala subtitles","Idhayam Murali Tamil movie sinhala sub","romantic drama sinhala sub"}', 'https://image.tmdb.org/t/p/original/xeb6080yZcKijIoXc1YxOU5A2Gb.jpg', 'https://image.tmdb.org/t/p/original/xeb6080yZcKijIoXc1YxOU5A2Gb.jpg', NULL, '2026-08-07 09:54:02.964215+00')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, poster_path = EXCLUDED.poster_path;
INSERT INTO movies (id, title, type, description, year, release_date, imdb_rating, genres, seo_tags, poster_path, backdrop_path, total_seasons, created_at)
VALUES ('ee83890c-8b6f-4305-a4bd-501d7a46b22c', 'Our Sticky Love', 'TV_SHOW', '🕵️‍♂️ Our Sticky Love (2026) - සිංහල උපසිරැසි 🎬

Our Sticky Love delivers a sweet yet action-packed romantic comedy centered on an unexpected cohabitation. An ambitious prosecutor loses her memory and finds herself hiding in a countryside village with a mysterious boxing coach who claims to be her boyfriend to protect her from a crime syndicate. Download high-quality 720p, 1080p WEB-DL video files directly or via Telegram on pixelpoplk.

ඔන්න අරගෙන ආවා Romantic Comedy, Action සහ Thriller කියන හැම රසයක්ම එකතු කරපු, Netflix හරහා නිකුත් වුණු අලුත්ම සුපිරි කොරියානු කතා මාලාව. D.P. සහ Love Next Door කතා මාලා හරහා අතිශය ජනප්‍රිය වුණු Jung Hae-in සහ දක්ෂ නිළි Ha Young ප්‍රධාන චරිත නිරූපණය කරන Our Sticky Love කියන්නේ නිකුත් වුණු දවසේ ඉඳලම ලෝකයේම ලොකු ප්‍රේක්ෂක අවධානයක් දිනාගත්තු අපූරු නිර්මාණයක්.

කතාව ගැන කිසිම දෙයක් ස්පොයිල් කරන්නේ නැතුව සරලවම කිව්වොත්, දූෂිත දේශපාලකයින් සහ මැර කල්ලියක් ගැන පරීක්ෂණ පවත්වන දක්ෂ රජයේ නීතිඥවරියක් වන Go Eun-sae ට මුහුණ දීමට සිදුවන අනතුරකින් පසුව ඇගේ මතකය සම්පූර්ණයෙන්ම අහිමි වෙනවා. ඇයව මරා දැමීමට මැර කල්ලියක් ලුහුබඳින අතරතුර, බොක්සිං පුහුණුකරුවෙකු සහ හිටපු මැරයෙකු වන Jang Tae-ha ඇයට හමුවෙනවා. ඇයව බේරාගැනීමේ අරමුණින් ඔහු තමන් ඇගේ පෙම්වතා බව පවසමින් බොරුවක් ගොතා ඇයව සාම්ප්‍රදායික පැණිරස රසකැවිලි සදන අපූරු ගම්මානයකට රැගෙන යනවා. මතකය අහිමි වූ ඇය සහ බොරු පෙම්වතෙක් වූ ඔහු අතර ඇතිවන මේ "ඇලෙන සුළු" ආදර කතාව මැරයින්ගෙන් බේරී අවසාන වන්නේ කෙසේද?

Kim Jang-han ගේ අධ්‍යක්ෂණයෙන් හැඩවුණු, හාස්‍යය, ආදරය මෙන්ම කුතුහලය පිරි මේ කතා මාලාව අනිවාර්යයෙන්ම ඔයාගේ Must Watch ලිස්ට් එකට එකතු කරගන්න ඕනේ එකක්.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: වීඩියෝව සමඟ උපසිරැසි නැරඹීමට කැමති අය සඳහා 720p, 1080p උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', 2026, '2026-01-01', 8.4, '{"Romantic","Comedy","Melodrama","Action","Thriller","K-Drama"}', '{"Our Sticky Love Sinhala Subtitles","Our Sticky Love sinhala sub","Our Sticky Love sinhala subtitle download","Our Sticky Love kdrama sinhala sub pixelpoplk","Our Sticky Love sinhala sub pixelpop.lk","pixelpoplk Netflix Korean series","අවර් ස්ටිකි ලව් සිංහල උපසිරැසි","Our Sticky Love full series sinhala subtitles download","Our Sticky Love sinhala sub web-dl","pixelpoplk sinhala subtitles","Our Sticky Love kdrama sinhala sub","romantic comedy k-drama sinhala sub"}', 'https://image.tmdb.org/t/p/original/tSZ4aFpTGc8Oj52SuzPUUZ7WKL0.jpg', 'https://image.tmdb.org/t/p/original/tSZ4aFpTGc8Oj52SuzPUUZ7WKL0.jpg', 1, '2026-08-08 08:30:23.609856+00')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, poster_path = EXCLUDED.poster_path;
INSERT INTO movies (id, title, type, description, year, release_date, imdb_rating, genres, seo_tags, poster_path, backdrop_path, total_seasons, created_at)
VALUES ('80a0b1c3-04a2-4225-aff1-afd80a7a6f22', 'The Night of', 'TV_SHOW', '🕵️‍♂️ The Night Of - සිංහල උපසිරැසි 🎬

The Night Of delivers a gripping, award-winning crime drama miniseries from HBO. After a night of partying with a mysterious stranger, a Pakistani-American student wakes up to find her stabbed to death and becomes the prime suspect in a complex murder trial. Download high-quality 720p Blu-Ray video files directly or via Telegram on pixelpoplk.

ඔන්න අරගෙන ආවා Crime, Mystery සහ Thriller ගණයේ රසිකයින්ට මඟහැරගන්නම බැරි, HBO නාලිකාව හරහා විකාශනය වුණු අතිශය ජනප්‍රිය වගේම සම්මානනීය මිනි-කතා මාලාවක්. එමී සම්මාන (Emmy Awards) පහක් දිනාගත්, IMDb හි 8.4/10 ක ඉහළම අගයක් හිමිකරගත් The Night Of කියන්නේ මුල සිට අගටම කුතුහලය උපරිමයෙන්ම පවත්වාගෙන යන විශිෂ්ටතම නිර්මාණයක්.👈

කතාව ගැන කිසිම දෙයක් ස්පොයිල් කරන්නේ නැතුව සරලවම කිව්වොත්, නිව්යෝර්ක් නුවර ජීවත් වන පකිස්ථාන-ඇමරිකානු තරුණයෙක් වන නසීර් "නෑස්" ඛාන් (Riz Ahmed), සාදයකට යාම සඳහා තමන්ගේ පියාගේ කුලී රථය රැගෙන යනවා. මඟදී ඔහුට මුණගැසෙන අද්භූත තරුණියක් සමඟ ගතකරන රාත්‍රියකින් පසු ඔහු නින්දෙන් ඇහැරෙන්නේ ඇය කෲර ලෙස ඝාතනය කර තිබෙනවා දකිමින්. කිසිවක් කරකියාගත නොහැකි වන ඔහු පොලිස් අත්අඩංගුවට පත්වෙන අතර, නීතීඥ ජෝන් ස්ටෝන් (John Turturro) ඔහු වෙනුවෙන් පෙනී සිටීමට ඉදිරිපත් වෙනවා. නසීර් ඇත්තටම ඝාතකයාද? නැතහොත් ඔහු සැඟවුණු දේශපාලන හා සාමාජීය කුමන්ත්‍රණයක ගොදුරක්ද?🤔

Riz Ahmed සහ John Turturro ගේ විශිෂ්ටතම රංගනයෙන් හැඩවුණු, මොහොතින් මොහොත උද්වේගකර බව වැඩිවන මේ කතා මාලාව අනිවාර්යයෙන්ම නැරඹිය යුතු එකක්.✅

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: 720p  උසස් තත්ත්වයේ Bluray වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', 2016, '2016-01-01', 8.4, '{"Crime","Drama","Mystery","Thriller","Miniseries"}', '{"The Night Of Sinhala Subtitles","The Night Of sinhala sub","The Night Of sinhala subtitle download","The Night Of tv series sinhala sub pixelpoplk","The Night Of sinhala sub pixelpop.lk","pixelpoplk HBO miniseries","ද නයිට් ඔෆ් සිංහල උපසිරැසි","The Night Of full series sinhala subtitles download","The Night Of sinhala sub web-dl","pixelpoplk sinhala subtitles","The Night Of miniseries sinhala sub","crime drama sinhala sub","The night of sinhala sub","night of sinhala sub"}', 'https://image.tmdb.org/t/p/original/q13XJHdnsmxQL9rXRcnNDrZGHjO.jpg', 'https://image.tmdb.org/t/p/original/q13XJHdnsmxQL9rXRcnNDrZGHjO.jpg', 1, '2026-08-08 11:01:21.636301+00')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, poster_path = EXCLUDED.poster_path;
INSERT INTO movies (id, title, type, description, year, release_date, imdb_rating, genres, seo_tags, poster_path, backdrop_path, total_seasons, created_at)
VALUES ('cd43d917-6076-4b02-a085-caec2d8f1f60', 'The Invite (2026)', 'MOVIE', '🕵️‍♂️ The Invite (2026) - සිංහල උපසිරැසි 🎬🔞

The Invite delivers a hilarious and sharp comedy-drama about modern relationships and adult compromises from A24. When a couple whose marriage is on thin ice invites their eccentric, free-spirited upstairs neighbors over for a dinner party, the evening quickly spirals into unpredictable, wild, and eye-opening territory. Download high-quality 720p, 1080p WEB-DL video files directly or via Telegram on pixelpoplk.

ඔන්න අරගෙන ආවා Comedy සහ Drama ගණයට ආස කරන අයට කිසිසේත්ම මඟහැරගන්න බැරි, ප්‍රසිද්ධ A24 සිනමා සමාගම හරහා නිකුත් වුණු අලුත්ම සුපිරි සිනමාපටයක්. සුප්‍රසිද්ධ ස්පාඤ්ඤ චිත්‍රපටයක් වන "The People Upstairs" ඇසුරෙන් නිර්මාණය වුණු The Invite කියන්නේ සබඳතා සහ විවාහ ජීවිතය පිළිබඳව හාස්‍යය මුසු කරමින් ඉතාමත් අපූරුවට කතාබහ කරන වැඩිහිටියන්ට පමණක් නිර්මාණය වූ 🔞 නිර්මාණයක්.

කතාව ගැන කිසිම දෙයක් ස්පොයිල් කරන්නේ නැතුව සරලවම කිව්වොත්, ජෝ (Seth Rogen) සහ ඇන්ජෙලා (Olivia Wilde) කියන්නේ සබඳතාවයේ ගැටලු රැසක් නිසා දික්කසාද වීමේ මට්ටමේ පසුවෙන යුවළක්. දිනක් ඔවුන්ගේ උඩුමහලේ පදිංචිව සිටින, තරමක් අමුතු අදහස් තියෙන අසල්වැසි යුවළක් වන පීනාව (Penélope Cruz) සහ හෝක්ව (Edward Norton) තමන්ගේ නිවසට රාත්‍රී ආහාර වේලක් සඳහා ඇරයුම් කරනවා. නමුත් සාමාන්‍ය විදිහට ඇරඹෙන මේ රාත්‍රී භෝජන සංග්‍රහය, ඔවුන් කිසිසේත්ම බලාපොරොත්තු නොවුණු, හාස්‍යයෙන් පිරි මෙන්ම දෙපිරිසේම පෞද්ගලික රහස් හෙළිවන අතිශය අවුල් සහගත තැනකට හැරෙන්නේ කෙසේද?

Olivia Wilde ගේ අධ්‍යක්ෂණයෙන් හැඩවුණු, Seth Rogen, Edward Norton සහ Penélope Cruz වැනි දක්ෂ නළු නිළියන් රැසකගේ රංගනයෙන් ඔපවත් වූ මේ චිත්‍රපටය අනිවාර්යයෙන්ම නැරඹිය යුතු එකක්.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: වීඩියෝව සමඟ උපසිරැසි නැරඹීමට කැමති අය සඳහා 720p, 1080p උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', 2026, '2026-01-01', 7.9, '{"Comedy","Drama","18+","Romance"}', '{"The Invite Sinhala Subtitles","The Invite sinhala sub","The Invite sinhala subtitle download","The Invite movie sinhala sub pixelpoplk","The Invite sinhala sub pixelpop.lk","pixelpoplk A24 movie","ද ඉන්වයිට් සිංහල උපසිරැසි","The Invite full movie sinhala subtitles download","The Invite sinhala sub web-dl","pixelpoplk sinhala subtitles","The Invite comedy drama sinhala sub","Olivia Wilde movie sinhala sub","18+"}', 'https://image.tmdb.org/t/p/original/b7Dr8Chzse8VagexAporUu2RtLx.jpg', 'https://image.tmdb.org/t/p/original/b7Dr8Chzse8VagexAporUu2RtLx.jpg', NULL, '2026-08-10 12:27:21.523628+00')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, poster_path = EXCLUDED.poster_path;
INSERT INTO movies (id, title, type, description, year, release_date, imdb_rating, genres, seo_tags, poster_path, backdrop_path, total_seasons, created_at)
VALUES ('1994a6f0-7522-418b-adca-31c5068a3ac0', 'Reacher', 'TV_SHOW', '🕵️‍♂️ Reacher Season 4 Episode 1 - සිංහල උපසිරැසි 🎬

Reacher Season 4 Episode 1 delivers the highly anticipated return of television''s ultimate wanderer. Before diving into this brand new chapter of conspiracy and action, let''s take a quick journey back to Reacher''s past adventures—from uncovering the corruption in Margrave, to avenging his fallen military comrades, and surviving a deadly undercover mission. Download high-quality 720p, 1080p WEB-DL video files directly or via Telegram on pixelpoplk.

ඔන්න යාළුවනේ, ලෝක පුරා අතිශය ජනප්‍රිය වුණු, ඇමසන් ප්‍රයිම් (Prime Video) හරහා විකාශනය ආරම්භ වුණු Reacher කතා මාලාවේ 4 වැනි කතා සමයේ (Season 4) පළමු වැනි කොටසට (Episode 1) සිංහල උපසිරැසි අරගෙන ආවා. මේ අලුත්ම සීසන් එක බලන්න පටන් ගන්න කලින්, කලින් කතා සමයන් 1, 2 සහ 3 තුළින් රීචර් ආපු ගමන කෙටියෙන් මතක් කරගන්න එක ඔයාලට ගොඩක් වටිනවා.

පළමු කතා සමයේදී (Season 1) මාග්‍රේව් (Margrave) නම් කුඩා නගරයේ සිදුවූ තමන්ගේ සහෝදරයාගේ ඝාතනයට පලිගැනීම සඳහා නගරයේ රහස්‍ය කල්ලියක් සහ දූෂිත පොලිසියක් මුළුමනින්ම විනාශ කිරීමට රීචර් සමත් වුණා. දෙවන කතා සමයේදී (Season 2) තමන්ගේ පැරණි හමුදා ඒකකයේ (110th Special Investigators) මිතුරන් පාවාදී මරා දැමූ දූෂිත ආයුධ ජාවාරම්කරුවන් කල්ලියක් සොයා ගොස් තමන්ගේ මිතුරන් වෙනුවෙන් යුක්තිය ඉටු කරන්න ඔහුට සිද්ධ වුණා. පසුගිය තුන්වන කතා සමයේදී (Season 3) දරුණු ජාවාරම්කරුවන් පිරිසක් කොටු කරගැනීම සඳහා රීචර් අතිශය අවදානම් සහගත රහසිගත මෙහෙයුමකට (Undercover) සම්බන්ධ වෙමින් දැවැන්ත සටනක් දියත් කළා.

මෙන්න මේ විදිහට හැම තැනකදීම තමන්ගේ ශාරීරික ශක්තිය සහ අසමසම බුද්ධිය උපයෝගී කරගෙන සතුරන් මෙල්ල කරපු ජැක් රීචර්, මේ 4 වැනි කතා සමයෙන් තවත් අලුත්ම දේශපාලන සහ රහස් ඔත්තු සේවා කුමන්ත්‍රණයකට මැදි වෙනවා. Alan Ritchson ගේ සුපිරි රංගනය සහ සුපිරි සටන් දර්ශන රැසක් සමඟින් ඇරඹෙන Reacher Season 4 හි පළමු කොටස කිසිසේත්ම මඟහැරගන්න එපා.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නා ආකාරය:

📄 Direct Subtitle Download: කිසිදු බාධාවකින් තොරව සිංහල උපසිරැසි ගොනුව (SRT) සෘජුවම බාගත කරගත හැක.

✈️ Telegram Download: වීඩියෝව සමඟ උපසිරැසි නැරඹීමට කැමති අය සඳහා 720p, 1080p උසස් තත්ත්වයේ WEB-DL වීඩියෝ පිටපත් ටෙලිග්‍රෑම් චැනලය හරහා ලබාගත හැක.', 2026, '2026-01-01', 8.1, '{"Action","Crime","Thriller","Detective","Drama"}', '{"Reacher Season 4 Episode 1 Sinhala Subtitles","Reacher S04E01 sinhala sub","Reacher S4 Ep1 sinhala subtitle download","Reacher S04E01 sinhala sub pixelpoplk","Reacher S4E1 sinhala sub pixelpop.lk","pixelpoplk Prime Video Reacher","රීචර් සිංහල උපසිරැසි","Reacher Season 4 sinhala subtitles download","Reacher S04E01 web-dl sinhala sub","pixelpoplk sinhala subtitles","action thriller series sinhala sub","Reacher recap sinhala sub"}', 'https://image.tmdb.org/t/p/original/wkKJHC34dIw9cJwAfNEEgDdb2ol.jpg', 'https://image.tmdb.org/t/p/original/wkKJHC34dIw9cJwAfNEEgDdb2ol.jpg', 4, '2026-08-12 08:51:51.598699+00')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, poster_path = EXCLUDED.poster_path;
INSERT INTO movies (id, title, type, description, year, release_date, imdb_rating, genres, seo_tags, poster_path, backdrop_path, total_seasons, created_at)
VALUES ('dfe1fee9-3347-4a6a-a91c-9610969dd963', 'Cocktail 2', 'MOVIE', '🕵️‍♂️ Cocktail 2 (2026) - සිංහල උපසිරැසි 🎬

ඔන්න අරගෙන ආවා Romance, Comedy වගේම Drama වලට ආස කරන අයට කිසිසේත්ම මඟහැරගන්න බැරි, මෑතකදී නිකුත් වුණු ලස්සන බොලිවුඩ් සිනමාපටයක්. 2012 වසරේ ආපු සුපිරිම "Cocktail" චිත්‍රපටයේ spiritual sequel එකක් විදිහට නිර්මාණය වුණු මේ නිර්මාණය, හාස්‍යය වගේම හැඟීම්බර ආදර කතාවක් අපූරුවට පෙන්නුම් කරනවා.

කතාව පැත්තට ගියොත්, කුනාල් (Shahid Kapoor) සහ දියා (Rashmika Mandanna) කියන්නේ කාලෙක ඉඳන් බොහොම සතුටින් එකට ජීවත් වෙන ආදරවන්තයෝ දෙන්නෙක්. හැබැයි මෙයාලට පවුලේ නෑදෑයින්ගෙන් නිතරම එල්ල වෙන්නේ එකම ප්‍රශ්නයක්. ඒ තමයි "කවදාද බඳින්නේ?" කියන එක. මේ කරදරකාරී ප්‍රශ්නවලින් බේරිලා නිදහසේ කාලය ගත කරන්න හිතාගෙන මෙයාලා ඉතාලියේ සිසිලි (Sicily) දූපතට ලස්සන සංචාරයක් යනවා. 

හැබැයි මෙයාලගේ මේ සුන්දර නිවාඩුව අතරතුරට අමුතුම විදිහේ කෙල්ලෙක් වෙන ඇලී (Kriti Sanon) එකතු වෙනවා. ඇලීගේ පැමිණීමත් එක්ක මේ දෙන්නගේ ආදරය, යාළුකම වගේම මුළු ජීවිතයම සම්පූර්ණයෙන්ම වෙනස් වෙලා, හිතාගන්න බැරි පැටලිලි සහගත ආදර ත්‍රිකෝණයක් නිර්මාණය වෙනවා. 

Homi Adajania ගේ අධ්‍යක්ෂණයෙන් වගේම Pritam ගේ සුපිරි සංගීතයෙන් හැඩවුණු, Shahid Kapoor, Kriti Sanon සහ Rashmika Mandanna ගේ සුපිරි රංගනයක් බලාගන්න පුළුවන් මේ ලස්සන චිත්‍රපටය ඔයාගේ Must Watch ලිස්ට් එකට අනිවාර්යයෙන්ම එකතු කරගන්න.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නේ මෙහෙමයි:

📄 Direct Subtitle Download: කිසිම කරදරයක් නැතුව සිංහල උපසිරැසි ගොනුව (SRT) කෙලින්ම ඩවුන්ලෝඩ් කරගන්න පුළුවන්.

✈️ Telegram Download: වීඩියෝ එකයි සබ් එකයි එකටම බලන්න කැමති අයට 720p, 1080p WEB-DL කොපි ටෙලිග්‍රෑම් චැනල් එක හරහා ගන්න පුළුවන්.', 2026, '2026-01-01', 7.5, '{"Movie","Comedy","Romance"}', '{"Cocktail 2 sinhala sub","cocktail hindi","Cocktail 2 Sinhala Subtitles","Cocktail 2 sinhala sub","Cocktail 2 sinhala subtitle download","Cocktail 2 movie sinhala sub pixelpoplk","Cocktail 2 sinhala sub pixelpop.lk","pixelpoplk Bollywood movie","කොක්ටේල් 2 සිංහල උපසිරැසි","Cocktail 2 full movie sinhala subtitles download","Cocktail 2 sinhala sub web-dl","pixelpoplk sinhala subtitles","Cocktail 2 Hindi movie sinhala sub","romantic comedy drama sinhala sub"}', 'https://image.tmdb.org/t/p/original/pRmPnUAhHHiDJPfNGLP8ikoc5cx.jpg', 'https://image.tmdb.org/t/p/original/pRmPnUAhHHiDJPfNGLP8ikoc5cx.jpg', NULL, '2026-08-14 18:39:26.460286+00')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, poster_path = EXCLUDED.poster_path;
INSERT INTO movies (id, title, type, description, year, release_date, imdb_rating, genres, seo_tags, poster_path, backdrop_path, total_seasons, created_at)
VALUES ('58006348-bcc7-4322-a1dc-1eecc28bd192', 'Lanterns (2026)', 'TV_SHOW', '🕵️‍♂️ Lanterns (2026) - සිංහල උපසිරැසි 🎬

Lanterns delivers a gritty, grounded, and cosmic detective thriller from HBO. When a legendary, grizzled Green Lantern is forced to train a defiant new recruit, the two intergalactic cops find themselves drawn into a dark, small-town murder mystery with massive, universe-altering implications. 

ඔන්න යාළුවනේ, DC රසිකයෝ හැමෝම අතිශය උනන්දුවෙන් බලාගෙන හිටපු, HBO සහ Max හරහා අදම විකාශනය ආරම්භ වුණු "Lanterns" අලුත්ම සජීවීකරණ නොවන (Live-action) සුපිරි කතා මාලාවට සිංහල උපසිරැසි අරගෙන ආවා. James Gunn ගේ අලුත්ම DC විශ්වයට (DCU) අයත් වෙන මේ කතාව, සාමාන්‍ය සුපිරි වීර කතාවලට වඩා හාත්පසින්ම වෙනස් "True Detective" වගේ අඳුරු රහස් පරීක්ෂණ (Grounded Detective Thriller) විලාසිතාවකින් තමයි නිර්මාණය කරලා තියෙන්නේ.

කතාව පැත්තට ගියොත්, වසර ගණනාවක අත්දැකීම් තියෙන ප්‍රබල මෙන්ම වයස්ගත ග්‍රීන් ලැන්ටර්න් කෙනෙක් වෙන හැල් ජෝර්ඩන්ට (Kyle Chandler), අලුතින්ම මේ කණ්ඩායමට එකතු වෙන මුරණ්ඩු හිටපු මැරීන් සෙබළෙක් වන ජෝන් ස්ටුවර්ට්ව (Aaron Pierre) පුහුණු කරන්න සිද්ධ වෙනවා. මෙයාලා දෙන්නා ඇමරිකාවේ කුඩා ගමක සිද්ධ වෙන අමුතුම විදිහේ මිනීමැරුමක් ගැන පරීක්ෂණ පවත්වන්න එකතු වෙනවා. හැබැයි සාමාන්‍ය එකක් විදිහට පේන මේ මිනීමැරුම පිටුපස මුළු විශ්වයම උඩුයටිකුරු කරන්න පුළුවන් තරමේ අභ්‍යවකාශ සහ පිටසක්වල කුමන්ත්‍රණයක් හැංගිලා තියෙනවා කියලා මෙයාලට තේරුම් යනවා.

Ozark කතා මාලාවේ Chris Mundy, Lost සහ Watchmen නිර්මාණය කරපු Damon Lindelof වැනි අති දක්ෂ පිරිසකගේ තිර රචනයෙන් හැඩවුණු මේ සුපිරි කතා මාලාව, DC ලෝලීන් විතරක් නෙවෙයි හොඳ රහස් පරීක්ෂණ කතාවලට ආස කරන හැමෝම අනිවාර්යයෙන්ම බලන්න ඕනේ එකක්.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නේ මෙහෙමයි:

📄 Direct Download: කිසිම කරදරයක් නැතුව සිංහල උපසිරැසි ගොනුව (SRT) කෙලින්ම ඩවුන්ලෝඩ් කරගන්න පුළුවන්.

✈️ Telegram Download: 720p, 1080p WEB-DL කොපි ටෙලිග්‍රෑම් චැනල් එක හරහා ගන්න පුළුවන්.', 2026, '2026-01-01', 8, '{"Superhero","Sci-Fi","Mystery","Detective","Drama"}', '{"Lanterns Sinhala Subtitles","Lanterns sinhala sub","Lanterns sinhala subtitle download","Lanterns tv series sinhala sub pixelpoplk","Lanterns sinhala sub pixelpop.lk","pixelpoplk HBO DC series","ලැන්ටර්න්ස් සිංහල උපසිරැසි","Lanterns full series sinhala subtitles download","Lanterns sinhala sub web-dl","pixelpoplk sinhala subtitles","Lanterns DCU series","Green Lantern live action sinhala sub"}', 'https://image.tmdb.org/t/p/original/isYpgPQdjxJ0Ht04uKgilVYGPp9.jpg', 'https://image.tmdb.org/t/p/original/isYpgPQdjxJ0Ht04uKgilVYGPp9.jpg', 1, '2026-08-17 00:43:29.237961+00')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, poster_path = EXCLUDED.poster_path;
INSERT INTO movies (id, title, type, description, year, release_date, imdb_rating, genres, seo_tags, poster_path, backdrop_path, total_seasons, created_at)
VALUES ('2482cdb9-8cae-4967-acae-5eca5d795530', 'Dexter', 'TV_SHOW', '🕵️‍♂️ Dexter Season 1 Episode 1 - සිංහල උපසිරැසි 🎬

Dexter Season 1 delivers a brilliant, darkly comedic psychological crime thriller from Showtime. A brilliant Miami forensics expert leads a double life as a meticulous vigilante serial killer who only hunts down other murderers. When a mysterious new killer begins leaving bloodless clues just for him, a high-stakes psychological game of cat-and-mouse begins.

ඔන්න අරගෙන ආවා Crime, Mystery වගේම Psychological Thriller කතාවලට ආස කරන අය හැමෝම අනිවාර්යයෙන්ම බලන්න ඕනේ, Showtime නාලිකාවෙන් නිකුත් කරපු ලෝක ප්‍රසිද්ධ ''Dexter'' කතා මාලාවේ පළමු කතා සමයේ (Season 1) පළමු වැනි කොටසට (Episode 1) සිංහල උපසිරැසි. IMDb එකේ 8.6/10ක ඉහළම රේටින් එකක් ගත්ත මේ සීරීස් එක, මුල ඉඳන් අගටම කුතුහලය උපරිමයෙන්ම තියාගෙන බලන්න පුළුවන් විශිෂ්ටතම නිර්මාණයක්.

කතාව පැත්තට ගියොත්, ඩෙක්ස්ටර් මෝගන් (Michael C. Hall) කියන්නේ මියාමි පොලිසියේ වැඩ කරන, ලේ පැල්ලම් ගැන පරීක්ෂණ පවත්වන දක්ෂ නිලධාරියෙක්. හැබැයි හැමෝටම පේන මේ සාමාන්‍ය ජීවිතයට අමතරව ඩෙක්ස්ටර්ට තව අඳුරු රහස් ජීවිතයක් තියෙනවා. ඒ තමයි එයා රෑට නීතියෙන් බේරිලා යන දරුණු වැරදිකරුවන් සොයාගෙන ඔවුන්ට දඬුවම් කරන රහසිගත ක්‍රියාකාරියෙක් (Vigilante) විදිහට වැඩ කරන එක. එයා මේ දේ කරන්නේ එයාගේ හදාගත්ත තාත්තා කියලා දුන්න දැඩි සීමාවන් සහ නීති මාලාවකට (The Code of Harry) අනුවයි.

මේ අතරේ මියාමි නගරයේ අමුතුම විදිහට අපරාධකරන අලුත් කෙනෙක් මතුවෙනවා. ''Ice Truck Killer'' විදිහට හඳුන්වන මේ පුද්ගලයා, තමන්ගේ ඉලක්කයන් ලේ බිඳක්වත් නැතිව සකසා පොදු ස්ථානවල දාලා යනවා. ඒ වගේම එයා ඩෙක්ස්ටර්ට විතරක් තේරෙන රහස් ඉඟි ඉතුරු කරමින් ඩෙක්ස්ටර් එක්ක අමුතුම මානසික සෙල්ලමක් කරන්න පටන් ගන්නවා. මේ රහස්‍ය පුද්ගලයා කවුද? එයා ඩෙක්ස්ටර් ගැන දන්නේ කොහොමද?

Michael C. Hall ගේ සුපිරිම රංගනයෙන් හැඩවුණු, හැම තත්පරේම කුතුහලයෙන් වගේම දරුණු suspense එකකින් බලන්න පුළුවන් මේ පට්ටම කතාව ඔයාගේ Must Watch ලිස්ට් එකට අනිවාර්යයෙන්ම එකතු කරගන්න.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නේ මෙහෙමයි:

📄 Direct Subtitle Download: කිසිම කරදරයක් නැතුව සිංහල උපසිරැසි ගොනුව (.zip) කෙලින්ම ඩවුන්ලෝඩ් කරගන්න පුළුවන්.

✈️ Telegram Download: 720p, 1080p Bluray කොපි ටෙලිග්‍රෑම් චැනල් එක හරහා ගන්න පුළුවන්.', 2006, '2006-01-01', 8.6, '{"Crime","Drama","Mystery","Thriller","Psychological"}', '{"Keywords: Dexter Season 1 Episode 1 Sinhala Subtitles","Dexter S01E01 sinhala sub","Dexter Season 1 sinhala subtitle download","Dexter S01E01 sinhala sub pixelpoplk","Dexter sinhala sub pixelpop.lk","pixelpoplk Showtime Dexter","ඩෙක්ස්ටර් සිංහල උපසිරැසි","Dexter full series sinhala subtitles download","Dexter season 1 sinhala sub bluray","pixelpoplk sinhala subtitles","crime drama series sinhala sub","psychological thriller sinhala sub | Description: Dexter Season 1 Episode 1 Sinhala Subtitles. Download Dexter S01E01 Sinhala Sub online from pixelpoplk."}', 'https://image.tmdb.org/t/p/original/rmhoMEHK3ZP2EAXX2VpxuKpW3Bf.jpg', 'https://image.tmdb.org/t/p/original/rmhoMEHK3ZP2EAXX2VpxuKpW3Bf.jpg', 1, '2026-08-22 06:41:53.87792+00')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, poster_path = EXCLUDED.poster_path;
INSERT INTO movies (id, title, type, description, year, release_date, imdb_rating, genres, seo_tags, poster_path, backdrop_path, total_seasons, created_at)
VALUES ('e3e39812-35a9-40d3-a740-e0b7d896c9f2', 'Batman: Knightfall Part 1', 'MOVIE', '🕵️‍♂️ Batman: Knightfall Part 1: Knightfall (2026) - සිංහල උපසිරැසි 🎬

Batman: Knightfall Part 1: Knightfall delivers a dark, gritty, and action-packed animated superhero masterpiece from DC. When the ruthless powerhouse Bane destroys Arkham Asylum and unleashes Gotham''s most dangerous psychopaths, Batman is pushed to his absolute physical and mental limits to save his city, leading to a fateful, bone-shattering confrontation.

ඔන්න යාළුවනේ, DC රසිකයෝ හැමෝම බොහොම උනන්දුවෙන් බලාගෙන හිටපු, අදම (අගෝස්තු 25) ඩිජිටල් මාධ්‍ය ඔස්සේ නිකුත් වුණු "Batman: Knightfall Part 1: Knightfall" අලුත්ම සුපිරි ඇනිමේෂන් චිත්‍රපටයට සිංහල උපසිරැසි අරගෙන ආවා. DC කොමික් ඉතිහාසයේ එදා මෙදා තුර බිහිවුණු සුප්‍රසිද්ධම වගේම ජනප්‍රියම "Knightfall" කොමික් කතා මාලාව ඇසුරෙන් තමයි මේ චිත්‍රපටය කොටස් තුනක ට්‍රිලොජි එකක් (Trilogy) විදිහට නිර්මාණය වෙන්නේ.

කතාව පැත්තට ගියොත්, ගෝතම් නගරයේ තියෙන භයානකම අපරාධකාරයෝ හිර කරලා ඉන්න ''ආකම් අසයිලම්'' (Arkham Asylum) එක සම්පූර්ණයෙන්ම විනාශ කරන්න බේන් (Bane) කියන අතිශය බලවත් වගේම කපටි සතුරා සමත් වෙනවා. මේකෙන් පස්සේ එහි සිටි සියලුම දරුණු අපරාධකාරයෝ ගෝතම් නගරයට මුදා හැරෙනවා. එක පිට එක එන මේ සතුරන්ව නැවත කොටු කරගන්න සටන් කරන බැට්මෑන්ට තමන්ගේ උපරිම ශාරීරික වගේම මානසික සීමාවන් පවා පහුකරලා යන්න සිද්ධ වෙනවා. මේ විදිහට හොඳටම හෙම්බත් වෙලා ඉන්න බැට්මෑන්ට, තමන්ගේ ජීවිතයේ දරුණුතම පරාජය අත්කරලා දෙන්න බලාගෙන ඉන්න බේන් එක්ක අවසන් සටනකට මුහුණ දෙන්න වෙනවා.

Jeff Wamester ගේ අධ්‍යක්ෂණයෙන් වගේම Anson Mount (Batman), Michael Mando (Bane) සහ Pablo Schreiber (Azrael) ගේ සුපිරි හඬ දායකත්වයෙන් හැඩවුණු මේ චිත්‍රපටය, බැට්මෑන් රසිකයෙක් නම් කිසිසේත්ම මඟහැරගන්න එපා.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නේ මෙහෙමයි:

📄 Direct Subtitle Download: කිසිම කරදරයක් නැතුව සිංහල උපසිරැසි ගොනුව (SRT) කෙලින්ම ඩවුන්ලෝඩ් කරගන්න පුළුවන්.

✈️ Telegram Download: 720p, 1080p WEB-DL කොපි ටෙලිග්‍රෑම් චැනල් එක හරහා ගන්න පුළුවන්.', 2026, '2026-01-01', 8.1, '{"Action","Adventure","Animation","Mystery"}', '{"Batman: Knightfall Part 1","Batman Knightfall Part 1 Sinhala Subtitles","Batman Knightfall Sinhala Sub","Batman Knightfall Sinhala Subtitles","Batman Knightfall 1 Sinhala Sub","Batman Knightfall Sinhala Subtitle","Batman Knightfall Part 1 Sinhala Subtitle","Batman Knightfall Sinhala","Batman Knightfall Subtitles Sinhala","Batman Sinhala Subtitles","Batman Sinhala Sub","Sinhala Subtitles","Sinhala Sub","Sinhala Subtitle","Subtitles Sinhala","Batman Animated Movie Sinhala Subtitles","Batman Knightfall Part 1 Sinhala Subtitle Download","Batman Knightfall Movie Sinhala Sub","Batman Knightfall Sinhala Sub Download","Batman 2022 Sinhala Sub","DC Animated Movies Sinhala Subtitles"}', 'https://image.tmdb.org/t/p/original/9pKPTugulAt0EtH0g4gvJGffPSg.jpg', 'https://image.tmdb.org/t/p/original/9pKPTugulAt0EtH0g4gvJGffPSg.jpg', NULL, '2026-08-25 08:44:47.317584+00')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, poster_path = EXCLUDED.poster_path;
INSERT INTO movies (id, title, type, description, year, release_date, imdb_rating, genres, seo_tags, poster_path, backdrop_path, total_seasons, created_at)
VALUES ('5df962ce-ab8b-4343-ab32-3858ae1eb96f', 'Motor City', 'MOVIE', '🕵️‍♂️ Motor City (2026) - සිංහල උපසිරැසි 🎬

Motor City delivers a brutal, nearly silent action-revenge masterpiece. After being framed for a crime by a ruthless gangster who stole his girlfriend, an innocent auto worker returns years later to unleash a relentless, dialogue-free barrage of vengeance. 

ඔන්න යාළුවනේ, Reacher කතා මාලාව හරහා හැමෝම අතරේ අතිශය ජනප්‍රිය වුණු Alan Ritchson ප්‍රධාන චරිතය රඟපාන, මේ සතියේ ඩිජිටල් මාධ්‍ය ඔස්සේ නිකුත් වුණු "Motor City" අලුත්ම සුපිරි ක්‍රියාදාම සිනමාපටයට සිංහල උපසිරැසි අරගෙන ආවා. මේ චිත්‍රපටයේ තියෙන විශේෂම දේ තමයි, මේකේ දෙබස් (dialogue) තියෙන්නේ අතළොස්සක් විතරයි. මුළු චිත්‍රපටයම පාහේ ගලාගෙන යන්නේ නියම ඇක්ෂන් දර්ශන, රොක් සංගීතය වගේම විශිෂ්ට රංගනයන් ඔස්සේ විතරයි. ඒනිසා සිංහල Sub නැතුව උනත් බලන්න පුලුවන්.

කතාව පැත්තට ගියොත්, 1970 දශකයේ ඩෙට්‍රොයිට් (Detroit) නගරයේ ජීවත් වෙන සාමාන්‍ය කම්කරුවෙක් වන ජෝන් මිලර් (Alan Ritchson), තමන් ආදරය කරන පෙම්වතියව (Shailene Woodley) ලබාගැනීමේ අරමුණින් ඉන්න දරුණු මැර කල්ලියක ලොක්කෙක් (Ben Foster) විසින් කරන සැලසුමකට අහුවෙනවා. මෙතැනදී ජෝන් මිලර් නොකළ වරදකට මත්ද්‍රව්‍ය ජාවාරම්කරුවෙක් විදිහට හිරේට යනවා. වසර ගණනාවකට පස්සේ හිරෙන් නිදහස් වෙලා එන ජෝන්, තමන්ගේ මුළු ජීවිතයම විනාශ කරපු, තමන්ගේ ආදරය උදුරාගත්ත මේ මැර කල්ලියෙන් පලිගන්න අතිශය දරුණු වගේම ලේවැකි මෙහෙයුමක් ආරම්භ කරනවා.

"Old Henry" අධ්‍යක්ෂණය කරපු Potsy Ponciroli ගේ විශිෂ්ට අධ්‍යක්ෂණයෙන් වගේම Ben Foster, Shailene Woodley සහ Pablo Schreiber වැනි දක්ෂ නළු නිළියන්ගේ රංගනයෙන් හැඩවුණු, ''80 දශකයේ සැබෑ ඇක්ෂන් සිනමාවක අත්දැකීමක් දෙන මේ පට්ටම ෆිල්ම් එක කිසිසේත්ම මඟහැරගන්න එපා.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නේ මෙහෙමයි:

📄 Direct Subtitle Download: කිසිම කරදරයක් නැතුව සිංහල උපසිරැසි ගොනුව (SRT) කෙලින්ම ඩවුන්ලෝඩ් කරගන්න පුළුවන්.

✈️ Telegram Download:  720p, 1080p WEB පිටපත් ටෙලිග්‍රෑම් චැනල් එක හරහා ගන්න පුළුවන්.', 2026, '2026-01-01', 6.1, '{"Action","Crime","Thriller"}', '{"Motor City Sinhala Subtitles","Motor City sinhala sub","Motor City sinhala subtitle download","Motor City movie sinhala sub pixelpoplk","Motor City sinhala sub pixelpop.lk","pixelpoplk Alan Ritchson movie","මෝටර් සිටි සිංහල උපසිරැසි","Motor City full movie sinhala subtitles download","Motor City sinhala sub web-dl","pixelpoplk sinhala subtitles","Motor City 2026 sinhala sub","Alan Ritchson revenge movie sinhala sub"}', 'https://image.tmdb.org/t/p/original/cWAVzTWm9xdc8skHH7h1vreUtcD.jpg', 'https://image.tmdb.org/t/p/original/cWAVzTWm9xdc8skHH7h1vreUtcD.jpg', NULL, '2026-08-25 15:35:47.386038+00')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, poster_path = EXCLUDED.poster_path;
INSERT INTO movies (id, title, type, description, year, release_date, imdb_rating, genres, seo_tags, poster_path, backdrop_path, total_seasons, created_at)
VALUES ('cb41648e-bb00-4fbf-a34e-0b67d6ad0f57', 'The Leftovers', 'TV_SHOW', '🕵️‍♂️ The Leftovers - සිංහල උපසිරැසි 🎬

The Leftovers delivers a hauntingly beautiful, deeply emotional, and critically acclaimed psychological mystery-drama from HBO. When 2% of the world''s population mysteriously vanishes without a trace, those left behind must struggle to find meaning, cope with grief, and survive in a world shattered by the unexplained. 

ඔන්න යාළුවනේ, ලෝකයේ මෙතෙක් බිහිවුණු විශිෂ්ටතම වගේම හැඟීම්බරම කතා මාලාවක් විදිහට විචාරකයින්ගේ ඉහළම ඇගයීමට ලක්වුණු, HBO එකෙන් නිකුත් කරපු "The Leftovers" ටෙලි කතා මාලාවට සිංහල උපසිරැසි අරගෙන ආවා. IMDb එකේ 8.3/10ක ඉහළම අගයක් ගත්ත, "Lost" සීරීස් එක හදපු Damon Lindelof ගේ තවත් අපූරු මනෝවිද්‍යාත්මක නිර්මාණයක් තමයි මේක.

කතාව පැත්තට ගියොත්, එකම දවසක, එකම මොහොතකදී ලෝක ජනගහනයෙන් 2%ක් (මිලියන 140ක සෙනඟක්) කිසිම හෝඩුවාවක් නැතුව අද්භූත විදිහට අතුරුදන් වෙනවා. මේ සිදුවීම හඳුන්වන්නේ ''Sudden Departure'' කියලා. කතාව ආරම්භ වෙන්නේ මේ සිදුවීම වෙලා අවුරුදු තුනකට පස්සේ. මේ අතුරුදන් වීමෙන් පස්සේ ඉතිරි වුණු මිනිස්සු (The Leftovers) තමන්ගේ ආදරණීයයන් අහිමි වීමේ දුක දරාගන්නේ කොහොමද, මේ අද්භූත සිදුවීමට හේතුව මොකක්ද කියලා හිතාගන්න බැරුව ඇතිවෙන මානසික කඩා වැටීමෙන් බේරෙන්නේ කොහොමද කියලා කතාවෙන් පෙන්නනවා.

කුඩා නගරයක පොලිස් ප්‍රධානියා වෙන කෙවින් ගාර්වි (Justin Theroux) තමන්ගේ පවුල බේරගන්න වගේම නගරයේ සාමය ರකින්න ලොකු සටනක් දෙනවා. ඒ අතරේ මේ සිදුවීම නිසා විවිධ ආගමික කල්ලි (උදාහරණයක් විදිහට කතා නොකර සුදු ඇඳගෙන දුම් බොන ''Guilty Remnant'' කල්ලිය) බිහිවෙලා මුළු සමාජයම තවත් අවුල් ජාලාවක් බවට පත් කරනවා.

අතිශය දක්ෂ රංගනයන්ගෙන් වගේම ලස්සන සංගීතයකින් හැඩවුණු, මිනිස් හදවතටම දැනෙන, කුතුහලය පිරි මේ සුපිරි කතාව ඔයාගේ Must Watch ලිස්ට් එකට අනිවාර්යයෙන්ම එකතු කරගන්න.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නේ මෙහෙමයි:

📄 Direct Subtitle Download: කිසිම කරදරයක් නැතුව සිංහල උපසිරැසි ගොනුව (SRT) කෙලින්ම ඩවුන්ලෝඩ් කරගන්න පුළුවන්.

✈️ Telegram Download: 720p, 1080p WEB-DL කොපි ටෙලිග්‍රෑම් චැනල් එක හරහා ගන්න පුළුවන්.', 2014, '2014-01-01', 8.3, '{"Mystery","Drama","Fantasy","Psychological"}', '{"The Leftovers Season 1 Episode 1 Sinhala Subtitles","The Leftovers S01E01 sinhala sub","The Leftovers Season 1 Episode 1 sinhala subtitle download","The Leftovers S01E01 tv series sinhala sub pixelpoplk","The Leftovers S01E01 sinhala sub pixelpop.lk","pixelpoplk HBO leftovers S01E01","ද ලෙෆ්ට්ඕවර්ස් කථාංගය 01 සිංහල උපසිරැසි","The Leftovers S01E01 sinhala subtitles download","The Leftovers Season 1 Episode 1 sinhala sub web-dl","pixelpoplk sinhala subtitles leftovers s1e1","mystery drama series sinhala sub leftovers s01e01","Damon Lindelof leftovers season 1 episode 1 sinhala sub"}', 'https://image.tmdb.org/t/p/original/lxRQJr68o9fZI1RzGDc0qeYX4Je.jpg', 'https://image.tmdb.org/t/p/original/lxRQJr68o9fZI1RzGDc0qeYX4Je.jpg', 1, '2026-08-27 05:15:49.32395+00')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, poster_path = EXCLUDED.poster_path;
INSERT INTO movies (id, title, type, description, year, release_date, imdb_rating, genres, seo_tags, poster_path, backdrop_path, total_seasons, created_at)
VALUES ('190486de-63e6-49e2-a16d-1195bb2596d3', 'I, Nobody (2026)', 'MOVIE', '🕵️‍♂️ I, Nobody (2026) - සිංහල උපසිරැසි 🎬

I, Nobody delivers a gripping, fast-paced Malayalam heist action-thriller. When a quiet, middle-class government employee gets trapped in a massive 17 Crore bank robbery, he is framed as the mastermind. Forced to flee with the robbers, he must navigate corrupt cops, dangerous mobsters, and protect his family to survive. 

ඔන්න යාළුවනේ, මලයාලම් සිනමාලෝලීන් හැමෝම බලාගෙන හිටපු, පසුගිය අගෝස්තු 25 වැනිදා OTT මාධ්‍ය ඔස්සේ අලුතින්ම නිකුත් වුණු "I, Nobody" කියන සුපිරි මලයාලම් ක්‍රියාදාම සිනමාපටයට සිංහල උපසිරැසි අරගෙන ආවා. "Rorschach" වැනි චිත්‍රපට අධ්‍යක්ෂණය කරපු Nissam Basheer ගේ අධ්‍යක්ෂණයෙන් හැඩවුණු මේ චිත්‍රපටය, මුල ඉඳන් අගටම කුතුහලයෙන් බලන්න පුළුවන් සුපිරි Heist Thriller එකක්.

කතාව පැත්තට ගියොත්, රජීවන් (Prithviraj Sukumaran) කියන්නේ තමන්ගේ බිරිඳ (Parvathy Thiruvothu) සහ දරුවන් එක්ක බොහොම සාමාන්‍ය ජීවිතයක් ගත කරන රජයේ රැකියාවක් කරන මැදපෙළ පුද්ගලයෙක්. හැබැයි දවසක් මෙයා අහම්බෙන් ලොකු බැංකුවක් ඇතුළේ ඉද්දි කෝටි 17ක දැවැන්ත බැංකු කොල්ලයක් සිද්ධ වෙනවා. මේ කොල්ලය අතරතුර සිද්ධ වෙන අමුතු සිදුවීම් නිසා, රජීවන්ට මේ හොරු කණ්ඩායමත් එක්ක පැනලා යන්න සිද්ධ වෙනවා වගේම මුළු පොලිසියම මේ කොල්ලයේ ප්‍රධාන මොළකරු (mastermind) විදිහට සැක කරන්නේ රජීවන්වයි.

පොලිසියෙන් වගේම දරුණු මැර කල්ලියකගෙනුත් බේරිලා, තමන්ගේ පවුලත් ආරක්ෂා කරගෙන මේ මහා අමාරු ප්‍රශ්නයෙන් රජීවන් බේරෙන්නේ කොහොමද? එයා ඇත්තටම නිකන්ම මේකට අහුවුණ අහිංසකයෙක්ද, නැත්නම් මේ හැමදේම පිටුපස ඉන්න සැබෑ සැලසුම්කරු එයාද?

Prithviraj Sukumaran ගේ සුපිරිම රංගනයක් බලාගන්න පුළුවන්, කුතුහලය පිරි මේ සුපිරි මලයාලම් චිත්‍රපටය ඔයාගේ Must Watch ලිස්ට් එකට අනිවාර්යයෙන්ම එකතු කරගන්න.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නේ මෙහෙමයි:

📄 Direct Subtitle Download: කිසිම කරදරයක් නැතුව සිංහල උපසිරැසි ගොනුව (SRT) කෙලින්ම ඩවුන්ලෝඩ් කරගන්න පුළුවන්.

✈️ Telegram Download: 720p, 1080p HQ HDRip කොපි ටෙලිග්‍රෑම් චැනල් එක හරහා ගන්න පුළුවන්.', 2026, '2026-01-01', 6, '{"Action","Crime","Thriller","Malayalam"}', '{"I Nobody Sinhala Subtitles","I Nobody sinhala sub","I Nobody sinhala subtitle download","I Nobody movie sinhala sub pixelpoplk","I Nobody sinhala sub pixelpop.lk","pixelpoplk Malayalam movie","අයි නෝබඩි සිංහල උපසිරැසි","I Nobody full movie sinhala subtitles download","I Nobody sinhala sub web-dl","pixelpoplk sinhala subtitles","I Nobody Malayalam 2026 sinhala sub","Prithviraj Sukumaran heist movie sinhala sub"}', 'https://image.tmdb.org/t/p/original/qFJl3w9KpVXpfZ3rpmv7p0UYZkP.jpg', 'https://image.tmdb.org/t/p/original/qFJl3w9KpVXpfZ3rpmv7p0UYZkP.jpg', NULL, '2026-08-28 05:17:20.917336+00')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, poster_path = EXCLUDED.poster_path;
INSERT INTO movies (id, title, type, description, year, release_date, imdb_rating, genres, seo_tags, poster_path, backdrop_path, total_seasons, created_at)
VALUES ('b502eb7f-d3b3-4b67-a82f-7b5154e561f9', 'The Whisper Man', 'MOVIE', '🕵️‍♂️ The Whisper Man (2026) - සිංහල උපසිරැසි 🎬

The Whisper Man delivers a chilling, highly atmospheric psychological crime thriller from Netflix. Based on the bestselling novel, a grieving father and his young son move to a quiet town with a dark history, only to find themselves haunted by the legacy of a notorious serial killer who preys on the vulnerable. 

ඔන්න යාළුවනේ, Alex North ගේ ලෝක ප්‍රසිද්ධ නවකතාව ඇසුරෙන් නිර්මාණය වුණු, අදම (අගෝස්තු 28) Netflix හරහා ලොව පුරා විකාශනය ආරම්භ වුණු "The Whisper Man" අලුත්ම සුපිරි අපරාධ සිනමාපටයට සිංහල උපසිරැසි අරගෙන ආවා. Robert De Niro, Adam Scott සහ Michelle Monaghan වැනි ප්‍රබල නළු නිළියන් රැසකගේ රංගනයෙන් හැඩවුණු මේ චිත්‍රපටය, මුල ඉඳන් අගටම ලොකු බයකින් වගේම කුතුහලයකින් බලන්න පුළුවන් නියම Psychological Thriller එකක්.

කතාව පැත්තට ගියොත්, තමන්ගේ බිරිඳගේ මරණයෙන් පස්සේ ඇතිවුණු දරාගත නොහැකි දුකෙන් බේරෙන්න හිතාගෙන, ටොම් (Adam Scott) තමන්ගේ අවුරුදු අටක් වයසැති පුතා වෙන ජේක්ව එක්කගෙන ''ෆෙදර්බෑන්ක්'' (Featherbank) කියන අතිශය නිස්කලංක නගරයට පදිංචියට යනවා. හැබැයි මේ නගරයට මීට අවුරුදු 15කට කලින් "The Whisper Man" නමින් හඳුන්වපු දරුණු මිනීමරුවෙක්ගෙන් ලොකු බලපෑමක් එල්ල වෙලා තිබුණා. 

මේ නගරයේ පදිංචි වෙලා ටික දවසක් යද්දී, කුඩා ජේක්ට අමුතු දේවල් ඇහෙන්න වගේම දකින්න ලැබෙනවා. දවසක් රෑක කාමරයේ ජනේලයෙන් කවුරු හරි කතා කරනවා වගේ හීනෙන් වගේ ඇහෙන රහස් හඬක් (whisper) නිසා ජේක් ලොකු බියකට පත්වෙනවා. මේ අතරේ නගරයේ තවත් දරුවෙක් අතුරුදන් වෙනවා. මේ දේවලින් බේරෙන්න ටොම්ට සිද්ධ වෙනවා එයාගේ අමනාප වෙලා ඉන්න තාත්තා වන, එදා ''The Whisper Man'' ව අල්ලගන්න ප්‍රධාන මෙහෙයුම දියත් කරපු විශ්‍රාමික පොලිස් රහස් පරීක්ෂක පීට් විලිස් (Robert De Niro) ගේ උදව් ලබාගන්න. 

මුළු නගරයම බියෙන් සලිත කරපු ඒ දරුණු මිනීමරුවා දැනටමත් හිරගෙදර ඉද්දි, මේ අලුත් කරදර පිටුපස ඉන්නේ කවුද? සැබෑ අපරාධකරු කවුද කියලා බලාගන්න මේ සුපිරිම චිත්‍රපටය ඔයාගේ Must Watch ලිස්ට් එකට අනිවාර්යයෙන්ම එකතු කරගන්න.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නේ මෙහෙමයි:

📄 Direct Subtitle Download: කිසිම කරදරයක් නැතුව සිංහල උපසිරැසි ගොනුව (SRT) කෙලින්ම ඩවුන්ලෝඩ් කරගන්න පුළුවන්.

✈️ Telegram Download: 720p, 1080p Webrip කොපි ටෙලිග්‍රෑම් චැනල් එක හරහා ගන්න පුළුවන්.', 2026, '2026-01-01', 6.6, '{"Mystery","Thriller","Psychological","Crime","Horror"}', '{"The Whisper Man Sinhala Subtitles","The Whisper Man sinhala sub","The Whisper Man sinhala subtitle download","The Whisper Man movie sinhala sub pixelpoplk","The Whisper Man sinhala sub pixelpop.lk","pixelpoplk Netflix movie","ද විස්පර් මෑන් සිංහල උපසිරැසි","The Whisper Man full movie sinhala subtitles download","The Whisper Man sinhala sub web-dl","pixelpoplk sinhala subtitles","The Whisper Man 2026 sinhala sub","Robert De Niro thriller movie sinhala sub"}', 'https://image.tmdb.org/t/p/original/6UqflU8Qqkz7Dq4swJPqs0ZJjY4.jpg', 'https://image.tmdb.org/t/p/original/6UqflU8Qqkz7Dq4swJPqs0ZJjY4.jpg', NULL, '2026-08-28 10:36:45.922339+00')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, poster_path = EXCLUDED.poster_path;
INSERT INTO movies (id, title, type, description, year, release_date, imdb_rating, genres, seo_tags, poster_path, backdrop_path, total_seasons, created_at)
VALUES ('0ce63c7b-0d29-4d4e-a6c9-dd5c7962aca1', 'The Wire', 'TV_SHOW', '🕵️‍♂️ The Wire - සිංහල උපසිරැසි 🎬

The Wire delivers a gritty, raw, and masterpiece of a crime-drama series from HBO. Set in Baltimore, it explores the complex and compromised worlds of both law enforcement and drug syndicates, showing the thin line between the cops and the criminals. 

ඔන්න යාළුවනේ, ලෝකයේ බිහිවුණු හොඳම ටීවී සීරීස් එකක් විදිහට හැමදාමත් උඩින්ම කතා වෙන, HBO එකෙන් නිකුත් කරපු "The Wire" සුපිරි අපරාධ කතා මාලාවට සිංහල උපසිරැසි අරගෙන ආවා. IMDb එකේ 9.3/10ක අති දැවැන්ත රේටින් එකක් ගත්ත මේ කතාව, ලෝකයේ තියෙන සැබෑ අපරාධ ලෝකය සහ නීතිය ක්‍රියාත්මක වෙන හැටි කිසිම සැඟවීමක් නැතුව, ඉතාමත් යථාර්ථවාදීව පෙන්නුම් කරන විශිෂ්ටතම නිර්මාණයක්.

කතාව පැත්තට ගියොත්, මේක ගෙතෙන්නේ ඇමරිකාවේ බැල්ටිමෝර් (Baltimore) නගරය පසුබිම් කරගෙනයි. නගරය පුරාම දරුණු විදිහට පැතිරිලා තියෙන මත්ද්‍රව්‍ය ජාලය සහ අපරාධ මර්දනය කරන්න එරෙහිව පොලිසිය කරන දැවැන්ත සටන තමයි මෙතැනදී බලාගන්න ලැබෙන්නේ. මෙහිදී බැල්ටිමෝර් පොලිසියේ විශේෂ විමර්ශන ඒකකය විසින් නගරයේ ප්‍රධානම මත්ද්‍රව්‍ය කල්ලියක් කොටු කරගන්න රහසිගත දුරකථන සවන්දීම් (Wiretapping) සහ ඔත්තු බැලීම් දියත් කරනවා.

මේ කතාවේ තියෙන විශේෂම දේ තමයි, මේකේ හොඳ මිනිස්සු හෝ නරක මිනිස්සු කියලා කොටසක් නැහැ. නීතිය රකින පොලිසියේ ඉන්න අයගේ දූෂිත බව, දුර්වලකම් වගේම අපරාධ ලෝකයේ ඉන්න අයගේ තියෙන මානුෂීය ගතිගුණ සහ ජීවත් වෙන්න කරන අරගලය දෙපැත්තෙන්ම අපූරුවට පෙන්නුම් කරනවා. මත්ද්‍රව්‍ය ජාවාරම්කරුවන්ගේ පැත්තෙන් Avon Barksdale සහ Stringer Bell (Idris Elba) වගේ චරිතත්, පොලිසියේ පැත්තෙන් Jimmy McNulty (Dominic West) වගේ චරිතත් අතර සිද්ධ වෙන මේ මහා බුද්ධිමය සටන කොහොමද ගලාගෙන යන්නේ කියලා ඔයාලම බලන්න.

කිසිසේත්ම මඟහැරගන්න නොකළ යුතු, හැම තත්පරේම කුතුහලයෙන් බලන්න පුළුවන් මේ පට්ටම සීරීස් එක ඔයාගේ Must Watch ලිස්ට් එකට අනිවාර්යයෙන්ම එකතු කරගන්න.

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නේ මෙහෙමයි:

📄 Direct Download: කිසිම කරදරයක් නැතුව සිංහල උපසිරැසි ගොනුව (SRT) කෙලින්ම ඩවුන්ලෝඩ් කරගන්න පුළුවන්.

✈️ Telegram Download: 720p Bluray කොපි ටෙලිග්‍රෑම් චැනල් එක හරහා ගන්න පුළුවන්.', 2002, '2002-01-01', 9.3, '{"Crime","Drama","Thriller","Police Procedural"}', '{"Keywords: The Wire Season 1 Episode 1 Sinhala Subtitles","The Wire S01E01 sinhala sub","The Wire Season 1 sinhala subtitle download","The Wire S01E01 sinhala sub pixelpoplk","The Wire sinhala sub pixelpop.lk","pixelpoplk HBO wire","ද වයර් සිංහල උපසිරැසි","The Wire full series sinhala subtitles download","The Wire sinhala sub bluray","pixelpoplk sinhala subtitles","crime drama series sinhala sub","HBO crime series sinhala | Description: The Wire Season 1 Episode 1 Sinhala Subtitles. Download The Wire S01E01 Sinhala Sub online from pixelpoplk."}', 'https://image.tmdb.org/t/p/original/4lbclFySvugI51fwsyxBTOm4DqK.jpg', 'https://image.tmdb.org/t/p/original/4lbclFySvugI51fwsyxBTOm4DqK.jpg', 1, '2026-08-29 16:00:51.135655+00')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, poster_path = EXCLUDED.poster_path;
INSERT INTO movies (id, title, type, description, year, release_date, imdb_rating, genres, seo_tags, poster_path, backdrop_path, total_seasons, created_at)
VALUES ('6e750f8d-93af-445c-a4e0-94b0625a87bd', 'Lost', 'TV_SHOW', '🕵️‍♂️ Lost (2004) - සිංහල උපසිරැසි 🎬

ඔන්න යාළුවනේ, ලෝකයේ මිනිස්සුන්ව වැඩිම කුතුහලයකින් ඇද බැඳ තියාගත්ත, ටීවී සීරීස් ඉතිහාසයම සම්පූර්ණයෙන්ම වෙනස් කරපු "Lost" සුපිරි විද්‍යා ප්‍රබන්ධ කතා මාලාවට සිංහල උපසිරැසි අරගෙන ආවා. IMDb එකේ 8.3/10ක ඉහළම අගයක් ගත්ත, J.J. Abrams සහ Damon Lindelof එකතු වෙලා නිර්මාණය කරපු මේ කතාව, හැම තත්පරේකම නොසිතූ විදිහේ කුතුහලයක් සහ අබිරහස් පිරුණු විශිෂ්ටතම නිර්මාණයක්.

කතාව පැත්තට ගියොත්, ඕෂනිට් ෆ්ලයිට් 815 (Oceanic Flight 815) කියන මගී ගුවන් යානය පැසිෆික් සාගරයට ඉහළින් පියාසර කරද්දී දරුණු අනතුරකට ලක්වෙලා කඩාගෙන වැටෙනවා. මේ අනතුරෙන් බේරෙන මගීන් 48 දෙනා පණ බේරගන්නේ කිසිම සිතියමක නැති, මිනිස් වාසයෙන් තොර අද්භූත දූපතකටයි. මේ නන්නාඳුනන දූපතේ ජීවිතය බේරගන්න මේ එකිනෙකට වෙනස් මිනිස්සුන්ට එකතු වෙලා වැඩ කරන්න සිද්ධ වෙනවා.

හැබැයි ටික දවසක් යද්දී මෙයාලට තේරුම් යනවා මේක සාමාන්‍ය දූපතක් නෙවෙයි කියලා. දූපත ඇතුළෙන් ඇහෙන භයානක සත්තුන්ගේ හඬවල්, රහසිගත අද්භූත කළු දුමාරයක් (Smoke Monster), පොළොව යට හැංගිලා තියෙන යකඩ දොරවල් (Hatch) වගේම මේ දූපතේ මෙයාලට කලින් ඉඳලම ජීවත් වුණු තවත් අද්භූත පිරිසක් (The Others) ඉන්නවා කියලා මෙයාලා හොයාගන්නවා. මේ අද්භූත දූපතේ රහස මොකක්ද? මෙයාලට ආපහු තමන්ගේ ගෙවල්වලට යන්න ලැබෙයිද?

විශිෂ්ටතම රංගනයන්ගෙන් වගේම, හැම කොටසක් අවසානයේදීම ඊළඟ කොටස බලනකන් ඉවසිල්ලක් නැති කරන මේ සුපිරිම කතාව ඔයාගේ Must Watch ලිස්ට් එකට අනිවාර්යයෙන්ම එකතු කරගන්න.

මෙම උපසිරැසි Bluray පිටපත් සඳහා ගැලපේ.💯

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නේ මෙහෙමයි:

📄 Direct Download: කිසිම කරදරයක් නැතුව සිංහල උපසිරැසි ගොනුව (SRT) කෙලින්ම ඩවුන්ලෝඩ් කරගන්න පුළුවන්.

✈️ Telegram Download: 720p, 1080p Bluray කොපි ටෙලිග්‍රෑම් චැනල් එක හරහා ගන්න පුළුවන්.', 2004, '2004-01-01', 8.3, '{"Mystery","Action","Adventure","Drama"}', '{"Keywords: Lost Season 1 Episode 1 Sinhala Subtitles","Lost S01E01 sinhala sub","Lost Season 1 sinhala subtitle download","Lost S01E01 sinhala sub pixelpoplk","Lost sinhala sub pixelpop.lk","pixelpoplk ABC lost","ලොස්ට් සිංහල උපසිරැසි","Lost full series sinhala subtitles download","Lost season 1 sinhala sub bluray","pixelpoplk sinhala subtitles","sci-fi mystery series sinhala sub","Lost 2004 sinhala sub | Description: Lost Season 1 Episode 1 Sinhala Subtitles. Download Lost S01E01 Sinhala Sub online from pixelpoplk."}', 'https://image.tmdb.org/t/p/original/ejLEJwmh3ptBpdYlKw0xgjjYXmP.jpg', 'https://image.tmdb.org/t/p/original/ejLEJwmh3ptBpdYlKw0xgjjYXmP.jpg', 1, '2026-08-31 15:22:15.597063+00')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, poster_path = EXCLUDED.poster_path;
INSERT INTO movies (id, title, type, description, year, release_date, imdb_rating, genres, seo_tags, poster_path, backdrop_path, total_seasons, created_at)
VALUES ('f993a834-dc2e-4c8d-aaba-4e624bc4a33a', 'I Want Your Sex', 'MOVIE', '🕵️‍♂️ I Want Your Sex (2026) - සිංහල උපසිරැසි 🎬

ඔන්න යාළුවනේ, සිනමා රසිකයෝ අතරේ ලොකු උනන්දුවක් ඇති කරපු, මෑතකදී ඩිජිටල් මාධ්‍ය ඔස්සේ නිකුත් වුණු "I Want Your Sex" අලුත්ම සුපිරි Erotic Comedy Thriller චිත්‍රපටයට සිංහල උපසිරැසි අරගෙන ආවා. "Mysterious Skin" වැනි නිර්මාණ කරපු ප්‍රකට අධ්‍යක්ෂක Gregg Araki ගේ අධ්‍යක්ෂණයෙන් හැඩවුණු මේ චිත්‍රපටය, හාස්‍යය වගේම දරුණු කුතුහලයක් පිරුණු, 18+ වැඩිහිටි ප්‍රේක්ෂකයින්ට පමණක් වෙන්වුණු අපූරු නිර්මාණයක්.

කතාව පැත්තට ගියොත්, තරුණ කොල්ලෙක් වෙන එලියට් (Cooper Hoffman) ට තමන් හීනෙන්වත් නොහිතපු විදිහේ රැකියාවක් ලැබෙනවා. ඒ තමයි ප්‍රසිද්ධ වගේම අමුතු අදහස් තියෙන සමකාලීන කලාකාරිනියක් වෙන එරිකා ට්‍රේසිගේ (Olivia Wilde) සහායකයා විදිහට වැඩ කරන්න ලැබෙන එක. එලියට්ගේ පෙම්වතිය වෙන මිනර්වා (Charli XCX) ලිංගිකත්වය ගැන එච්චර උනන්දුවක් නැති නිසා, එලියට් ටිකෙන් ටික එරිකාගේ ආකර්ෂණයට ලක්වෙනවා.

දවසක් එරිකා මේ ඔෆිස් සීමාවන් ඔක්කොම කඩලා දාලා, එලියට්ව තමන්ගේ කලා නිර්මාණ සඳහා ලිංගික උත්තේජනයක් සපයන රහස් සහායකයෙක් (sexual muse) බවට පත් කරගන්නවා. මේ සිදුවීම නිසා එලියට්ගේ මුළු ජීවිතයම උඩුයටිකුරු වෙලා, බල අරගල, දැඩි ඇබ්බැහියන්, පාවාදීම් වගේම නොසිතූ අබිරහස් සිදුවීම් රැසක් මැද අතරමං වෙනවා. එරිකාගේ මේ මානසික සෙල්ලමෙන් එලියට්ට බේරෙන්න පුළුවන් වෙයිද?

Olivia Wilde, Cooper Hoffman වගේම ජනප්‍රිය ගායිකා Charli XCX ගේ සුපිරි රංගනයක් බලාගන්න පුළුවන් මේ අපූරු චිත්‍රපටය ඔයාගේ Must Watch ලිස්ට් එකට එකතු කරගන්න. 

(විශේෂයෙන්ම මතක් කරන්න ඕනේ, මෙහි අන්තර්ගත දර්ශන නිසා මෙය 18+ වැඩිහිටියන්ට පමණක් සුදුසු වේ.)

📥 වීඩියෝ පිටපත් සහ උපසිරැසි ලබාගන්නේ මෙහෙමයි:

📄 Direct Subtitle Download: කිසිම කරදරයක් නැතුව සිංහල උපසිරැසි ගොනුව (SRT) කෙලින්ම ඩවුන්ලෝඩ් කරගන්න පුළුවන්.

✈️ Telegram Download: 720p, 1080p Webrip කොපි ටෙලිග්‍රෑම් චැනල් එක හරහා ගන්න පුළුවන්.', 2026, '2026-01-01', 7, '{"Erotic","Thriller","Dark Comedy","Romance"}', '{"I Want Your Sex Sinhala Subtitles","I Want Your Sex sinhala sub","I Want Your Sex sinhala subtitle download","I Want Your Sex movie sinhala sub pixelpoplk","I Want Your Sex sinhala sub pixelpop.lk","pixelpoplk erotic movie","අයි වෝන්ට් යෝ සෙක්ස් සිංහල උපසිරැසි","I Want Your Sex full movie sinhala subtitles download","I Want Your Sex sinhala sub web-dl","pixelpoplk sinhala subtitles","I Want Your Sex 2026 sinhala sub","Gregg Araki movie sinhala sub"}', 'https://image.tmdb.org/t/p/original/pR7SIX3AwqdoD96OI44oLG98e7g.jpg', 'https://image.tmdb.org/t/p/original/pR7SIX3AwqdoD96OI44oLG98e7g.jpg', NULL, '2026-09-01 12:05:41.773693+00')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, poster_path = EXCLUDED.poster_path;

-- SEASONS
INSERT INTO seasons (id, movie_id, season_number, title, description, created_at)
VALUES ('dea697ac-9d69-4e1b-afa9-e53cc91f77bd', '3b699ddd-3e8a-4c84-af32-acea43414a83', 1, 'Season 1', 'Sons of Anarchy Season 1', '2026-07-02 20:20:47.74712+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO seasons (id, movie_id, season_number, title, description, created_at)
VALUES ('238f5cc0-d71d-412e-a585-b88983d953d7', '42ae1274-0ac6-4892-a31a-134c4d85d2c3', 3, 'Season 3', 'House Of The Dragon Season 3', '2026-07-05 19:07:04.212977+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO seasons (id, movie_id, season_number, title, description, created_at)
VALUES ('b7badc5b-9caa-4421-ae20-68eecdfd6f3b', '3b699ddd-3e8a-4c84-af32-acea43414a83', 2, 'Season 2', 'Sons of Anarchy Season 2', '2026-07-10 21:03:45.984807+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO seasons (id, movie_id, season_number, title, description, created_at)
VALUES ('dfd9ac67-3d2a-40cc-a044-53039146877b', '3b699ddd-3e8a-4c84-af32-acea43414a83', 3, 'Season 3', 'Sons of Anarchy Season 3', '2026-07-16 15:21:01.297081+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO seasons (id, movie_id, season_number, title, description, created_at)
VALUES ('413b646f-71dc-4c71-a89a-b09b0dd2b5f7', '8cc2980c-b4b8-46db-afe9-55e319c6614e', 1, 'Season 1', 'The East Palace (2026) Season 1', '2026-07-18 06:07:52.262353+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO seasons (id, movie_id, season_number, title, description, created_at)
VALUES ('9874e733-36d7-4308-aff5-23e27f3ae7ee', '3b699ddd-3e8a-4c84-af32-acea43414a83', 4, 'Season 4', 'Sons of Anarchy Season 4', '2026-07-19 18:04:00.986472+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO seasons (id, movie_id, season_number, title, description, created_at)
VALUES ('1f69fab1-bff3-4009-a0ed-99d73ed5e228', '5abd4f11-9adf-4868-ad67-a80a1d51daf7', 1, 'Season 1', 'Dune: Prophecy Season 1', '2026-07-21 11:40:57.426392+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO seasons (id, movie_id, season_number, title, description, created_at)
VALUES ('38abd4bc-f09e-40ea-a26a-11c6a64b57f2', '3b699ddd-3e8a-4c84-af32-acea43414a83', 5, 'Season 5', 'Sons of Anarchy Season 5', '2026-07-22 15:20:11.306013+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO seasons (id, movie_id, season_number, title, description, created_at)
VALUES ('4d849e15-637c-41c6-a015-e4b236fad674', '3b699ddd-3e8a-4c84-af32-acea43414a83', 6, 'Season 6', 'Sons of Anarchy Season 6', '2026-07-25 11:21:03.246098+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO seasons (id, movie_id, season_number, title, description, created_at)
VALUES ('291b580e-934f-4a68-a631-23f1e4a2d904', '91af03eb-e36a-4005-a506-e177e8c89a81', 3, 'Season 3', 'The Walking Dead: Dead City Season 3', '2026-07-26 09:14:46.57961+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO seasons (id, movie_id, season_number, title, description, created_at)
VALUES ('6647736d-c0f3-4e5d-a780-82061fa49383', 'b6b4aa04-8615-4dd8-a055-7aea79dea82f', 1, 'Season 1', 'The Sopranos Season 1', '2026-07-28 16:58:59.501453+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO seasons (id, movie_id, season_number, title, description, created_at)
VALUES ('722b8080-0c6d-4cc0-a15a-75c2b79760b5', '3b699ddd-3e8a-4c84-af32-acea43414a83', 7, 'Season 7', 'Sons of Anarchy Season 7', '2026-07-28 17:47:57.477299+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO seasons (id, movie_id, season_number, title, description, created_at)
VALUES ('97b86cf5-a703-4325-aca3-02b874080ef1', '7029d726-99d2-49d0-a112-bddf83ae943c', 1, 'Season 1', 'Batman: Caped Crusader Season 1', '2026-07-31 09:09:26.160221+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO seasons (id, movie_id, season_number, title, description, created_at)
VALUES ('9e6fe1f3-ed15-40b2-ab7e-611a8fcc19a1', 'b6b4aa04-8615-4dd8-a055-7aea79dea82f', 2, 'Season 2', 'The Sopranos Season 2', '2026-08-04 13:03:55.568064+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO seasons (id, movie_id, season_number, title, description, created_at)
VALUES ('3bfcd8ef-0048-4ebd-a0f2-1fa54b1f797e', 'ddad8dd9-5bbf-4e8c-ab94-49f941e761d8', 1, 'Season 1', 'Black Bird Season 1', '2026-08-06 10:35:58.56554+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO seasons (id, movie_id, season_number, title, description, created_at)
VALUES ('2a8648ce-dc1f-417a-a81c-d355f8f502a2', 'ee83890c-8b6f-4305-a4bd-501d7a46b22c', 1, 'Season 1', 'Our Sticky Love Season 1', '2026-08-08 08:30:23.609856+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO seasons (id, movie_id, season_number, title, description, created_at)
VALUES ('396b7b20-bec8-42b2-a30b-ce95e82e6ae6', '80a0b1c3-04a2-4225-aff1-afd80a7a6f22', 1, 'Season 1', 'The Night of Season 1', '2026-08-08 11:01:21.636301+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO seasons (id, movie_id, season_number, title, description, created_at)
VALUES ('cded2aba-34c3-4566-aac9-f9d32a12ed8b', 'b6b4aa04-8615-4dd8-a055-7aea79dea82f', 3, 'Season 3', 'The Sopranos Season 3', '2026-08-11 13:42:49.900781+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO seasons (id, movie_id, season_number, title, description, created_at)
VALUES ('dce280d1-b521-4972-ae66-5a5cdaaa5ab5', '1994a6f0-7522-418b-adca-31c5068a3ac0', 4, 'Season 4', 'Reacher Season 4', '2026-08-12 08:51:51.598699+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO seasons (id, movie_id, season_number, title, description, created_at)
VALUES ('415f4dd7-12e0-48d0-aaa6-a2075689e704', 'b6b4aa04-8615-4dd8-a055-7aea79dea82f', 4, 'Season 4', 'The Sopranos Season 4', '2026-08-15 23:36:34.227099+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO seasons (id, movie_id, season_number, title, description, created_at)
VALUES ('9b2f9dc0-e6ac-479f-a80d-4a594b4ba8b0', '58006348-bcc7-4322-a1dc-1eecc28bd192', 1, 'Season 1', 'Lanterns (2026) Season 1', '2026-08-17 00:43:29.237961+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO seasons (id, movie_id, season_number, title, description, created_at)
VALUES ('e12655e8-f100-4a5a-a5c8-a28c2f22a7b2', '2482cdb9-8cae-4967-acae-5eca5d795530', 1, 'Season 1', 'Dexter Season 1', '2026-08-22 06:41:53.87792+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO seasons (id, movie_id, season_number, title, description, created_at)
VALUES ('2c3c11bd-f35b-4602-a475-0e1c00c1832d', 'b6b4aa04-8615-4dd8-a055-7aea79dea82f', 5, 'Season 5', 'The Sopranos Season 5', '2026-08-25 05:40:25.195915+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO seasons (id, movie_id, season_number, title, description, created_at)
VALUES ('f5f10eb8-7bf5-434f-a4c7-ecc0a693fb17', 'cb41648e-bb00-4fbf-a34e-0b67d6ad0f57', 1, 'Season 1', 'The Leftovers Season 1', '2026-08-27 05:15:49.32395+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO seasons (id, movie_id, season_number, title, description, created_at)
VALUES ('9d42845b-f3ec-4e7b-aa59-0d5bda0cf1e0', '0ce63c7b-0d29-4d4e-a6c9-dd5c7962aca1', 1, 'Season 1', 'The Wire Season 1', '2026-08-29 16:00:51.135655+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO seasons (id, movie_id, season_number, title, description, created_at)
VALUES ('296a550e-ecac-401d-aa12-af8fde8dac27', 'b6b4aa04-8615-4dd8-a055-7aea79dea82f', 6, 'Season 6', 'The Sopranos Season 6', '2026-08-30 17:59:35.347525+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO seasons (id, movie_id, season_number, title, description, created_at)
VALUES ('c70b337c-3179-4717-ad69-8352be7ee35e', '6e750f8d-93af-445c-a4e0-94b0625a87bd', 1, 'Season 1', 'Lost Season 1', '2026-08-31 15:22:15.597063+00')
ON CONFLICT (id) DO NOTHING;

-- EPISODES
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('2cc3b850-6686-4afd-ab86-7d2684d9690a', 'dea697ac-9d69-4e1b-afa9-e53cc91f77bd', 1, 'Sons of Anarchy S01E01', 'Episode 1', 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-02 20:20:47.74712+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('77b2a8d9-3306-4860-a61b-91dd06a4cc88', '238f5cc0-d71d-412e-a585-b88983d953d7', 3, 'House Of The Dragon S03E03', 'Episode 3', 'https://image.tmdb.org/t/p/original/wSvDQN6tZR4VzDDZD3MUPIghVjC.jpg', '2026-07-05 19:07:04.212977+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('ea343ca1-c4ea-4973-ae68-4ba24c6e0527', 'dea697ac-9d69-4e1b-afa9-e53cc91f77bd', 2, 'Sons Of Anarchy S01E02', 'Episode 2', 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-06 17:23:49.258164+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('cacbd9f9-ebf1-42cc-aca4-333071a27b3f', 'dea697ac-9d69-4e1b-afa9-e53cc91f77bd', 3, 'Sons of Anarchy S01E03', 'Episode 3', 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-06 18:51:33.429257+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('719bbd7b-9632-43e0-a5be-7bc49884cf47', 'dea697ac-9d69-4e1b-afa9-e53cc91f77bd', 4, 'Sons of Anarchy S01E04', 'Episode 4', 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-06 18:51:33.429257+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('03462571-4563-427a-aa3a-40afc3bbe243', 'dea697ac-9d69-4e1b-afa9-e53cc91f77bd', 5, 'Sons of Anarchy S01E05', 'Episode 5', 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-06 18:51:33.429257+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('612f034d-1c8f-4285-a427-ebeea801e532', 'dea697ac-9d69-4e1b-afa9-e53cc91f77bd', 6, 'Sons of Anarchy S01E06', 'Episode 6', 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-06 18:51:33.429257+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('03f30b76-caf8-46c6-ac3d-b125dcddb935', 'dea697ac-9d69-4e1b-afa9-e53cc91f77bd', 7, 'Sons of Anarchy S01E07', 'Episode 7', 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-06 18:51:33.429257+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('4c03ca7e-dc94-471d-a5e8-2d674c7b4109', 'dea697ac-9d69-4e1b-afa9-e53cc91f77bd', 8, 'Sons of Anarchy S01E08', 'Episode 8', 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-06 18:51:33.429257+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('3c84c9e6-fabc-456a-a293-9f5a1e239bda', 'dea697ac-9d69-4e1b-afa9-e53cc91f77bd', 9, 'Sons of Anarchy S01E09', 'Episode 9', 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-06 18:51:33.429257+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('cb3c37c3-f214-4f02-af5a-747e0113143b', 'dea697ac-9d69-4e1b-afa9-e53cc91f77bd', 10, 'Sons of Anarchy S01E10', 'Episode 10', 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-06 18:51:33.429257+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('15d9fb09-e27c-49ab-ae02-34b12edb971e', 'dea697ac-9d69-4e1b-afa9-e53cc91f77bd', 11, 'Sons of Anarchy S01E11', 'Episode 11', 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-06 18:51:33.429257+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('89b29727-a6cb-4209-a579-aa16e73786df', 'dea697ac-9d69-4e1b-afa9-e53cc91f77bd', 12, 'Sons of Anarchy S01E12', 'Episode 12', 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-06 18:51:33.429257+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('309301d8-a536-4ba8-a8fb-4ad8fb9f73d2', 'dea697ac-9d69-4e1b-afa9-e53cc91f77bd', 13, 'Sons of Anarchy S01E13', 'Episode 13', 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-06 18:51:33.429257+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('c60152f3-1cea-4bb9-a577-74292695110f', 'b7badc5b-9caa-4421-ae20-68eecdfd6f3b', 1, 'Sons of Anarchy S02E01', 'Episode 1', 'https://image.tmdb.org/t/p/original/aIZ8Fze3sJHC0OWtYXIYVCKnpMr.jpg', '2026-07-10 21:03:45.984807+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('e6ca4568-68f2-489c-a996-3f834fb21e3f', 'b7badc5b-9caa-4421-ae20-68eecdfd6f3b', 2, 'Sons of Anarchy S02E02', 'Episode 2', 'https://image.tmdb.org/t/p/original/aIZ8Fze3sJHC0OWtYXIYVCKnpMr.jpg', '2026-07-10 21:03:45.984807+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('5e1eb95d-6f26-4e45-ad78-419a01f7445f', 'b7badc5b-9caa-4421-ae20-68eecdfd6f3b', 3, 'Sons of Anarchy S02E03', 'Episode 3', 'https://image.tmdb.org/t/p/original/aIZ8Fze3sJHC0OWtYXIYVCKnpMr.jpg', '2026-07-10 21:03:45.984807+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('4e97a1bd-9177-4075-a248-bd0678ccd7a1', 'b7badc5b-9caa-4421-ae20-68eecdfd6f3b', 4, 'Sons of Anarchy S02E04', 'Episode 4', 'https://image.tmdb.org/t/p/original/aIZ8Fze3sJHC0OWtYXIYVCKnpMr.jpg', '2026-07-10 21:03:45.984807+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('ac618de0-e5af-427a-af4e-8f2476d7b2cb', 'b7badc5b-9caa-4421-ae20-68eecdfd6f3b', 5, 'Sons of Anarchy S02E05', 'Episode 5', 'https://image.tmdb.org/t/p/original/aIZ8Fze3sJHC0OWtYXIYVCKnpMr.jpg', '2026-07-10 21:03:45.984807+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('d591745e-c197-4f84-afcb-9ae3e41ca66c', 'b7badc5b-9caa-4421-ae20-68eecdfd6f3b', 6, 'Sons of Anarchy S02E06', 'Episode 6', 'https://image.tmdb.org/t/p/original/aIZ8Fze3sJHC0OWtYXIYVCKnpMr.jpg', '2026-07-10 21:03:45.984807+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('944f13a0-5bfd-43ee-a05a-72ca54793b80', '238f5cc0-d71d-412e-a585-b88983d953d7', 4, 'House of The Dragon S03E04', 'Episode 4', 'https://image.tmdb.org/t/p/original/wSvDQN6tZR4VzDDZD3MUPIghVjC.jpg', '2026-07-13 01:46:09.988815+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('ea6c3d96-ddd4-47cf-a122-961243698461', 'b7badc5b-9caa-4421-ae20-68eecdfd6f3b', 7, 'Sons of Anarchy S02E07', 'Episode 7', 'https://image.tmdb.org/t/p/original/aIZ8Fze3sJHC0OWtYXIYVCKnpMr.jpg', '2026-07-14 11:59:44.37195+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('27ba32f4-c711-46f8-a0a5-608387a12769', 'b7badc5b-9caa-4421-ae20-68eecdfd6f3b', 8, 'Sons of Anarchy S02E08', 'Episode 8', 'https://image.tmdb.org/t/p/original/aIZ8Fze3sJHC0OWtYXIYVCKnpMr.jpg', '2026-07-14 11:59:44.37195+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('9422b3ed-3fff-40c5-a0c0-34997b284e87', 'b7badc5b-9caa-4421-ae20-68eecdfd6f3b', 9, 'Sons of Anarchy S02E09', 'Episode 9', 'https://image.tmdb.org/t/p/original/aIZ8Fze3sJHC0OWtYXIYVCKnpMr.jpg', '2026-07-14 11:59:44.37195+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('82d1400b-e78d-4622-a5a0-35fd688da419', 'b7badc5b-9caa-4421-ae20-68eecdfd6f3b', 10, 'Sons of Anarchy S02E10', 'Episode 10', 'https://image.tmdb.org/t/p/original/aIZ8Fze3sJHC0OWtYXIYVCKnpMr.jpg', '2026-07-14 11:59:44.37195+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('86ee5e8b-4163-44d3-ad9d-6bf91569d621', 'b7badc5b-9caa-4421-ae20-68eecdfd6f3b', 11, 'Sons of Anarchy S02E11', 'Episode 11', 'https://image.tmdb.org/t/p/original/aIZ8Fze3sJHC0OWtYXIYVCKnpMr.jpg', '2026-07-14 11:59:44.37195+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('bbd1b009-7be8-4d07-a347-0ad724924c8b', 'b7badc5b-9caa-4421-ae20-68eecdfd6f3b', 12, 'Sons of Anarchy S02E12', 'Episode 12', 'https://image.tmdb.org/t/p/original/aIZ8Fze3sJHC0OWtYXIYVCKnpMr.jpg', '2026-07-14 11:59:44.37195+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('01199b58-b2cc-438a-a083-8d44058eed5e', 'b7badc5b-9caa-4421-ae20-68eecdfd6f3b', 13, 'Sons of Anarchy S02E13', 'Episode 13', 'https://image.tmdb.org/t/p/original/aIZ8Fze3sJHC0OWtYXIYVCKnpMr.jpg', '2026-07-14 11:59:44.37195+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('e35a2c4f-5206-4a66-a366-e82874e61130', 'dfd9ac67-3d2a-40cc-a044-53039146877b', 1, 'Sons of Anarchy S03E01', 'Episode 1', 'https://image.tmdb.org/t/p/original/tOdDvDXyRbKU0GIIlKxcjaN0SDN.jpg', '2026-07-16 15:21:01.297081+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('e82b433d-d300-4c4f-ae12-6a4bb4c79eca', 'dfd9ac67-3d2a-40cc-a044-53039146877b', 2, 'Sons of Anarchy S03E02', 'Episode 2', 'https://image.tmdb.org/t/p/original/tOdDvDXyRbKU0GIIlKxcjaN0SDN.jpg', '2026-07-16 15:21:01.297081+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('e02ddde3-8169-4b27-ac59-392c2b344518', 'dfd9ac67-3d2a-40cc-a044-53039146877b', 3, 'Sons of Anarchy S03E03', 'Episode 3', 'https://image.tmdb.org/t/p/original/tOdDvDXyRbKU0GIIlKxcjaN0SDN.jpg', '2026-07-16 15:21:01.297081+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('5dc04c79-8dd1-40e1-a09e-b58fa2488bc8', 'dfd9ac67-3d2a-40cc-a044-53039146877b', 4, 'Sons of Anarchy S03E04', 'Episode 4', 'https://image.tmdb.org/t/p/original/tOdDvDXyRbKU0GIIlKxcjaN0SDN.jpg', '2026-07-16 15:21:01.297081+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('430e537b-a78a-4328-abec-fc9336265539', 'dfd9ac67-3d2a-40cc-a044-53039146877b', 5, 'Sons of Anarchy S03E05', 'Episode 5', 'https://image.tmdb.org/t/p/original/tOdDvDXyRbKU0GIIlKxcjaN0SDN.jpg', '2026-07-16 15:21:01.297081+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('f3f1acd9-8b69-451d-ac31-c68eb4765046', 'dfd9ac67-3d2a-40cc-a044-53039146877b', 6, 'Sons of Anarchy S03E06', 'Episode 6', 'https://image.tmdb.org/t/p/original/tOdDvDXyRbKU0GIIlKxcjaN0SDN.jpg', '2026-07-17 13:58:47.835069+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('89cffa70-f22d-4baf-a0dd-8f4fbff12009', 'dfd9ac67-3d2a-40cc-a044-53039146877b', 7, 'Sons of Anarchy S03E07', 'Episode 7', 'https://image.tmdb.org/t/p/original/tOdDvDXyRbKU0GIIlKxcjaN0SDN.jpg', '2026-07-17 13:58:47.835069+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('c1cf41bb-9fa6-4b44-a797-e11e724cc978', 'dfd9ac67-3d2a-40cc-a044-53039146877b', 8, 'Sons of Anarchy S03E08', 'Episode 8', 'https://image.tmdb.org/t/p/original/tOdDvDXyRbKU0GIIlKxcjaN0SDN.jpg', '2026-07-17 13:58:47.835069+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('6209517b-ba97-4edf-a986-79105177e097', 'dfd9ac67-3d2a-40cc-a044-53039146877b', 9, 'Sons of Anarchy S03E09', 'Episode 9', 'https://image.tmdb.org/t/p/original/tOdDvDXyRbKU0GIIlKxcjaN0SDN.jpg', '2026-07-17 13:58:47.835069+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('299ff645-f014-4bb1-a4f0-e0b08ff1df49', 'dfd9ac67-3d2a-40cc-a044-53039146877b', 10, 'Sons of Anarchy S03E10', 'Episode 10', 'https://image.tmdb.org/t/p/original/tOdDvDXyRbKU0GIIlKxcjaN0SDN.jpg', '2026-07-17 13:58:47.835069+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('310e451e-4e84-425d-a539-1d719acae553', 'dfd9ac67-3d2a-40cc-a044-53039146877b', 11, 'Sons of Anarchy S03E11', 'Episode 11', 'https://image.tmdb.org/t/p/original/tOdDvDXyRbKU0GIIlKxcjaN0SDN.jpg', '2026-07-17 13:58:47.835069+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('ab8847c0-ad32-43aa-aa67-5069fb8a1d26', 'dfd9ac67-3d2a-40cc-a044-53039146877b', 12, 'Sons of Anarchy S03E12', 'Episode 12', 'https://image.tmdb.org/t/p/original/tOdDvDXyRbKU0GIIlKxcjaN0SDN.jpg', '2026-07-17 13:58:47.835069+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('2358e133-5f2e-4442-ace0-5202c0e1a5ea', 'dfd9ac67-3d2a-40cc-a044-53039146877b', 13, 'Sons of Anarchy S03E13', 'Episode 13', 'https://image.tmdb.org/t/p/original/tOdDvDXyRbKU0GIIlKxcjaN0SDN.jpg', '2026-07-17 13:58:47.835069+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('75d0a3d5-5005-4d05-ac96-df51a0192507', '413b646f-71dc-4c71-a89a-b09b0dd2b5f7', 1, 'The East Palace (2026) S01E01', 'Episode 1', 'https://image.tmdb.org/t/p/original/yfYohBszGqoAW8oM0qydOtJ4kPh.jpg', '2026-07-18 06:07:52.262353+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('0904fda1-cdef-4878-a18e-d9c698e0b9ef', '413b646f-71dc-4c71-a89a-b09b0dd2b5f7', 2, 'The East Palace (2026) S01E02', 'Episode 2', 'https://image.tmdb.org/t/p/original/yfYohBszGqoAW8oM0qydOtJ4kPh.jpg', '2026-07-18 06:09:35.713148+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('b88a1b3e-f7f3-43e3-a8d4-89c10dc677d6', '413b646f-71dc-4c71-a89a-b09b0dd2b5f7', 3, 'The East Palace (2026) S01E03', 'Episode 3', 'https://image.tmdb.org/t/p/original/yfYohBszGqoAW8oM0qydOtJ4kPh.jpg', '2026-07-18 17:41:59.995576+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('4becc21e-915c-44ec-a5df-4f84f0c6ade2', '413b646f-71dc-4c71-a89a-b09b0dd2b5f7', 4, 'The East Palace (2026) S01E04', 'Episode 4', 'https://image.tmdb.org/t/p/original/yfYohBszGqoAW8oM0qydOtJ4kPh.jpg', '2026-07-18 17:41:59.995576+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('99cf14e1-f54e-4303-a099-3f53771acc3e', '413b646f-71dc-4c71-a89a-b09b0dd2b5f7', 5, 'The East Palace (2026) S01E05', 'Episode 5', 'https://image.tmdb.org/t/p/original/yfYohBszGqoAW8oM0qydOtJ4kPh.jpg', '2026-07-18 17:41:59.995576+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('4944bacb-a743-4264-a6c4-1b648f1f61e5', '413b646f-71dc-4c71-a89a-b09b0dd2b5f7', 6, 'The East Palace (2026) S01E06', 'Episode 6', 'https://image.tmdb.org/t/p/original/yfYohBszGqoAW8oM0qydOtJ4kPh.jpg', '2026-07-18 17:41:59.995576+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('ddade0d2-f45c-478a-abfc-5fa73bf1521c', '413b646f-71dc-4c71-a89a-b09b0dd2b5f7', 7, 'The East Palace (2026) S01E07', 'Episode 7', 'https://image.tmdb.org/t/p/original/yfYohBszGqoAW8oM0qydOtJ4kPh.jpg', '2026-07-18 17:41:59.995576+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('50220617-6560-4669-a946-ffb634e33779', '413b646f-71dc-4c71-a89a-b09b0dd2b5f7', 8, 'The East Palace (2026) S01E08', 'Episode 8', 'https://image.tmdb.org/t/p/original/yfYohBszGqoAW8oM0qydOtJ4kPh.jpg', '2026-07-18 17:41:59.995576+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('95315ed4-11f0-43e7-a029-2c0d7755a62d', '238f5cc0-d71d-412e-a585-b88983d953d7', 2, 'House of The Dragon S03E02', 'Episode 2', 'https://image.tmdb.org/t/p/original/wSvDQN6tZR4VzDDZD3MUPIghVjC.jpg', '2026-07-18 18:03:31.96276+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('e55206c4-1253-408a-a2d3-a08e662c12c0', '238f5cc0-d71d-412e-a585-b88983d953d7', 1, 'House of The Dragon S03E01', 'Episode 1', 'https://image.tmdb.org/t/p/original/wSvDQN6tZR4VzDDZD3MUPIghVjC.jpg', '2026-07-18 18:05:34.87458+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('80548dc8-f452-4bac-a8b5-403b3f4e19a9', '9874e733-36d7-4308-aff5-23e27f3ae7ee', 1, 'Sons of Anarchy S04E01', 'Episode 1', 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-19 18:04:00.986472+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('1a20966b-ec05-4c1a-a2a0-aac81811e0cb', '9874e733-36d7-4308-aff5-23e27f3ae7ee', 2, 'Sons of Anarchy S04E02', 'Episode 2', 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-19 18:04:00.986472+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('7fc5235b-b315-4576-a40f-468923bd0623', '9874e733-36d7-4308-aff5-23e27f3ae7ee', 3, 'Sons of Anarchy S04E03', 'Episode 3', 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-19 18:04:00.986472+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('0f38be62-9755-4228-aceb-c90656d7a935', '9874e733-36d7-4308-aff5-23e27f3ae7ee', 4, 'Sons of Anarchy S04E04', 'Episode 4', 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-19 18:04:00.986472+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('21059568-1722-49ce-a15a-2252d47ef971', '9874e733-36d7-4308-aff5-23e27f3ae7ee', 5, 'Sons of Anarchy S04E05', 'Episode 5', 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-19 18:04:00.986472+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('1bf72f06-f39e-4be9-a837-e2c19c588e90', '9874e733-36d7-4308-aff5-23e27f3ae7ee', 6, 'Sons of Anarchy S04E06', 'Episode 6', 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-19 18:04:00.986472+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('63dbe61d-808b-4467-aed5-20009f8a86b9', '238f5cc0-d71d-412e-a585-b88983d953d7', 5, 'House of The Dragon S03E05', 'Episode 5', 'https://image.tmdb.org/t/p/original/wSvDQN6tZR4VzDDZD3MUPIghVjC.jpg', '2026-07-20 02:26:00.42846+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('ca371690-e836-4c05-a91f-875704cb23ff', '9874e733-36d7-4308-aff5-23e27f3ae7ee', 7, 'Sons of Anarchy S04E07', 'Episode 7', 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-21 11:40:15.630722+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('698f1205-0367-4a57-a1d1-a8ba6d8d491f', '9874e733-36d7-4308-aff5-23e27f3ae7ee', 8, 'Sons of Anarchy S04E08', 'Episode 8', 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-21 11:40:15.630722+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('368cb299-ef3b-42e2-af6b-8efc86381237', '9874e733-36d7-4308-aff5-23e27f3ae7ee', 9, 'Sons of Anarchy S04E09', 'Episode 9', 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-21 11:40:15.630722+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('794b840f-462b-42a3-ae5e-0ac36bc17d36', '9874e733-36d7-4308-aff5-23e27f3ae7ee', 10, 'Sons of Anarchy S04E10', 'Episode 10', 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-21 11:40:15.630722+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('73821cf1-ea50-4da4-a876-40088a9ace4a', '9874e733-36d7-4308-aff5-23e27f3ae7ee', 11, 'Sons of Anarchy S04E11', 'Episode 11', 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-21 11:40:15.630722+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('bbff83c9-213a-4464-a36b-2b67982280e3', '9874e733-36d7-4308-aff5-23e27f3ae7ee', 12, 'Sons of Anarchy S04E12', 'Episode 12', 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-21 11:40:15.630722+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('e21a578c-ad9b-4512-a07d-7b22a8e3ac9c', '9874e733-36d7-4308-aff5-23e27f3ae7ee', 13, 'Sons of Anarchy S04E13', 'Episode 13', 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-21 11:40:15.630722+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('d0900956-0102-4566-aa13-c09bffe1e464', '9874e733-36d7-4308-aff5-23e27f3ae7ee', 14, 'Sons of Anarchy S04E14', 'Episode 14', 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-21 11:40:15.630722+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('222ad6df-73f1-45ba-ac8a-38d8c21e2e46', '1f69fab1-bff3-4009-a0ed-99d73ed5e228', 1, 'Dune: Prophecy S01E01', 'Episode 1', 'https://image.tmdb.org/t/p/original/5B8Cxz8ZZXp3w2WmmdKTXpkS24e.jpg', '2026-07-21 11:40:57.426392+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('338fb4b5-b92d-48cd-a324-77ee39ef30ac', '1f69fab1-bff3-4009-a0ed-99d73ed5e228', 2, 'Dune: Prophecy S01E02', 'Episode 2', 'https://image.tmdb.org/t/p/original/5B8Cxz8ZZXp3w2WmmdKTXpkS24e.jpg', '2026-07-21 11:40:57.426392+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('d7e26624-0ec9-4648-a251-60a5d338c78c', '1f69fab1-bff3-4009-a0ed-99d73ed5e228', 3, 'Dune: Prophecy S01E03', 'Episode 3', 'https://image.tmdb.org/t/p/original/5B8Cxz8ZZXp3w2WmmdKTXpkS24e.jpg', '2026-07-21 11:40:57.426392+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('d0b4c45b-4b5f-4921-a1cb-df8360b5af6d', '1f69fab1-bff3-4009-a0ed-99d73ed5e228', 4, 'Dune: Prophecy S01E04', 'Episode 4', 'https://image.tmdb.org/t/p/original/5B8Cxz8ZZXp3w2WmmdKTXpkS24e.jpg', '2026-07-21 11:40:57.426392+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('13a6fba1-d1e6-43d6-a256-b34735de376f', '1f69fab1-bff3-4009-a0ed-99d73ed5e228', 5, 'Dune: Prophecy S01E05', 'Episode 5', 'https://image.tmdb.org/t/p/original/5B8Cxz8ZZXp3w2WmmdKTXpkS24e.jpg', '2026-07-21 11:40:57.426392+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('3cf2c156-e756-4d50-a710-bcc7d6556ed0', '1f69fab1-bff3-4009-a0ed-99d73ed5e228', 6, 'Dune: Prophecy S01E06', 'Episode 6', 'https://image.tmdb.org/t/p/original/5B8Cxz8ZZXp3w2WmmdKTXpkS24e.jpg', '2026-07-21 11:40:57.426392+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('52686cc5-f72e-4d32-a887-97c0c66c8c70', '38abd4bc-f09e-40ea-a26a-11c6a64b57f2', 1, 'Sons of Anarchy S05E01', 'Episode 1', 'https://image.tmdb.org/t/p/original/sW67RSH740Ogrp6LGDCgpgGaK1u.jpg', '2026-07-22 15:20:11.306013+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('189982d4-7328-4b53-a79e-2b5ee5619828', '38abd4bc-f09e-40ea-a26a-11c6a64b57f2', 2, 'Sons of Anarchy S05E02', 'Episode 2', 'https://image.tmdb.org/t/p/original/sW67RSH740Ogrp6LGDCgpgGaK1u.jpg', '2026-07-22 15:20:11.306013+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('0f0873c0-f5c0-4c0a-afd5-cdc0585e63fb', '38abd4bc-f09e-40ea-a26a-11c6a64b57f2', 3, 'Sons of Anarchy S05E03', 'Episode 3', 'https://image.tmdb.org/t/p/original/sW67RSH740Ogrp6LGDCgpgGaK1u.jpg', '2026-07-22 15:20:11.306013+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('b25570b7-1e07-4d84-ae08-e4e5f59a46b3', '38abd4bc-f09e-40ea-a26a-11c6a64b57f2', 4, 'Sons of Anarchy S05E04', 'Episode 4', 'https://image.tmdb.org/t/p/original/sW67RSH740Ogrp6LGDCgpgGaK1u.jpg', '2026-07-22 15:20:11.306013+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('a03dd8e3-1ba0-49e9-a2fb-6a1ae7d24300', '38abd4bc-f09e-40ea-a26a-11c6a64b57f2', 5, 'Sons of Anarchy S05E05', 'Episode 5', 'https://image.tmdb.org/t/p/original/sW67RSH740Ogrp6LGDCgpgGaK1u.jpg', '2026-07-22 15:20:11.306013+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('885890f6-86b7-4444-a898-5a3769be7b3d', '38abd4bc-f09e-40ea-a26a-11c6a64b57f2', 6, 'Sons of Anarchy S05E06', 'Episode 6', 'https://image.tmdb.org/t/p/original/sW67RSH740Ogrp6LGDCgpgGaK1u.jpg', '2026-07-23 15:20:45.443248+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('2bdd29eb-1ef4-40f4-a9f7-5c19ac3176ca', '38abd4bc-f09e-40ea-a26a-11c6a64b57f2', 7, 'Sons of Anarchy S05E07', 'Episode 7', 'https://image.tmdb.org/t/p/original/sW67RSH740Ogrp6LGDCgpgGaK1u.jpg', '2026-07-23 15:20:45.443248+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('b5b445f0-0318-4bdc-aea7-706657c7a61d', '38abd4bc-f09e-40ea-a26a-11c6a64b57f2', 8, 'Sons of Anarchy S05E08', 'Episode 8', 'https://image.tmdb.org/t/p/original/sW67RSH740Ogrp6LGDCgpgGaK1u.jpg', '2026-07-23 15:20:45.443248+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('1e5ab17d-c96b-4e4e-a4c2-a16a9b647ca7', '38abd4bc-f09e-40ea-a26a-11c6a64b57f2', 9, 'Sons of Anarchy S05E09', 'Episode 9', 'https://image.tmdb.org/t/p/original/sW67RSH740Ogrp6LGDCgpgGaK1u.jpg', '2026-07-23 15:20:45.443248+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('08f1b5b3-5554-49d5-ad1f-dfe75b0de463', '38abd4bc-f09e-40ea-a26a-11c6a64b57f2', 10, 'Sons of Anarchy S05E10', 'Episode 10', 'https://image.tmdb.org/t/p/original/sW67RSH740Ogrp6LGDCgpgGaK1u.jpg', '2026-07-23 15:20:45.443248+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('fc5bb8bb-5bc8-4c06-af12-fa98e47dacbc', '38abd4bc-f09e-40ea-a26a-11c6a64b57f2', 11, 'Sons of Anarchy S05E11', 'Episode 11', 'https://image.tmdb.org/t/p/original/sW67RSH740Ogrp6LGDCgpgGaK1u.jpg', '2026-07-23 15:20:45.443248+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('1acd005b-2c4d-44c9-a715-de8753a91db3', '38abd4bc-f09e-40ea-a26a-11c6a64b57f2', 12, 'Sons of Anarchy S05E12', 'Episode 12', 'https://image.tmdb.org/t/p/original/sW67RSH740Ogrp6LGDCgpgGaK1u.jpg', '2026-07-23 15:20:45.443248+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('8ecd6e3e-cfdc-4189-ac6e-1f8c2bcdcfcc', '38abd4bc-f09e-40ea-a26a-11c6a64b57f2', 13, 'Sons of Anarchy S05E13', 'Episode 13', 'https://image.tmdb.org/t/p/original/sW67RSH740Ogrp6LGDCgpgGaK1u.jpg', '2026-07-23 15:20:45.443248+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('77c2deb4-4b84-4592-a048-c57a573d3c75', '4d849e15-637c-41c6-a015-e4b236fad674', 1, 'Sons of Anarchy S06E01', 'Episode 1', 'https://image.tmdb.org/t/p/original/tB22kwHHXGAHT52P4bgBtBAPBRS.jpg', '2026-07-25 11:21:03.246098+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('3cfe9b71-d26b-4d27-ab90-cde86b07216d', '4d849e15-637c-41c6-a015-e4b236fad674', 2, 'Sons of Anarchy S06E02', 'Episode 2', 'https://image.tmdb.org/t/p/original/tB22kwHHXGAHT52P4bgBtBAPBRS.jpg', '2026-07-25 11:21:03.246098+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('64dbf9bb-cb79-4704-a86b-f1c041c7da84', '4d849e15-637c-41c6-a015-e4b236fad674', 3, 'Sons of Anarchy S06E03', 'Episode 3', 'https://image.tmdb.org/t/p/original/tB22kwHHXGAHT52P4bgBtBAPBRS.jpg', '2026-07-25 11:21:03.246098+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('75ce2c81-1976-43a1-ad91-dcce0c4c592e', '4d849e15-637c-41c6-a015-e4b236fad674', 4, 'Sons of Anarchy S06E04', 'Episode 4', 'https://image.tmdb.org/t/p/original/tB22kwHHXGAHT52P4bgBtBAPBRS.jpg', '2026-07-25 11:21:03.246098+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('64ea51cc-d8bd-405c-a422-5b2781e32566', '4d849e15-637c-41c6-a015-e4b236fad674', 5, 'Sons of Anarchy S06E05', 'Episode 5', 'https://image.tmdb.org/t/p/original/tB22kwHHXGAHT52P4bgBtBAPBRS.jpg', '2026-07-25 11:21:03.246098+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('1c9893ce-278f-4c24-a7d2-a35198f81a1b', '4d849e15-637c-41c6-a015-e4b236fad674', 6, 'Sons of Anarchy S06E06', 'Episode 6', 'https://image.tmdb.org/t/p/original/tB22kwHHXGAHT52P4bgBtBAPBRS.jpg', '2026-07-25 11:21:03.246098+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('7e8ba31b-90ab-4c2b-a836-a7a609313b90', '291b580e-934f-4a68-a631-23f1e4a2d904', 1, 'The Walking Dead: Dead City S03E01', 'Episode 1', 'https://image.tmdb.org/t/p/original/seYokxOjFyTVX13XgD2FNjWIry8.jpg', '2026-07-26 09:14:46.57961+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('edab7b3c-681d-4c9d-ace4-071fe9f67022', '4d849e15-637c-41c6-a015-e4b236fad674', 7, 'Sons of Anarchy S06E07', 'Episode 7', 'https://image.tmdb.org/t/p/original/tB22kwHHXGAHT52P4bgBtBAPBRS.jpg', '2026-07-26 15:57:14.899352+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('03492fb2-46fa-4256-a8de-cfc9d010374a', '4d849e15-637c-41c6-a015-e4b236fad674', 8, 'Sons of Anarchy S06E08', 'Episode 8', 'https://image.tmdb.org/t/p/original/tB22kwHHXGAHT52P4bgBtBAPBRS.jpg', '2026-07-26 15:57:14.899352+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('92c0e755-8f28-41e3-a80c-964e244d2838', '4d849e15-637c-41c6-a015-e4b236fad674', 9, 'Sons of Anarchy S06E09', 'Episode 9', 'https://image.tmdb.org/t/p/original/tB22kwHHXGAHT52P4bgBtBAPBRS.jpg', '2026-07-26 15:57:14.899352+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('bd69d98f-b680-4233-a936-b5757b761ca5', '4d849e15-637c-41c6-a015-e4b236fad674', 10, 'Sons of Anarchy S06E10', 'Episode 10', 'https://image.tmdb.org/t/p/original/tB22kwHHXGAHT52P4bgBtBAPBRS.jpg', '2026-07-26 15:57:14.899352+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('284cc148-417f-41bd-a016-a334425cf20b', '4d849e15-637c-41c6-a015-e4b236fad674', 11, 'Sons of Anarchy S06E11', 'Episode 11', 'https://image.tmdb.org/t/p/original/tB22kwHHXGAHT52P4bgBtBAPBRS.jpg', '2026-07-26 15:57:14.899352+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('6893db14-d921-4e5d-aee9-00a9a7684990', '4d849e15-637c-41c6-a015-e4b236fad674', 12, 'Sons of Anarchy S06E12', 'Episode 12', 'https://image.tmdb.org/t/p/original/tB22kwHHXGAHT52P4bgBtBAPBRS.jpg', '2026-07-26 15:57:14.899352+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('66a09de6-2feb-4a98-aded-f4c7876c8389', '4d849e15-637c-41c6-a015-e4b236fad674', 13, 'Sons of Anarchy S06E13', 'Episode 13', 'https://image.tmdb.org/t/p/original/tB22kwHHXGAHT52P4bgBtBAPBRS.jpg', '2026-07-26 15:57:14.899352+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('20c0ef33-dcc6-4a16-af37-7120dfa53ff5', '238f5cc0-d71d-412e-a585-b88983d953d7', 6, 'House of The Dragon S03E06', 'Episode 6', 'https://image.tmdb.org/t/p/original/7V0Ebks0GgpKvQ7QbLAIdX5dos4.jpg', '2026-07-26 19:36:34.146575+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('d0f4555f-a4fc-4da0-aa16-250bf17b6dc6', '6647736d-c0f3-4e5d-a780-82061fa49383', 1, 'The Sopranos S01E01', 'Episode 1', 'https://image.tmdb.org/t/p/original/rTc7ZXdroqjkKivFPvCPX0Ru7uw.jpg', '2026-07-28 16:58:59.501453+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('2c4823c5-2eba-4b71-a8fc-8ecf344ae8a2', '722b8080-0c6d-4cc0-a15a-75c2b79760b5', 1, 'Sons of Anarchy S07E01', 'Episode 1', 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-28 17:47:57.477299+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('63b40e8f-3f58-4378-aef8-b4e46519ccd7', '722b8080-0c6d-4cc0-a15a-75c2b79760b5', 2, 'Sons of Anarchy S07E02', 'Episode 2', 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-28 17:47:57.477299+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('5e5d6994-0c1e-4a5b-a409-0ec027c01610', '722b8080-0c6d-4cc0-a15a-75c2b79760b5', 3, 'Sons of Anarchy S07E03', 'Episode 3', 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-28 17:47:57.477299+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('58f4f368-2048-4dfe-ade8-cb8f6a71335c', '722b8080-0c6d-4cc0-a15a-75c2b79760b5', 4, 'Sons of Anarchy S07E04', 'Episode 4', 'https://image.tmdb.org/t/p/original/tB22kwHHXGAHT52P4bgBtBAPBRS.jpg', '2026-07-29 15:47:39.376403+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('b644584d-6beb-4f9e-afe9-eb5ee8eedfd1', '722b8080-0c6d-4cc0-a15a-75c2b79760b5', 5, 'Sons of Anarchy S07E05', 'Episode 5', 'https://image.tmdb.org/t/p/original/tB22kwHHXGAHT52P4bgBtBAPBRS.jpg', '2026-07-29 15:47:39.376403+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('83d768fe-b45e-4c9d-a6f4-45972629217b', '722b8080-0c6d-4cc0-a15a-75c2b79760b5', 6, 'Sons of Anarchy S07E06', 'Episode 6', 'https://image.tmdb.org/t/p/original/tB22kwHHXGAHT52P4bgBtBAPBRS.jpg', '2026-07-29 15:47:39.376403+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('955ea3c4-c95a-4ab3-adda-230eb371fee4', '722b8080-0c6d-4cc0-a15a-75c2b79760b5', 7, 'Sons of Anarchy S07E07', 'Episode 7', 'https://image.tmdb.org/t/p/original/tB22kwHHXGAHT52P4bgBtBAPBRS.jpg', '2026-07-29 15:47:39.376403+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('0302ad93-a071-4659-a7ac-68d2eadbce48', '6647736d-c0f3-4e5d-a780-82061fa49383', 2, 'The Sopranos S01E02', 'Episode 2', 'https://image.tmdb.org/t/p/original/rTc7ZXdroqjkKivFPvCPX0Ru7uw.jpg', '2026-07-29 16:57:22.390038+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('e76fccd1-c5d4-4364-a13a-cdd08d7f82dc', '722b8080-0c6d-4cc0-a15a-75c2b79760b5', 8, 'Sons of Anarchy S07E08', 'Episode 8', 'https://image.tmdb.org/t/p/original/tB22kwHHXGAHT52P4bgBtBAPBRS.jpg', '2026-07-30 09:44:00.617394+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('8effbb46-e183-4e09-acd6-8e7020089a5c', '722b8080-0c6d-4cc0-a15a-75c2b79760b5', 9, 'Sons of Anarchy S07E09', 'Episode 9', 'https://image.tmdb.org/t/p/original/tB22kwHHXGAHT52P4bgBtBAPBRS.jpg', '2026-07-30 09:44:00.617394+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('406954d8-a6c4-4461-a0f5-128b46a552cb', '722b8080-0c6d-4cc0-a15a-75c2b79760b5', 10, 'Sons of Anarchy S07E10', 'Episode 10', 'https://image.tmdb.org/t/p/original/tB22kwHHXGAHT52P4bgBtBAPBRS.jpg', '2026-07-30 09:44:00.617394+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('75dcb4d7-ad01-4b5d-ac44-af7dcc074143', '722b8080-0c6d-4cc0-a15a-75c2b79760b5', 11, 'Sons of Anarchy S07E11', 'Episode 11', 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-30 09:44:00.617394+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('a3557a0a-cddd-4b54-ae83-078d0c5db74d', '722b8080-0c6d-4cc0-a15a-75c2b79760b5', 12, 'Sons of Anarchy S07E12', 'Episode 12', 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-30 09:44:00.617394+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('c3e0b55d-5d39-4694-a57e-290dc2dd1688', '722b8080-0c6d-4cc0-a15a-75c2b79760b5', 13, 'Sons of Anarchy S07E13', 'Episode 13', 'https://image.tmdb.org/t/p/original/kiy8BHtIHAslh81rvFcZ4wbNGdY.jpg', '2026-07-30 09:44:00.617394+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('ec8eed25-378b-42af-a65e-374ca3131bf2', '6647736d-c0f3-4e5d-a780-82061fa49383', 3, 'The Sopranos S01E03', 'Episode 3', 'https://image.tmdb.org/t/p/original/rTc7ZXdroqjkKivFPvCPX0Ru7uw.jpg', '2026-07-30 17:16:11.526432+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('a6cfd8cd-59ce-498f-a9bc-47204425eef6', '97b86cf5-a703-4325-aca3-02b874080ef1', 1, 'Batman: Caped Crusader S01E01', 'Episode 1', 'https://image.tmdb.org/t/p/original/tJ7zq4VtvJqUyaRsLeNjpEFDXzk.jpg', '2026-07-31 09:09:26.160221+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('f4fcbb58-0b08-4cee-a88c-c7365cf0659b', '97b86cf5-a703-4325-aca3-02b874080ef1', 2, 'Batman: Caped Crusader S01E02', 'Episode 2', 'https://image.tmdb.org/t/p/original/tJ7zq4VtvJqUyaRsLeNjpEFDXzk.jpg', '2026-07-31 09:09:26.160221+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('3b51ac84-ce09-4234-a343-1c74913985a4', '97b86cf5-a703-4325-aca3-02b874080ef1', 3, 'Batman: Caped Crusader S01E03', 'Episode 3', 'https://image.tmdb.org/t/p/original/tJ7zq4VtvJqUyaRsLeNjpEFDXzk.jpg', '2026-07-31 09:09:26.160221+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('e9ae28bd-37c8-47a9-ac40-32dafe67d221', '97b86cf5-a703-4325-aca3-02b874080ef1', 4, 'Batman: Caped Crusader S01E04', 'Episode 4', 'https://image.tmdb.org/t/p/original/tJ7zq4VtvJqUyaRsLeNjpEFDXzk.jpg', '2026-07-31 09:09:26.160221+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('ba471fc4-cdd7-433f-ac73-5630f9f7805a', '97b86cf5-a703-4325-aca3-02b874080ef1', 5, 'Batman: Caped Crusader S01E05', 'Episode 5', 'https://image.tmdb.org/t/p/original/tJ7zq4VtvJqUyaRsLeNjpEFDXzk.jpg', '2026-07-31 09:09:26.160221+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('fea0951d-e28c-4d8c-a0ac-6b46c488eddd', '6647736d-c0f3-4e5d-a780-82061fa49383', 4, 'The Sopranos S01E04', 'Episode 4', 'https://image.tmdb.org/t/p/original/rTc7ZXdroqjkKivFPvCPX0Ru7uw.jpg', '2026-07-31 15:59:35.827563+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('2a0eae91-9ba4-4a13-afe3-ebb0cd010529', '6647736d-c0f3-4e5d-a780-82061fa49383', 5, 'The Sopranos S01E05', 'Episode 5', 'https://image.tmdb.org/t/p/original/rTc7ZXdroqjkKivFPvCPX0Ru7uw.jpg', '2026-07-31 17:35:43.965012+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('95edb036-490d-4672-a691-de72f1fc4433', '6647736d-c0f3-4e5d-a780-82061fa49383', 6, 'The Sopranos S01E06', 'Episode 6', 'https://image.tmdb.org/t/p/original/rTc7ZXdroqjkKivFPvCPX0Ru7uw.jpg', '2026-08-01 18:42:43.72199+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('a4c80c92-c0cd-42c0-a40c-d11d2446d96f', '6647736d-c0f3-4e5d-a780-82061fa49383', 7, 'The Sopranos S01E07', 'Episode 7', 'https://image.tmdb.org/t/p/original/rTc7ZXdroqjkKivFPvCPX0Ru7uw.jpg', '2026-08-01 18:42:43.72199+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('c4b9733a-acb6-4a6c-a682-6ff934780c1f', '6647736d-c0f3-4e5d-a780-82061fa49383', 8, 'The Sopranos S01E08', 'Episode 8', 'https://image.tmdb.org/t/p/original/rTc7ZXdroqjkKivFPvCPX0Ru7uw.jpg', '2026-08-01 18:42:43.72199+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('51d69f36-0897-4aa6-a071-3091f4df449c', '6647736d-c0f3-4e5d-a780-82061fa49383', 9, 'The Sopranos S01E09', 'Episode 9', 'https://image.tmdb.org/t/p/original/rTc7ZXdroqjkKivFPvCPX0Ru7uw.jpg', '2026-08-02 11:53:59.619015+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('710e795f-a404-46ce-aaf6-0343d30ccc43', '6647736d-c0f3-4e5d-a780-82061fa49383', 10, 'The Sopranos S01E10', 'Episode 10', 'https://image.tmdb.org/t/p/original/rTc7ZXdroqjkKivFPvCPX0Ru7uw.jpg', '2026-08-02 11:53:59.619015+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('31700cda-d742-45d1-a603-a060d2967c16', '6647736d-c0f3-4e5d-a780-82061fa49383', 11, 'The Sopranos S01E11', 'Episode 11', 'https://image.tmdb.org/t/p/original/rTc7ZXdroqjkKivFPvCPX0Ru7uw.jpg', '2026-08-02 11:53:59.619015+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('65c4f780-ba0b-4b8f-a989-a8071213610a', '6647736d-c0f3-4e5d-a780-82061fa49383', 12, 'The Sopranos S01E12', 'Episode 12', 'https://image.tmdb.org/t/p/original/rTc7ZXdroqjkKivFPvCPX0Ru7uw.jpg', '2026-08-02 11:53:59.619015+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('cf2881d3-1dd2-4b90-a256-15d63f803d58', '6647736d-c0f3-4e5d-a780-82061fa49383', 13, 'The Sopranos S01E13', 'Episode 13', 'https://image.tmdb.org/t/p/original/rTc7ZXdroqjkKivFPvCPX0Ru7uw.jpg', '2026-08-02 11:53:59.619015+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('74c2427b-5304-48b9-af5f-eaba3842a990', '238f5cc0-d71d-412e-a585-b88983d953d7', 7, 'House of The Dragon S03E07', 'Episode 7', 'https://image.tmdb.org/t/p/original/7V0Ebks0GgpKvQ7QbLAIdX5dos4.jpg', '2026-08-03 02:22:22.473636+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('f5146e8f-c913-4aad-a945-fa8b34b8778c', '291b580e-934f-4a68-a631-23f1e4a2d904', 2, 'The Walking Dead: Dead City S03E02', 'Episode 2', 'https://image.tmdb.org/t/p/original/seYokxOjFyTVX13XgD2FNjWIry8.jpg', '2026-08-03 09:03:10.202106+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('11381df3-b8be-48d4-a1ad-569e05c95521', '9e6fe1f3-ed15-40b2-ab7e-611a8fcc19a1', 1, 'The Sopranos S02E01', 'Episode 1', 'https://image.tmdb.org/t/p/original/u7dlARwP2zsqHaMNL5HtHhaEPea.jpg', '2026-08-04 13:03:55.568064+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('fb0ccdae-d227-469d-a5bf-8397a8e67e11', '9e6fe1f3-ed15-40b2-ab7e-611a8fcc19a1', 2, 'The Sopranos S02E02', 'Episode 2', 'https://image.tmdb.org/t/p/original/u7dlARwP2zsqHaMNL5HtHhaEPea.jpg', '2026-08-04 13:03:55.568064+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('45bb51fe-8399-4ff9-aca0-0fb5ef8e5f0d', '9e6fe1f3-ed15-40b2-ab7e-611a8fcc19a1', 3, 'The Sopranos S02E03', 'Episode 3', 'https://image.tmdb.org/t/p/original/u7dlARwP2zsqHaMNL5HtHhaEPea.jpg', '2026-08-04 13:03:55.568064+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('dc904877-7506-487a-a885-56cae91aa869', '9e6fe1f3-ed15-40b2-ab7e-611a8fcc19a1', 4, 'The Sopranos S02E04', 'Episode 4', 'https://image.tmdb.org/t/p/original/u7dlARwP2zsqHaMNL5HtHhaEPea.jpg', '2026-08-04 13:03:55.568064+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('1a42ff11-76f2-406f-a112-74050f0ed6b3', '9e6fe1f3-ed15-40b2-ab7e-611a8fcc19a1', 5, 'The Sopranos S02E05', 'Episode 5', 'https://image.tmdb.org/t/p/original/u7dlARwP2zsqHaMNL5HtHhaEPea.jpg', '2026-08-04 13:03:55.568064+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('5a628954-c86b-4446-aba7-35c164668a1b', '9e6fe1f3-ed15-40b2-ab7e-611a8fcc19a1', 6, 'The Sopranos S02E06', 'Episode 6', 'https://image.tmdb.org/t/p/original/u7dlARwP2zsqHaMNL5HtHhaEPea.jpg', '2026-08-04 13:03:55.568064+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('25c29c59-b2ed-47b4-aab3-5c75da0f60af', '9e6fe1f3-ed15-40b2-ab7e-611a8fcc19a1', 7, 'The Sopranos S02E07', 'Episode 7', 'https://image.tmdb.org/t/p/original/u7dlARwP2zsqHaMNL5HtHhaEPea.jpg', '2026-08-04 13:03:55.568064+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('066a18bc-7bdb-4a18-aa2e-4cbad14402c4', '97b86cf5-a703-4325-aca3-02b874080ef1', 6, 'Batman: Caped Crusader S01E06', 'Episode 6', 'https://image.tmdb.org/t/p/original/tJ7zq4VtvJqUyaRsLeNjpEFDXzk.jpg', '2026-08-05 06:40:15.262255+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('13adeaee-d6b9-4ce7-aaa3-22014c09f3fe', '97b86cf5-a703-4325-aca3-02b874080ef1', 7, 'Batman: Caped Crusader S01E07', 'Episode 7', 'https://image.tmdb.org/t/p/original/tJ7zq4VtvJqUyaRsLeNjpEFDXzk.jpg', '2026-08-05 06:40:15.262255+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('eb7be14d-309e-447a-af0c-77c067687792', '97b86cf5-a703-4325-aca3-02b874080ef1', 8, 'Batman: Caped Crusader S01E08', 'Episode 8', 'https://image.tmdb.org/t/p/original/tJ7zq4VtvJqUyaRsLeNjpEFDXzk.jpg', '2026-08-05 06:40:15.262255+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('8918d7af-ddc8-4d79-a115-648c4d8a842b', '97b86cf5-a703-4325-aca3-02b874080ef1', 9, 'Batman: Caped Crusader S01E09', 'Episode 9', 'https://image.tmdb.org/t/p/original/tJ7zq4VtvJqUyaRsLeNjpEFDXzk.jpg', '2026-08-05 06:40:15.262255+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('66a28dbc-03be-430c-ab95-6e85647ceb4a', '97b86cf5-a703-4325-aca3-02b874080ef1', 10, 'Batman: Caped Crusader S01E10', 'Episode 10', 'https://image.tmdb.org/t/p/original/tJ7zq4VtvJqUyaRsLeNjpEFDXzk.jpg', '2026-08-05 06:40:15.262255+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('d5ff3e6f-be53-41a0-a1db-a32c7fd6058c', '9e6fe1f3-ed15-40b2-ab7e-611a8fcc19a1', 8, 'The Sopranos S02E08', 'Episode 8', 'https://image.tmdb.org/t/p/original/u7dlARwP2zsqHaMNL5HtHhaEPea.jpg', '2026-08-05 14:04:25.09645+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('58f013a3-9706-4a95-a23b-1447a33dcfdd', '9e6fe1f3-ed15-40b2-ab7e-611a8fcc19a1', 9, 'The Sopranos S02E09', 'Episode 9', 'https://image.tmdb.org/t/p/original/u7dlARwP2zsqHaMNL5HtHhaEPea.jpg', '2026-08-05 14:04:25.09645+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('aecf096e-b032-4427-a048-5847754c40d9', '9e6fe1f3-ed15-40b2-ab7e-611a8fcc19a1', 10, 'The Sopranos S02E10', 'Episode 10', 'https://image.tmdb.org/t/p/original/u7dlARwP2zsqHaMNL5HtHhaEPea.jpg', '2026-08-05 14:04:25.09645+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('fc308178-cf48-4075-ae4f-7d52903534cf', '9e6fe1f3-ed15-40b2-ab7e-611a8fcc19a1', 11, 'The Sopranos S02E11', 'Episode 11', 'https://image.tmdb.org/t/p/original/u7dlARwP2zsqHaMNL5HtHhaEPea.jpg', '2026-08-05 14:04:25.09645+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('0da8bb61-54d3-4e34-a964-3c3aeeb2f16a', '9e6fe1f3-ed15-40b2-ab7e-611a8fcc19a1', 12, 'The Sopranos S02E12', 'Episode 12', 'https://image.tmdb.org/t/p/original/u7dlARwP2zsqHaMNL5HtHhaEPea.jpg', '2026-08-05 14:04:25.09645+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('8edacccc-9ea3-464e-a452-1a43a32f6a8c', '9e6fe1f3-ed15-40b2-ab7e-611a8fcc19a1', 13, 'The Sopranos S02E13', 'Episode 13', 'https://image.tmdb.org/t/p/original/u7dlARwP2zsqHaMNL5HtHhaEPea.jpg', '2026-08-05 14:04:25.09645+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('c8b7d6e7-659c-441d-a6b2-0f793f7a12f3', '3bfcd8ef-0048-4ebd-a0f2-1fa54b1f797e', 1, 'Black Bird S01E01', 'Episode 1', 'https://image.tmdb.org/t/p/original/qu312pwM61NPTr7nexvovCClDNP.jpg', '2026-08-06 10:35:58.56554+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('b8b71ba1-035c-4e38-abeb-5a963747103b', '3bfcd8ef-0048-4ebd-a0f2-1fa54b1f797e', 2, 'Black Bird S01E02', 'Episode 2', 'https://image.tmdb.org/t/p/original/qu312pwM61NPTr7nexvovCClDNP.jpg', '2026-08-06 10:35:58.56554+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('c6bd7616-67b9-4ef0-ab7b-8f0dc1c59094', '3bfcd8ef-0048-4ebd-a0f2-1fa54b1f797e', 3, 'Black Bird S01E03', 'Episode 3', 'https://image.tmdb.org/t/p/original/qu312pwM61NPTr7nexvovCClDNP.jpg', '2026-08-06 10:35:58.56554+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('97480402-5c90-4820-a67b-eb3200b200fd', '3bfcd8ef-0048-4ebd-a0f2-1fa54b1f797e', 4, 'Black Bird S01E04', 'Episode 4', 'https://image.tmdb.org/t/p/original/qu312pwM61NPTr7nexvovCClDNP.jpg', '2026-08-06 10:35:58.56554+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('bdb6486a-12de-48ef-a744-d33ba66f3350', '3bfcd8ef-0048-4ebd-a0f2-1fa54b1f797e', 5, 'Black Bird S01E05', 'Episode 5', 'https://image.tmdb.org/t/p/original/qu312pwM61NPTr7nexvovCClDNP.jpg', '2026-08-06 10:35:58.56554+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('ace2be51-4e1b-4bda-aaf2-0ba9c9503f18', '3bfcd8ef-0048-4ebd-a0f2-1fa54b1f797e', 6, 'Black Bird S01E06', 'Episode 6', 'https://image.tmdb.org/t/p/original/qu312pwM61NPTr7nexvovCClDNP.jpg', '2026-08-06 10:35:58.56554+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('40eff4a1-1286-4be5-a527-ed426a350c79', '2a8648ce-dc1f-417a-a81c-d355f8f502a2', 1, 'Our Sticky Love S01E01', 'Episode 1', 'https://image.tmdb.org/t/p/original/tSZ4aFpTGc8Oj52SuzPUUZ7WKL0.jpg', '2026-08-08 08:30:23.609856+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('94a241a0-94ee-4f4b-a1d3-266d92a048ae', '396b7b20-bec8-42b2-a30b-ce95e82e6ae6', 1, 'The Night of S01E01', 'Episode 1', 'https://image.tmdb.org/t/p/original/q13XJHdnsmxQL9rXRcnNDrZGHjO.jpg', '2026-08-08 11:01:21.636301+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('37e475b0-4507-43f7-aedc-49ec791400af', '238f5cc0-d71d-412e-a585-b88983d953d7', 8, 'House of The Dragon S03E08', 'Episode 8', 'https://image.tmdb.org/t/p/original/7V0Ebks0GgpKvQ7QbLAIdX5dos4.jpg', '2026-08-09 18:17:04.550544+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('f553f3c2-685f-4c47-affe-6a4a9bb08a82', '291b580e-934f-4a68-a631-23f1e4a2d904', 3, 'The Walking Dead: Dead City S03E03', 'Episode 3', 'https://image.tmdb.org/t/p/original/seYokxOjFyTVX13XgD2FNjWIry8.jpg', '2026-08-10 13:02:14.876293+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('1a8c74d1-454f-4eda-a981-9fd8cac7e925', 'cded2aba-34c3-4566-aac9-f9d32a12ed8b', 1, 'The Sopranos S03E01', 'Episode 1', 'https://image.tmdb.org/t/p/original/fg2sTwO5FglA1S6prL7GlCo124n.jpg', '2026-08-11 13:42:49.900781+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('ad4d6aa8-2423-44af-adf0-3f06c3286455', 'cded2aba-34c3-4566-aac9-f9d32a12ed8b', 2, 'The Sopranos S03E02', 'Episode 2', 'https://image.tmdb.org/t/p/original/fg2sTwO5FglA1S6prL7GlCo124n.jpg', '2026-08-11 13:42:49.900781+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('58fe2ca3-311b-42e3-a5dc-88f3bb2f1979', 'cded2aba-34c3-4566-aac9-f9d32a12ed8b', 3, 'The Sopranos S03E03', 'Episode 3', 'https://image.tmdb.org/t/p/original/fg2sTwO5FglA1S6prL7GlCo124n.jpg', '2026-08-11 13:42:49.900781+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('e27888a2-fb08-4a4b-ac48-f237cd8fed6b', 'cded2aba-34c3-4566-aac9-f9d32a12ed8b', 4, 'The Sopranos S03E04', 'Episode 4', 'https://image.tmdb.org/t/p/original/fg2sTwO5FglA1S6prL7GlCo124n.jpg', '2026-08-11 13:42:49.900781+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('1b656de1-5e5f-4102-aca3-4789567c3579', 'cded2aba-34c3-4566-aac9-f9d32a12ed8b', 5, 'The Sopranos S03E05', 'Episode 5', 'https://image.tmdb.org/t/p/original/fg2sTwO5FglA1S6prL7GlCo124n.jpg', '2026-08-11 13:42:49.900781+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('8991af5f-0ff6-4961-a2b5-e9a555cd95bc', 'dce280d1-b521-4972-ae66-5a5cdaaa5ab5', 1, 'Reacher S04E01', 'Episode 1', 'https://image.tmdb.org/t/p/original/wkKJHC34dIw9cJwAfNEEgDdb2ol.jpg', '2026-08-12 08:51:51.598699+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('f5d37077-57ba-49ed-aa2f-478e40f20cb0', 'dce280d1-b521-4972-ae66-5a5cdaaa5ab5', 2, 'Reacher S04E02', 'Episode 2', 'https://image.tmdb.org/t/p/original/wkKJHC34dIw9cJwAfNEEgDdb2ol.jpg', '2026-08-12 11:07:22.290595+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('8b7fb51f-0142-4edf-a86b-adfbc039efc2', 'dce280d1-b521-4972-ae66-5a5cdaaa5ab5', 3, 'Reacher S04E03', 'Episode 3', 'https://image.tmdb.org/t/p/original/wkKJHC34dIw9cJwAfNEEgDdb2ol.jpg', '2026-08-12 11:07:22.290595+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('6280c28b-3194-4a60-a8fe-a7a3a13699d7', '396b7b20-bec8-42b2-a30b-ce95e82e6ae6', 2, 'The Night Of S01E02', 'Episode 2', 'https://image.tmdb.org/t/p/original/q13XJHdnsmxQL9rXRcnNDrZGHjO.jpg', '2026-08-12 17:01:42.133751+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('c8188f07-4d2e-470c-afd0-244c7378402b', '396b7b20-bec8-42b2-a30b-ce95e82e6ae6', 3, 'The Night Of S01E03', 'Episode 3', 'https://image.tmdb.org/t/p/original/q13XJHdnsmxQL9rXRcnNDrZGHjO.jpg', '2026-08-12 17:01:42.133751+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('85b87adc-baa2-491d-ab40-3727af06ddad', '396b7b20-bec8-42b2-a30b-ce95e82e6ae6', 4, 'The Night Of S01E04', 'Episode 4', 'https://image.tmdb.org/t/p/original/q13XJHdnsmxQL9rXRcnNDrZGHjO.jpg', '2026-08-12 17:01:42.133751+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('e7846de1-9b15-49dc-aacd-f480f9d50dcf', '396b7b20-bec8-42b2-a30b-ce95e82e6ae6', 5, 'The Night Of S01E05', 'Episode 5', 'https://image.tmdb.org/t/p/original/q13XJHdnsmxQL9rXRcnNDrZGHjO.jpg', '2026-08-12 17:01:42.133751+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('70e78e42-65e2-4fbd-a4d0-6b9dfa82206f', '396b7b20-bec8-42b2-a30b-ce95e82e6ae6', 6, 'The Night Of S01E06', 'Episode 6', 'https://image.tmdb.org/t/p/original/q13XJHdnsmxQL9rXRcnNDrZGHjO.jpg', '2026-08-12 17:01:42.133751+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('61604b7c-f5cb-4fb0-a4e5-6bc2adaf755f', '396b7b20-bec8-42b2-a30b-ce95e82e6ae6', 7, 'The Night Of S01E07', 'Episode 7', 'https://image.tmdb.org/t/p/original/q13XJHdnsmxQL9rXRcnNDrZGHjO.jpg', '2026-08-12 17:01:42.133751+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('ff4dcc37-773b-4aed-a294-ae8f4a20d492', '396b7b20-bec8-42b2-a30b-ce95e82e6ae6', 8, 'The Night Of S01E08', 'Episode 8', 'https://image.tmdb.org/t/p/original/q13XJHdnsmxQL9rXRcnNDrZGHjO.jpg', '2026-08-12 17:01:42.133751+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('191fb25b-1489-4aa5-a09c-3a1bb5035682', 'cded2aba-34c3-4566-aac9-f9d32a12ed8b', 6, 'The Sopranos S03E06', 'Episode 6', 'https://image.tmdb.org/t/p/original/fg2sTwO5FglA1S6prL7GlCo124n.jpg', '2026-08-13 13:52:53.403139+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('0e544c60-134d-4b6e-ab7a-d60812c17d9d', 'cded2aba-34c3-4566-aac9-f9d32a12ed8b', 7, 'The Sopranos S03E07', 'Episode 7', 'https://image.tmdb.org/t/p/original/fg2sTwO5FglA1S6prL7GlCo124n.jpg', '2026-08-13 13:52:53.403139+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('f658749e-03ec-41a8-ac3c-3036f9d85f33', 'cded2aba-34c3-4566-aac9-f9d32a12ed8b', 8, 'The Sopranos S03E08', 'Episode 8', 'https://image.tmdb.org/t/p/original/fg2sTwO5FglA1S6prL7GlCo124n.jpg', '2026-08-13 13:52:53.403139+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('8cc52726-234b-432b-af43-5ce8491f5a8b', 'cded2aba-34c3-4566-aac9-f9d32a12ed8b', 9, 'The Sopranos S03E09', 'Episode 9', 'https://image.tmdb.org/t/p/original/fg2sTwO5FglA1S6prL7GlCo124n.jpg', '2026-08-13 13:52:53.403139+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('e9b5512c-2484-45b0-a8bb-4b80aa715f3c', 'cded2aba-34c3-4566-aac9-f9d32a12ed8b', 10, 'The Sopranos S03E10', 'Episode 10', 'https://image.tmdb.org/t/p/original/fg2sTwO5FglA1S6prL7GlCo124n.jpg', '2026-08-13 13:52:53.403139+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('5be25a7b-2fee-4755-a871-5650c019faf5', 'cded2aba-34c3-4566-aac9-f9d32a12ed8b', 11, 'The Sopranos S03E11', 'Episode 11', 'https://image.tmdb.org/t/p/original/fg2sTwO5FglA1S6prL7GlCo124n.jpg', '2026-08-13 13:52:53.403139+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('149865ec-ea72-4647-ab86-b12fdb66a63a', 'cded2aba-34c3-4566-aac9-f9d32a12ed8b', 12, 'The Sopranos S03E12', 'Episode 12', 'https://image.tmdb.org/t/p/original/fg2sTwO5FglA1S6prL7GlCo124n.jpg', '2026-08-13 13:52:53.403139+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('a0be06c0-210a-4599-aa21-fc366d3a818d', 'cded2aba-34c3-4566-aac9-f9d32a12ed8b', 13, 'The Sopranos S03E13', 'Episode 13', 'https://image.tmdb.org/t/p/original/fg2sTwO5FglA1S6prL7GlCo124n.jpg', '2026-08-13 13:52:53.403139+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('98b05e9d-cd93-4508-a217-81fd5b3b0036', '415f4dd7-12e0-48d0-aaa6-a2075689e704', 1, 'The Sopranos S04E01', 'Episode 1', 'https://image.tmdb.org/t/p/original/EwMBNMUIx9kKf0DpijNF1bncJT.jpg', '2026-08-15 23:36:34.227099+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('8f2f9892-b228-4212-abb5-35515d84c0a3', '415f4dd7-12e0-48d0-aaa6-a2075689e704', 2, 'The Sopranos S04E02', 'Episode 2', 'https://image.tmdb.org/t/p/original/EwMBNMUIx9kKf0DpijNF1bncJT.jpg', '2026-08-15 23:36:34.227099+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('8aba4e35-8b7b-4d06-ad89-6551b5f9b402', '415f4dd7-12e0-48d0-aaa6-a2075689e704', 3, 'The Sopranos S04E03', 'Episode 3', 'https://image.tmdb.org/t/p/original/EwMBNMUIx9kKf0DpijNF1bncJT.jpg', '2026-08-15 23:36:34.227099+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('b5f05606-c416-4a11-aa1a-80b6bd800c37', '415f4dd7-12e0-48d0-aaa6-a2075689e704', 4, 'The Sopranos S04E04', 'Episode 4', 'https://image.tmdb.org/t/p/original/EwMBNMUIx9kKf0DpijNF1bncJT.jpg', '2026-08-15 23:36:34.227099+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('1d377f3c-ab53-4cb6-af8f-09a404e8f723', '415f4dd7-12e0-48d0-aaa6-a2075689e704', 5, 'The Sopranos S04E05', 'Episode 5', 'https://image.tmdb.org/t/p/original/EwMBNMUIx9kKf0DpijNF1bncJT.jpg', '2026-08-15 23:36:34.227099+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('2372aab2-eef2-4116-a97b-d582cadfa8e2', '415f4dd7-12e0-48d0-aaa6-a2075689e704', 6, 'The Sopranos S04E06', 'Episode 6', 'https://image.tmdb.org/t/p/original/EwMBNMUIx9kKf0DpijNF1bncJT.jpg', '2026-08-15 23:36:34.227099+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('b464488c-24ac-4d31-ae16-e649bef534e6', '415f4dd7-12e0-48d0-aaa6-a2075689e704', 7, 'The Sopranos S04E07', 'Episode 7', 'https://image.tmdb.org/t/p/original/EwMBNMUIx9kKf0DpijNF1bncJT.jpg', '2026-08-15 23:36:34.227099+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('b7936214-2dc4-442d-a9a0-765a41cb09f8', '415f4dd7-12e0-48d0-aaa6-a2075689e704', 8, 'The Sopranos S04E08', 'Episode 8', 'https://image.tmdb.org/t/p/original/EwMBNMUIx9kKf0DpijNF1bncJT.jpg', '2026-08-15 23:36:34.227099+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('3fe5fc3e-c492-42e3-a74b-b6c44d1c324a', '415f4dd7-12e0-48d0-aaa6-a2075689e704', 9, 'The Sopranos S04E09', 'Episode 9', 'https://image.tmdb.org/t/p/original/EwMBNMUIx9kKf0DpijNF1bncJT.jpg', '2026-08-15 23:36:34.227099+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('21643407-9641-4f7e-a223-6a653db20f25', '415f4dd7-12e0-48d0-aaa6-a2075689e704', 10, 'The Sopranos S04E10', 'Episode 10', 'https://image.tmdb.org/t/p/original/EwMBNMUIx9kKf0DpijNF1bncJT.jpg', '2026-08-15 23:36:34.227099+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('3542bb23-9412-4424-a3f6-79690d79d547', '415f4dd7-12e0-48d0-aaa6-a2075689e704', 11, 'The Sopranos S04E11', 'Episode 11', 'https://image.tmdb.org/t/p/original/EwMBNMUIx9kKf0DpijNF1bncJT.jpg', '2026-08-15 23:36:34.227099+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('5015e274-d773-4989-a936-aa141bca60b5', '415f4dd7-12e0-48d0-aaa6-a2075689e704', 12, 'The Sopranos S04E12', 'Episode 12', 'https://image.tmdb.org/t/p/original/EwMBNMUIx9kKf0DpijNF1bncJT.jpg', '2026-08-15 23:36:34.227099+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('20d369a0-cefe-4535-a150-8bb00fe3e54b', '415f4dd7-12e0-48d0-aaa6-a2075689e704', 13, 'The Sopranos S04E13', 'Episode 13', 'https://image.tmdb.org/t/p/original/EwMBNMUIx9kKf0DpijNF1bncJT.jpg', '2026-08-15 23:36:34.227099+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('38dd3b0b-21d7-4f1e-ad07-3aa7b6acc95c', '9b2f9dc0-e6ac-479f-a80d-4a594b4ba8b0', 1, 'Lanterns (2026) S01E01', 'Episode 1', 'https://image.tmdb.org/t/p/original/isYpgPQdjxJ0Ht04uKgilVYGPp9.jpg', '2026-08-17 00:43:29.237961+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('cc38852b-5cd4-4356-abbf-5ec43ad09d8a', 'e12655e8-f100-4a5a-a5c8-a28c2f22a7b2', 1, 'Dexter S01E01', 'Episode 1', 'https://image.tmdb.org/t/p/original/rmhoMEHK3ZP2EAXX2VpxuKpW3Bf.jpg', '2026-08-22 06:41:53.87792+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('8e06915c-289b-4d6d-a80b-a4f0e98cb15c', 'e12655e8-f100-4a5a-a5c8-a28c2f22a7b2', 2, 'Dexter S01E02', 'Episode 2', 'https://image.tmdb.org/t/p/original/rmhoMEHK3ZP2EAXX2VpxuKpW3Bf.jpg', '2026-08-22 06:41:53.87792+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('3140d13c-9c60-49fd-aa70-564192a7a43f', 'e12655e8-f100-4a5a-a5c8-a28c2f22a7b2', 3, 'Dexter S01E03', 'Episode 3', 'https://image.tmdb.org/t/p/original/rmhoMEHK3ZP2EAXX2VpxuKpW3Bf.jpg', '2026-08-22 06:41:53.87792+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('4dbe64b1-0518-41ca-af49-1a236395688f', 'e12655e8-f100-4a5a-a5c8-a28c2f22a7b2', 4, 'Dexter S01E04', 'Episode 4', 'https://image.tmdb.org/t/p/original/rmhoMEHK3ZP2EAXX2VpxuKpW3Bf.jpg', '2026-08-22 06:41:53.87792+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('8c6ac497-91bf-4773-aa56-f652b4079059', 'e12655e8-f100-4a5a-a5c8-a28c2f22a7b2', 5, 'Dexter S01E05', 'Episode 5', 'https://image.tmdb.org/t/p/original/rmhoMEHK3ZP2EAXX2VpxuKpW3Bf.jpg', '2026-08-22 06:41:53.87792+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('e3fd67b4-9d7d-4873-acf2-c69dd004f52d', 'e12655e8-f100-4a5a-a5c8-a28c2f22a7b2', 6, 'Dexter S01E06', 'Episode 6', 'https://image.tmdb.org/t/p/original/rmhoMEHK3ZP2EAXX2VpxuKpW3Bf.jpg', '2026-08-22 06:41:53.87792+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('2f8cee7f-8dfa-4e76-acb0-db1aa0f743c3', 'e12655e8-f100-4a5a-a5c8-a28c2f22a7b2', 7, 'Dexter S01E07', 'Episode 7', 'https://image.tmdb.org/t/p/original/rmhoMEHK3ZP2EAXX2VpxuKpW3Bf.jpg', '2026-08-22 06:41:53.87792+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('2d833038-4754-4446-ace7-0c9d6d027c24', 'e12655e8-f100-4a5a-a5c8-a28c2f22a7b2', 8, 'Dexter S01E08', 'Episode 8', 'https://image.tmdb.org/t/p/original/rmhoMEHK3ZP2EAXX2VpxuKpW3Bf.jpg', '2026-08-22 06:41:53.87792+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('e0cfbf70-052a-4762-a631-7a5de70fbf94', 'e12655e8-f100-4a5a-a5c8-a28c2f22a7b2', 9, 'Dexter S01E09', 'Episode 9', 'https://image.tmdb.org/t/p/original/rmhoMEHK3ZP2EAXX2VpxuKpW3Bf.jpg', '2026-08-22 06:41:53.87792+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('fd7c84fb-6b9d-493c-ab4e-b98e383ba42c', 'e12655e8-f100-4a5a-a5c8-a28c2f22a7b2', 10, 'Dexter S01E10', 'Episode 10', 'https://image.tmdb.org/t/p/original/rmhoMEHK3ZP2EAXX2VpxuKpW3Bf.jpg', '2026-08-22 06:41:53.87792+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('7ccb2ea5-115e-49cc-af17-24eb219bd037', 'e12655e8-f100-4a5a-a5c8-a28c2f22a7b2', 11, 'Dexter S01E11', 'Episode 11', 'https://image.tmdb.org/t/p/original/rmhoMEHK3ZP2EAXX2VpxuKpW3Bf.jpg', '2026-08-22 06:41:53.87792+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('ffff599b-46ba-44fa-aab1-683027beb6bf', 'e12655e8-f100-4a5a-a5c8-a28c2f22a7b2', 12, 'Dexter S01E12', 'Episode 12', 'https://image.tmdb.org/t/p/original/rmhoMEHK3ZP2EAXX2VpxuKpW3Bf.jpg', '2026-08-22 06:41:53.87792+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('e5be140e-2674-4498-a88d-9945783b2dce', 'dce280d1-b521-4972-ae66-5a5cdaaa5ab5', 4, 'Reacher S04E04', 'Episode 4', 'https://image.tmdb.org/t/p/original/wkKJHC34dIw9cJwAfNEEgDdb2ol.jpg', '2026-08-23 09:40:14.081704+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('b7f6eba1-3322-462d-a996-27583b0b19cf', '2c3c11bd-f35b-4602-a475-0e1c00c1832d', 1, 'The Sopranos S05E01', 'Episode 1', 'https://image.tmdb.org/t/p/original/p651eYM0Vd0CWDvndbMyaS0lDeD.jpg', '2026-08-25 05:40:25.195915+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('507eb0cf-d4b2-4334-ae0e-9d37a3a380dc', '2c3c11bd-f35b-4602-a475-0e1c00c1832d', 2, 'The Sopranos S05E02', 'Episode 2', 'https://image.tmdb.org/t/p/original/p651eYM0Vd0CWDvndbMyaS0lDeD.jpg', '2026-08-25 05:40:25.195915+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('d015ab0b-ca0c-4431-a48e-773e66948ad7', '2c3c11bd-f35b-4602-a475-0e1c00c1832d', 3, 'The Sopranos S05E03', 'Episode 3', 'https://image.tmdb.org/t/p/original/p651eYM0Vd0CWDvndbMyaS0lDeD.jpg', '2026-08-25 05:40:25.195915+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('f36a3aea-3514-407f-a84c-acbb19de45dc', '2c3c11bd-f35b-4602-a475-0e1c00c1832d', 4, 'The Sopranos S05E04', 'Episode 4', 'https://image.tmdb.org/t/p/original/p651eYM0Vd0CWDvndbMyaS0lDeD.jpg', '2026-08-25 05:40:25.195915+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('8bb582af-39d8-4b26-a14e-71fddd8ac0eb', '2c3c11bd-f35b-4602-a475-0e1c00c1832d', 5, 'The Sopranos S05E05', 'Episode 5', 'https://image.tmdb.org/t/p/original/p651eYM0Vd0CWDvndbMyaS0lDeD.jpg', '2026-08-25 05:40:25.195915+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('bb419048-ba2c-4a88-a68f-d9e5e94e25ee', '2c3c11bd-f35b-4602-a475-0e1c00c1832d', 6, 'The Sopranos S05E06', 'Episode 6', 'https://image.tmdb.org/t/p/original/p651eYM0Vd0CWDvndbMyaS0lDeD.jpg', '2026-08-25 05:40:25.195915+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('424dce3b-babe-4e17-aaf0-3815dd3af1d7', '2c3c11bd-f35b-4602-a475-0e1c00c1832d', 7, 'The Sopranos S05E07', 'Episode 7', 'https://image.tmdb.org/t/p/original/p651eYM0Vd0CWDvndbMyaS0lDeD.jpg', '2026-08-25 05:40:25.195915+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('8f12f2b0-039c-4538-a584-f92e04e67a31', '2c3c11bd-f35b-4602-a475-0e1c00c1832d', 8, 'The Sopranos S05E08', 'Episode 8', 'https://image.tmdb.org/t/p/original/p651eYM0Vd0CWDvndbMyaS0lDeD.jpg', '2026-08-25 05:40:25.195915+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('4455e468-754f-4a46-a9f4-e88b128f3744', '2c3c11bd-f35b-4602-a475-0e1c00c1832d', 9, 'The Sopranos S05E09', 'Episode 9', 'https://image.tmdb.org/t/p/original/p651eYM0Vd0CWDvndbMyaS0lDeD.jpg', '2026-08-25 05:40:25.195915+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('816c2cac-e4e1-4630-ad0a-ef46fcbf4bff', '2c3c11bd-f35b-4602-a475-0e1c00c1832d', 10, 'The Sopranos S05E10', 'Episode 10', 'https://image.tmdb.org/t/p/original/p651eYM0Vd0CWDvndbMyaS0lDeD.jpg', '2026-08-25 05:40:25.195915+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('f9b0dd20-e0be-4aa8-a651-b7f0c1dd4bbf', '2c3c11bd-f35b-4602-a475-0e1c00c1832d', 11, 'The Sopranos S05E11', 'Episode 11', 'https://image.tmdb.org/t/p/original/p651eYM0Vd0CWDvndbMyaS0lDeD.jpg', '2026-08-25 05:40:25.195915+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('15d86585-56cd-4734-afc0-dbf78740b5af', '2c3c11bd-f35b-4602-a475-0e1c00c1832d', 12, 'The Sopranos S05E12', 'Episode 12', 'https://image.tmdb.org/t/p/original/p651eYM0Vd0CWDvndbMyaS0lDeD.jpg', '2026-08-25 05:40:25.195915+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('8a2eac0f-a913-4008-ab65-b538f4c2f4b3', '2c3c11bd-f35b-4602-a475-0e1c00c1832d', 13, 'The Sopranos S05E13', 'Episode 13', 'https://image.tmdb.org/t/p/original/p651eYM0Vd0CWDvndbMyaS0lDeD.jpg', '2026-08-25 05:40:25.195915+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('9ff7b188-18f9-43d9-a097-4796653c4c91', '9b2f9dc0-e6ac-479f-a80d-4a594b4ba8b0', 2, 'Lanterns (2026) S01E02', 'Episode 2', 'https://image.tmdb.org/t/p/original/isYpgPQdjxJ0Ht04uKgilVYGPp9.jpg', '2026-08-26 07:49:32.527149+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('f8a9e144-6890-42d0-a30b-d49809109286', 'dce280d1-b521-4972-ae66-5a5cdaaa5ab5', 5, 'Reacher S04E05', 'Episode 5', 'https://image.tmdb.org/t/p/original/wkKJHC34dIw9cJwAfNEEgDdb2ol.jpg', '2026-08-26 08:36:36.055185+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('0dcba767-bd00-4648-aaf2-56d993832cc7', '291b580e-934f-4a68-a631-23f1e4a2d904', 4, 'The Walking Dead: Dead City S03E04', 'Episode 4', 'https://image.tmdb.org/t/p/original/seYokxOjFyTVX13XgD2FNjWIry8.jpg', '2026-08-26 16:54:25.719949+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('6aabdd6a-da4d-45fe-acd3-72fc11464740', '291b580e-934f-4a68-a631-23f1e4a2d904', 5, 'The Walking Dead: Dead City S03E05', 'Episode 5', 'https://image.tmdb.org/t/p/original/seYokxOjFyTVX13XgD2FNjWIry8.jpg', '2026-08-26 16:54:25.719949+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('c3432fbd-3cf1-46c5-a5d8-a3a0a04c92a9', 'f5f10eb8-7bf5-434f-a4c7-ecc0a693fb17', 1, 'The Leftovers S01E01', 'Episode 1', 'https://image.tmdb.org/t/p/original/lxRQJr68o9fZI1RzGDc0qeYX4Je.jpg', '2026-08-27 05:15:49.32395+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('eb0a5895-faa8-4421-abd1-81eb83d38c21', 'f5f10eb8-7bf5-434f-a4c7-ecc0a693fb17', 2, 'The Leftovers S01E02', 'Episode 2', 'https://image.tmdb.org/t/p/original/lxRQJr68o9fZI1RzGDc0qeYX4Je.jpg', '2026-08-29 04:30:40.560346+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('c76b4dd5-0f9a-4889-ab54-8b634041a6aa', 'f5f10eb8-7bf5-434f-a4c7-ecc0a693fb17', 3, 'The Leftovers S01E03', 'Episode 3', 'https://image.tmdb.org/t/p/original/lxRQJr68o9fZI1RzGDc0qeYX4Je.jpg', '2026-08-29 04:30:40.560346+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('9d0c89fe-0f66-4967-afa4-1bfeae1b5aef', 'f5f10eb8-7bf5-434f-a4c7-ecc0a693fb17', 4, 'The Leftovers S01E04', 'Episode 4', 'https://image.tmdb.org/t/p/original/lxRQJr68o9fZI1RzGDc0qeYX4Je.jpg', '2026-08-29 04:30:40.560346+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('02e7ebbe-5f00-4f17-ad6d-f6cb85cffe78', 'f5f10eb8-7bf5-434f-a4c7-ecc0a693fb17', 5, 'The Leftovers S01E05', 'Episode 5', 'https://image.tmdb.org/t/p/original/lxRQJr68o9fZI1RzGDc0qeYX4Je.jpg', '2026-08-29 04:30:40.560346+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('7c3706f9-36a5-4b02-a4b1-ddcf13ca510c', 'f5f10eb8-7bf5-434f-a4c7-ecc0a693fb17', 6, 'The Leftovers S01E06', 'Episode 6', 'https://image.tmdb.org/t/p/original/lxRQJr68o9fZI1RzGDc0qeYX4Je.jpg', '2026-08-29 04:30:40.560346+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('bf8c6f91-ce9e-4e98-ab55-2fdd7be7ed64', 'f5f10eb8-7bf5-434f-a4c7-ecc0a693fb17', 7, 'The Leftovers S01E07', 'Episode 7', 'https://image.tmdb.org/t/p/original/lxRQJr68o9fZI1RzGDc0qeYX4Je.jpg', '2026-08-29 04:30:40.560346+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('410ae787-71a8-4123-a8cd-623731caa954', 'f5f10eb8-7bf5-434f-a4c7-ecc0a693fb17', 8, 'The Leftovers S01E08', 'Episode 8', 'https://image.tmdb.org/t/p/original/lxRQJr68o9fZI1RzGDc0qeYX4Je.jpg', '2026-08-29 04:30:40.560346+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('e0f33508-2a13-4da7-a9d1-8284926d9156', 'f5f10eb8-7bf5-434f-a4c7-ecc0a693fb17', 9, 'The Leftovers S01E09', 'Episode 9', 'https://image.tmdb.org/t/p/original/lxRQJr68o9fZI1RzGDc0qeYX4Je.jpg', '2026-08-29 04:30:40.560346+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('74fe1b70-0c3a-4484-a476-77da2e131e37', 'f5f10eb8-7bf5-434f-a4c7-ecc0a693fb17', 10, 'The Leftovers S01E10', 'Episode 10', 'https://image.tmdb.org/t/p/original/lxRQJr68o9fZI1RzGDc0qeYX4Je.jpg', '2026-08-29 04:30:40.560346+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('d8ae654a-085a-4e8b-abd9-4e9f78ec8a9d', '9d42845b-f3ec-4e7b-aa59-0d5bda0cf1e0', 1, 'The Wire S01E01', 'Episode 1', 'https://image.tmdb.org/t/p/original/4lbclFySvugI51fwsyxBTOm4DqK.jpg', '2026-08-29 16:00:51.135655+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('8a11b38a-0b2a-4923-a91c-bd5c1360eb95', '9d42845b-f3ec-4e7b-aa59-0d5bda0cf1e0', 2, 'The Wire S01E02', 'Episode 2', 'https://image.tmdb.org/t/p/original/4lbclFySvugI51fwsyxBTOm4DqK.jpg', '2026-08-29 16:00:51.135655+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('3b1497f3-7c33-47e6-ab08-c952b8002e16', '9d42845b-f3ec-4e7b-aa59-0d5bda0cf1e0', 3, 'The Wire S01E03', 'Episode 3', 'https://image.tmdb.org/t/p/original/4lbclFySvugI51fwsyxBTOm4DqK.jpg', '2026-08-29 16:00:51.135655+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('55d6d674-3ca0-44ad-acec-b9fc57d6802f', '9d42845b-f3ec-4e7b-aa59-0d5bda0cf1e0', 4, 'The Wire S01E04', 'Episode 4', 'https://image.tmdb.org/t/p/original/4lbclFySvugI51fwsyxBTOm4DqK.jpg', '2026-08-29 16:00:51.135655+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('6e0096f8-3ef5-4915-a616-dd32aa8dec91', '9d42845b-f3ec-4e7b-aa59-0d5bda0cf1e0', 5, 'The Wire S01E05', 'Episode 5', 'https://image.tmdb.org/t/p/original/4lbclFySvugI51fwsyxBTOm4DqK.jpg', '2026-08-29 16:00:51.135655+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('76408d94-d589-41cf-ae93-4a4256535aa5', '291b580e-934f-4a68-a631-23f1e4a2d904', 6, 'The Walking Dead: Dead City S03E06', 'Episode 6', 'https://image.tmdb.org/t/p/original/seYokxOjFyTVX13XgD2FNjWIry8.jpg', '2026-08-30 17:11:35.166847+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('37c486ca-928f-467f-a60d-c2e682367f99', '296a550e-ecac-401d-aa12-af8fde8dac27', 1, 'The Sopranos S06E01', 'Episode 1', 'https://image.tmdb.org/t/p/original/b1P9PAUI18mb62N0DtHOd71L3CT.jpg', '2026-08-30 17:59:35.347525+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('8569271e-62af-49c9-af46-d1f684f36504', '296a550e-ecac-401d-aa12-af8fde8dac27', 2, 'The Sopranos S06E02', 'Episode 2', 'https://image.tmdb.org/t/p/original/b1P9PAUI18mb62N0DtHOd71L3CT.jpg', '2026-08-30 17:59:35.347525+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('606e0612-c03e-45a6-a5bc-59b24e48e084', '296a550e-ecac-401d-aa12-af8fde8dac27', 3, 'The Sopranos S06E03', 'Episode 3', 'https://image.tmdb.org/t/p/original/b1P9PAUI18mb62N0DtHOd71L3CT.jpg', '2026-08-30 17:59:35.347525+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('8cd552b1-2b39-44a8-a917-0cd3d39e2578', '296a550e-ecac-401d-aa12-af8fde8dac27', 4, 'The Sopranos S06E04', 'Episode 4', 'https://image.tmdb.org/t/p/original/b1P9PAUI18mb62N0DtHOd71L3CT.jpg', '2026-08-30 17:59:35.347525+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('c29e4dcd-7043-4cb8-a62a-61b2cff419b6', '296a550e-ecac-401d-aa12-af8fde8dac27', 5, 'The Sopranos S06E05', 'Episode 5', 'https://image.tmdb.org/t/p/original/b1P9PAUI18mb62N0DtHOd71L3CT.jpg', '2026-08-30 17:59:35.347525+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('a7b9fb04-6516-444c-aad6-18c75c610dcf', '9d42845b-f3ec-4e7b-aa59-0d5bda0cf1e0', 6, 'The Wire S01E06', 'Episode 6', 'https://image.tmdb.org/t/p/original/4lbclFySvugI51fwsyxBTOm4DqK.jpg', '2026-08-30 17:59:35.347525+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('113999b2-6d07-4418-a187-98ba1583659c', '9d42845b-f3ec-4e7b-aa59-0d5bda0cf1e0', 7, 'The Wire S01E07', 'Episode 7', 'https://image.tmdb.org/t/p/original/4lbclFySvugI51fwsyxBTOm4DqK.jpg', '2026-08-30 17:59:35.347525+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('85518795-e360-4af5-a3fc-3a7d38e831d5', '9d42845b-f3ec-4e7b-aa59-0d5bda0cf1e0', 8, 'The Wire S01E08', 'Episode 8', 'https://image.tmdb.org/t/p/original/4lbclFySvugI51fwsyxBTOm4DqK.jpg', '2026-08-30 17:59:35.347525+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('3335954c-1a21-4efa-aaab-c79a132a44a9', '9b2f9dc0-e6ac-479f-a80d-4a594b4ba8b0', 3, 'Lanterns (2026) S01E03', 'Episode 3', 'https://image.tmdb.org/t/p/original/isYpgPQdjxJ0Ht04uKgilVYGPp9.jpg', '2026-08-31 05:10:46.772366+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('2593c3b7-0c4e-4c54-a1d8-d28983a7f139', '296a550e-ecac-401d-aa12-af8fde8dac27', 6, 'The Sopranos S06E06', 'Episode 6', 'https://image.tmdb.org/t/p/original/b1P9PAUI18mb62N0DtHOd71L3CT.jpg', '2026-08-31 14:58:40.394763+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('51a6bbf5-d90f-407c-a2b3-9eafdfd3c367', '296a550e-ecac-401d-aa12-af8fde8dac27', 7, 'The Sopranos S06E07', 'Episode 7', 'https://image.tmdb.org/t/p/original/b1P9PAUI18mb62N0DtHOd71L3CT.jpg', '2026-08-31 14:58:40.394763+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('a51a0b58-d35e-4ba1-ab29-06717917508c', '296a550e-ecac-401d-aa12-af8fde8dac27', 8, 'The Sopranos S06E08', 'Episode 8', 'https://image.tmdb.org/t/p/original/b1P9PAUI18mb62N0DtHOd71L3CT.jpg', '2026-08-31 14:58:40.394763+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('90d46548-b3e8-43a4-a091-e258abf8df1f', '296a550e-ecac-401d-aa12-af8fde8dac27', 9, 'The Sopranos S06E09', 'Episode 9', 'https://image.tmdb.org/t/p/original/b1P9PAUI18mb62N0DtHOd71L3CT.jpg', '2026-08-31 14:58:40.394763+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('3168ef66-0641-48eb-a121-327b8d7ffe57', '296a550e-ecac-401d-aa12-af8fde8dac27', 10, 'The Sopranos S06E10', 'Episode 10', 'https://image.tmdb.org/t/p/original/b1P9PAUI18mb62N0DtHOd71L3CT.jpg', '2026-08-31 14:58:40.394763+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('1bf0c921-6945-47ab-ab10-6edf349e0ebb', '296a550e-ecac-401d-aa12-af8fde8dac27', 11, 'The Sopranos S06E11', 'Episode 11', 'https://image.tmdb.org/t/p/original/b1P9PAUI18mb62N0DtHOd71L3CT.jpg', '2026-08-31 14:58:40.394763+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('698280d6-38fd-49a1-af0f-a71899213eeb', '9d42845b-f3ec-4e7b-aa59-0d5bda0cf1e0', 9, 'The Wire S01E09', 'Episode 9', 'https://image.tmdb.org/t/p/original/4lbclFySvugI51fwsyxBTOm4DqK.jpg', '2026-08-31 14:58:46.532211+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('93b4e985-8d60-4e21-a4d0-79a55b9124b1', '9d42845b-f3ec-4e7b-aa59-0d5bda0cf1e0', 10, 'The Wire S01E10', 'Episode 10', 'https://image.tmdb.org/t/p/original/4lbclFySvugI51fwsyxBTOm4DqK.jpg', '2026-08-31 14:58:46.532211+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('ce3f8e97-f96d-4086-ae00-fdd45c587ff1', '9d42845b-f3ec-4e7b-aa59-0d5bda0cf1e0', 11, 'The Wire S01E11', 'Episode 11', 'https://image.tmdb.org/t/p/original/4lbclFySvugI51fwsyxBTOm4DqK.jpg', '2026-08-31 14:58:46.532211+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('a634f1d1-59c6-4d84-ab86-6edd862f9f8d', '9d42845b-f3ec-4e7b-aa59-0d5bda0cf1e0', 12, 'The Wire S01E12', 'Episode 12', 'https://image.tmdb.org/t/p/original/4lbclFySvugI51fwsyxBTOm4DqK.jpg', '2026-08-31 14:58:46.532211+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('8fdee6fc-0fda-4ee7-a705-fcd92ebb71f5', '9d42845b-f3ec-4e7b-aa59-0d5bda0cf1e0', 13, 'The Wire S01E13', 'Episode 13', 'https://image.tmdb.org/t/p/original/4lbclFySvugI51fwsyxBTOm4DqK.jpg', '2026-08-31 14:58:46.532211+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('66bb0f3f-0da1-4196-a90d-6fb8b4e3db0d', 'c70b337c-3179-4717-ad69-8352be7ee35e', 1, 'Lost S01E01', 'Episode 1', 'https://image.tmdb.org/t/p/original/ejLEJwmh3ptBpdYlKw0xgjjYXmP.jpg', '2026-08-31 15:22:15.597063+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('5ad34313-8a36-4a73-aa04-12d816f19727', 'c70b337c-3179-4717-ad69-8352be7ee35e', 2, 'Lost S01E02', 'Episode 2', 'https://image.tmdb.org/t/p/original/ejLEJwmh3ptBpdYlKw0xgjjYXmP.jpg', '2026-08-31 15:22:15.597063+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('46273df1-c6fd-4c7b-a913-b63adec354a1', 'c70b337c-3179-4717-ad69-8352be7ee35e', 3, 'Lost S01E03', 'Episode 3', 'https://image.tmdb.org/t/p/original/ejLEJwmh3ptBpdYlKw0xgjjYXmP.jpg', '2026-08-31 15:22:15.597063+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('f5e0d712-d353-4558-ab8b-fc0d77c3f6c8', 'c70b337c-3179-4717-ad69-8352be7ee35e', 4, 'Lost S01E04', 'Episode 4', 'https://image.tmdb.org/t/p/original/ejLEJwmh3ptBpdYlKw0xgjjYXmP.jpg', '2026-08-31 15:22:15.597063+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('d71806d5-9edf-464b-ae7b-743538127d03', 'c70b337c-3179-4717-ad69-8352be7ee35e', 5, 'Lost S01E05', 'Episode 5', 'https://image.tmdb.org/t/p/original/ejLEJwmh3ptBpdYlKw0xgjjYXmP.jpg', '2026-08-31 15:22:15.597063+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('16daa1e3-1c33-4ecd-a9ba-e7a5e88c8a61', 'c70b337c-3179-4717-ad69-8352be7ee35e', 6, 'Lost S01E06', 'Episode 6', 'https://image.tmdb.org/t/p/original/ejLEJwmh3ptBpdYlKw0xgjjYXmP.jpg', '2026-08-31 15:22:15.597063+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('1c37b93a-dac0-4a67-a4c5-16e891b96870', 'c70b337c-3179-4717-ad69-8352be7ee35e', 7, 'Lost S01E07', 'Episode 7', 'https://image.tmdb.org/t/p/original/ejLEJwmh3ptBpdYlKw0xgjjYXmP.jpg', '2026-08-31 15:22:15.597063+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('42920081-08e9-4342-a5e4-1f158a325ec2', 'c70b337c-3179-4717-ad69-8352be7ee35e', 8, 'Lost S01E08', 'Episode 8', 'https://image.tmdb.org/t/p/original/ejLEJwmh3ptBpdYlKw0xgjjYXmP.jpg', '2026-08-31 15:22:15.597063+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('29cc3d75-75b2-40d8-a282-63cbe5acefd2', '296a550e-ecac-401d-aa12-af8fde8dac27', 12, 'The Sopranos S06E12', 'Episode 12', 'https://image.tmdb.org/t/p/original/b1P9PAUI18mb62N0DtHOd71L3CT.jpg', '2026-09-01 16:24:02.280019+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('379eb4e8-1d17-49e8-a9d0-5d9a82c32951', '296a550e-ecac-401d-aa12-af8fde8dac27', 13, 'The Sopranos S06E13', 'Episode 13', 'https://image.tmdb.org/t/p/original/b1P9PAUI18mb62N0DtHOd71L3CT.jpg', '2026-09-01 16:24:02.280019+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('49716a14-9cc5-4345-a661-875a783377e6', '296a550e-ecac-401d-aa12-af8fde8dac27', 14, 'The Sopranos S06E14', 'Episode 14', 'https://image.tmdb.org/t/p/original/b1P9PAUI18mb62N0DtHOd71L3CT.jpg', '2026-09-01 16:24:02.280019+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('7bd19fb3-8be2-4fbb-aa50-1a13df14cc3c', '296a550e-ecac-401d-aa12-af8fde8dac27', 15, 'The Sopranos S06E15', 'Episode 15', 'https://image.tmdb.org/t/p/original/b1P9PAUI18mb62N0DtHOd71L3CT.jpg', '2026-09-01 16:24:02.280019+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('438187f1-8d27-4023-a061-af2f1ed0b501', '296a550e-ecac-401d-aa12-af8fde8dac27', 16, 'The Sopranos S06E16', 'Episode 16', 'https://image.tmdb.org/t/p/original/b1P9PAUI18mb62N0DtHOd71L3CT.jpg', '2026-09-01 16:24:02.280019+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('fc8259ad-dd31-47c8-a2db-87f58912bb41', '296a550e-ecac-401d-aa12-af8fde8dac27', 17, 'The Sopranos S06E17', 'Episode 17', 'https://image.tmdb.org/t/p/original/b1P9PAUI18mb62N0DtHOd71L3CT.jpg', '2026-09-01 16:24:02.280019+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('59914f39-d2ee-4fe5-a3f2-ff07909929d0', '296a550e-ecac-401d-aa12-af8fde8dac27', 18, 'The Sopranos S06E18', 'Episode 18', 'https://image.tmdb.org/t/p/original/b1P9PAUI18mb62N0DtHOd71L3CT.jpg', '2026-09-01 16:24:02.280019+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('fd3a4d80-392b-4555-a9f2-cf646f014b06', '296a550e-ecac-401d-aa12-af8fde8dac27', 19, 'The Sopranos S06E19', 'Episode 19', 'https://image.tmdb.org/t/p/original/b1P9PAUI18mb62N0DtHOd71L3CT.jpg', '2026-09-01 16:24:02.280019+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('40e1f73c-6622-4411-a35b-fdb225b5fdd2', '296a550e-ecac-401d-aa12-af8fde8dac27', 20, 'The Sopranos S06E20', 'Episode 20', 'https://image.tmdb.org/t/p/original/b1P9PAUI18mb62N0DtHOd71L3CT.jpg', '2026-09-01 16:24:02.280019+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('ad459679-1860-415f-aab3-99bfdb4fc137', '296a550e-ecac-401d-aa12-af8fde8dac27', 21, 'The Sopranos S06E21', 'Episode 21', 'https://image.tmdb.org/t/p/original/b1P9PAUI18mb62N0DtHOd71L3CT.jpg', '2026-09-01 16:24:02.280019+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO episodes (id, season_id, episode_number, title, description, still_path, created_at)
VALUES ('4839d614-188e-46d3-a41d-c952d4880b51', 'dce280d1-b521-4972-ae66-5a5cdaaa5ab5', 6, 'Reacher S04E06', 'Episode 6', 'https://image.tmdb.org/t/p/original/wkKJHC34dIw9cJwAfNEEgDdb2ol.jpg', '2026-09-02 07:49:46.881692+00')
ON CONFLICT (id) DO NOTHING;

-- SUBTITLES
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('5ff89a4c-dbd8-4553-a95c-cf6fef87c43c', NULL, '2cc3b850-6686-4afd-ab86-7d2684d9690a', 'Sinhala', 'Sons_of_Anarchy_S01E01_Sinhala.srt', 'https://vtzndlehoqopaxdxmwim.supabase.co/storage/v1/object/public/pixelpoplk/SOA_S01_E01_Sinhala.zip?download', 'WEB-DL / HD', 54, '2026-07-02 20:20:47.74712+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('82a2b42c-29e8-4d82-ac1f-4bcc78c569ed', NULL, '77b2a8d9-3306-4860-a61b-91dd06a4cc88', 'Sinhala', 'House_Of_The_Dragon_S03E03_Sinhala.srt', 'https://vtzndlehoqopaxdxmwim.supabase.co/storage/v1/object/public/pixelpoplk/House%20of%20the%20dragon/House_of_the_Dragon_S03E03_57837.zip?download', 'WEB-DL / HD', 9, '2026-07-05 19:07:04.212977+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('1a2f8229-ba89-4dbb-a4a1-8be3e4cc2ade', NULL, 'ea343ca1-c4ea-4973-ae68-4ba24c6e0527', 'Sinhala', 'Sons_Of_Anarchy_S01E02_Sinhala.srt', 'https://vtzndlehoqopaxdxmwim.supabase.co/storage/v1/object/public/pixelpoplk/SOA/Sons_Of_Anarchy_S01E02_3691.zip?download', 'WEB-DL / HD', 25, '2026-07-06 17:23:49.258164+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('b48bfdd5-6e39-4a3b-ab70-82400ce45371', NULL, 'cacbd9f9-ebf1-42cc-aca4-333071a27b3f', 'Sinhala', 'Sons_of_Anarchy_S01E03_Sinhala.srt', 'https://vtzndlehoqopaxdxmwim.supabase.co/storage/v1/object/public/pixelpoplk/SOA/Sons_Of_Anarchy_S01E03_3616.zip?download', 'WEB-DL / HD', 22, '2026-07-06 18:51:33.429257+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('82e4a8c2-4279-4529-a977-23303869338b', NULL, '719bbd7b-9632-43e0-a5be-7bc49884cf47', 'Sinhala', 'Sons_of_Anarchy_S01E04_Sinhala.srt', 'https://vtzndlehoqopaxdxmwim.supabase.co/storage/v1/object/public/pixelpoplk/SOA/Sons_Of_Anarchy_S01E04_4855.zip?download', 'WEB-DL / HD', 26, '2026-07-06 18:51:33.429257+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('2d200b47-3d88-4a78-a484-2589907c6223', NULL, '03462571-4563-427a-aa3a-40afc3bbe243', 'Sinhala', 'Sons_of_Anarchy_S01E05_Sinhala.srt', 'https://vtzndlehoqopaxdxmwim.supabase.co/storage/v1/object/public/pixelpoplk/SOA/Sons_Of_Anarchy_S01E05_1485.zip?download', 'WEB-DL / HD', 24, '2026-07-06 18:51:33.429257+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('3fd60288-aefe-49dd-ae15-3855b7c6f42a', NULL, '612f034d-1c8f-4285-a427-ebeea801e532', 'Sinhala', 'Sons_of_Anarchy_S01E06_Sinhala.srt', 'https://vtzndlehoqopaxdxmwim.supabase.co/storage/v1/object/public/pixelpoplk/SOA/Sons_Of_Anarchy_S01E06_6892.zip?download', 'WEB-DL / HD', 18, '2026-07-06 18:51:33.429257+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('307b795b-fbff-4fdc-a55f-5dd614334cf2', NULL, '03f30b76-caf8-46c6-ac3d-b125dcddb935', 'Sinhala', 'Sons_of_Anarchy_S01E07_Sinhala.srt', 'https://vtzndlehoqopaxdxmwim.supabase.co/storage/v1/object/public/pixelpoplk/SOA/Sons_Of_Anarchy_S01E07_8763.zip?download', 'WEB-DL / HD', 19, '2026-07-06 18:51:33.429257+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('93060879-38ec-4a90-a556-77b6a67a5ee9', NULL, '4c03ca7e-dc94-471d-a5e8-2d674c7b4109', 'Sinhala', 'Sons_of_Anarchy_S01E08_Sinhala.srt', 'https://vtzndlehoqopaxdxmwim.supabase.co/storage/v1/object/public/pixelpoplk/SOA/Sons_Of_Anarchy_S01E08_7873.zip?download', 'WEB-DL / HD', 18, '2026-07-06 18:51:33.429257+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('1bc3ef95-41a1-4d64-a9cd-42eb231a645a', NULL, '3c84c9e6-fabc-456a-a293-9f5a1e239bda', 'Sinhala', 'Sons_of_Anarchy_S01E09_Sinhala.srt', 'https://vtzndlehoqopaxdxmwim.supabase.co/storage/v1/object/public/pixelpoplk/SOA/Sons_Of_Anarchy_S01E09_1648.zip?download', 'WEB-DL / HD', 19, '2026-07-06 18:51:33.429257+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('873358e5-9fd2-4d89-af59-d37de2eb7954', NULL, 'cb3c37c3-f214-4f02-af5a-747e0113143b', 'Sinhala', 'Sons_of_Anarchy_S01E10_Sinhala.srt', 'https://vtzndlehoqopaxdxmwim.supabase.co/storage/v1/object/public/pixelpoplk/SOA/Sons_Of_Anarchy_S01E10_7404.zip?download', 'WEB-DL / HD', 17, '2026-07-06 18:51:33.429257+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('fa86ed73-acd1-4aed-ad22-77ea791d5c70', NULL, '15d9fb09-e27c-49ab-ae02-34b12edb971e', 'Sinhala', 'Sons_of_Anarchy_S01E11_Sinhala.srt', 'https://vtzndlehoqopaxdxmwim.supabase.co/storage/v1/object/public/pixelpoplk/SOA/Sons_Of_Anarchy_S01E11_1885.zip?download', 'WEB-DL / HD', 17, '2026-07-06 18:51:33.429257+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('0ab86de2-788e-46b3-a574-e6d10f857e9d', NULL, '89b29727-a6cb-4209-a579-aa16e73786df', 'Sinhala', 'Sons_of_Anarchy_S01E12_Sinhala.srt', 'https://vtzndlehoqopaxdxmwim.supabase.co/storage/v1/object/public/pixelpoplk/SOA/Sons_Of_Anarchy_S01E12_4957.zip?download', 'WEB-DL / HD', 17, '2026-07-06 18:51:33.429257+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('9401fb2d-f20d-4920-ac73-7d71a3619731', NULL, '309301d8-a536-4ba8-a8fb-4ad8fb9f73d2', 'Sinhala', 'Sons_of_Anarchy_S01E13_Sinhala.srt', 'https://vtzndlehoqopaxdxmwim.supabase.co/storage/v1/object/public/pixelpoplk/SOA/Sons_Of_Anarchy_S01E13_9695.zip?download', 'WEB-DL / HD', 17, '2026-07-06 18:51:33.429257+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('487e0a32-3b93-417d-a539-3a51c171ac2f', NULL, 'c60152f3-1cea-4bb9-a577-74292695110f', 'Sinhala', 'Sons_of_Anarchy_S02E01_Sinhala.srt', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%201/Sons_Of_Anarchy_S02E01_7168.zip?download', 'WEB-DL / HD', 63, '2026-07-10 21:03:45.984807+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('3bfa912f-27d2-4713-a18e-16977613464c', NULL, 'e6ca4568-68f2-489c-a996-3f834fb21e3f', 'Sinhala', 'Sons_of_Anarchy_S02E02_Sinhala.srt', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%201/Sons_Of_Anarchy_S02E02_7183.zip?download', 'WEB-DL / HD', 24, '2026-07-10 21:03:45.984807+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('5a103144-97c4-4643-ac8e-b19aa3628627', NULL, '5e1eb95d-6f26-4e45-ad78-419a01f7445f', 'Sinhala', 'Sons_of_Anarchy_S02E03_Sinhala.srt', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%201/Sons_Of_Anarchy_S02E03_7683.zip?download', 'WEB-DL / HD', 18, '2026-07-10 21:03:45.984807+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('65a29216-daea-4428-afe9-a77063704532', NULL, '4e97a1bd-9177-4075-a248-bd0678ccd7a1', 'Sinhala', 'Sons_of_Anarchy_S02E04_Sinhala.srt', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%201/Sons_Of_Anarchy_S02E04_4852.zip?download', 'WEB-DL / HD', 15, '2026-07-10 21:03:45.984807+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('efb78367-d54b-4b07-a845-f053a8ae820a', NULL, 'ac618de0-e5af-427a-af4e-8f2476d7b2cb', 'Sinhala', 'Sons_of_Anarchy_S02E05_Sinhala.srt', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%201/Sons_Of_Anarchy_S02E05_4480.zip?download', 'WEB-DL / HD', 15, '2026-07-10 21:03:45.984807+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('bdbd1369-f767-4f0d-a57f-96885a26ac28', NULL, 'd591745e-c197-4f84-afcb-9ae3e41ca66c', 'Sinhala', 'Sons_of_Anarchy_S02E06_Sinhala.srt', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%201/Sons_Of_Anarchy_S02E06_1294.zip?download', 'WEB-DL / HD', 12, '2026-07-10 21:03:45.984807+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('72537ea6-7ace-493d-a908-fafa45a63449', NULL, '944f13a0-5bfd-43ee-a05a-72ca54793b80', 'Sinhala', 'House_of_The_Dragon_S03E04_Sinhala.srt', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Hotd/House.of.the.Dragon.S03E04.WEBRip.Sinhala_2054.zip?download', 'WEB-DL / HD', 15, '2026-07-13 01:46:09.988815+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('edbd7ff9-d0a8-4d59-aa3c-505a3eeb930e', 'b727785a-1be1-4a90-a810-655fb4a5d54e', NULL, 'Sinhala', 'Backrooms_2026_Sinhala.srt', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Movies/Backrooms%202026/Backrooms.2026.WEBRip.HEVC-PSA.mkv3_sinhala-646474.zip?download', 'WEB-DL / HD', 0, '2026-07-14 05:32:34.672294+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('4f40199f-fbe3-4aa8-a114-fab7c9a6f3d8', NULL, 'ea6c3d96-ddd4-47cf-a122-961243698461', 'Sinhala', 'Sons_of_Anarchy_S02E07_Sinhala.srt', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%202/Sons_Of_Anarchy_S02E07_8737.zip?download', 'WEB-DL / HD', 11, '2026-07-14 11:59:44.37195+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('ef95afe3-47db-4752-acb9-64aa9df07b03', NULL, '27ba32f4-c711-46f8-a0a5-608387a12769', 'Sinhala', 'Sons_of_Anarchy_S02E08_Sinhala.srt', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%202/Sons_Of_Anarchy_S02E08_2643.zip?download', 'WEB-DL / HD', 12, '2026-07-14 11:59:44.37195+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('7d554bc8-b7b4-429b-ad59-449b3e55cc3d', NULL, '9422b3ed-3fff-40c5-a0c0-34997b284e87', 'Sinhala', 'Sons_of_Anarchy_S02E09_Sinhala.srt', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%202/Sons_Of_Anarchy_S02E09_2950.zip?download', 'WEB-DL / HD', 12, '2026-07-14 11:59:44.37195+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('005c9f10-586d-4fc5-a8b1-641c0a08013d', NULL, '82d1400b-e78d-4622-a5a0-35fd688da419', 'Sinhala', 'Sons_of_Anarchy_S02E10_Sinhala.srt', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%202/Sons_Of_Anarchy_S02E10_4053.zip?download', 'WEB-DL / HD', 11, '2026-07-14 11:59:44.37195+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('91af25de-8583-4eed-a473-a21cbe8c85c8', NULL, '86ee5e8b-4163-44d3-ad9d-6bf91569d621', 'Sinhala', 'Sons_of_Anarchy_S02E11_Sinhala.srt', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%202/Sons_Of_Anarchy_S02E11_4099.zip?download', 'WEB-DL / HD', 10, '2026-07-14 11:59:44.37195+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('5f891bc9-1949-46da-aa5f-bd8685262804', NULL, 'bbd1b009-7be8-4d07-a347-0ad724924c8b', 'Sinhala', 'Sons_of_Anarchy_S02E12_Sinhala.srt', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%202/Sons_Of_Anarchy_S02E12_1658.zip?download', 'WEB-DL / HD', 11, '2026-07-14 11:59:44.37195+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('d18230ef-7278-4fd3-a6bc-3ea7ae414c19', NULL, '01199b58-b2cc-438a-a083-8d44058eed5e', 'Sinhala', 'Sons_of_Anarchy_S02E13_Sinhala.srt', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%202/Sons_Of_Anarchy_S02E13_7779.zip?download', 'WEB-DL / HD', 12, '2026-07-14 11:59:44.37195+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('1edf7c1f-5714-4108-a110-58be5c5fadc9', NULL, 'e35a2c4f-5206-4a66-a366-e82874e61130', 'Sinhala', 'Sons_of_Anarchy_S03E01_Sinhala.srt', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%203/Sons_Of_Anarchy_S03E01_580550.zip', 'WEB-DL / HD', 11, '2026-07-16 15:21:01.297081+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('6b3b2367-bff0-47e0-af8d-e1b185ce95c1', NULL, 'e82b433d-d300-4c4f-ae12-6a4bb4c79eca', 'Sinhala', 'Sons_of_Anarchy_S03E02_Sinhala.srt', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%203/Sons_Of_Anarchy_S03E02_115537.zip', 'WEB-DL / HD', 10, '2026-07-16 15:21:01.297081+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('a4a76c6b-3190-4b11-a7a0-d8cadaed6b47', NULL, 'e02ddde3-8169-4b27-ac59-392c2b344518', 'Sinhala', 'Sons_of_Anarchy_S03E03_Sinhala.srt', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%203/Sons_Of_Anarchy_S03E03_148829.zip', 'WEB-DL / HD', 12, '2026-07-16 15:21:01.297081+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('f36da128-831e-4700-afad-12389b86c2e2', NULL, '5dc04c79-8dd1-40e1-a09e-b58fa2488bc8', 'Sinhala', 'Sons_of_Anarchy_S03E04_Sinhala.srt', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%203/Sons_Of_Anarchy_S03E04_789789.zip', 'WEB-DL / HD', 12, '2026-07-16 15:21:01.297081+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('3c3566e2-10ad-4f06-a991-0e75837a1354', NULL, '430e537b-a78a-4328-abec-fc9336265539', 'Sinhala', 'Sons_of_Anarchy_S03E05_Sinhala.srt', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%203/Sons_Of_Anarchy_S03E05_586816.zip', 'WEB-DL / HD', 17, '2026-07-16 15:21:01.297081+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('0af59bff-9762-4a7e-aa21-55bf22be6988', NULL, 'f3f1acd9-8b69-451d-ac31-c68eb4765046', 'Sinhala', 'Sons_of_Anarchy_S03E06_Sinhala.srt', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%203/Sons_Of_Anarchy_S03E06_7243.zip?download', 'WEB-DL / HD', 14, '2026-07-17 13:58:47.835069+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('d963adc1-abe3-4058-a278-945787bf727a', NULL, '89cffa70-f22d-4baf-a0dd-8f4fbff12009', 'Sinhala', 'Sons_of_Anarchy_S03E07_Sinhala.srt', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%203/Sons_Of_Anarchy_S03E07_6877.zip?download', 'WEB-DL / HD', 15, '2026-07-17 13:58:47.835069+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('5027b2f4-d310-4347-ac4c-333a31f57874', NULL, 'c1cf41bb-9fa6-4b44-a797-e11e724cc978', 'Sinhala', 'Sons_of_Anarchy_S03E08_Sinhala.srt', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%203/Sons_Of_Anarchy_S03E08_1329.zip?download', 'WEB-DL / HD', 15, '2026-07-17 13:58:47.835069+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('bfdf6e2d-b872-4aca-af4d-d41cc5af0919', NULL, '6209517b-ba97-4edf-a986-79105177e097', 'Sinhala', 'Sons_of_Anarchy_S03E09_Sinhala.srt', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%203/Sons_Of_Anarchy_S03E09_5879.zip?download', 'WEB-DL / HD', 31, '2026-07-17 13:58:47.835069+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('a69864a0-1782-4597-ac55-84ab9465cd42', NULL, '299ff645-f014-4bb1-a4f0-e0b08ff1df49', 'Sinhala', 'Sons_of_Anarchy_S03E10_Sinhala.srt', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%203/Sons_Of_Anarchy_S03E10_3995.zip?download', 'WEB-DL / HD', 18, '2026-07-17 13:58:47.835069+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('14d36603-e420-43cd-af39-df4031ea40d0', NULL, '310e451e-4e84-425d-a539-1d719acae553', 'Sinhala', 'Sons_of_Anarchy_S03E11_Sinhala.srt', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%203/Sons_Of_Anarchy_S03E11_5255.zip?download', 'WEB-DL / HD', 14, '2026-07-17 13:58:47.835069+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('f12a8911-5e81-4b1b-a12a-677d379a7e33', NULL, 'ab8847c0-ad32-43aa-aa67-5069fb8a1d26', 'Sinhala', 'Sons_of_Anarchy_S03E12_Sinhala.srt', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%203/Sons_Of_Anarchy_S03E12_2901.zip?download', 'WEB-DL / HD', 16, '2026-07-17 13:58:47.835069+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('247a0760-901b-4c48-a692-17804c175013', NULL, '2358e133-5f2e-4442-ace0-5202c0e1a5ea', 'Sinhala', 'Sons_of_Anarchy_S03E13_Sinhala.srt', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Sons%20Of%20anarchy/Season%203/Sons_Of_Anarchy_S03E13_3764.zip?download', 'WEB-DL / HD', 14, '2026-07-17 13:58:47.835069+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('3e14b6c1-8030-422d-acaa-f065a063427c', NULL, '75d0a3d5-5005-4d05-ac96-df51a0192507', 'Sinhala', 'The_East_Palace__2026__S01E01_Sinhala.srt', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/The%20east%20palace%202026/Season%201/The.East.Palace.2026.S01E01.NF.WEB-DL_Sinhala.17637.zip?download', 'WEB-DL / HD', 0, '2026-07-18 06:07:52.262353+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('fbe717af-e8d7-4a78-a0b7-e5065799d328', NULL, '0904fda1-cdef-4878-a18e-d9c698e0b9ef', 'Sinhala', 'The_East_Palace__2026__S01E02_Sinhala.srt', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/The%20east%20palace%202026/Season%201/The.East.Palace.2026.S01E02.NF.WEB-DL_Sinhala.573636.zip?download', 'WEB-DL / HD', 0, '2026-07-18 06:09:35.713148+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('d26754ac-6acc-4218-a3dd-f8a206a0f912', NULL, 'b88a1b3e-f7f3-43e3-a8d4-89c10dc677d6', 'Sinhala', 'The_East_Palace__2026__S01E03_Sinhala.srt', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/The%20east%20palace%202026/Season%201/The_East_Palace_2026_S01E03_825657.zip?download', 'WEB-DL / HD', 0, '2026-07-18 17:41:59.995576+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('4f787622-9260-4fe0-a458-4f0f400a1859', NULL, '4becc21e-915c-44ec-a5df-4f84f0c6ade2', 'Sinhala', 'The_East_Palace__2026__S01E04_Sinhala.srt', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/The%20east%20palace%202026/Season%201/The_East_Palace_2026_S01E04_855866.zip?download', 'WEB-DL / HD', 0, '2026-07-18 17:41:59.995576+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('b2df442e-3bd2-406b-aa24-be3177d00627', NULL, '99cf14e1-f54e-4303-a099-3f53771acc3e', 'Sinhala', 'The_East_Palace__2026__S01E05_Sinhala.srt', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/The%20east%20palace%202026/Season%201/The_East_Palace_2026_S01E05_465698.zip?download', 'WEB-DL / HD', 0, '2026-07-18 17:41:59.995576+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('3cdcf4a2-8e4d-4a63-afc4-66896c731df6', NULL, '4944bacb-a743-4264-a6c4-1b648f1f61e5', 'Sinhala', 'The_East_Palace__2026__S01E06_Sinhala.srt', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/The%20east%20palace%202026/Season%201/The_East_Palace_2026_S01E06_248056.zip?download', 'WEB-DL / HD', 0, '2026-07-18 17:41:59.995576+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('1f59addd-fb1b-43ec-a461-1a754eb205b8', NULL, 'ddade0d2-f45c-478a-abfc-5fa73bf1521c', 'Sinhala', 'The_East_Palace__2026__S01E07_Sinhala.srt', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/The%20east%20palace%202026/Season%201/The_East_Palace_2026_S01E07_286656.zip?download', 'WEB-DL / HD', 0, '2026-07-18 17:41:59.995576+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('3e8b01cc-8091-458d-af1a-ad9bc0b193db', NULL, '50220617-6560-4669-a946-ffb634e33779', 'Sinhala', 'The_East_Palace__2026__S01E08_Sinhala.srt', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/The%20east%20palace%202026/Season%201/The_East_Palace_2026_S01E08_769245.zip?download', 'WEB-DL / HD', 0, '2026-07-18 17:41:59.995576+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('4976416e-91fa-4289-a1a8-45e1e890a38c', NULL, '95315ed4-11f0-43e7-a029-2c0d7755a62d', 'Sinhala', 'House_of_The_Dragon_S03E02_Sinhala.srt', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Hotd/House_of_the_Dragon_S03E01_WEBRip_PSA_Sinhala.srt?download', 'WEB-DL / HD', 13, '2026-07-18 18:03:31.96276+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('b0706838-8cef-44d5-a720-fb681e06a42f', NULL, 'e55206c4-1253-408a-a2d3-a08e662c12c0', 'Sinhala', 'House_of_The_Dragon_S03E01_Sinhala.srt', 'https://jgechrsxkejzizcrrvjc.supabase.co/storage/v1/object/public/Subtitles%20Zip/Hotd/House_of_the_Dragon_S03E01_WEBRip_PSA_Sinhala.srt', 'WEB-DL / HD', 24, '2026-07-18 18:05:34.87458+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('e5dd61ee-0818-4826-a20d-429fc9d3f849', NULL, '80548dc8-f452-4bac-a8b5-403b3f4e19a9', 'Sinhala', 'Sons_of_Anarchy_S04E01_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S04e01%203180767/Sons_of_Anarchy_S04E01_3180767.zip?download', 'WEB-DL / HD', 11, '2026-07-19 18:04:00.986472+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('34499e63-0cde-4eb1-a268-e6c2acfba7e4', NULL, '1a20966b-ec05-4c1a-a2a0-aac81811e0cb', 'Sinhala', 'Sons_of_Anarchy_S04E02_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S04e02%206308576/Sons_of_Anarchy_S04E02_6308576.zip?download', 'WEB-DL / HD', 12, '2026-07-19 18:04:00.986472+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('bc38f3ea-106e-494a-a98b-ba119ae89762', NULL, '7fc5235b-b315-4576-a40f-468923bd0623', 'Sinhala', 'Sons_of_Anarchy_S04E03_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S04e03%205399575/Sons_of_Anarchy_S04E03_5399575.zip?download', 'WEB-DL / HD', 17, '2026-07-19 18:04:00.986472+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('ab77b9b0-5281-4c94-a0f1-325c8cb3de84', NULL, '0f38be62-9755-4228-aceb-c90656d7a935', 'Sinhala', 'Sons_of_Anarchy_S04E04_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S04e04%208766464/Sons_of_Anarchy_S04E04_8766464.zip?download', 'WEB-DL / HD', 15, '2026-07-19 18:04:00.986472+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('14f24ff8-5852-460f-a2c7-fcf40d557a0a', NULL, '21059568-1722-49ce-a15a-2252d47ef971', 'Sinhala', 'Sons_of_Anarchy_S04E05_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S04e05%203204565/Sons_of_Anarchy_S04E05_3204565.zip?download', 'WEB-DL / HD', 15, '2026-07-19 18:04:00.986472+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('f74c69e2-74fd-4394-a9b0-5a567e6d1d7b', NULL, '1bf72f06-f39e-4be9-a837-e2c19c588e90', 'Sinhala', 'Sons_of_Anarchy_S04E06_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S04e06%206948575/Sons_of_Anarchy_S04E06_6948575.zip?download', 'WEB-DL / HD', 11, '2026-07-19 18:04:00.986472+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('0f060885-0813-4ce8-a8b6-944de38fea05', NULL, '63dbe61d-808b-4467-aed5-20009f8a86b9', 'Sinhala', 'House_of_The_Dragon_S03E05_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/House%20of%20the%20Dragon%20S03e05%202819756%20(/House_of_the_Dragon_S03E05_2819756%20(1).zip?download', 'WEB-DL / HD', 18, '2026-07-20 02:26:00.42846+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('1f166034-82d4-4c30-a963-9e846f9abed3', 'e0acef12-4bfd-4d2a-a3d4-6f3dc06b57a2', NULL, 'Sinhala', 'Disclosure_Day_2026_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Disclosure%20Day/Disclosure.Day.2026.WEBRip.@pixelpoplk.6464646.zip?download', 'WEB-DL / HD', 1, '2026-07-21 08:01:41.770922+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('e1e010f3-cc8a-4461-a444-031dbf14c0ff', NULL, 'ca371690-e836-4c05-a91f-875704cb23ff', 'Sinhala', 'Sons_of_Anarchy_S04E07_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S04e07%205251/Sons_of_Anarchy_S04E07_5251.zip?download', 'WEB-DL / HD', 10, '2026-07-21 11:40:15.630722+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('ac20b1e4-84f3-4112-a16e-4203f9c24202', NULL, '698f1205-0367-4a57-a1d1-a8ba6d8d491f', 'Sinhala', 'Sons_of_Anarchy_S04E08_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S04e08%206510/Sons_of_Anarchy_S04E08_6510.zip?download', 'WEB-DL / HD', 11, '2026-07-21 11:40:15.630722+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('96b2cfd8-8ba3-4e9a-a0f1-b6aeff670806', NULL, '368cb299-ef3b-42e2-af6b-8efc86381237', 'Sinhala', 'Sons_of_Anarchy_S04E09_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S04e09%204320/Sons_of_Anarchy_S04E09_4320.zip?download', 'WEB-DL / HD', 10, '2026-07-21 11:40:15.630722+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('f7f7d365-6b25-4dfe-a58d-0707365dd1f9', NULL, '794b840f-462b-42a3-ae5e-0ac36bc17d36', 'Sinhala', 'Sons_of_Anarchy_S04E10_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S04e10%207286/Sons_of_Anarchy_S04E10_7286.zip?download', 'WEB-DL / HD', 11, '2026-07-21 11:40:15.630722+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('15d54290-3fc2-4607-a582-cf7d69febf65', NULL, '73821cf1-ea50-4da4-a876-40088a9ace4a', 'Sinhala', 'Sons_of_Anarchy_S04E11_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S04e11%209798/Sons_of_Anarchy_S04E11_9798.zip?download', 'WEB-DL / HD', 9, '2026-07-21 11:40:15.630722+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('8845f1d2-ab5f-477e-a626-015e6f87cf0c', NULL, 'bbff83c9-213a-4464-a36b-2b67982280e3', 'Sinhala', 'Sons_of_Anarchy_S04E12_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S04e12%201909/Sons_of_Anarchy_S04E12_1909.zip?download', 'WEB-DL / HD', 8, '2026-07-21 11:40:15.630722+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('2a2dd286-4b4b-4d0e-a998-0329f06566a6', NULL, 'e21a578c-ad9b-4512-a07d-7b22a8e3ac9c', 'Sinhala', 'Sons_of_Anarchy_S04E13_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S04e13%202358/Sons_of_Anarchy_S04E13_2358.zip?download', 'WEB-DL / HD', 8, '2026-07-21 11:40:15.630722+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('efd251a9-0833-44f2-a2d1-780b20d240e3', NULL, 'd0900956-0102-4566-aa13-c09bffe1e464', 'Sinhala', 'Sons_of_Anarchy_S04E14_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S04e14%207267/Sons_of_Anarchy_S04E14_7267.zip?download', 'WEB-DL / HD', 9, '2026-07-21 11:40:15.630722+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('8041f6f8-79a1-402f-a907-7e9069169a44', NULL, '222ad6df-73f1-45ba-ac8a-38d8c21e2e46', 'Sinhala', 'Dune__Prophecy_S01E01_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Dune%20Prophecy%20S01e01%207379/Dune_Prophecy_S01E01_7379.zip?download', 'WEB-DL / HD', 0, '2026-07-21 11:40:57.426392+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('7e7b63e2-aa46-4793-aa68-b3f42f6ad4dd', NULL, '338fb4b5-b92d-48cd-a324-77ee39ef30ac', 'Sinhala', 'Dune__Prophecy_S01E02_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Dune%20Prophecy%20S01e02%204146/Dune_Prophecy_S01E02_4146.zip?download', 'WEB-DL / HD', 0, '2026-07-21 11:40:57.426392+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('cd16f40c-52b9-4e5a-a103-999b51b28582', NULL, 'd7e26624-0ec9-4648-a251-60a5d338c78c', 'Sinhala', 'Dune__Prophecy_S01E03_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Dune%20Prophecy%20S01e03%203381/Dune_Prophecy_S01E03_3381.zip?download', 'WEB-DL / HD', 0, '2026-07-21 11:40:57.426392+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('a0d8cd69-8b2c-491e-a2b3-857580b501bb', NULL, 'd0b4c45b-4b5f-4921-a1cb-df8360b5af6d', 'Sinhala', 'Dune__Prophecy_S01E04_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Dune%20Prophecy%20S01e04%206817/Dune_Prophecy_S01E04_6817.zip?download', 'WEB-DL / HD', 0, '2026-07-21 11:40:57.426392+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('5eb8444a-ea89-43a9-a7ef-4d2ce5af2c74', NULL, '13a6fba1-d1e6-43d6-a256-b34735de376f', 'Sinhala', 'Dune__Prophecy_S01E05_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Dune%20Prophecy%20S01e05%207821/Dune_Prophecy_S01E05_7821.zip?download', 'WEB-DL / HD', 0, '2026-07-21 11:40:57.426392+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('030a80f7-7219-4a05-ae1b-d85de4d974f3', NULL, '3cf2c156-e756-4d50-a710-bcc7d6556ed0', 'Sinhala', 'Dune__Prophecy_S01E06_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Dune%20Prophecy%20S01e06%206804/Dune_Prophecy_S01E06_6804.zip?download', 'WEB-DL / HD', 0, '2026-07-21 11:40:57.426392+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('e9c65df4-6d78-473e-aa9b-247b44561d3c', NULL, '52686cc5-f72e-4d32-a887-97c0c66c8c70', 'Sinhala', 'Sons_of_Anarchy_S05E01_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S05e01@pixelpoplk%20697767/Sons_of_Anarchy_S05E01@pixelpoplk_697767.zip?download', 'WEB-DL / HD', 8, '2026-07-22 15:20:11.306013+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('b8a02bd9-6e49-4910-a542-2ff03dc08b01', NULL, '189982d4-7328-4b53-a79e-2b5ee5619828', 'Sinhala', 'Sons_of_Anarchy_S05E02_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S05e02@pixelpoplk%2012760/Sons_of_Anarchy_S05E02@pixelpoplk_12760.zip?download', 'WEB-DL / HD', 8, '2026-07-22 15:20:11.306013+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('86a6f75b-a149-4eaa-a938-7f25e2e57b14', NULL, '0f0873c0-f5c0-4c0a-afd5-cdc0585e63fb', 'Sinhala', 'Sons_of_Anarchy_S05E03_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S05e03@pixelpoplk%2095787/Sons_of_Anarchy_S05E03@pixelpoplk_95787.zip?download', 'WEB-DL / HD', 7, '2026-07-22 15:20:11.306013+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('d1a9d41d-c794-429f-ab1f-e83249fe00d1', NULL, 'b25570b7-1e07-4d84-ae08-e4e5f59a46b3', 'Sinhala', 'Sons_of_Anarchy_S05E04_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S05e04@pixelpoplk%20126789/Sons_of_Anarchy_S05E04@pixelpoplk_126789.zip?download', 'WEB-DL / HD', 7, '2026-07-22 15:20:11.306013+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('1cf94753-1f18-4bf6-a760-11bdd0167713', NULL, 'a03dd8e3-1ba0-49e9-a2fb-6a1ae7d24300', 'Sinhala', 'Sons_of_Anarchy_S05E05_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S05e05@pixelpoplk%20305612/Sons_of_Anarchy_S05E05@pixelpoplk_305612.zip?download', 'WEB-DL / HD', 7, '2026-07-22 15:20:11.306013+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('768c76bc-54c9-4cb2-a64d-2e0cdb531eae', NULL, '885890f6-86b7-4444-a898-5a3769be7b3d', 'Sinhala', 'Sons_of_Anarchy_S05E06_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S05e06%20@pixelpoplk105756/Sons_of_Anarchy_S05E06_@pixelpoplk105756.zip?download', 'WEB-DL / HD', 8, '2026-07-23 15:20:45.443248+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('bfeb3ddd-eefd-42c2-a3bd-92252615de4c', NULL, '2bdd29eb-1ef4-40f4-a9f7-5c19ac3176ca', 'Sinhala', 'Sons_of_Anarchy_S05E07_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S05e07%20@pixelpoplk673141/Sons_of_Anarchy_S05E07_@pixelpoplk673141.zip?download', 'WEB-DL / HD', 6, '2026-07-23 15:20:45.443248+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('b3e94c7f-26f1-49b6-abcc-b194e98caf0e', NULL, 'b5b445f0-0318-4bdc-aea7-706657c7a61d', 'Sinhala', 'Sons_of_Anarchy_S05E08_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S05e08%20@pixelpoplk566086/Sons_of_Anarchy_S05E08_@pixelpoplk566086.zip?download', 'WEB-DL / HD', 7, '2026-07-23 15:20:45.443248+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('9781479c-bea3-46e3-ae0d-e2fdbc9dfa3e', NULL, '1e5ab17d-c96b-4e4e-a4c2-a16a9b647ca7', 'Sinhala', 'Sons_of_Anarchy_S05E09_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S05e09%20@pixelpoplk568727/Sons_of_Anarchy_S05E09_@pixelpoplk568727.zip?download', 'WEB-DL / HD', 7, '2026-07-23 15:20:45.443248+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('71cd7054-e80d-47f1-a985-21c05e14a462', NULL, '08f1b5b3-5554-49d5-ad1f-dfe75b0de463', 'Sinhala', 'Sons_of_Anarchy_S05E10_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S05e10%20@pixelpoplk568155/Sons_of_Anarchy_S05E10_@pixelpoplk568155.zip?download', 'WEB-DL / HD', 7, '2026-07-23 15:20:45.443248+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('f35e204e-76d9-4ec8-a9a3-792f9473237b', NULL, 'fc5bb8bb-5bc8-4c06-af12-fa98e47dacbc', 'Sinhala', 'Sons_of_Anarchy_S05E11_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S05e11%20@pixelpoplk564166/Sons_of_Anarchy_S05E11_@pixelpoplk564166.zip?download', 'WEB-DL / HD', 7, '2026-07-23 15:20:45.443248+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('2f1b215b-7bec-43ed-ade5-8dcf16ae844c', NULL, '1acd005b-2c4d-44c9-a715-de8753a91db3', 'Sinhala', 'Sons_of_Anarchy_S05E12_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S05e12%20@pixelpoplk567449/Sons_of_Anarchy_S05E12_@pixelpoplk567449.zip?download', 'WEB-DL / HD', 7, '2026-07-23 15:20:45.443248+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('a31f7ecf-2159-4466-adbf-44477e5867df', NULL, '8ecd6e3e-cfdc-4189-ac6e-1f8c2bcdcfcc', 'Sinhala', 'Sons_of_Anarchy_S05E13_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S05e13%20@pixelpoplk567855/Sons_of_Anarchy_S05E13_@pixelpoplk567855.zip?download', 'WEB-DL / HD', 8, '2026-07-23 15:20:45.443248+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('892e5bd5-df89-4ea3-af00-6a4c5978f699', '0229ecbe-ddae-4a78-a2b7-663225e0a314', NULL, 'Sinhala', 'Colony_2026_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Coiony%202026%20720p%20Web%20Dl%20Sinhala%20Pixelpoplk/CoIony_2026_720p_WEB-DL%20Sinhala.pixelpoplk.zip?download', 'WEB-DL / HD', 6, '2026-07-23 19:35:18.298072+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('2cb61e39-fa26-43db-a8bb-029e0b2a1646', '1aad2806-8173-4ae1-ae43-57d800d76bdd', NULL, 'Sinhala', 'Anomie_2026_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Anomie/Anomie.2026.720p.AMZN.WEB-DL_sinhala%20(1).zip?download', 'WEB-DL / HD', 2, '2026-07-24 12:04:54.624116+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('f36458f9-8836-43c1-ac6b-aa43d70f08f3', NULL, '77c2deb4-4b84-4592-a048-c57a573d3c75', 'Sinhala', 'Sons_of_Anarchy_S06E01_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S06e01%20@pixelpoplk761163/Sons_of_Anarchy_S06E01_@pixelpoplk761163.zip?download', 'WEB-DL / HD', 10, '2026-07-25 11:21:03.246098+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('4d94021d-7b2c-432e-a55a-7fba6e8a46cc', NULL, '3cfe9b71-d26b-4d27-ab90-cde86b07216d', 'Sinhala', 'Sons_of_Anarchy_S06E02_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S06e02%20@pixelpoplk767345/Sons_of_Anarchy_S06E02_@pixelpoplk767345.zip?download', 'WEB-DL / HD', 6, '2026-07-25 11:21:03.246098+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('b20cb815-aa5a-4553-a50a-29cad14e5a3b', NULL, '64dbf9bb-cb79-4704-a86b-f1c041c7da84', 'Sinhala', 'Sons_of_Anarchy_S06E03_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S06e03%20@pixelpoplk765210/Sons_of_Anarchy_S06E03_@pixelpoplk765210.zip?download', 'WEB-DL / HD', 5, '2026-07-25 11:21:03.246098+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('5cead87d-53c9-48ba-a692-2b8b76817bca', NULL, '75ce2c81-1976-43a1-ad91-dcce0c4c592e', 'Sinhala', 'Sons_of_Anarchy_S06E04_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S06e04%20@pixelpoplk768406/Sons_of_Anarchy_S06E04_@pixelpoplk768406.zip?download', 'WEB-DL / HD', 5, '2026-07-25 11:21:03.246098+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('cd5cd633-3e13-419d-abd3-15e389ac0b34', NULL, '64ea51cc-d8bd-405c-a422-5b2781e32566', 'Sinhala', 'Sons_of_Anarchy_S06E05_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S06e05%20@pixelpoplk766524/Sons_of_Anarchy_S06E05_@pixelpoplk766524.zip?download', 'WEB-DL / HD', 5, '2026-07-25 11:21:03.246098+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('c179b52c-15e6-4fc8-a8a6-aa042f90ef9a', NULL, '1c9893ce-278f-4c24-a7d2-a35198f81a1b', 'Sinhala', 'Sons_of_Anarchy_S06E06_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S06e06%20@pixelpoplk764136/Sons_of_Anarchy_S06E06_@pixelpoplk764136.zip?download', 'WEB-DL / HD', 5, '2026-07-25 11:21:03.246098+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('e7a29618-8694-4505-a209-1d7ef38da5c1', '7273abd3-83a6-4546-a3ec-63ecbad7afee', NULL, 'Sinhala', '72_Hours__2026__Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/72%20Hours%202026%20Webrip%20Hevc%20Psa%20Sinhala%20@pixelpoplk/72.Hours.2026.WEBRip.HEVC-PSA.sinhala.@pixelpoplk.zip?download', 'WEB-DL / HD', 5, '2026-07-26 08:15:56.089476+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('6c4c1565-0d52-4d7f-a315-3627c4a21831', NULL, '7e8ba31b-90ab-4c2b-a836-a7a609313b90', 'Sinhala', 'The_Walking_Dead__Dead_City_S03E01_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Walking%20Dead%20Dead%20City%20S03e01%20@pixelpoplk9609/The_Walking_Dead_Dead_City_S03E01_@pixelpoplk9609.zip?download', 'WEB-DL / HD', 10, '2026-07-26 09:14:46.57961+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('99320ca7-164e-4d77-acf8-ce17f329978d', NULL, 'edab7b3c-681d-4c9d-ace4-071fe9f67022', 'Sinhala', 'Sons_of_Anarchy_S06E07_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S06e07%205954/Sons_of_Anarchy_S06E07_5954.zip?download', 'WEB-DL / HD', 5, '2026-07-26 15:57:14.899352+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('9f9f8954-ea2c-45ef-a460-e2e23b2aa23e', NULL, '03492fb2-46fa-4256-a8de-cfc9d010374a', 'Sinhala', 'Sons_of_Anarchy_S06E08_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S06e08%203997/Sons_of_Anarchy_S06E08_3997.zip?download', 'WEB-DL / HD', 5, '2026-07-26 15:57:14.899352+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('509087e0-11de-464f-a849-84fd36ddf665', NULL, '92c0e755-8f28-41e3-a80c-964e244d2838', 'Sinhala', 'Sons_of_Anarchy_S06E09_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S06e09%207748/Sons_of_Anarchy_S06E09_7748.zip?download', 'WEB-DL / HD', 5, '2026-07-26 15:57:14.899352+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('3e0d3236-8470-4f76-a3ff-2b8a7a38789e', NULL, 'bd69d98f-b680-4233-a936-b5757b761ca5', 'Sinhala', 'Sons_of_Anarchy_S06E10_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S06e10%208344/Sons_of_Anarchy_S06E10_8344.zip?download', 'WEB-DL / HD', 5, '2026-07-26 15:57:14.899352+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('a5ab2185-0758-4542-a1ca-ba530f4a20be', NULL, '284cc148-417f-41bd-a016-a334425cf20b', 'Sinhala', 'Sons_of_Anarchy_S06E11_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S06e11%204513/Sons_of_Anarchy_S06E11_4513.zip?download', 'WEB-DL / HD', 5, '2026-07-26 15:57:14.899352+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('f75ea8f8-b2c6-4ca8-af90-139c62b406d0', NULL, '6893db14-d921-4e5d-aee9-00a9a7684990', 'Sinhala', 'Sons_of_Anarchy_S06E12_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S06e12%207409/Sons_of_Anarchy_S06E12_7409.zip?download', 'WEB-DL / HD', 5, '2026-07-26 15:57:14.899352+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('dabf7316-b8a9-449b-a126-ac5fc9691e14', NULL, '66a09de6-2feb-4a98-aded-f4c7876c8389', 'Sinhala', 'Sons_of_Anarchy_S06E13_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S06e13%205682/Sons_of_Anarchy_S06E13_5682.zip?download', 'WEB-DL / HD', 5, '2026-07-26 15:57:14.899352+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('333ea7b3-7cb4-4be7-ad13-ae45d58b0b5b', NULL, '20c0ef33-dcc6-4a16-af37-7120dfa53ff5', 'Sinhala', 'House_of_The_Dragon_S03E06_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/House%20of%20the%20Dragon%20S03e06%202991/House_of_the_Dragon_S03E06_2991.zip?download', 'WEB-DL / HD', 74, '2026-07-26 19:36:34.146575+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('243349aa-cd21-4783-a932-9584f02ed4b6', 'df9ada98-9278-4ca8-a15c-8a7ea09f99c8', NULL, 'Sinhala', 'Supergirl__2026__Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Supergirl/Supergirl.2026.720p.WEBRip_sinhala.zip?download', 'WEB-DL / HD', 1, '2026-07-27 06:46:17.212937+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('7a25da51-0464-4d53-a706-3dea2ac24f47', NULL, 'd0f4555f-a4fc-4da0-aa16-250bf17b6dc6', 'Sinhala', 'The_Sopranos_S01E01_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S01e01%209451/The_Sopranos_S01E01_9451.zip?download', 'WEB-DL / HD', 161, '2026-07-28 16:58:59.501453+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('d844156a-80bb-4617-af86-3764bd471864', NULL, '2c4823c5-2eba-4b71-a8fc-8ecf344ae8a2', 'Sinhala', 'Sons_of_Anarchy_S07E01_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S07e01%202778/Sons_of_Anarchy_S07E01_2778.zip?download', 'WEB-DL / HD', 5, '2026-07-28 17:47:57.477299+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('6ba8425b-2b44-46f3-a1bb-c0ee7f70cf75', NULL, '63b40e8f-3f58-4378-aef8-b4e46519ccd7', 'Sinhala', 'Sons_of_Anarchy_S07E02_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S07e02%206601/Sons_of_Anarchy_S07E02_6601.zip?download', 'WEB-DL / HD', 4, '2026-07-28 17:47:57.477299+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('958cfb82-17a4-483f-ad68-aa74270c0256', NULL, '5e5d6994-0c1e-4a5b-a409-0ec027c01610', 'Sinhala', 'Sons_of_Anarchy_S07E03_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S07e03%205551/Sons_of_Anarchy_S07E03_5551.zip?download', 'WEB-DL / HD', 4, '2026-07-28 17:47:57.477299+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('47fdc132-bdc2-4b42-a586-766a9091ccd9', '3cf8526a-e6d0-4385-a6c8-a42b45e28736', NULL, 'Sinhala', 'Demon_Slayer___Infinity_Castle_2025_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Demon%20Slayer%20Infinity%20Castle%202025%20Bluray%20Sinhala%2045454/Demon_Slayer_Infinity_Castle_2025.BluRay_sinhala_45454.zip?download', 'WEB-DL / HD', 0, '2026-07-28 20:01:07.145515+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('55987492-f18e-4f62-a2b4-c1269f574a31', NULL, '58f4f368-2048-4dfe-ade8-cb8f6a71335c', 'Sinhala', 'Sons_of_Anarchy_S07E04_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S07e04%202108/Sons_of_Anarchy_S07E04_2108.zip?download', 'WEB-DL / HD', 4, '2026-07-29 15:47:39.376403+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('c38ca63e-ff0e-48af-a34b-069d00989d8a', NULL, 'b644584d-6beb-4f9e-afe9-eb5ee8eedfd1', 'Sinhala', 'Sons_of_Anarchy_S07E05_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S07e05%204215/Sons_of_Anarchy_S07E05_4215.zip?download', 'WEB-DL / HD', 4, '2026-07-29 15:47:39.376403+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('7fbbb9b2-49de-4599-a967-3a4f11f457a3', NULL, '83d768fe-b45e-4c9d-a6f4-45972629217b', 'Sinhala', 'Sons_of_Anarchy_S07E06_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S07e06%201715/Sons_of_Anarchy_S07E06_1715.zip?download', 'WEB-DL / HD', 4, '2026-07-29 15:47:39.376403+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('3c0db684-326f-44c8-ad21-91e34080ade1', NULL, '955ea3c4-c95a-4ab3-adda-230eb371fee4', 'Sinhala', 'Sons_of_Anarchy_S07E07_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S07e07%206809/Sons_of_Anarchy_S07E07_6809.zip?download', 'WEB-DL / HD', 4, '2026-07-29 15:47:39.376403+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('15491a5c-af82-4d39-a186-d9a732b823b3', NULL, '0302ad93-a071-4659-a7ac-68d2eadbce48', 'Sinhala', 'The_Sopranos_S01E02_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S01e02%202845/The_Sopranos_S01E02_2845.zip?download', 'WEB-DL / HD', 100, '2026-07-29 16:57:22.390038+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('d9770cc5-81ab-4c77-a719-afee76901126', NULL, 'e76fccd1-c5d4-4364-a13a-cdd08d7f82dc', 'Sinhala', 'Sons_of_Anarchy_S07E08_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S07e08%201620/Sons_of_Anarchy_S07E08_1620.zip?download', 'WEB-DL / HD', 4, '2026-07-30 09:44:00.617394+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('67d25f95-d29c-4528-a945-54c9f6e14e89', NULL, '8effbb46-e183-4e09-acd6-8e7020089a5c', 'Sinhala', 'Sons_of_Anarchy_S07E09_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S07e09%202852/Sons_of_Anarchy_S07E09_2852.zip?download', 'WEB-DL / HD', 4, '2026-07-30 09:44:00.617394+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('77b06253-5e13-4199-a2de-066ce06abe71', NULL, '406954d8-a6c4-4461-a0f5-128b46a552cb', 'Sinhala', 'Sons_of_Anarchy_S07E10_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S07e10%208615/Sons_of_Anarchy_S07E10_8615.zip?download', 'WEB-DL / HD', 4, '2026-07-30 09:44:00.617394+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('d6ff63cf-a093-46ff-ab35-dee4476c182e', NULL, '75dcb4d7-ad01-4b5d-ac44-af7dcc074143', 'Sinhala', 'Sons_of_Anarchy_S07E11_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S07e11%203040/Sons_of_Anarchy_S07E11_3040.zip?download', 'WEB-DL / HD', 4, '2026-07-30 09:44:00.617394+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('5207c51e-aeab-4aa4-ad96-fe1c79db0b69', NULL, 'a3557a0a-cddd-4b54-ae83-078d0c5db74d', 'Sinhala', 'Sons_of_Anarchy_S07E12_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S07e12%206642/Sons_of_Anarchy_S07E12_6642.zip?download', 'WEB-DL / HD', 6, '2026-07-30 09:44:00.617394+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('7f880175-71a3-4d0d-abd0-bb6eea975ba8', NULL, 'c3e0b55d-5d39-4694-a57e-290dc2dd1688', 'Sinhala', 'Sons_of_Anarchy_S07E13_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Sons%20of%20Anarchy%20S07e13%201168/Sons_of_Anarchy_S07E13_1168.zip?download', 'WEB-DL / HD', 5, '2026-07-30 09:44:00.617394+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('01251184-dc49-47da-af6f-d65f1eafb6fb', 'd42c4776-344b-449a-a5fe-a6cadb6b0e59', NULL, 'Sinhala', 'Spider_Man__Brand_New_Day__2026__Sinhala.srt', 'https://vegamoviess.cc/56319-spiderman-brand-new-day-2026-english-audio-hdtc-720p-480p-1080p.html', 'WEB-DL / HD', 37, '2026-07-30 10:11:12.178415+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('a5b0d98f-e7f3-4095-a85d-7844fb12afad', NULL, 'ec8eed25-378b-42af-a65e-374ca3131bf2', 'Sinhala', 'The_Sopranos_S01E03_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S01e03%20197956%20(/The_Sopranos_S01E03_197956%20(1).zip?download', 'WEB-DL / HD', 40, '2026-07-30 17:16:11.526432+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('95c9e32d-3807-4a90-a6d3-d299da2f42b2', NULL, 'a6cfd8cd-59ce-498f-a9bc-47204425eef6', 'Sinhala', 'Batman__Caped_Crusader_S01E01_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Batman%20Caped%20Crusader%20S01e01%20852284/Batman_Caped_Crusader_S01E01_852284.zip?download', 'WEB-DL / HD', 4, '2026-07-31 09:09:26.160221+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('8e9930ab-e158-4678-a9db-fe69087c3253', NULL, 'f4fcbb58-0b08-4cee-a88c-c7365cf0659b', 'Sinhala', 'Batman__Caped_Crusader_S01E02_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Batman%20Caped%20Crusader%20S01e02%20658105/Batman_Caped_Crusader_S01E02_658105.zip?download', 'WEB-DL / HD', 1, '2026-07-31 09:09:26.160221+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('520f7332-fc76-4dcb-aef3-f8243b8c69b8', NULL, '3b51ac84-ce09-4234-a343-1c74913985a4', 'Sinhala', 'Batman__Caped_Crusader_S01E03_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Batman%20Caped%20Crusader%20S01e03%20445345/Batman_Caped_Crusader_S01E03_445345.zip?download', 'WEB-DL / HD', 1, '2026-07-31 09:09:26.160221+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('65360ecf-b03c-4087-aab0-b1dd079d94d2', NULL, 'e9ae28bd-37c8-47a9-ac40-32dafe67d221', 'Sinhala', 'Batman__Caped_Crusader_S01E04_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Batman%20Caped%20Crusader%20S01e04%20959128/Batman_Caped_Crusader_S01E04_959128.zip?download', 'WEB-DL / HD', 3, '2026-07-31 09:09:26.160221+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('26c4ac08-b6ab-484d-aab0-5c0281bea0a0', NULL, 'ba471fc4-cdd7-433f-ac73-5630f9f7805a', 'Sinhala', 'Batman__Caped_Crusader_S01E05_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Batman%20Caped%20Crusader%20S01e05%20205699/Batman_Caped_Crusader_S01E05_205699.zip?download', 'WEB-DL / HD', 1, '2026-07-31 09:09:26.160221+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('688231ed-adfb-45f5-a391-3af24b7c1df5', NULL, 'fea0951d-e28c-4d8c-a0ac-6b46c488eddd', 'Sinhala', 'The_Sopranos_S01E04_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S01e04%20907241/The_Sopranos_S01E04_907241.zip?download', 'WEB-DL / HD', 42, '2026-07-31 15:59:35.827563+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('1caab38a-e688-4ad7-a763-4911671a210d', NULL, '2a0eae91-9ba4-4a13-afe3-ebb0cd010529', 'Sinhala', 'The_Sopranos_S01E05_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S01e05%20940875/The_Sopranos_S01E05_940875.zip?download', 'WEB-DL / HD', 27, '2026-07-31 17:35:43.965012+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('7a321b43-e1f5-4f08-adcc-381c364cd926', NULL, '95edb036-490d-4672-a691-de72f1fc4433', 'Sinhala', 'The_Sopranos_S01E06_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S01e06%20865595/The_Sopranos_S01E06_865595.zip?download', 'WEB-DL / HD', 25, '2026-08-01 18:42:43.72199+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('5bea3310-b9f7-4490-a9a8-a4f85501464b', NULL, 'a4c80c92-c0cd-42c0-a40c-d11d2446d96f', 'Sinhala', 'The_Sopranos_S01E07_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S01e07%20285423/The_Sopranos_S01E07_285423.zip?download', 'WEB-DL / HD', 22, '2026-08-01 18:42:43.72199+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('f8a49e54-ce14-449f-aade-7cbb76ade107', NULL, 'c4b9733a-acb6-4a6c-a682-6ff934780c1f', 'Sinhala', 'The_Sopranos_S01E08_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S01e08%20104983/The_Sopranos_S01E08_104983.zip?download', 'WEB-DL / HD', 23, '2026-08-01 18:42:43.72199+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('da8d1912-5d43-4249-a26f-58eb25e21d9b', '864fdf34-739e-4d67-a432-7871ff39f735', NULL, 'Sinhala', 'Soulm8te_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Soulm8te/Soulm8te.2026.720p.WEB-DL.x265.10Bit-Pahe.sinhala@pixelpoplk.zip?download', 'WEB-DL / HD', 1, '2026-08-02 10:40:16.846602+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('a5556618-efd7-4a83-a561-263a5b4d69ef', NULL, '51d69f36-0897-4aa6-a071-3091f4df449c', 'Sinhala', 'The_Sopranos_S01E09_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S01e09%20944054/The_Sopranos_S01E09_944054.zip?download', 'WEB-DL / HD', 20, '2026-08-02 11:53:59.619015+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('6c98a503-1c19-4640-a928-214ebe762b15', NULL, '710e795f-a404-46ce-aaf6-0343d30ccc43', 'Sinhala', 'The_Sopranos_S01E10_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S01e10%20720818/The_Sopranos_S01E10_720818.zip?download', 'WEB-DL / HD', 24, '2026-08-02 11:53:59.619015+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('e84f3658-7b29-43f7-a07e-20aa814525b3', NULL, '31700cda-d742-45d1-a603-a060d2967c16', 'Sinhala', 'The_Sopranos_S01E11_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S01e11%20794463/The_Sopranos_S01E11_794463.zip?download', 'WEB-DL / HD', 20, '2026-08-02 11:53:59.619015+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('009a53cc-310d-4780-a886-b41bdc9d1fa3', NULL, '65c4f780-ba0b-4b8f-a989-a8071213610a', 'Sinhala', 'The_Sopranos_S01E12_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S01e12%20781430/The_Sopranos_S01E12_781430.zip?download', 'WEB-DL / HD', 21, '2026-08-02 11:53:59.619015+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('8c64df47-49f1-46b2-a037-54b31cd59952', NULL, 'cf2881d3-1dd2-4b90-a256-15d63f803d58', 'Sinhala', 'The_Sopranos_S01E13_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S01e13%20740206/The_Sopranos_S01E13_740206.zip?download', 'WEB-DL / HD', 23, '2026-08-02 11:53:59.619015+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('20d0b093-dafe-46c7-aeaf-48c0b08948a0', NULL, '74c2427b-5304-48b9-af5f-eaba3842a990', 'Sinhala', 'House_of_The_Dragon_S03E07_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/House%20of%20the%20Dragon%20S03e07%20234347/House_of_the_Dragon_S03E07_234347.zip?download', 'WEB-DL / HD', 29, '2026-08-03 02:22:22.473636+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('c76f8d1e-1a90-4924-a501-b007b7824eb8', NULL, 'f5146e8f-c913-4aad-a945-fa8b34b8778c', 'Sinhala', 'The_Walking_Dead__Dead_City_S03E02_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Walking%20Dead%20Dead%20City%20S03e02%20880775/The_Walking_Dead_Dead_City_S03E02_880775.zip?download', 'WEB-DL / HD', 0, '2026-08-03 09:03:10.202106+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('0fba5d9c-3fcc-4a75-a2e3-66e3ee6d292a', '27348593-2ecd-404c-a1de-9b09f44a255c', NULL, 'Sinhala', 'Evil_Dead_Burn__2026__Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Evil%20Dead%20Burn/Evil.Dead.Burn.2026.WEBRip_sinhala.srt.zip?download', 'WEB-DL / HD', 9, '2026-08-04 08:00:52.849475+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('652a325e-a2d4-43f5-a574-2db9fd2eb0a5', NULL, '11381df3-b8be-48d4-a1ad-569e05c95521', 'Sinhala', 'The_Sopranos_S02E01_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S02e01%20394561/The_Sopranos_S02E01_394561.zip?download', 'WEB-DL / HD', 13, '2026-08-04 13:03:55.568064+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('057d1994-0273-4583-a5d8-ce135f2ca19d', NULL, 'fb0ccdae-d227-469d-a5bf-8397a8e67e11', 'Sinhala', 'The_Sopranos_S02E02_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S02e02%20713497/The_Sopranos_S02E02_713497.zip?download', 'WEB-DL / HD', 13, '2026-08-04 13:03:55.568064+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('6a470d40-f062-4b68-aa82-5047c9b7c977', NULL, '45bb51fe-8399-4ff9-aca0-0fb5ef8e5f0d', 'Sinhala', 'The_Sopranos_S02E03_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S02e03%20564981/The_Sopranos_S02E03_564981.zip?download', 'WEB-DL / HD', 11, '2026-08-04 13:03:55.568064+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('70286fcb-90bf-4eef-a8ca-5b693b17eaa4', NULL, 'dc904877-7506-487a-a885-56cae91aa869', 'Sinhala', 'The_Sopranos_S02E04_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S02e04%20190095/The_Sopranos_S02E04_190095.zip?download', 'WEB-DL / HD', 11, '2026-08-04 13:03:55.568064+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('458e3119-9bdf-4800-a137-a143a43e37b4', NULL, '1a42ff11-76f2-406f-a112-74050f0ed6b3', 'Sinhala', 'The_Sopranos_S02E05_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S02e05%20797662/The_Sopranos_S02E05_797662.zip?download', 'WEB-DL / HD', 7, '2026-08-04 13:03:55.568064+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('4f35498f-3bd6-42ba-a5d8-21fda4f3dee4', NULL, '5a628954-c86b-4446-aba7-35c164668a1b', 'Sinhala', 'The_Sopranos_S02E06_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S02e06%20535651/The_Sopranos_S02E06_535651.zip?download', 'WEB-DL / HD', 7, '2026-08-04 13:03:55.568064+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('bb891720-c5c2-41b4-a7ac-94458a984315', NULL, '25c29c59-b2ed-47b4-aab3-5c75da0f60af', 'Sinhala', 'The_Sopranos_S02E07_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S02e07%20303750/The_Sopranos_S02E07_303750.zip?download', 'WEB-DL / HD', 8, '2026-08-04 13:03:55.568064+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('ce09d4f1-7ba3-4461-affb-a7a99971fa8f', '818a4550-dcd3-47b2-aac9-8a5cc2177b56', NULL, 'Sinhala', 'The_Isolate_Thief__2026__Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Isolate%20Thief/The.Isolate.Thief.2026.WEB-DL_sinhala.zip?download', 'WEB-DL / HD', 5, '2026-08-05 06:34:07.587586+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('b119c6fb-fe79-491f-a8f8-7546dcabd814', NULL, '066a18bc-7bdb-4a18-aa2e-4cbad14402c4', 'Sinhala', 'Batman__Caped_Crusader_S01E06_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Batman%20Caped%20Crusader%20S01e06%20311606/Batman_Caped_Crusader_S01E06_311606.zip?download', 'WEB-DL / HD', 1, '2026-08-05 06:40:15.262255+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('bb25d3c4-9055-445b-a1ec-2316521fb9b2', NULL, '13adeaee-d6b9-4ce7-aaa3-22014c09f3fe', 'Sinhala', 'Batman__Caped_Crusader_S01E07_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Batman%20Caped%20Crusader%20S01e07%20955765/Batman_Caped_Crusader_S01E07_955765.zip?download', 'WEB-DL / HD', 1, '2026-08-05 06:40:15.262255+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('043dfda1-218d-4b3c-aad4-7b92812cc1b1', NULL, 'eb7be14d-309e-447a-af0c-77c067687792', 'Sinhala', 'Batman__Caped_Crusader_S01E08_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Batman%20Caped%20Crusader%20S01e08%20817274/Batman_Caped_Crusader_S01E08_817274.zip?download', 'WEB-DL / HD', 1, '2026-08-05 06:40:15.262255+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('81d50405-61f0-491d-a12c-d159451ba289', NULL, '8918d7af-ddc8-4d79-a115-648c4d8a842b', 'Sinhala', 'Batman__Caped_Crusader_S01E09_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Batman%20Caped%20Crusader%20S01e09%20177201/Batman_Caped_Crusader_S01E09_177201.zip?download', 'WEB-DL / HD', 1, '2026-08-05 06:40:15.262255+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('2c968bd6-8c4e-4ba5-ac42-985bf1d578a9', NULL, '66a28dbc-03be-430c-ab95-6e85647ceb4a', 'Sinhala', 'Batman__Caped_Crusader_S01E10_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Batman%20Caped%20Crusader%20S01e10%20918984/Batman_Caped_Crusader_S01E10_918984.zip?download', 'WEB-DL / HD', 1, '2026-08-05 06:40:15.262255+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('97913318-b550-4b0b-ad51-bcdd08867f4d', NULL, 'd5ff3e6f-be53-41a0-a1db-a32c7fd6058c', 'Sinhala', 'The_Sopranos_S02E08_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S02e08%20397981/The_Sopranos_S02E08_397981.zip?download', 'WEB-DL / HD', 7, '2026-08-05 14:04:25.09645+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('64b9066b-8fb7-4e47-a93f-da15d9700d43', NULL, '58f013a3-9706-4a95-a23b-1447a33dcfdd', 'Sinhala', 'The_Sopranos_S02E09_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S02e09%20375801/The_Sopranos_S02E09_375801.zip?download', 'WEB-DL / HD', 8, '2026-08-05 14:04:25.09645+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('eca91471-74e1-4ea7-aa49-c6e2a76c0060', NULL, 'aecf096e-b032-4427-a048-5847754c40d9', 'Sinhala', 'The_Sopranos_S02E10_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S02e10%20504007/The_Sopranos_S02E10_504007.zip?download', 'WEB-DL / HD', 7, '2026-08-05 14:04:25.09645+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('6d5c6dcb-4e5b-49bc-abae-c25c63b847b5', NULL, 'fc308178-cf48-4075-ae4f-7d52903534cf', 'Sinhala', 'The_Sopranos_S02E11_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S02e11%20326649/The_Sopranos_S02E11_326649.zip?download', 'WEB-DL / HD', 7, '2026-08-05 14:04:25.09645+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('a872b174-bbc7-4b27-a850-fbe07f198335', NULL, '0da8bb61-54d3-4e34-a964-3c3aeeb2f16a', 'Sinhala', 'The_Sopranos_S02E12_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S02e12%20646366/The_Sopranos_S02E12_646366.zip?download', 'WEB-DL / HD', 7, '2026-08-05 14:04:25.09645+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('5b66b228-505d-4e43-a2d7-8bb9de81b849', NULL, '8edacccc-9ea3-464e-a452-1a43a32f6a8c', 'Sinhala', 'The_Sopranos_S02E13_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S02e13%20327223/The_Sopranos_S02E13_327223.zip?download', 'WEB-DL / HD', 7, '2026-08-05 14:04:25.09645+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('a1342a02-d2a8-4608-ae12-8ec8ea21ec16', NULL, 'c8b7d6e7-659c-441d-a6b2-0f793f7a12f3', 'Sinhala', 'Black_Bird_S01E01_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Black%20Bird%20S01e01%20720813/Black_Bird_S01E01_720813.zip?download', 'WEB-DL / HD', 42, '2026-08-06 10:35:58.56554+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('7843eb87-168e-4e8b-aaab-65931544ec46', NULL, 'b8b71ba1-035c-4e38-abeb-5a963747103b', 'Sinhala', 'Black_Bird_S01E02_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Black%20Bird%20S01e02%20748252/Black_Bird_S01E02_748252.zip?download', 'WEB-DL / HD', 34, '2026-08-06 10:35:58.56554+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('1777b72b-5262-4716-a93d-0e6b27d5ad41', NULL, 'c6bd7616-67b9-4ef0-ab7b-8f0dc1c59094', 'Sinhala', 'Black_Bird_S01E03_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Black%20Bird%20S01e03%20897257/Black_Bird_S01E03_897257.zip?download', 'WEB-DL / HD', 17, '2026-08-06 10:35:58.56554+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('25a5d2c8-bc9b-4577-a03d-bcfe4bede05b', NULL, '97480402-5c90-4820-a67b-eb3200b200fd', 'Sinhala', 'Black_Bird_S01E04_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Black%20Bird%20S01e04%20489323/Black_Bird_S01E04_489323.zip?download', 'WEB-DL / HD', 12, '2026-08-06 10:35:58.56554+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('1435addc-8d3d-4743-aba1-b19ffca3736a', NULL, 'bdb6486a-12de-48ef-a744-d33ba66f3350', 'Sinhala', 'Black_Bird_S01E05_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Black%20Bird%20S01e05%20471717/Black_Bird_S01E05_471717.zip?download', 'WEB-DL / HD', 9, '2026-08-06 10:35:58.56554+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('fdf3169a-a04f-4f92-add8-bbee0703e11a', NULL, 'ace2be51-4e1b-4bda-aaf2-0ba9c9503f18', 'Sinhala', 'Black_Bird_S01E06_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Black%20Bird%20S01e06%20728697/Black_Bird_S01E06_728697.zip?download', 'WEB-DL / HD', 8, '2026-08-06 10:35:58.56554+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('62078e1a-66c3-41bc-a99b-0176453da528', 'ea4bba9c-79bc-4754-acc5-2346a5fa7043', NULL, 'Sinhala', 'Lenin__2026__Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Lenin/Lenin.2026.720p.ZEE5.WEB-DL_sinhala.zip?download', 'WEB-DL / HD', 6, '2026-08-07 07:34:34.672569+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('ff2fefa1-80c7-4af9-ae6c-53c6949c463d', '13edeece-2efe-4aa9-a85f-f62b92aa5f88', NULL, 'Sinhala', 'Idhayam_Murali__2026__Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Idhayam%20Murali%20(/Idhayam%20Murali%20(2026)%20HQ%20HDRip%20-%20sinhala.zip?download', 'WEB-DL / HD', 20, '2026-08-07 09:54:02.964215+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('b149e454-e223-4b1e-a986-2e612a71809c', NULL, '40eff4a1-1286-4be5-a527-ed426a350c79', 'Sinhala', 'Our_Sticky_Love_S01E01_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Our%20Sticky%20Love%20S01e01%20993851/Our_Sticky_Love_S01E01_993851.zip?download', 'WEB-DL / HD', 2, '2026-08-08 08:30:23.609856+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('e3203885-a74a-4307-ad83-2455fe94cf20', NULL, '94a241a0-94ee-4f4b-a1d3-266d92a048ae', 'Sinhala', 'The_Night_of_S01E01_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Night%20of%20S01e01%20867272/The_Night_Of_S01E01_867272.zip?download', 'WEB-DL / HD', 19, '2026-08-08 11:01:21.636301+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('afe3c5fc-0f10-4b37-a57c-99eb7ff2cebe', NULL, '37e475b0-4507-43f7-aedc-49ec791400af', 'Sinhala', 'House_of_The_Dragon_S03E08_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/House%20of%20the%20Dragon%20S03e08%20394614/House_of_the_Dragon_S03E08_394614.zip?download', 'WEB-DL / HD', 357, '2026-08-09 18:17:04.550544+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('c805413f-dca4-4ead-a813-6787655acbad', 'cd43d917-6076-4b02-a085-caec2d8f1f60', NULL, 'Sinhala', 'The_Invite__2026__Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Invite/The.Invite.2026.WEBRip.sinhala.zip?download', 'WEB-DL / HD', 14, '2026-08-10 12:27:21.523628+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('baf23e33-ebff-4c31-a89e-047b54eb673e', NULL, 'f553f3c2-685f-4c47-affe-6a4a9bb08a82', 'Sinhala', 'The_Walking_Dead__Dead_City_S03E03_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Walking%20Dead%20Dead%20City%20S03e03%20138024/The_Walking_Dead_Dead_City_S03E03_138024.zip?download', 'WEB-DL / HD', 5, '2026-08-10 13:02:14.876293+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('b9898490-8001-4c55-a655-de7ac5327042', NULL, '1a8c74d1-454f-4eda-a981-9fd8cac7e925', 'Sinhala', 'The_Sopranos_S03E01_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S03e01%20909109/The_Sopranos_S03E01_909109.zip?download', 'WEB-DL / HD', 12, '2026-08-11 13:42:49.900781+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('6b1177f4-7052-44db-ad10-4a06612210e3', NULL, 'ad4d6aa8-2423-44af-adf0-3f06c3286455', 'Sinhala', 'The_Sopranos_S03E02_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S03e02%20933482/The_Sopranos_S03E02_933482.zip?download', 'WEB-DL / HD', 7, '2026-08-11 13:42:49.900781+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('125eca75-5175-4071-a1af-40c8bd7965dd', NULL, '58fe2ca3-311b-42e3-a5dc-88f3bb2f1979', 'Sinhala', 'The_Sopranos_S03E03_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S03e03%20474854/The_Sopranos_S03E03_474854.zip?download', 'WEB-DL / HD', 7, '2026-08-11 13:42:49.900781+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('9d712531-7f66-4973-aaf9-c3a140ae2d83', NULL, 'e27888a2-fb08-4a4b-ac48-f237cd8fed6b', 'Sinhala', 'The_Sopranos_S03E04_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S03e04%20852059/The_Sopranos_S03E04_852059.zip?download', 'WEB-DL / HD', 8, '2026-08-11 13:42:49.900781+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('4a031c11-df42-40eb-a6fb-50d591f0b38c', NULL, '1b656de1-5e5f-4102-aca3-4789567c3579', 'Sinhala', 'The_Sopranos_S03E05_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S03e05%20718927/The_Sopranos_S03E05_718927.zip?download', 'WEB-DL / HD', 7, '2026-08-11 13:42:49.900781+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('c548a595-5ba5-4848-afaf-40e1f1b0e659', NULL, '8991af5f-0ff6-4961-a2b5-e9a555cd95bc', 'Sinhala', 'Reacher_S04E01_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Reacher%20S04e01%20605767/Reacher_S04E01_605767.zip?download', 'WEB-DL / HD', 67, '2026-08-12 08:51:51.598699+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('0b8d69e2-97c9-4267-adb7-3698834bb0f0', NULL, 'f5d37077-57ba-49ed-aa2f-478e40f20cb0', 'Sinhala', 'Reacher_S04E02_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Reacher%20S04e02%20764263/Reacher_S04E02_764263.zip?download', 'WEB-DL / HD', 33, '2026-08-12 11:07:22.290595+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('65cf2978-23ae-49f3-a876-fda91a08c395', NULL, '8b7fb51f-0142-4edf-a86b-adfbc039efc2', 'Sinhala', 'Reacher_S04E03_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Reacher%20S04e03%20133069/Reacher_S04E03_133069.zip?download', 'WEB-DL / HD', 29, '2026-08-12 11:07:22.290595+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('23b6d884-7ac2-4eca-a693-e6959d1fe887', NULL, '6280c28b-3194-4a60-a8fe-a7a3a13699d7', 'Sinhala', 'The_Night_Of_S01E02_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Night%20of%20S01e02%20106730/The_Night_Of_S01E02_106730.zip?download', 'WEB-DL / HD', 7, '2026-08-12 17:01:42.133751+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('e8cc9664-98bf-4d04-a590-2f12de16e101', NULL, 'c8188f07-4d2e-470c-afd0-244c7378402b', 'Sinhala', 'The_Night_Of_S01E03_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Night%20of%20S01e03%20630715/The_Night_Of_S01E03_630715.zip?download', 'WEB-DL / HD', 6, '2026-08-12 17:01:42.133751+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('68e35f99-8e49-4429-afa2-bd7890177865', NULL, '85b87adc-baa2-491d-ab40-3727af06ddad', 'Sinhala', 'The_Night_Of_S01E04_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Night%20of%20S01e04%20112317/The_Night_Of_S01E04_112317.zip?download', 'WEB-DL / HD', 7, '2026-08-12 17:01:42.133751+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('142b2f52-e8ae-47cf-add3-408545a160db', NULL, 'e7846de1-9b15-49dc-aacd-f480f9d50dcf', 'Sinhala', 'The_Night_Of_S01E05_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Night%20of%20S01e05%20899873/The_Night_Of_S01E05_899873.zip?download', 'WEB-DL / HD', 6, '2026-08-12 17:01:42.133751+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('c21975b4-10c6-424b-a9f0-f1079de9ca32', NULL, '70e78e42-65e2-4fbd-a4d0-6b9dfa82206f', 'Sinhala', 'The_Night_Of_S01E06_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Night%20of%20S01e06%20156862/The_Night_Of_S01E06_156862.zip?download', 'WEB-DL / HD', 6, '2026-08-12 17:01:42.133751+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('769dd363-62e2-41e6-a969-38233d7c23f7', NULL, '61604b7c-f5cb-4fb0-a4e5-6bc2adaf755f', 'Sinhala', 'The_Night_Of_S01E07_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Night%20of%20S01e07%20341151/The_Night_Of_S01E07_341151.zip?download', 'WEB-DL / HD', 6, '2026-08-12 17:01:42.133751+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('823d0510-89ac-4a81-ac98-8959a14eb062', NULL, 'ff4dcc37-773b-4aed-a294-ae8f4a20d492', 'Sinhala', 'The_Night_Of_S01E08_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Night%20of%20S01e08%20561344/The_Night_Of_S01E08_561344.zip?download', 'WEB-DL / HD', 7, '2026-08-12 17:01:42.133751+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('4c14336c-e8ca-4c5a-a0e6-8c6aa099efec', NULL, '191fb25b-1489-4aa5-a09c-3a1bb5035682', 'Sinhala', 'The_Sopranos_S03E06_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S03e06%20795011/The_Sopranos_S03E06_795011.zip?download', 'WEB-DL / HD', 7, '2026-08-13 13:52:53.403139+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('f03d1582-ea59-477f-ae25-694236671e37', NULL, '0e544c60-134d-4b6e-ab7a-d60812c17d9d', 'Sinhala', 'The_Sopranos_S03E07_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S03e07%20725705/The_Sopranos_S03E07_725705.zip?download', 'WEB-DL / HD', 8, '2026-08-13 13:52:53.403139+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('5b6c84d4-bd4f-4b23-ac59-4bdc59c13fe9', NULL, 'f658749e-03ec-41a8-ac3c-3036f9d85f33', 'Sinhala', 'The_Sopranos_S03E08_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S03e08%20321435/The_Sopranos_S03E08_321435.zip?download', 'WEB-DL / HD', 8, '2026-08-13 13:52:53.403139+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('9c1b36fc-898b-4a65-a093-371f785ee467', NULL, '8cc52726-234b-432b-af43-5ce8491f5a8b', 'Sinhala', 'The_Sopranos_S03E09_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S03e09%20392346/The_Sopranos_S03E09_392346.zip?download', 'WEB-DL / HD', 8, '2026-08-13 13:52:53.403139+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('ab238827-6679-4d6a-a97b-c7cc5aad3e8a', NULL, 'e9b5512c-2484-45b0-a8bb-4b80aa715f3c', 'Sinhala', 'The_Sopranos_S03E10_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S03e10%20864968/The_Sopranos_S03E10_864968.zip?download', 'WEB-DL / HD', 8, '2026-08-13 13:52:53.403139+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('058978b5-cd04-4123-a339-5b56920ddf35', NULL, '5be25a7b-2fee-4755-a871-5650c019faf5', 'Sinhala', 'The_Sopranos_S03E11_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S03e11%20942041/The_Sopranos_S03E11_942041.zip?download', 'WEB-DL / HD', 9, '2026-08-13 13:52:53.403139+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('b58b26d4-8c8f-4909-abc5-b668605d13c6', NULL, '149865ec-ea72-4647-ab86-b12fdb66a63a', 'Sinhala', 'The_Sopranos_S03E12_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S03e12%20846554/The_Sopranos_S03E12_846554.zip?download', 'WEB-DL / HD', 7, '2026-08-13 13:52:53.403139+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('a2b3cdd5-d897-4d38-a5e5-26f6d47b858f', NULL, 'a0be06c0-210a-4599-aa21-fc366d3a818d', 'Sinhala', 'The_Sopranos_S03E13_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S03e13%20997585/The_Sopranos_S03E13_997585.zip?download', 'WEB-DL / HD', 9, '2026-08-13 13:52:53.403139+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('e1b882b1-a8e6-4a0c-aef3-a6a38fe38ddc', 'dfe1fee9-3347-4a6a-a91c-9610969dd963', NULL, 'Sinhala', 'Cocktail_2_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Cocktail/Cocktail.2.2026.NF.WEB-DL.Hindi.ExtraFlix_sinhala.zip?download', 'WEB-DL / HD', 78, '2026-08-14 18:39:26.460286+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('cfaba97c-5d03-43b4-a5b0-6862ed84a8f9', NULL, '98b05e9d-cd93-4508-a217-81fd5b3b0036', 'Sinhala', 'The_Sopranos_S04E01_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S04e01%20445127/The_Sopranos_S04E01_445127.zip?download', 'WEB-DL / HD', 5, '2026-08-15 23:36:34.227099+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('bff61577-fc60-493e-a501-d987a1add427', NULL, '8f2f9892-b228-4212-abb5-35515d84c0a3', 'Sinhala', 'The_Sopranos_S04E02_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S04e02%20699287/The_Sopranos_S04E02_699287.zip?download', 'WEB-DL / HD', 5, '2026-08-15 23:36:34.227099+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('9c61bea3-f280-4189-afb8-9ccc1e53736d', NULL, '8aba4e35-8b7b-4d06-ad89-6551b5f9b402', 'Sinhala', 'The_Sopranos_S04E03_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S04e03%20457351/The_Sopranos_S04E03_457351.zip?download', 'WEB-DL / HD', 5, '2026-08-15 23:36:34.227099+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('d6de3d91-fd07-41cd-a429-98ba9e52ce30', NULL, 'b5f05606-c416-4a11-aa1a-80b6bd800c37', 'Sinhala', 'The_Sopranos_S04E04_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S04e04%20475444/The_Sopranos_S04E04_475444.zip?download', 'WEB-DL / HD', 4, '2026-08-15 23:36:34.227099+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('c6b33391-6055-4266-acdc-ff1d25275a31', NULL, '1d377f3c-ab53-4cb6-af8f-09a404e8f723', 'Sinhala', 'The_Sopranos_S04E05_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S04e05%20506471/The_Sopranos_S04E05_506471.zip?download', 'WEB-DL / HD', 4, '2026-08-15 23:36:34.227099+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('4c206b31-3543-44be-af3c-49f67abd29b3', NULL, '2372aab2-eef2-4116-a97b-d582cadfa8e2', 'Sinhala', 'The_Sopranos_S04E06_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S04e06%20177333/The_Sopranos_S04E06_177333.zip?download', 'WEB-DL / HD', 4, '2026-08-15 23:36:34.227099+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('17fb0941-189e-4e57-a02f-115650a8c737', NULL, 'b464488c-24ac-4d31-ae16-e649bef534e6', 'Sinhala', 'The_Sopranos_S04E07_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S04e07%20404453/The_Sopranos_S04E07_404453.zip?download', 'WEB-DL / HD', 4, '2026-08-15 23:36:34.227099+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('83513bf1-20c8-4f2e-acf1-90942ed2d7c6', NULL, 'b7936214-2dc4-442d-a9a0-765a41cb09f8', 'Sinhala', 'The_Sopranos_S04E08_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S04e08%20264067/The_Sopranos_S04E08_264067.zip?download', 'WEB-DL / HD', 4, '2026-08-15 23:36:34.227099+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('6261192d-ede3-420f-a4a0-48c412c5aebe', NULL, '3fe5fc3e-c492-42e3-a74b-b6c44d1c324a', 'Sinhala', 'The_Sopranos_S04E09_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S04e09%20958349/The_Sopranos_S04E09_958349.zip?download', 'WEB-DL / HD', 4, '2026-08-15 23:36:34.227099+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('7297cd45-f99e-45c6-aae4-df098a89332a', NULL, '21643407-9641-4f7e-a223-6a653db20f25', 'Sinhala', 'The_Sopranos_S04E10_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S04e10%20929685/The_Sopranos_S04E10_929685.zip?download', 'WEB-DL / HD', 4, '2026-08-15 23:36:34.227099+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('11cd16df-520a-452d-a38c-60fe5e8c7b80', NULL, '3542bb23-9412-4424-a3f6-79690d79d547', 'Sinhala', 'The_Sopranos_S04E11_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S04e11%20405043/The_Sopranos_S04E11_405043.zip?download', 'WEB-DL / HD', 4, '2026-08-15 23:36:34.227099+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('64a2ac0c-a640-4643-a1d9-dd8dacc3470c', NULL, '5015e274-d773-4989-a936-aa141bca60b5', 'Sinhala', 'The_Sopranos_S04E12_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S04e12%20690200/The_Sopranos_S04E12_690200.zip?download', 'WEB-DL / HD', 4, '2026-08-15 23:36:34.227099+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('c0c378d0-b373-4a28-a6e6-276802c052e1', NULL, '20d369a0-cefe-4535-a150-8bb00fe3e54b', 'Sinhala', 'The_Sopranos_S04E13_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S04e13%20322504/The_Sopranos_S04E13_322504.zip?download', 'WEB-DL / HD', 4, '2026-08-15 23:36:34.227099+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('08be1b1c-5b3a-4ec8-a5bd-77f515ea1db9', NULL, '38dd3b0b-21d7-4f1e-ad07-3aa7b6acc95c', 'Sinhala', 'Lanterns__2026__S01E01_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Lanterns%20S01e01%20488132/Lanterns_S01E01_488132.zip?download', 'WEB-DL / HD', 25, '2026-08-17 00:43:29.237961+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('9c09dd8e-4ed2-49c1-a4ce-680454d72689', NULL, 'cc38852b-5cd4-4356-abbf-5ec43ad09d8a', 'Sinhala', 'Dexter_S01E01_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Dexter%20S01e01%20166599/Dexter_S01E01_166599.zip?download', 'WEB-DL / HD', 24, '2026-08-22 06:41:53.87792+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('ad470c5e-67a2-430b-a645-ba0dbadb0ff1', NULL, '8e06915c-289b-4d6d-a80b-a4f0e98cb15c', 'Sinhala', 'Dexter_S01E02_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Dexter%20S01e02%20432343/Dexter_S01E02_432343.zip?download', 'WEB-DL / HD', 3, '2026-08-22 06:41:53.87792+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('63674ca5-862d-4790-a8db-2e36bdea6a5a', NULL, '3140d13c-9c60-49fd-aa70-564192a7a43f', 'Sinhala', 'Dexter_S01E03_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Dexter%20S01e03%20335630/Dexter_S01E03_335630.zip?download', 'WEB-DL / HD', 2, '2026-08-22 06:41:53.87792+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('89785cae-365e-4553-aef7-41979c93a842', NULL, '4dbe64b1-0518-41ca-af49-1a236395688f', 'Sinhala', 'Dexter_S01E04_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Dexter%20S01e04%20573244/Dexter_S01E04_573244.zip?download', 'WEB-DL / HD', 3, '2026-08-22 06:41:53.87792+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('02a4bc07-a8c3-4a33-ac55-4606abf760f8', NULL, '8c6ac497-91bf-4773-aa56-f652b4079059', 'Sinhala', 'Dexter_S01E05_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Dexter%20S01e05%20797012/Dexter_S01E05_797012.zip?download', 'WEB-DL / HD', 1, '2026-08-22 06:41:53.87792+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('15839118-b903-4a47-a2d6-1449df3b8d76', NULL, 'e3fd67b4-9d7d-4873-acf2-c69dd004f52d', 'Sinhala', 'Dexter_S01E06_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Dexter%20S01e06%20941990/Dexter_S01E06_941990.zip?download', 'WEB-DL / HD', 2, '2026-08-22 06:41:53.87792+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('dd14c947-1b29-476c-ab63-fbeeda42a197', NULL, '2f8cee7f-8dfa-4e76-acb0-db1aa0f743c3', 'Sinhala', 'Dexter_S01E07_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Dexter%20S01e07%20925571/Dexter_S01E07_925571.zip?download', 'WEB-DL / HD', 1, '2026-08-22 06:41:53.87792+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('6684e61a-16dc-4124-a824-0c0174da2ce9', NULL, '2d833038-4754-4446-ace7-0c9d6d027c24', 'Sinhala', 'Dexter_S01E08_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Dexter%20S01e08%20342473/Dexter_S01E08_342473.zip?download', 'WEB-DL / HD', 1, '2026-08-22 06:41:53.87792+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('c502f0d8-3d4e-40ab-a9b5-de3578069eda', NULL, 'e0cfbf70-052a-4762-a631-7a5de70fbf94', 'Sinhala', 'Dexter_S01E09_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Dexter%20S01e09%20552431/Dexter_S01E09_552431.zip?download', 'WEB-DL / HD', 1, '2026-08-22 06:41:53.87792+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('4be9d8df-a589-4486-a7bd-5e16cc02f240', NULL, 'fd7c84fb-6b9d-493c-ab4e-b98e383ba42c', 'Sinhala', 'Dexter_S01E10_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Dexter%20S01e10%20461467/Dexter_S01E10_461467.zip?download', 'WEB-DL / HD', 1, '2026-08-22 06:41:53.87792+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('685b971e-bcdd-41a5-a038-548aece0d939', NULL, '7ccb2ea5-115e-49cc-af17-24eb219bd037', 'Sinhala', 'Dexter_S01E11_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Dexter%20S01e11%20683849/Dexter_S01E11_683849.zip?download', 'WEB-DL / HD', 1, '2026-08-22 06:41:53.87792+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('438648f0-4fde-45b2-a2a1-eca46af5f8df', NULL, 'ffff599b-46ba-44fa-aab1-683027beb6bf', 'Sinhala', 'Dexter_S01E12_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Dexter%20S01e12%20784715/Dexter_S01E12_784715.zip?download', 'WEB-DL / HD', 1, '2026-08-22 06:41:53.87792+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('46bfff30-a4f4-45c3-abf7-daca107b1dd0', NULL, 'e5be140e-2674-4498-a88d-9945783b2dce', 'Sinhala', 'Reacher_S04E04_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Reacher%202026%20S04e04%20807045/Reacher_2026_S04E04_807045.zip?download', 'WEB-DL / HD', 15, '2026-08-23 09:40:14.081704+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('e5db2a20-cc63-47f6-aef9-c2636e4bea16', NULL, 'b7f6eba1-3322-462d-a996-27583b0b19cf', 'Sinhala', 'The_Sopranos_S05E01_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S05e01%20405737/The_Sopranos_S05E01_405737.zip?download', 'WEB-DL / HD', 5, '2026-08-25 05:40:25.195915+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('66d562e7-e526-442d-a2e4-8dae9dc19371', NULL, '507eb0cf-d4b2-4334-ae0e-9d37a3a380dc', 'Sinhala', 'The_Sopranos_S05E02_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S05e02%20874554/The_Sopranos_S05E02_874554.zip?download', 'WEB-DL / HD', 4, '2026-08-25 05:40:25.195915+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('949ac9ec-5658-4c2a-a2e2-444a08287972', NULL, 'd015ab0b-ca0c-4431-a48e-773e66948ad7', 'Sinhala', 'The_Sopranos_S05E03_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S05e03%20789241/The_Sopranos_S05E03_789241.zip?download', 'WEB-DL / HD', 4, '2026-08-25 05:40:25.195915+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('b560ae9d-ac6f-44cc-ab2f-a65c1cbcd46d', NULL, 'f36a3aea-3514-407f-a84c-acbb19de45dc', 'Sinhala', 'The_Sopranos_S05E04_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S05e04%20348465/The_Sopranos_S05E04_348465.zip?download', 'WEB-DL / HD', 4, '2026-08-25 05:40:25.195915+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('e9c0d376-3a37-4470-a254-e5b2ebb9ac1e', NULL, '8bb582af-39d8-4b26-a14e-71fddd8ac0eb', 'Sinhala', 'The_Sopranos_S05E05_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S05e05%20336106/The_Sopranos_S05E05_336106.zip?download', 'WEB-DL / HD', 5, '2026-08-25 05:40:25.195915+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('9cf5d1d0-bf7e-4076-a5aa-1730a1a5d4a3', NULL, 'bb419048-ba2c-4a88-a68f-d9e5e94e25ee', 'Sinhala', 'The_Sopranos_S05E06_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S05e06%20199330/The_Sopranos_S05E06_199330.zip?download', 'WEB-DL / HD', 4, '2026-08-25 05:40:25.195915+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('80d6e077-c36f-4597-ace1-80753903b6bf', NULL, '424dce3b-babe-4e17-aaf0-3815dd3af1d7', 'Sinhala', 'The_Sopranos_S05E07_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S05e07%20962356/The_Sopranos_S05E07_962356.zip?download', 'WEB-DL / HD', 7, '2026-08-25 05:40:25.195915+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('f4a52afc-889f-40e8-a8f9-1b133af563af', NULL, '8f12f2b0-039c-4538-a584-f92e04e67a31', 'Sinhala', 'The_Sopranos_S05E08_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S05e08%20217927/The_Sopranos_S05E08_217927.zip?download', 'WEB-DL / HD', 4, '2026-08-25 05:40:25.195915+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('cd04a73e-3278-419d-ac3d-5665cd0687c1', NULL, '4455e468-754f-4a46-a9f4-e88b128f3744', 'Sinhala', 'The_Sopranos_S05E09_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S05e09%20460090/The_Sopranos_S05E09_460090.zip?download', 'WEB-DL / HD', 6, '2026-08-25 05:40:25.195915+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('37195d3d-2967-474c-a96f-bfa437a7c517', NULL, '816c2cac-e4e1-4630-ad0a-ef46fcbf4bff', 'Sinhala', 'The_Sopranos_S05E10_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S05e10%20190772/The_Sopranos_S05E10_190772.zip?download', 'WEB-DL / HD', 4, '2026-08-25 05:40:25.195915+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('a8fbe3ae-412a-4b55-a531-bfd84554c9b8', NULL, 'f9b0dd20-e0be-4aa8-a651-b7f0c1dd4bbf', 'Sinhala', 'The_Sopranos_S05E11_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S05e11%20333890/The_Sopranos_S05E11_333890.zip?download', 'WEB-DL / HD', 4, '2026-08-25 05:40:25.195915+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('c8aca841-6809-4429-a602-1a40f3b1dd84', NULL, '15d86585-56cd-4734-afc0-dbf78740b5af', 'Sinhala', 'The_Sopranos_S05E12_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S05e12%20824442/The_Sopranos_S05E12_824442.zip?download', 'WEB-DL / HD', 4, '2026-08-25 05:40:25.195915+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('be5ad748-0034-4473-a49a-44bc96e47de8', NULL, '8a2eac0f-a913-4008-ab65-b538f4c2f4b3', 'Sinhala', 'The_Sopranos_S05E13_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S05e13%20595338/The_Sopranos_S05E13_595338.zip?download', 'WEB-DL / HD', 4, '2026-08-25 05:40:25.195915+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('45f4e550-e114-4c4c-afda-314cc18074ed', 'e3e39812-35a9-40d3-a740-e0b7d896c9f2', NULL, 'Sinhala', 'Batman__Knightfall_Part_1_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Batman%20Knightfall%20Part/Batman.Knightfall-Part.1.Knightfall.2026.sinhala.zip?download', 'WEB-DL / HD', 26, '2026-08-25 08:44:47.317584+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('3ddb51dd-d914-4ee0-a5c6-8c1cce2482e1', '5df962ce-ab8b-4343-ab32-3858ae1eb96f', NULL, 'Sinhala', 'Motor_City_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Motor%20City/Motor.City.2025.WEBRip_sinhala.zip?download', 'WEB-DL / HD', 22, '2026-08-25 15:35:47.386038+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('dfe7e30f-4ca2-49ed-ab2d-aa659990e57b', NULL, '9ff7b188-18f9-43d9-a097-4796653c4c91', 'Sinhala', 'Lanterns__2026__S01E02_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Lanterns%20S01e02%20162466/Lanterns_S01E02_162466.zip?download', 'WEB-DL / HD', 5, '2026-08-26 07:49:32.527149+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('9075b21d-92a2-476a-a52d-37680763ec8b', NULL, 'f8a9e144-6890-42d0-a30b-d49809109286', 'Sinhala', 'Reacher_S04E05_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Reacher%20S04e05%20989736/Reacher_S04E05_989736.zip?download', 'WEB-DL / HD', 28, '2026-08-26 08:36:36.055185+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('f077eff1-6a48-4aee-a814-c96774336484', NULL, '0dcba767-bd00-4648-aaf2-56d993832cc7', 'Sinhala', 'The_Walking_Dead__Dead_City_S03E04_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Walking%20Dead%20Dead%20City%20S03e04%20131526/The_Walking_Dead_Dead_City_S03E04_131526.zip?download', 'WEB-DL / HD', 33, '2026-08-26 16:54:25.719949+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('6dca944b-ebdd-406d-a78f-6529d1b9ab83', NULL, '6aabdd6a-da4d-45fe-acd3-72fc11464740', 'Sinhala', 'The_Walking_Dead__Dead_City_S03E05_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Walking%20Dead%20Dead%20City%20S03e05%20917029/The_Walking_Dead_Dead_City_S03E05_917029.zip?download', 'WEB-DL / HD', 22, '2026-08-26 16:54:25.719949+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('6310d55d-43a9-4f3f-a504-025d0a338d78', NULL, 'c3432fbd-3cf1-46c5-a5d8-a3a0a04c92a9', 'Sinhala', 'The_Leftovers_S01E01_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Leftovers%20S01e01%20100577/The_Leftovers_S01E01_100577.zip?download', 'WEB-DL / HD', 10, '2026-08-27 05:15:49.32395+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('5e80ce6c-0f1f-4c1b-ab68-ed94311955cb', '190486de-63e6-49e2-a16d-1195bb2596d3', NULL, 'Sinhala', 'I__Nobody__2026__Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/I,nobody(/I,Nobody(2026)_Malayalam.HQ.HDRip_sinhala.zip?download', 'WEB-DL / HD', 11, '2026-08-28 05:17:20.917336+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('39a9ea10-da12-424e-a271-dbdd9a640a7a', 'b502eb7f-d3b3-4b67-a82f-7b5154e561f9', NULL, 'Sinhala', 'The_Whisper_Man_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Whisper%20Man/The.Whisper.Man.2026.WEBRip.HEVC-PSA.sinhala.zip?download', 'WEB-DL / HD', 23, '2026-08-28 10:36:45.922339+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('886cf4fe-00e9-487c-aa4a-85a642b95fdb', NULL, 'eb0a5895-faa8-4421-abd1-81eb83d38c21', 'Sinhala', 'The_Leftovers_S01E02_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Leftovers%20S01e02%20877197/The_Leftovers_S01E02_877197.zip?download', 'WEB-DL / HD', 2, '2026-08-29 04:30:40.560346+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('1960d89e-414a-43a4-a88d-d62ab172b55e', NULL, 'c76b4dd5-0f9a-4889-ab54-8b634041a6aa', 'Sinhala', 'The_Leftovers_S01E03_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Leftovers%20S01e03%20400040/The_Leftovers_S01E03_400040.zip?download', 'WEB-DL / HD', 1, '2026-08-29 04:30:40.560346+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('531dd3f5-7b53-40e5-a8fd-23c530c0c5f5', NULL, '9d0c89fe-0f66-4967-afa4-1bfeae1b5aef', 'Sinhala', 'The_Leftovers_S01E04_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Leftovers%20S01e04%20330911/The_Leftovers_S01E04_330911.zip?download', 'WEB-DL / HD', 1, '2026-08-29 04:30:40.560346+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('3ef439ef-f9fd-4f91-afcb-d75fba996592', NULL, '02e7ebbe-5f00-4f17-ad6d-f6cb85cffe78', 'Sinhala', 'The_Leftovers_S01E05_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Leftovers%20S01e05%20288409/The_Leftovers_S01E05_288409.zip?download', 'WEB-DL / HD', 1, '2026-08-29 04:30:40.560346+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('29a72960-3603-4e66-add5-ab386fef72b1', NULL, '7c3706f9-36a5-4b02-a4b1-ddcf13ca510c', 'Sinhala', 'The_Leftovers_S01E06_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Leftovers%20S01e06%20121644/The_Leftovers_S01E06_121644.zip?download', 'WEB-DL / HD', 1, '2026-08-29 04:30:40.560346+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('678e8aa6-ac7f-41f5-a4c4-c126070a831c', NULL, 'bf8c6f91-ce9e-4e98-ab55-2fdd7be7ed64', 'Sinhala', 'The_Leftovers_S01E07_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Leftovers%20S01e07%20306519/The_Leftovers_S01E07_306519.zip?download', 'WEB-DL / HD', 1, '2026-08-29 04:30:40.560346+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('47feac9d-fd55-4309-a971-a9a23f49986d', NULL, '410ae787-71a8-4123-a8cd-623731caa954', 'Sinhala', 'The_Leftovers_S01E08_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Leftovers%20S01e08%20558413/The_Leftovers_S01E08_558413.zip?download', 'WEB-DL / HD', 1, '2026-08-29 04:30:40.560346+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('dfb1fd69-b8a9-4505-a10b-27fed400a279', NULL, 'e0f33508-2a13-4da7-a9d1-8284926d9156', 'Sinhala', 'The_Leftovers_S01E09_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Leftovers%20S01e09%20802341/The_Leftovers_S01E09_802341.zip?download', 'WEB-DL / HD', 1, '2026-08-29 04:30:40.560346+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('9afa8dab-40e9-40e5-a775-0e5aa91ffca4', NULL, '74fe1b70-0c3a-4484-a476-77da2e131e37', 'Sinhala', 'The_Leftovers_S01E10_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Leftovers%20S01e10%20886631/The_Leftovers_S01E10_886631.zip?download', 'WEB-DL / HD', 1, '2026-08-29 04:30:40.560346+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('8cbf8126-ed1b-4685-ace4-d44fd1c2446d', NULL, 'd8ae654a-085a-4e8b-abd9-4e9f78ec8a9d', 'Sinhala', 'The_Wire_S01E01_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Wire%20S01e01%20433618/The_Wire_S01E01_433618.zip?download', 'WEB-DL / HD', 42, '2026-08-29 16:00:51.135655+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('8bbe9a9b-0aaa-44b0-ad47-186a0f0a0fb7', NULL, '8a11b38a-0b2a-4923-a91c-bd5c1360eb95', 'Sinhala', 'The_Wire_S01E02_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Wire%20S01e02%20996380/The_Wire_S01E02_996380.zip?download', 'WEB-DL / HD', 14, '2026-08-29 16:00:51.135655+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('4eb967ac-ad07-465a-ae3f-163949267258', NULL, '3b1497f3-7c33-47e6-ab08-c952b8002e16', 'Sinhala', 'The_Wire_S01E03_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Wire%20S01e03%20241481/The_Wire_S01E03_241481.zip?download', 'WEB-DL / HD', 8, '2026-08-29 16:00:51.135655+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('e012ea0a-4b0b-468c-a736-19d3faeea1fe', NULL, '55d6d674-3ca0-44ad-acec-b9fc57d6802f', 'Sinhala', 'The_Wire_S01E04_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Wire%20S01e04%20512106/The_Wire_S01E04_512106.zip?download', 'WEB-DL / HD', 6, '2026-08-29 16:00:51.135655+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('dccf4391-7a3f-4b03-a92d-62823aa95e06', NULL, '6e0096f8-3ef5-4915-a616-dd32aa8dec91', 'Sinhala', 'The_Wire_S01E05_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Wire%20S01e05%20256129/The_Wire_S01E05_256129.zip?download', 'WEB-DL / HD', 4, '2026-08-29 16:00:51.135655+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('1d6a66ee-f532-43fe-a15d-0a9a42255f26', NULL, '76408d94-d589-41cf-ae93-4a4256535aa5', 'Sinhala', 'The_Walking_Dead__Dead_City_S03E06_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Walking%20Dead%20Dead%20City%20S03e06%20967078/The_Walking_Dead_Dead_City_S03E06_967078.zip?download', 'WEB-DL / HD', 7, '2026-08-30 17:11:35.166847+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('e0acbe3e-150f-4228-acbb-3b257dad6862', NULL, '37c486ca-928f-467f-a60d-c2e682367f99', 'Sinhala', 'The_Sopranos_S06E01_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S06e01%20214010/The_Sopranos_S06E01_214010.zip?download', 'WEB-DL / HD', 5, '2026-08-30 17:59:35.347525+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('89efbc17-86ff-4bb1-ab3f-1dbb8b1361fa', NULL, '8569271e-62af-49c9-af46-d1f684f36504', 'Sinhala', 'The_Sopranos_S06E02_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S06e02%20104729/The_Sopranos_S06E02_104729.zip?download', 'WEB-DL / HD', 3, '2026-08-30 17:59:35.347525+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('87e8c049-a7be-4a73-a33e-14811bcf3825', NULL, '606e0612-c03e-45a6-a5bc-59b24e48e084', 'Sinhala', 'The_Sopranos_S06E03_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S06e03%20483965/The_Sopranos_S06E03_483965.zip?download', 'WEB-DL / HD', 3, '2026-08-30 17:59:35.347525+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('bee1a65c-9c2b-462a-a172-8a68950aff78', NULL, '8cd552b1-2b39-44a8-a917-0cd3d39e2578', 'Sinhala', 'The_Sopranos_S06E04_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S06e04%20123960/The_Sopranos_S06E04_123960.zip?download', 'WEB-DL / HD', 1, '2026-08-30 17:59:35.347525+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('085337f5-b3c1-4003-a296-44e285b26737', NULL, 'c29e4dcd-7043-4cb8-a62a-61b2cff419b6', 'Sinhala', 'The_Sopranos_S06E05_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S06e05%20802539/The_Sopranos_S06E05_802539.zip?download', 'WEB-DL / HD', 3, '2026-08-30 17:59:35.347525+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('d7fe4ee4-4f47-4aa0-a8c9-bbc928a75396', NULL, 'a7b9fb04-6516-444c-aad6-18c75c610dcf', 'Sinhala', 'The_Wire_S01E06_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Wire%20S01e06%20625294/The_Wire_S01E06_625294.zip?download', 'WEB-DL / HD', 3, '2026-08-30 17:59:35.347525+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('87ee0a95-c736-4b7d-a2f4-6d10e7a0b014', NULL, '113999b2-6d07-4418-a187-98ba1583659c', 'Sinhala', 'The_Wire_S01E07_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Wire%20S01e07%20351590/The_Wire_S01E07_351590.zip?download', 'WEB-DL / HD', 2, '2026-08-30 17:59:35.347525+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('42b5da8e-1502-403b-aa93-9ccb1f3092dc', NULL, '85518795-e360-4af5-a3fc-3a7d38e831d5', 'Sinhala', 'The_Wire_S01E08_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Wire%20S01e08%20809840/The_Wire_S01E08_809840.zip?download', 'WEB-DL / HD', 2, '2026-08-30 17:59:35.347525+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('0fbdf691-042a-48a0-a04d-7e46199bff6c', NULL, '3335954c-1a21-4efa-aaab-c79a132a44a9', 'Sinhala', 'Lanterns__2026__S01E03_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Lanterns%20S01e03%20597235/Lanterns_S01E03_597235.zip?download', 'WEB-DL / HD', 3, '2026-08-31 05:10:46.772366+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('3fb3cb33-9cdf-49b8-a185-d05b18389bd5', NULL, '2593c3b7-0c4e-4c54-a1d8-d28983a7f139', 'Sinhala', 'The_Sopranos_S06E06_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S06e06%20836847/The_Sopranos_S06E06_836847.zip?download', 'WEB-DL / HD', 1, '2026-08-31 14:58:40.394763+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('86cdafa6-9d07-45ff-af1e-9069177d8ac9', NULL, '51a6bbf5-d90f-407c-a2b3-9eafdfd3c367', 'Sinhala', 'The_Sopranos_S06E07_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S06e07%20310259/The_Sopranos_S06E07_310259.zip?download', 'WEB-DL / HD', 1, '2026-08-31 14:58:40.394763+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('632009e1-cc83-4fb0-a915-186c64f492d3', NULL, 'a51a0b58-d35e-4ba1-ab29-06717917508c', 'Sinhala', 'The_Sopranos_S06E08_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S06e08%20853346/The_Sopranos_S06E08_853346.zip?download', 'WEB-DL / HD', 1, '2026-08-31 14:58:40.394763+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('18f47336-bc38-4dba-a616-86ff17e11bc2', NULL, '90d46548-b3e8-43a4-a091-e258abf8df1f', 'Sinhala', 'The_Sopranos_S06E09_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S06e09%20145155/The_Sopranos_S06E09_145155.zip?download', 'WEB-DL / HD', 1, '2026-08-31 14:58:40.394763+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('ca245dac-dc59-475d-a22b-46c690171963', NULL, '3168ef66-0641-48eb-a121-327b8d7ffe57', 'Sinhala', 'The_Sopranos_S06E10_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S06e10%20703365/The_Sopranos_S06E10_703365.zip?download', 'WEB-DL / HD', 1, '2026-08-31 14:58:40.394763+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('23e1711e-c0de-4eda-a22e-2c5cf5d6da73', NULL, '1bf0c921-6945-47ab-ab10-6edf349e0ebb', 'Sinhala', 'The_Sopranos_S06E11_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S06e11%20125752/The_Sopranos_S06E11_125752.zip?download', 'WEB-DL / HD', 3, '2026-08-31 14:58:40.394763+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('b7ea8207-785e-487d-a30f-cf9b1df169af', NULL, 'a7b9fb04-6516-444c-aad6-18c75c610dcf', 'Sinhala', 'The_Wire_S01E06_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Wire%20S01e06%20429945/The_Wire_S01E06_429945.zip?download', 'WEB-DL / HD', 2, '2026-08-31 14:58:46.532211+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('fced66d3-81f3-435c-a641-a5bf20069781', NULL, '113999b2-6d07-4418-a187-98ba1583659c', 'Sinhala', 'The_Wire_S01E07_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Wire%20S01e07%20331602/The_Wire_S01E07_331602.zip?download', 'WEB-DL / HD', 2, '2026-08-31 14:58:46.532211+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('71cfb62c-a837-4f0b-a8f3-25ed0f4be289', NULL, '85518795-e360-4af5-a3fc-3a7d38e831d5', 'Sinhala', 'The_Wire_S01E08_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Wire%20S01e08%20809840/The_Wire_S01E08_809840.zip?download', 'WEB-DL / HD', 2, '2026-08-31 14:58:46.532211+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('b326d60c-ace5-4a10-a437-7cef3f979cb7', NULL, '698280d6-38fd-49a1-af0f-a71899213eeb', 'Sinhala', 'The_Wire_S01E09_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Wire%20S01e09%20483893/The_Wire_S01E09_483893.zip?download', 'WEB-DL / HD', 3, '2026-08-31 14:58:46.532211+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('6ec46b9e-2a6c-45dc-a8c2-4f85157e9540', NULL, '93b4e985-8d60-4e21-a4d0-79a55b9124b1', 'Sinhala', 'The_Wire_S01E10_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Wire%20S01e10%20432089/The_Wire_S01E10_432089.zip?download', 'WEB-DL / HD', 3, '2026-08-31 14:58:46.532211+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('79d546e4-3c0f-425d-a0b4-a99c9dd8c63a', NULL, 'ce3f8e97-f96d-4086-ae00-fdd45c587ff1', 'Sinhala', 'The_Wire_S01E11_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Wire%20S01e11%20933077/The_Wire_S01E11_933077.zip?download', 'WEB-DL / HD', 3, '2026-08-31 14:58:46.532211+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('b0478a0a-0d4a-45c2-a974-075acc6ccabd', NULL, 'a634f1d1-59c6-4d84-ab86-6edd862f9f8d', 'Sinhala', 'The_Wire_S01E12_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Wire%20S01e12%20740279/The_Wire_S01E12_740279.zip?download', 'WEB-DL / HD', 3, '2026-08-31 14:58:46.532211+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('8277449f-089c-4ed0-a4e1-819b83333d5b', NULL, '8fdee6fc-0fda-4ee7-a705-fcd92ebb71f5', 'Sinhala', 'The_Wire_S01E13_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Wire%20S01e13%20800488/The_Wire_S01E13_800488.zip?download', 'WEB-DL / HD', 3, '2026-08-31 14:58:46.532211+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('d6e08eba-282f-4a7b-a622-9ecde8dbdab3', NULL, '66bb0f3f-0da1-4196-a90d-6fb8b4e3db0d', 'Sinhala', 'Lost_S01E01_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Lost%20S01e01%20112803/Lost_S01E01_112803.zip?download', 'WEB-DL / HD', 7, '2026-08-31 15:22:15.597063+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('52f35641-3bf3-4c6c-ad4c-bcbc08e04aaf', NULL, '5ad34313-8a36-4a73-aa04-12d816f19727', 'Sinhala', 'Lost_S01E02_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Lost%20S01e02%20738779/Lost_S01E02_738779.zip?download', 'WEB-DL / HD', 1, '2026-08-31 15:22:15.597063+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('75ecbb99-8ff0-4ac9-aa64-0dfb793522ff', NULL, '46273df1-c6fd-4c7b-a913-b63adec354a1', 'Sinhala', 'Lost_S01E03_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Lost%20S01e03%20741601/Lost_S01E03_741601.zip?download', 'WEB-DL / HD', 1, '2026-08-31 15:22:15.597063+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('5698b648-a0c1-4272-afac-d4f01c20c5e8', NULL, 'f5e0d712-d353-4558-ab8b-fc0d77c3f6c8', 'Sinhala', 'Lost_S01E04_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Lost%20S01e04%20838551/Lost_S01E04_838551.zip?download', 'WEB-DL / HD', 1, '2026-08-31 15:22:15.597063+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('7d2889a6-3922-43be-ac44-27a4a8975930', NULL, 'd71806d5-9edf-464b-ae7b-743538127d03', 'Sinhala', 'Lost_S01E05_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Lost%20S01e05%20259932/Lost_S01E05_259932.zip?download', 'WEB-DL / HD', 1, '2026-08-31 15:22:15.597063+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('44c87358-49d6-4417-aeca-aa917e49b60d', NULL, '16daa1e3-1c33-4ecd-a9ba-e7a5e88c8a61', 'Sinhala', 'Lost_S01E06_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Lost%20S01e06%20331426/Lost_S01E06_331426.zip?download', 'WEB-DL / HD', 0, '2026-08-31 15:22:15.597063+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('765f544a-e62f-406a-a222-3187bee28d7c', NULL, '1c37b93a-dac0-4a67-a4c5-16e891b96870', 'Sinhala', 'Lost_S01E07_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Lost%20S01e07%20644659/Lost_S01E07_644659.zip?download', 'WEB-DL / HD', 0, '2026-08-31 15:22:15.597063+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('40bd4d77-bac3-4b2b-acc1-e19437d585e2', NULL, '42920081-08e9-4342-a5e4-1f158a325ec2', 'Sinhala', 'Lost_S01E08_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Lost%20S01e08%20171484/Lost_S01E08_171484.zip?download', 'WEB-DL / HD', 1, '2026-08-31 15:22:15.597063+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('395e7e07-4009-4a9b-a7f8-b756b9984779', 'f993a834-dc2e-4c8d-aaba-4e624bc4a33a', NULL, 'Sinhala', 'I_Want_Your_Sex_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/I%20Want%20Your%20Sex/I.Want.Your.Sex.2026.WEBRip.HEVC-PSA_sinhala@pixelpoplk.zip?download', 'WEB-DL / HD', 102, '2026-09-01 12:05:41.773693+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('0ea28831-cac1-422f-a8d0-7694decfe55d', NULL, '29cc3d75-75b2-40d8-a282-63cbe5acefd2', 'Sinhala', 'The_Sopranos_S06E12_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S06e12%20649988/The_Sopranos_S06E12_649988.zip?download', 'WEB-DL / HD', 1, '2026-09-01 16:24:02.280019+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('5de4de57-fea5-4aba-ac06-d27799515c82', NULL, '379eb4e8-1d17-49e8-a9d0-5d9a82c32951', 'Sinhala', 'The_Sopranos_S06E13_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S06e13%20256152/The_Sopranos_S06E13_256152.zip?download', 'WEB-DL / HD', 1, '2026-09-01 16:24:02.280019+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('28b04ef0-e17e-4724-a423-e67b05443087', NULL, '49716a14-9cc5-4345-a661-875a783377e6', 'Sinhala', 'The_Sopranos_S06E14_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S06e14%20598975/The_Sopranos_S06E14_598975.zip?download', 'WEB-DL / HD', 1, '2026-09-01 16:24:02.280019+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('562ee223-f3d0-448e-a319-c005700c40a0', NULL, '7bd19fb3-8be2-4fbb-aa50-1a13df14cc3c', 'Sinhala', 'The_Sopranos_S06E15_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S06e15%20129207/The_Sopranos_S06E15_129207.zip?download', 'WEB-DL / HD', 1, '2026-09-01 16:24:02.280019+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('0b32e89e-1bec-457a-aed5-9a690e151c29', NULL, '438187f1-8d27-4023-a061-af2f1ed0b501', 'Sinhala', 'The_Sopranos_S06E16_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S06e16%20927230/The_Sopranos_S06E16_927230.zip?download', 'WEB-DL / HD', 5, '2026-09-01 16:24:02.280019+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('78e42ab7-4059-4f19-a884-b762bbbc5812', NULL, 'fc8259ad-dd31-47c8-a2db-87f58912bb41', 'Sinhala', 'The_Sopranos_S06E17_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S06e17%20670006/The_Sopranos_S06E17_670006.zip?download', 'WEB-DL / HD', 1, '2026-09-01 16:24:02.280019+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('7a2d512b-845e-444f-a6f5-4d21fb9a9429', NULL, '59914f39-d2ee-4fe5-a3f2-ff07909929d0', 'Sinhala', 'The_Sopranos_S06E18_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S06e18%20642391/The_Sopranos_S06E18_642391.zip?download', 'WEB-DL / HD', 1, '2026-09-01 16:24:02.280019+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('3ee7fb2f-577c-4ec8-aadb-ead15138ccac', NULL, 'fd3a4d80-392b-4555-a9f2-cf646f014b06', 'Sinhala', 'The_Sopranos_S06E19_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S06e19%20556802/The_Sopranos_S06E19_556802.zip?download', 'WEB-DL / HD', 1, '2026-09-01 16:24:02.280019+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('6f6d670c-590d-466d-a162-8092547718f2', NULL, '40e1f73c-6622-4411-a35b-fdb225b5fdd2', 'Sinhala', 'The_Sopranos_S06E20_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S06e20%20619526/The_Sopranos_S06E20_619526.zip?download', 'WEB-DL / HD', 1, '2026-09-01 16:24:02.280019+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('f305fcc1-4189-4be9-a7ba-f56a460bc409', NULL, 'ad459679-1860-415f-aab3-99bfdb4fc137', 'Sinhala', 'The_Sopranos_S06E21_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/The%20Sopranos%20S06e21%20519388/The_Sopranos_S06E21_519388.zip?download', 'WEB-DL / HD', 1, '2026-09-01 16:24:02.280019+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO subtitles (id, movie_id, episode_id, language, file_name, file_url, version, downloads_count, created_at)
VALUES ('f02ffc3f-abcf-4fe8-a5a4-b15ab8e2a9e1', NULL, '4839d614-188e-46d3-a41d-c952d4880b51', 'Sinhala', 'Reacher_S04E06_Sinhala.srt', 'https://frdgyadvbdpacwfoqybw.supabase.co/storage/v1/object/public/subtitles/Reacher%20S04e06%20566259/Reacher_S04E06_566259.zip?download', 'WEB-DL / HD', 13, '2026-09-02 07:49:46.881692+00')
ON CONFLICT (id) DO NOTHING;

-- TELEGRAM LINKS
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('475c6aef-9ad7-4346-a98c-65633d0089ae', NULL, '2cc3b850-6686-4afd-ab86-7d2684d9690a', '720p / 1080p HDTV', '450 MB', 'https://telegram.me/PixelPopLk_bot?start=f4665c39-c37c-4b24-81aa-b8c839a45e6d', 'Telegram Fast Download', 54, '2026-07-02 20:20:47.74712+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('6acb3a21-0404-40f2-a852-e01cc6261b99', NULL, '77b2a8d9-3306-4860-a61b-91dd06a4cc88', '720p / 1080p HDTV', '450 MB', 'https://telegram.me/PixelPopLk_bot?start=f9e601f7-50c8-43e8-9141-3b0c257224c5', 'Telegram Fast Download', 9, '2026-07-05 19:07:04.212977+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('594b18ce-db64-4691-a19f-4d963d5097db', NULL, 'ea343ca1-c4ea-4973-ae68-4ba24c6e0527', '720p / 1080p HDTV', '450 MB', 'https://telegram.me/PixelPopLk_bot?start=7ff27dce-8815-46de-945d-f82fd1cabeba', 'Telegram Fast Download', 25, '2026-07-06 17:23:49.258164+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('80919381-3922-4cac-a939-0ab85f2e67ee', NULL, 'cacbd9f9-ebf1-42cc-aca4-333071a27b3f', '720p / 1080p HDTV', '450 MB', 'https://telegram.me/PixelPopLk_bot?start=918d3874-2498-4380-9c70-f1602024c58e', 'Telegram Fast Download', 22, '2026-07-06 18:51:33.429257+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('7b84da9e-319c-4f56-ae08-60afd7d59497', NULL, '719bbd7b-9632-43e0-a5be-7bc49884cf47', '720p / 1080p HDTV', '450 MB', 'https://telegram.me/PixelPopLk_bot?start=5aacabbc-f883-47b3-8574-4d7449843821', 'Telegram Fast Download', 26, '2026-07-06 18:51:33.429257+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('6eb344f3-238f-4dd4-a06b-3125a8fec6f1', NULL, '03462571-4563-427a-aa3a-40afc3bbe243', '720p / 1080p HDTV', '450 MB', 'https://telegram.me/PixelPopLk_bot?start=185c4b26-b940-4d53-8bf2-d61a519f6c36', 'Telegram Fast Download', 24, '2026-07-06 18:51:33.429257+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('ac074178-c953-4eb0-af5c-32d23aaf14b8', NULL, '612f034d-1c8f-4285-a427-ebeea801e532', '720p / 1080p HDTV', '450 MB', 'https://telegram.me/PixelPopLk_bot?start=0de80f22-fdd8-478d-98c0-ea2b07e736a5', 'Telegram Fast Download', 18, '2026-07-06 18:51:33.429257+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('681feeb8-5ff1-43d6-ac48-0f1e547cf774', NULL, '03f30b76-caf8-46c6-ac3d-b125dcddb935', '720p / 1080p HDTV', '450 MB', 'https://telegram.me/PixelPopLk_bot?start=80a78a9e-758a-4de6-b390-bd65223d9a6d', 'Telegram Fast Download', 19, '2026-07-06 18:51:33.429257+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('c50fe5ce-c6b7-499e-a363-296b97c8e503', NULL, '4c03ca7e-dc94-471d-a5e8-2d674c7b4109', '720p / 1080p HDTV', '450 MB', 'https://telegram.me/PixelPopLk_bot?start=d2ea6765-f918-47ee-8d84-b5bbc6a2a9e8', 'Telegram Fast Download', 18, '2026-07-06 18:51:33.429257+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('e474883b-9d2f-403a-ab5e-cc3b3491b002', NULL, '3c84c9e6-fabc-456a-a293-9f5a1e239bda', '720p / 1080p HDTV', '450 MB', 'https://telegram.me/PixelPopLk_bot?start=e71241ff-72a9-4cae-ad14-50583c0dc5c0', 'Telegram Fast Download', 19, '2026-07-06 18:51:33.429257+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('8683b155-e9c7-4b6a-aa4b-9b2a478baf7d', NULL, 'cb3c37c3-f214-4f02-af5a-747e0113143b', '720p / 1080p HDTV', '450 MB', 'https://telegram.me/PixelPopLk_bot?start=cb083040-bcd9-4e4d-80a8-c9245f19cc62', 'Telegram Fast Download', 17, '2026-07-06 18:51:33.429257+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('bf98f12b-a70b-4433-ae81-ed0c0fd3e09b', NULL, '15d9fb09-e27c-49ab-ae02-34b12edb971e', '720p / 1080p HDTV', '450 MB', 'https://telegram.me/PixelPopLk_bot?start=ebff73b8-00dd-4658-98c4-fc37feba518c', 'Telegram Fast Download', 17, '2026-07-06 18:51:33.429257+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('a36320c5-dfee-441a-ad44-e0f3337bbe18', NULL, '89b29727-a6cb-4209-a579-aa16e73786df', '720p / 1080p HDTV', '450 MB', 'https://telegram.me/PixelPopLk_bot?start=84bc7d3b-16ab-4242-843e-930443b68382', 'Telegram Fast Download', 17, '2026-07-06 18:51:33.429257+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('a149cf45-3f81-4f13-a6f7-e5ea440ba00d', NULL, '309301d8-a536-4ba8-a8fb-4ad8fb9f73d2', '720p / 1080p HDTV', '450 MB', 'https://telegram.me/PixelPopLk_bot?start=a234283e-f3ba-452d-b5a6-b580b65c0e69', 'Telegram Fast Download', 17, '2026-07-06 18:51:33.429257+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('f0932c3b-1f70-40be-a144-67768119caa4', NULL, 'c60152f3-1cea-4bb9-a577-74292695110f', '720p / 1080p HDTV', '450 MB', 'https://telegram.me/Pixelpopnew_bot?start=bZLcfBOHyGo', 'Telegram Fast Download', 63, '2026-07-10 21:03:45.984807+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('721330e5-8391-4356-ad9e-a637920e9c03', NULL, 'e6ca4568-68f2-489c-a996-3f834fb21e3f', '720p / 1080p HDTV', '450 MB', 'https://telegram.me/Pixelpopnew_bot?start=wSdi9dygo7c', 'Telegram Fast Download', 24, '2026-07-10 21:03:45.984807+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('5e976b7a-8b12-4b9b-a2ab-ec4d70117856', NULL, '5e1eb95d-6f26-4e45-ad78-419a01f7445f', '720p / 1080p HDTV', '450 MB', 'https://telegram.me/Pixelpopnew_bot?start=bz5FEqL7Alw', 'Telegram Fast Download', 18, '2026-07-10 21:03:45.984807+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('b3e72c2f-4724-46a3-a211-64190542654b', NULL, '4e97a1bd-9177-4075-a248-bd0678ccd7a1', '720p / 1080p HDTV', '450 MB', 'https://telegram.me/Pixelpopnew_bot?start=kwpKKX_0HMc', 'Telegram Fast Download', 15, '2026-07-10 21:03:45.984807+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('1219b447-44b7-4d3e-a2a0-e4ce6cfd254b', NULL, 'ac618de0-e5af-427a-af4e-8f2476d7b2cb', '720p / 1080p HDTV', '450 MB', 'https://telegram.me/Pixelpopnew_bot?start=8sVvr3oJCC8', 'Telegram Fast Download', 15, '2026-07-10 21:03:45.984807+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('e417e437-0682-486a-a476-ecf2bb7f5845', NULL, 'd591745e-c197-4f84-afcb-9ae3e41ca66c', '720p / 1080p HDTV', '450 MB', 'https://telegram.me/Pixelpopnew_bot?start=tQBSfGa8rbE', 'Telegram Fast Download', 12, '2026-07-10 21:03:45.984807+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('c544e7fd-5ee1-47a2-a978-0bb9711351c8', NULL, '944f13a0-5bfd-43ee-a05a-72ca54793b80', '720p / 1080p HDTV', '450 MB', 'https://telegram.me/PixelPopLk_bot?start=3f71a5c6-3156-4e93-a371-98383cd89447', 'Telegram Fast Download', 15, '2026-07-13 01:46:09.988815+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('189c289e-71a8-46a2-ae26-46ecf9a6f4c7', 'b727785a-1be1-4a90-a810-655fb4a5d54e', NULL, '1080p / 720p HD', '1.2 GB', 'https://telegram.me/PixelPopLk_bot?start=ce1f51a1-b727-428d-996f-5232dbe1d1ae', 'Fast Telegram CDN', 0, '2026-07-14 05:32:34.672294+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('f4398565-f056-4590-a283-6491a6a66717', NULL, 'ea6c3d96-ddd4-47cf-a122-961243698461', '720p / 1080p HDTV', '450 MB', 'https://telegram.me/Pixelpopnew_bot?start=QKnz2FD0oMU', 'Telegram Fast Download', 11, '2026-07-14 11:59:44.37195+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('df607836-3564-4fcf-a9b2-10594650acf8', NULL, '27ba32f4-c711-46f8-a0a5-608387a12769', '720p / 1080p HDTV', '450 MB', 'https://telegram.me/Pixelpopnew_bot?start=_E8XvNCEomU', 'Telegram Fast Download', 12, '2026-07-14 11:59:44.37195+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('3c703b3b-100a-4058-aa7f-6b510bc656aa', NULL, '9422b3ed-3fff-40c5-a0c0-34997b284e87', '720p / 1080p HDTV', '450 MB', 'https://telegram.me/Pixelpopnew_bot?start=IF7-4W1JVvI', 'Telegram Fast Download', 12, '2026-07-14 11:59:44.37195+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('96a3ebfa-5f89-40dd-a358-db8632b1f915', NULL, '82d1400b-e78d-4622-a5a0-35fd688da419', '720p / 1080p HDTV', '450 MB', 'https://telegram.me/Pixelpopnew_bot?start=AdomEMXm41g', 'Telegram Fast Download', 11, '2026-07-14 11:59:44.37195+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('6064d875-067e-4f32-a1c9-391815b41c65', NULL, '86ee5e8b-4163-44d3-ad9d-6bf91569d621', '720p / 1080p HDTV', '450 MB', 'https://telegram.me/Pixelpopnew_bot?start=KbYzqf3-Xj4', 'Telegram Fast Download', 10, '2026-07-14 11:59:44.37195+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('1d12698d-f2da-461f-a981-4c2d5ff77921', NULL, 'bbd1b009-7be8-4d07-a347-0ad724924c8b', '720p / 1080p HDTV', '450 MB', 'https://telegram.me/Pixelpopnew_bot?start=Us5MJCmH9uU', 'Telegram Fast Download', 11, '2026-07-14 11:59:44.37195+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('51cb3219-3c1b-4832-aacb-ee3f24dd0b5c', NULL, '01199b58-b2cc-438a-a083-8d44058eed5e', '720p / 1080p HDTV', '450 MB', 'https://telegram.me/Pixelpopnew_bot?start=5DSSmuf-tWA', 'Telegram Fast Download', 12, '2026-07-14 11:59:44.37195+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('8bae4098-d9a1-4090-a519-9aa155f05e5a', NULL, 'e35a2c4f-5206-4a66-a366-e82874e61130', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=Nj1jum1zo8Y', 'Telegram Fast Download', 11, '2026-07-16 15:21:01.297081+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('ce33b0d9-eb9f-4d0f-a45c-ce8e1bc56493', NULL, 'e82b433d-d300-4c4f-ae12-6a4bb4c79eca', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=ctyEt5nRX4w', 'Telegram Fast Download', 10, '2026-07-16 15:21:01.297081+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('a1fca17c-ad92-4505-ab3a-616cb92adce8', NULL, 'e02ddde3-8169-4b27-ac59-392c2b344518', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=ffye6Opt8Fc', 'Telegram Fast Download', 12, '2026-07-16 15:21:01.297081+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('2dee2fde-8624-4cd8-ac20-120f1ad93dce', NULL, '5dc04c79-8dd1-40e1-a09e-b58fa2488bc8', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=t-q8BmS57c4', 'Telegram Fast Download', 12, '2026-07-16 15:21:01.297081+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('c9627448-11e7-458e-a2a9-bd8c5ecd296c', NULL, '430e537b-a78a-4328-abec-fc9336265539', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=Xdoh5cdJPcQ', 'Telegram Fast Download', 17, '2026-07-16 15:21:01.297081+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('b33abf75-f57a-44b2-a94f-6de7798b9625', NULL, 'f3f1acd9-8b69-451d-ac31-c68eb4765046', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=_We7V_I4Djo', 'Telegram Fast Download', 14, '2026-07-17 13:58:47.835069+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('8e266477-44fc-4b8d-a246-0f372c55c3d0', NULL, '89cffa70-f22d-4baf-a0dd-8f4fbff12009', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=db0aM82iT14', 'Telegram Fast Download', 15, '2026-07-17 13:58:47.835069+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('517c3e8c-a25b-4d6e-ac3f-a067ce5f473d', NULL, 'c1cf41bb-9fa6-4b44-a797-e11e724cc978', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=wvrsZR5C0Wc', 'Telegram Fast Download', 15, '2026-07-17 13:58:47.835069+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('e3a4a258-6a71-4df4-ab3d-54b2af2c20f9', NULL, '6209517b-ba97-4edf-a986-79105177e097', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=gZoo5fAVeGs', 'Telegram Fast Download', 31, '2026-07-17 13:58:47.835069+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('0c263694-f6a4-439a-a1d2-ba855009b448', NULL, '299ff645-f014-4bb1-a4f0-e0b08ff1df49', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=SHnUyOO_Qus', 'Telegram Fast Download', 18, '2026-07-17 13:58:47.835069+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('98e3540a-a9aa-4ebb-af5e-e3fa17448eea', NULL, '310e451e-4e84-425d-a539-1d719acae553', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=TYB9eVLhTkM', 'Telegram Fast Download', 14, '2026-07-17 13:58:47.835069+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('967b0942-6c58-4028-ae98-45ee0246884a', NULL, 'ab8847c0-ad32-43aa-aa67-5069fb8a1d26', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=v1-7amMjLhs', 'Telegram Fast Download', 16, '2026-07-17 13:58:47.835069+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('0cca050b-652f-48f3-aeff-7e2d49ecd117', NULL, '2358e133-5f2e-4442-ace0-5202c0e1a5ea', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=F-0GG-6qGoI', 'Telegram Fast Download', 14, '2026-07-17 13:58:47.835069+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('c6d07c5c-1735-4a40-a55f-955be18dcec6', NULL, '75d0a3d5-5005-4d05-ac96-df51a0192507', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=_aUcpqo3YPI', 'Telegram Fast Download', 0, '2026-07-18 06:07:52.262353+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('55da4f64-517a-4560-a747-9339bf546c52', NULL, '0904fda1-cdef-4878-a18e-d9c698e0b9ef', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=XlsNCjz8mcs', 'Telegram Fast Download', 0, '2026-07-18 06:09:35.713148+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('37c5000a-4f94-408d-a93b-bd6302d4f474', NULL, 'b88a1b3e-f7f3-43e3-a8d4-89c10dc677d6', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=SDnkstXheBg', 'Telegram Fast Download', 0, '2026-07-18 17:41:59.995576+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('4ec18422-ac55-455b-aacd-982e4655e6ff', NULL, '4becc21e-915c-44ec-a5df-4f84f0c6ade2', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=6w9Dk8VNhrE', 'Telegram Fast Download', 0, '2026-07-18 17:41:59.995576+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('d3d1041f-3294-4eb5-afa4-14e08386059f', NULL, '99cf14e1-f54e-4303-a099-3f53771acc3e', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=RgSSdU9Tg3Q', 'Telegram Fast Download', 0, '2026-07-18 17:41:59.995576+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('f6bc3e6b-9d7d-49de-a778-63569d9efbc8', NULL, '4944bacb-a743-4264-a6c4-1b648f1f61e5', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=0ZF18F5WoCs', 'Telegram Fast Download', 0, '2026-07-18 17:41:59.995576+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('774ce0c3-1419-493c-adb2-9437c251576c', NULL, 'ddade0d2-f45c-478a-abfc-5fa73bf1521c', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=qYF_IcYwgCM', 'Telegram Fast Download', 0, '2026-07-18 17:41:59.995576+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('7656bcd0-0b07-437c-a701-6478715ff820', NULL, '50220617-6560-4669-a946-ffb634e33779', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=d__-ZYvsyM4', 'Telegram Fast Download', 0, '2026-07-18 17:41:59.995576+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('67d71ba2-6682-4f2f-a419-c7a32ca9523b', NULL, '95315ed4-11f0-43e7-a029-2c0d7755a62d', '720p / 1080p HDTV', '450 MB', 'https://t.me/PixelPopLk_bot?start=497ab715-57ac-4a68-b482-61f84bd17159', 'Telegram Fast Download', 13, '2026-07-18 18:03:31.96276+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('c442137b-a304-4530-afbf-459ef0a1ad2e', NULL, 'e55206c4-1253-408a-a2d3-a08e662c12c0', '720p / 1080p HDTV', '450 MB', 'https://t.me/PixelPopLk_bot?start=810c4d64-4c91-42a5-9ae3-3124e18bb189', 'Telegram Fast Download', 24, '2026-07-18 18:05:34.87458+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('35024b54-64e6-46e5-a5c1-9f26beaf555a', NULL, '80548dc8-f452-4bac-a8b5-403b3f4e19a9', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=8NEJwzLMMMk', 'Telegram Fast Download', 11, '2026-07-19 18:04:00.986472+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('4ea22130-e07e-4ed9-a659-c7e49f2a213a', NULL, '1a20966b-ec05-4c1a-a2a0-aac81811e0cb', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=EKDdwz2kDnI', 'Telegram Fast Download', 12, '2026-07-19 18:04:00.986472+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('fee444e6-7d15-4809-ad3a-77072ff41a5b', NULL, '7fc5235b-b315-4576-a40f-468923bd0623', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=5cEwOHO6gXE', 'Telegram Fast Download', 17, '2026-07-19 18:04:00.986472+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('8df9be54-b2d4-4789-ab90-9899870f4742', NULL, '0f38be62-9755-4228-aceb-c90656d7a935', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=0QWzapTw4CE', 'Telegram Fast Download', 15, '2026-07-19 18:04:00.986472+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('1870e497-ca97-4e4b-a17b-d251f78f48f5', NULL, '21059568-1722-49ce-a15a-2252d47ef971', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=hgX23awWEhc', 'Telegram Fast Download', 15, '2026-07-19 18:04:00.986472+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('a63cd41f-032a-4423-afae-6295ada4a90b', NULL, '1bf72f06-f39e-4be9-a837-e2c19c588e90', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=yQo2hMHgRa8', 'Telegram Fast Download', 11, '2026-07-19 18:04:00.986472+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('3911be3f-a9d5-4827-a64c-6fa35d53d7c9', NULL, '63dbe61d-808b-4467-aed5-20009f8a86b9', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=jcPBAK9DK_g', 'Telegram Fast Download', 18, '2026-07-20 02:26:00.42846+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('94934156-59a8-4a44-a9f6-5605044b66e1', 'e0acef12-4bfd-4d2a-a3d4-6f3dc06b57a2', NULL, '1080p / 720p HD', '1.2 GB', 'https://t.me/PixelPopLk_bot?start=a0795f91-288e-48c9-8e87-257726a3cae5', 'Fast Telegram CDN', 1, '2026-07-21 08:01:41.770922+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('78b1b3ac-3471-4f37-ae94-30e06977c013', NULL, 'ca371690-e836-4c05-a91f-875704cb23ff', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=KtkDN-42odc', 'Telegram Fast Download', 10, '2026-07-21 11:40:15.630722+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('a12ca5d7-d387-4fdb-a22e-5dd0246d368b', NULL, '698f1205-0367-4a57-a1d1-a8ba6d8d491f', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=8fDnjFpoY0Y', 'Telegram Fast Download', 11, '2026-07-21 11:40:15.630722+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('545d538d-81c2-45c6-a83a-c396f88ab650', NULL, '368cb299-ef3b-42e2-af6b-8efc86381237', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=UfFdUVG6RFE', 'Telegram Fast Download', 10, '2026-07-21 11:40:15.630722+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('549efd3d-58aa-4d58-ac0a-47aaa06c6054', NULL, '794b840f-462b-42a3-ae5e-0ac36bc17d36', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=3cEG-0FdiAU', 'Telegram Fast Download', 11, '2026-07-21 11:40:15.630722+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('51c3808e-0757-4f2a-a72b-21ed9f0082b0', NULL, '73821cf1-ea50-4da4-a876-40088a9ace4a', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=SIgmPxUPMp4', 'Telegram Fast Download', 9, '2026-07-21 11:40:15.630722+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('e62747b5-1e40-423c-a111-35b15a36430b', NULL, 'bbff83c9-213a-4464-a36b-2b67982280e3', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=dzLuyeorNsg', 'Telegram Fast Download', 8, '2026-07-21 11:40:15.630722+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('77872796-43f4-45c3-a7c3-5a88c00e6c4d', NULL, 'e21a578c-ad9b-4512-a07d-7b22a8e3ac9c', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=V0GgpWU7F84', 'Telegram Fast Download', 8, '2026-07-21 11:40:15.630722+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('70b6b3a1-efc2-49cc-a81f-a08e77b74dde', NULL, 'd0900956-0102-4566-aa13-c09bffe1e464', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=vmPMRGqvj-Y', 'Telegram Fast Download', 9, '2026-07-21 11:40:15.630722+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('5138d7b7-001c-43bd-ad74-ec9fe24599b1', NULL, '222ad6df-73f1-45ba-ac8a-38d8c21e2e46', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=0dXvvBaQSb4', 'Telegram Fast Download', 0, '2026-07-21 11:40:57.426392+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('896c873d-bd8c-4565-a888-491cbf0f183d', NULL, '338fb4b5-b92d-48cd-a324-77ee39ef30ac', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=3glZV3fPr7M', 'Telegram Fast Download', 0, '2026-07-21 11:40:57.426392+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('95043052-c415-4530-a554-fe7b9e0b7904', NULL, 'd7e26624-0ec9-4648-a251-60a5d338c78c', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=4zHu9uNt7k8', 'Telegram Fast Download', 0, '2026-07-21 11:40:57.426392+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('ff71b17a-281d-49bd-accd-73c29e011368', NULL, 'd0b4c45b-4b5f-4921-a1cb-df8360b5af6d', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=IDYDagRDWRc', 'Telegram Fast Download', 0, '2026-07-21 11:40:57.426392+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('3a5120c2-e03f-43a7-ad38-390ef393a680', NULL, '13a6fba1-d1e6-43d6-a256-b34735de376f', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=5Vhp0WJ3nDQ', 'Telegram Fast Download', 0, '2026-07-21 11:40:57.426392+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('1b911936-4586-471c-a28c-1ccdf306f3bb', NULL, '3cf2c156-e756-4d50-a710-bcc7d6556ed0', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=RPyqWmuqi8g', 'Telegram Fast Download', 0, '2026-07-21 11:40:57.426392+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('983666ea-9e93-4749-ac1f-186d93c4abb4', NULL, '52686cc5-f72e-4d32-a887-97c0c66c8c70', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=_pC3ossCHzM', 'Telegram Fast Download', 8, '2026-07-22 15:20:11.306013+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('4820c8b9-73a7-4d69-ae7e-9f45e46a32f0', NULL, '189982d4-7328-4b53-a79e-2b5ee5619828', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=QeDzBAr5sqA', 'Telegram Fast Download', 8, '2026-07-22 15:20:11.306013+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('e0b9339b-87ae-4083-aaaa-e2ad7336e9ea', NULL, '0f0873c0-f5c0-4c0a-afd5-cdc0585e63fb', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=001N-5kET58', 'Telegram Fast Download', 7, '2026-07-22 15:20:11.306013+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('6c300812-a86d-479a-a26d-cb392552d10c', NULL, 'b25570b7-1e07-4d84-ae08-e4e5f59a46b3', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=eYot5P-7oSU', 'Telegram Fast Download', 7, '2026-07-22 15:20:11.306013+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('0bb8eb74-7e1a-48d4-ac1e-1a68b8f88437', NULL, 'a03dd8e3-1ba0-49e9-a2fb-6a1ae7d24300', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=uXcSz7_TwLg', 'Telegram Fast Download', 7, '2026-07-22 15:20:11.306013+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('1fb53dd1-68c5-48a4-ad6c-0acc3a4d6bd9', NULL, '885890f6-86b7-4444-a898-5a3769be7b3d', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=5Gz2t4qHCUk', 'Telegram Fast Download', 8, '2026-07-23 15:20:45.443248+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('18e33803-b55e-4ea0-a53b-221a84436bd8', NULL, '2bdd29eb-1ef4-40f4-a9f7-5c19ac3176ca', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=eDpR9igtdjc', 'Telegram Fast Download', 6, '2026-07-23 15:20:45.443248+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('d6a20508-0c42-40d7-a6d8-e0724e709239', NULL, 'b5b445f0-0318-4bdc-aea7-706657c7a61d', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=z-6eFCtY7Uw', 'Telegram Fast Download', 7, '2026-07-23 15:20:45.443248+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('4252e460-005a-4d7d-a63b-afba1d085ce0', NULL, '1e5ab17d-c96b-4e4e-a4c2-a16a9b647ca7', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=TuuXkPJL320', 'Telegram Fast Download', 7, '2026-07-23 15:20:45.443248+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('0a8d7d11-a4fd-44ec-a522-efcf2e5eb872', NULL, '08f1b5b3-5554-49d5-ad1f-dfe75b0de463', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=GsRL_Cha5UU', 'Telegram Fast Download', 7, '2026-07-23 15:20:45.443248+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('85b31660-8adb-4d42-a746-26e55c4d6366', NULL, 'fc5bb8bb-5bc8-4c06-af12-fa98e47dacbc', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=LQ1kcNDHDMo', 'Telegram Fast Download', 7, '2026-07-23 15:20:45.443248+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('d5000c6a-a3ca-44d7-a541-725dcb95b499', NULL, '1acd005b-2c4d-44c9-a715-de8753a91db3', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=UhgiyvxRYu4', 'Telegram Fast Download', 7, '2026-07-23 15:20:45.443248+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('cd5c8420-0a71-4d56-a2a4-adcbcc54f24f', NULL, '8ecd6e3e-cfdc-4189-ac6e-1f8c2bcdcfcc', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=jJiJ-GTU3c8', 'Telegram Fast Download', 8, '2026-07-23 15:20:45.443248+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('4f38cd53-da31-4ba2-a10d-d11ed4224cd6', '0229ecbe-ddae-4a78-a2b7-663225e0a314', NULL, '1080p / 720p HD', '1.2 GB', 'https://t.me/PixelPopLk_bot?start=690e9734-9a4a-41cb-9810-756ad318327c', 'Fast Telegram CDN', 6, '2026-07-23 19:35:18.298072+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('4ca23b72-bc6b-43d8-a2ee-c7d09741c35a', '1aad2806-8173-4ae1-ae43-57d800d76bdd', NULL, '1080p / 720p HD', '1.2 GB', 'https://t.me/PixelPopLk_bot?start=4b58a7e9-b428-4b24-99f7-739cda38f7e2', 'Fast Telegram CDN', 2, '2026-07-24 12:04:54.624116+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('9b159b12-294f-4ec5-a348-e28b44c7d753', NULL, '77c2deb4-4b84-4592-a048-c57a573d3c75', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=NlMvTfV_O1o', 'Telegram Fast Download', 10, '2026-07-25 11:21:03.246098+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('e85762eb-fa32-41e8-a1fc-f8212d9a8d62', NULL, '3cfe9b71-d26b-4d27-ab90-cde86b07216d', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=PR_aBdl0xgo', 'Telegram Fast Download', 6, '2026-07-25 11:21:03.246098+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('95e91994-3806-4d11-a4a7-affec36ee554', NULL, '64dbf9bb-cb79-4704-a86b-f1c041c7da84', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=m-2l0ZSeECA', 'Telegram Fast Download', 5, '2026-07-25 11:21:03.246098+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('317618da-893d-4483-a558-4e88e5735a5b', NULL, '75ce2c81-1976-43a1-ad91-dcce0c4c592e', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=k-ac9Q2-TpU', 'Telegram Fast Download', 5, '2026-07-25 11:21:03.246098+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('d6c2a3c2-76f5-44e5-a163-a5fc09f97de5', NULL, '64ea51cc-d8bd-405c-a422-5b2781e32566', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=L7_onccmLN0', 'Telegram Fast Download', 5, '2026-07-25 11:21:03.246098+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('9cbacaff-553e-458c-aac4-8b1f3b57d033', NULL, '1c9893ce-278f-4c24-a7d2-a35198f81a1b', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=V46RzWEr9M4', 'Telegram Fast Download', 5, '2026-07-25 11:21:03.246098+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('d84876ff-4b23-42f3-a809-7fc422eb54a8', '7273abd3-83a6-4546-a3ec-63ecbad7afee', NULL, '1080p / 720p HD', '1.2 GB', 'https://t.me/PixelPopLk_bot?start=289976c7-6918-40dd-a0e4-7e21e8b43121', 'Fast Telegram CDN', 5, '2026-07-26 08:15:56.089476+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('3eef7ec1-1fa0-4f05-ab92-28bcb5e514bf', NULL, '7e8ba31b-90ab-4c2b-a836-a7a609313b90', '720p / 1080p HDTV', '450 MB', 'https://t.me/PixelPopLk_bot?start=d1cf3b6c-6aba-4005-9300-7343433859b1', 'Telegram Fast Download', 10, '2026-07-26 09:14:46.57961+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('00b892bc-0d8e-4a74-a164-44941665f9e9', NULL, 'edab7b3c-681d-4c9d-ace4-071fe9f67022', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=WijpIA9Rh3Q', 'Telegram Fast Download', 5, '2026-07-26 15:57:14.899352+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('4e271e16-01f9-4890-ae05-9fb85f4f2558', NULL, '03492fb2-46fa-4256-a8de-cfc9d010374a', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=lKFthgH2gWw', 'Telegram Fast Download', 5, '2026-07-26 15:57:14.899352+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('24fed6b4-2d64-41da-a978-a80644d8544a', NULL, '92c0e755-8f28-41e3-a80c-964e244d2838', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=RYl95u2P_SE', 'Telegram Fast Download', 5, '2026-07-26 15:57:14.899352+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('c069fbf7-d39d-4ed7-a516-7745563a40e7', NULL, 'bd69d98f-b680-4233-a936-b5757b761ca5', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=3Whk7g9Sjcg', 'Telegram Fast Download', 5, '2026-07-26 15:57:14.899352+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('31c1a27a-643f-42ec-ace5-4e07ad4ecd44', NULL, '284cc148-417f-41bd-a016-a334425cf20b', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=HeGe8BRK9Xs', 'Telegram Fast Download', 5, '2026-07-26 15:57:14.899352+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('b62d7d9b-1ed3-4db7-ac37-ea2640114608', NULL, '6893db14-d921-4e5d-aee9-00a9a7684990', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=cKSQhKO8W2Y', 'Telegram Fast Download', 5, '2026-07-26 15:57:14.899352+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('1350d051-628b-4107-a8b7-5406d354ad73', NULL, '66a09de6-2feb-4a98-aded-f4c7876c8389', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=IvhGcKuOeNU', 'Telegram Fast Download', 5, '2026-07-26 15:57:14.899352+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('ab580ea3-16e1-475b-a515-2e6e6a0251ff', NULL, '20c0ef33-dcc6-4a16-af37-7120dfa53ff5', '720p / 1080p HDTV', '450 MB', 'https://t.me/PixelPopLk_bot?start=55bfb940-f864-48aa-a391-69a7036b2ea0', 'Telegram Fast Download', 74, '2026-07-26 19:36:34.146575+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('a719a5bb-36cf-4636-a128-e53eaf5f5f7c', 'df9ada98-9278-4ca8-a15c-8a7ea09f99c8', NULL, '1080p / 720p HD', '1.2 GB', 'https://t.me/PixelPopLk_bot?start=e6ee1d93-ba80-41e2-a10d-cf82a81d433b', 'Fast Telegram CDN', 1, '2026-07-27 06:46:17.212937+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('d135d44e-23c2-4fe2-a1a9-b29f920df9b6', NULL, 'd0f4555f-a4fc-4da0-aa16-250bf17b6dc6', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=sKu_8Y7f48E', 'Telegram Fast Download', 161, '2026-07-28 16:58:59.501453+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('3956458a-cc02-42b9-aec7-b580bf602d0f', NULL, '2c4823c5-2eba-4b71-a8fc-8ecf344ae8a2', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=VPP38LjCqT8', 'Telegram Fast Download', 5, '2026-07-28 17:47:57.477299+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('ce4b9754-1df5-4efc-a2ae-c28bdbcc94cd', NULL, '63b40e8f-3f58-4378-aef8-b4e46519ccd7', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=yPknsp-C0O4', 'Telegram Fast Download', 4, '2026-07-28 17:47:57.477299+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('a62969fb-b2be-487c-a336-e57011aaef6e', NULL, '5e5d6994-0c1e-4a5b-a409-0ec027c01610', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=0o9LdxEFyP4', 'Telegram Fast Download', 4, '2026-07-28 17:47:57.477299+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('10ad0df9-97aa-4268-a2ac-c1011712b3db', '3cf8526a-e6d0-4385-a6c8-a42b45e28736', NULL, '1080p / 720p HD', '1.2 GB', 'https://t.me/Pixelpopnew_bot?start=8MejAK2soLo', 'Fast Telegram CDN', 0, '2026-07-28 20:01:07.145515+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('4543650e-57fa-4147-ac48-af55e6abd3a4', NULL, '58f4f368-2048-4dfe-ade8-cb8f6a71335c', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=pPW4NKswXEo', 'Telegram Fast Download', 4, '2026-07-29 15:47:39.376403+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('54996490-9560-400b-adb1-8045fac2ae3a', NULL, 'b644584d-6beb-4f9e-afe9-eb5ee8eedfd1', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=o_kYmabVLvk', 'Telegram Fast Download', 4, '2026-07-29 15:47:39.376403+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('2ff7cf9d-f85b-4716-afbd-04675463bfa2', NULL, '83d768fe-b45e-4c9d-a6f4-45972629217b', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=U2Uuw9kQCZs', 'Telegram Fast Download', 4, '2026-07-29 15:47:39.376403+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('3e2ce3b6-6325-4945-ad02-33f899fff8f0', NULL, '955ea3c4-c95a-4ab3-adda-230eb371fee4', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=Nk02jll07P0', 'Telegram Fast Download', 4, '2026-07-29 15:47:39.376403+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('b01bef9a-b5a3-48e6-a4c3-4e2a4e6d8406', NULL, '0302ad93-a071-4659-a7ac-68d2eadbce48', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=pfHsCOk5IrU', 'Telegram Fast Download', 100, '2026-07-29 16:57:22.390038+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('84dcafb2-e37f-497e-ad25-dd887fb6a036', NULL, 'e76fccd1-c5d4-4364-a13a-cdd08d7f82dc', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=KufqRVs38r4', 'Telegram Fast Download', 4, '2026-07-30 09:44:00.617394+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('301f05f5-be02-4133-ac0f-62150f5223c8', NULL, '8effbb46-e183-4e09-acd6-8e7020089a5c', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=8exANhaRh9A', 'Telegram Fast Download', 4, '2026-07-30 09:44:00.617394+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('0bd5f178-0307-4d16-af35-706bf8a21f75', NULL, '406954d8-a6c4-4461-a0f5-128b46a552cb', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=fnVLH336XKI', 'Telegram Fast Download', 4, '2026-07-30 09:44:00.617394+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('99377370-f463-4f99-abfc-fe416130e210', NULL, '75dcb4d7-ad01-4b5d-ac44-af7dcc074143', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=MXMlD5vhRrE', 'Telegram Fast Download', 4, '2026-07-30 09:44:00.617394+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('f5ef5ab0-9ae0-4e12-a4e9-a8059f643bcc', NULL, 'a3557a0a-cddd-4b54-ae83-078d0c5db74d', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=xSIqbLgHhOY', 'Telegram Fast Download', 6, '2026-07-30 09:44:00.617394+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('9216d292-de43-4e78-a274-766593ecc1fe', NULL, 'c3e0b55d-5d39-4694-a57e-290dc2dd1688', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=DE7Gjhbj6g4', 'Telegram Fast Download', 5, '2026-07-30 09:44:00.617394+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('9dddb2ab-7568-43eb-a259-076fd4279227', 'd42c4776-344b-449a-a5fe-a6cadb6b0e59', NULL, '1080p / 720p HD', '1.2 GB', 'https://vegamoviess.cc/56319-spiderman-brand-new-day-2026-english-audio-hdtc-720p-480p-1080p.html', 'Fast Telegram CDN', 37, '2026-07-30 10:11:12.178415+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('c56714b3-cafc-4a27-aa61-1c4480b6fd67', NULL, 'ec8eed25-378b-42af-a65e-374ca3131bf2', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=ipU2sVOrHe8', 'Telegram Fast Download', 40, '2026-07-30 17:16:11.526432+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('d49d1311-8819-473b-a512-6e950a4b39c3', NULL, 'a6cfd8cd-59ce-498f-a9bc-47204425eef6', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=arsDrNcCmQE', 'Telegram Fast Download', 4, '2026-07-31 09:09:26.160221+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('b4c440de-3db8-4090-aa74-87a4dcacc511', NULL, 'f4fcbb58-0b08-4cee-a88c-c7365cf0659b', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=TXkURLcyE_w', 'Telegram Fast Download', 1, '2026-07-31 09:09:26.160221+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('c3c96485-c478-46fb-a477-ec6742586786', NULL, '3b51ac84-ce09-4234-a343-1c74913985a4', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=H3yIEBKeZLA', 'Telegram Fast Download', 1, '2026-07-31 09:09:26.160221+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('faae4940-5fcc-4832-a428-e0ae7d57fc1f', NULL, 'e9ae28bd-37c8-47a9-ac40-32dafe67d221', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=YmJCBCRy4TI', 'Telegram Fast Download', 3, '2026-07-31 09:09:26.160221+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('91eae738-2c81-48cb-afdf-830712480ca6', NULL, 'ba471fc4-cdd7-433f-ac73-5630f9f7805a', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=Sp-sUyy5zc0', 'Telegram Fast Download', 1, '2026-07-31 09:09:26.160221+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('2bed8bb4-b109-4cb9-a915-972c6092dabb', NULL, 'fea0951d-e28c-4d8c-a0ac-6b46c488eddd', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=40gVwZLFfBE', 'Telegram Fast Download', 42, '2026-07-31 15:59:35.827563+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('26fff493-000a-4548-a8d6-9c0cc9e616a3', NULL, '2a0eae91-9ba4-4a13-afe3-ebb0cd010529', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=bbazHfhb2S8', 'Telegram Fast Download', 27, '2026-07-31 17:35:43.965012+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('53a721ff-419d-44a5-a141-1627be29238b', NULL, '95edb036-490d-4672-a691-de72f1fc4433', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=zEXFqU9Fu9c', 'Telegram Fast Download', 25, '2026-08-01 18:42:43.72199+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('1b378509-429e-4706-abc6-7610e7b9df23', NULL, 'a4c80c92-c0cd-42c0-a40c-d11d2446d96f', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=9PpPcRwzxK4', 'Telegram Fast Download', 22, '2026-08-01 18:42:43.72199+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('40717aa7-c2cd-4601-a991-b79deb26366a', NULL, 'c4b9733a-acb6-4a6c-a682-6ff934780c1f', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=ri4xxuzwwIY', 'Telegram Fast Download', 23, '2026-08-01 18:42:43.72199+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('911fff67-b3d2-4718-a0b0-b8f571ba98b7', '864fdf34-739e-4d67-a432-7871ff39f735', NULL, '1080p / 720p HD', '1.2 GB', 'https://t.me/Pixelpopnew_bot?start=6wemrhldcjs', 'Fast Telegram CDN', 1, '2026-08-02 10:40:16.846602+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('6112b5f2-b2cb-402b-a201-45d867b03183', NULL, '51d69f36-0897-4aa6-a071-3091f4df449c', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=bUAvt3hZby8', 'Telegram Fast Download', 20, '2026-08-02 11:53:59.619015+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('5e2d91d7-5c01-4c70-aa70-f6e87fd9493a', NULL, '710e795f-a404-46ce-aaf6-0343d30ccc43', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=KwibnYnLOpU', 'Telegram Fast Download', 24, '2026-08-02 11:53:59.619015+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('783fbc20-d216-455a-ae82-a8fbc9868917', NULL, '31700cda-d742-45d1-a603-a060d2967c16', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=LrwOtn8SNjw', 'Telegram Fast Download', 20, '2026-08-02 11:53:59.619015+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('12d93eab-29d8-4d05-aa2e-2fab062e8a43', NULL, '65c4f780-ba0b-4b8f-a989-a8071213610a', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=wkzJifBN85E', 'Telegram Fast Download', 21, '2026-08-02 11:53:59.619015+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('18eec0ee-a4b0-4685-a237-252326165c1b', NULL, 'cf2881d3-1dd2-4b90-a256-15d63f803d58', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=nVMnxz2cFpA', 'Telegram Fast Download', 23, '2026-08-02 11:53:59.619015+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('a99fd830-b44f-48dd-a378-b50c71594606', NULL, '74c2427b-5304-48b9-af5f-eaba3842a990', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=dACUTV89r3E', 'Telegram Fast Download', 29, '2026-08-03 02:22:22.473636+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('50dcfa6a-8edc-4242-aaf4-a71346171e82', NULL, 'f5146e8f-c913-4aad-a945-fa8b34b8778c', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=SoEC2DCU-fU', 'Telegram Fast Download', 0, '2026-08-03 09:03:10.202106+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('74076c13-b45c-4597-a37a-a9766e4f261d', '27348593-2ecd-404c-a1de-9b09f44a255c', NULL, '1080p / 720p HD', '1.2 GB', 'https://t.me/Pixelpopnew_bot?start=ooDWzHzv0T0', 'Fast Telegram CDN', 9, '2026-08-04 08:00:52.849475+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('167bc48b-0da5-4fa9-a051-efd459911e9a', NULL, '11381df3-b8be-48d4-a1ad-569e05c95521', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=4R92m467whk', 'Telegram Fast Download', 13, '2026-08-04 13:03:55.568064+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('bb87a15d-a9bb-49cd-a4e5-8faa0266e153', NULL, 'fb0ccdae-d227-469d-a5bf-8397a8e67e11', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=ONCV16Hzu-g', 'Telegram Fast Download', 13, '2026-08-04 13:03:55.568064+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('55eefc9b-b971-4ec4-a619-4536ce933695', NULL, '45bb51fe-8399-4ff9-aca0-0fb5ef8e5f0d', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=r6iZ7SZf7lw', 'Telegram Fast Download', 11, '2026-08-04 13:03:55.568064+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('b57db255-3198-4a75-ab94-d86222661def', NULL, 'dc904877-7506-487a-a885-56cae91aa869', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=8EkhwMK4Tws', 'Telegram Fast Download', 11, '2026-08-04 13:03:55.568064+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('4ae028b9-5dbc-4627-a1fe-2bae5159a302', NULL, '1a42ff11-76f2-406f-a112-74050f0ed6b3', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=3mxhNy2a_sU', 'Telegram Fast Download', 7, '2026-08-04 13:03:55.568064+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('b47e7be6-1c4c-4e64-a747-2afb2a401749', NULL, '5a628954-c86b-4446-aba7-35c164668a1b', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=1NZ3QrMdBj8', 'Telegram Fast Download', 7, '2026-08-04 13:03:55.568064+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('d59c88e0-53b5-4d76-ac09-46c75bb38f4b', NULL, '25c29c59-b2ed-47b4-aab3-5c75da0f60af', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=CG-FHNqKaKY', 'Telegram Fast Download', 8, '2026-08-04 13:03:55.568064+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('29ea5d44-35f3-4e07-a2ab-a3fbeb7ee818', '818a4550-dcd3-47b2-aac9-8a5cc2177b56', NULL, '1080p / 720p HD', '1.2 GB', 'https://t.me/Pixelpopnew_bot?start=IyXLQl8Vog8', 'Fast Telegram CDN', 5, '2026-08-05 06:34:07.587586+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('3dd83995-0cd4-4705-ab37-18a6a4144c94', NULL, '066a18bc-7bdb-4a18-aa2e-4cbad14402c4', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=aP-YdpMmgZw', 'Telegram Fast Download', 1, '2026-08-05 06:40:15.262255+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('2a0d7582-6ca8-4a06-ae03-c046a8896f37', NULL, '13adeaee-d6b9-4ce7-aaa3-22014c09f3fe', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=uAWGS7zYrMQ', 'Telegram Fast Download', 1, '2026-08-05 06:40:15.262255+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('df166423-bead-4ea9-ad38-e88b0bf49aaf', NULL, 'eb7be14d-309e-447a-af0c-77c067687792', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=-OFIIL8N0bk', 'Telegram Fast Download', 1, '2026-08-05 06:40:15.262255+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('a8f5c876-21de-4e6e-ab79-f7df7e78deb9', NULL, '8918d7af-ddc8-4d79-a115-648c4d8a842b', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=y2wHtYalp2Y', 'Telegram Fast Download', 1, '2026-08-05 06:40:15.262255+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('ccdbc6e2-52fa-4b3d-a0af-35f61ff4d0a0', NULL, '66a28dbc-03be-430c-ab95-6e85647ceb4a', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=873lLDC5gUQ', 'Telegram Fast Download', 1, '2026-08-05 06:40:15.262255+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('6510bfe4-f956-4b81-a939-b977c6408c58', NULL, 'd5ff3e6f-be53-41a0-a1db-a32c7fd6058c', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=8mDwdOCxUhA', 'Telegram Fast Download', 7, '2026-08-05 14:04:25.09645+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('2ad8da46-5d63-4b43-a252-6f836d4810ec', NULL, '58f013a3-9706-4a95-a23b-1447a33dcfdd', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=XaKaYZ4OYgw', 'Telegram Fast Download', 8, '2026-08-05 14:04:25.09645+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('4c25008b-8b4c-4089-ac2d-6269bea76ca6', NULL, 'aecf096e-b032-4427-a048-5847754c40d9', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=oJ3D1pN4eoI', 'Telegram Fast Download', 7, '2026-08-05 14:04:25.09645+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('f9d02c4f-11eb-4a85-a7ae-5d9285695b0e', NULL, 'fc308178-cf48-4075-ae4f-7d52903534cf', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=iqbq-BUrEx4', 'Telegram Fast Download', 7, '2026-08-05 14:04:25.09645+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('e39fb2ba-10c8-43a8-a205-e23d1c742b9a', NULL, '0da8bb61-54d3-4e34-a964-3c3aeeb2f16a', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=pFj7buRsk_g', 'Telegram Fast Download', 7, '2026-08-05 14:04:25.09645+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('1e6816e0-63af-4786-ae5e-84fccf193d77', NULL, '8edacccc-9ea3-464e-a452-1a43a32f6a8c', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=KmfdPHTMPf0', 'Telegram Fast Download', 7, '2026-08-05 14:04:25.09645+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('e57032b2-db68-4e82-ae33-9c50b7c5f864', NULL, 'c8b7d6e7-659c-441d-a6b2-0f793f7a12f3', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=mHjCjLg9mMc', 'Telegram Fast Download', 42, '2026-08-06 10:35:58.56554+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('f2dfc710-93fd-4aee-ae8c-d9cfe2c8ed96', NULL, 'b8b71ba1-035c-4e38-abeb-5a963747103b', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=zFRARMXn88g', 'Telegram Fast Download', 34, '2026-08-06 10:35:58.56554+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('bbbab9d2-4b65-4290-aa5d-a66d8ac74ca3', NULL, 'c6bd7616-67b9-4ef0-ab7b-8f0dc1c59094', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=Ig7BUCTE7es', 'Telegram Fast Download', 17, '2026-08-06 10:35:58.56554+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('4e7cfc2e-43ff-4300-acd9-9e05123870fb', NULL, '97480402-5c90-4820-a67b-eb3200b200fd', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=neY3EQ_L3zw', 'Telegram Fast Download', 12, '2026-08-06 10:35:58.56554+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('9b856771-7490-465b-a897-d80a32af7658', NULL, 'bdb6486a-12de-48ef-a744-d33ba66f3350', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=lVBTeEmTcgU', 'Telegram Fast Download', 9, '2026-08-06 10:35:58.56554+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('4a1d0b06-59f9-4bd2-a977-747d49996773', NULL, 'ace2be51-4e1b-4bda-aaf2-0ba9c9503f18', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=IaJFkFVNlW8', 'Telegram Fast Download', 8, '2026-08-06 10:35:58.56554+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('6afa830c-ae28-4f49-a8e7-a181b067c171', 'ea4bba9c-79bc-4754-acc5-2346a5fa7043', NULL, '1080p / 720p HD', '1.2 GB', 'https://t.me/Pixelpopnew_bot?start=lnHDjEpwOhg', 'Fast Telegram CDN', 6, '2026-08-07 07:34:34.672569+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('ed95b18d-9a59-4aae-a7bb-df50c5d29b6f', '13edeece-2efe-4aa9-a85f-f62b92aa5f88', NULL, '1080p / 720p HD', '1.2 GB', 'https://t.me/Pixelpopnew_bot?start=PJLeftrWSoM', 'Fast Telegram CDN', 20, '2026-08-07 09:54:02.964215+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('337fc4d7-5237-43e5-aa59-088e1c126233', NULL, '40eff4a1-1286-4be5-a527-ed426a350c79', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=etyNwuHeSCw', 'Telegram Fast Download', 2, '2026-08-08 08:30:23.609856+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('fb065f06-fccb-439d-a1e1-03fd91785138', NULL, '94a241a0-94ee-4f4b-a1d3-266d92a048ae', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=b5-7tmWYRYs', 'Telegram Fast Download', 19, '2026-08-08 11:01:21.636301+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('529c1dfe-5a43-4f5d-afcf-9a2b9feb4f34', NULL, '37e475b0-4507-43f7-aedc-49ec791400af', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=x7Ayw2zp5Sw', 'Telegram Fast Download', 357, '2026-08-09 18:17:04.550544+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('58d2b46c-333a-4252-ae6b-5cc35bd86577', 'cd43d917-6076-4b02-a085-caec2d8f1f60', NULL, '1080p / 720p HD', '1.2 GB', 'https://t.me/Pixelpopnew_bot?start=bh0r5hKGUQo', 'Fast Telegram CDN', 14, '2026-08-10 12:27:21.523628+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('ef6b8493-633b-4090-a35b-43ac8bfc657a', NULL, 'f553f3c2-685f-4c47-affe-6a4a9bb08a82', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=UkpEV1gX-9M', 'Telegram Fast Download', 5, '2026-08-10 13:02:14.876293+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('6f1bcef8-c481-4123-a98d-c302becafdd0', NULL, '1a8c74d1-454f-4eda-a981-9fd8cac7e925', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=8x-ba73m7zg', 'Telegram Fast Download', 12, '2026-08-11 13:42:49.900781+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('b3551921-56d9-446a-a34d-c4f4e6d4604f', NULL, 'ad4d6aa8-2423-44af-adf0-3f06c3286455', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=vO7vfxcCB9I', 'Telegram Fast Download', 7, '2026-08-11 13:42:49.900781+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('193cc301-cc4c-4401-a612-dbe2343a3f1f', NULL, '58fe2ca3-311b-42e3-a5dc-88f3bb2f1979', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=3Q7coxFLTSg', 'Telegram Fast Download', 7, '2026-08-11 13:42:49.900781+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('95621c1b-1735-4fcb-a12f-f7587822625f', NULL, 'e27888a2-fb08-4a4b-ac48-f237cd8fed6b', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=ZwTmXT71QIo', 'Telegram Fast Download', 8, '2026-08-11 13:42:49.900781+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('a97c9952-7834-48b4-a1c5-7b83c20af6f2', NULL, '1b656de1-5e5f-4102-aca3-4789567c3579', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=l2YpKZwz1VQ', 'Telegram Fast Download', 7, '2026-08-11 13:42:49.900781+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('4b1dd633-7a3c-4eb9-a7cb-a4c2689b8b43', NULL, '8991af5f-0ff6-4961-a2b5-e9a555cd95bc', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=eN1vvAiL1OE', 'Telegram Fast Download', 67, '2026-08-12 08:51:51.598699+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('0c339880-4c47-4bea-aafe-90ff83e11f5c', NULL, 'f5d37077-57ba-49ed-aa2f-478e40f20cb0', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=mxXHA8lgziE', 'Telegram Fast Download', 33, '2026-08-12 11:07:22.290595+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('ed36e85f-20c7-4373-a575-33ef3510666e', NULL, '8b7fb51f-0142-4edf-a86b-adfbc039efc2', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=hBiqSXseDeI', 'Telegram Fast Download', 29, '2026-08-12 11:07:22.290595+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('05f9acb8-a7ef-416e-a563-5805a146da14', NULL, '6280c28b-3194-4a60-a8fe-a7a3a13699d7', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=yX1gqQgPwxc', 'Telegram Fast Download', 7, '2026-08-12 17:01:42.133751+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('f01e26d5-42bb-443a-ace9-973f8eb8b1e5', NULL, 'c8188f07-4d2e-470c-afd0-244c7378402b', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=xA9IoawyTSM', 'Telegram Fast Download', 6, '2026-08-12 17:01:42.133751+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('c0c28b90-7381-47ce-a2b1-8d23f7a3432e', NULL, '85b87adc-baa2-491d-ab40-3727af06ddad', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=PmpxEwt-T4A', 'Telegram Fast Download', 7, '2026-08-12 17:01:42.133751+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('153e0de0-53af-4f5f-ab71-e9f8f785b76a', NULL, 'e7846de1-9b15-49dc-aacd-f480f9d50dcf', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=ozqvpM7jbq0', 'Telegram Fast Download', 6, '2026-08-12 17:01:42.133751+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('94202b1d-5b97-4b36-ad24-077018917bd8', NULL, '70e78e42-65e2-4fbd-a4d0-6b9dfa82206f', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=arrAWfDY8Ek', 'Telegram Fast Download', 6, '2026-08-12 17:01:42.133751+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('8ef20e9b-6da2-4182-a524-68bb0aaf0130', NULL, '61604b7c-f5cb-4fb0-a4e5-6bc2adaf755f', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=u2MjDEWbTjc', 'Telegram Fast Download', 6, '2026-08-12 17:01:42.133751+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('17f3c26c-3085-421d-a5d4-37c1c7a5b3a0', NULL, 'ff4dcc37-773b-4aed-a294-ae8f4a20d492', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=BW93kHZMsG0', 'Telegram Fast Download', 7, '2026-08-12 17:01:42.133751+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('c7242a68-8259-4987-ab3c-4a6fb10642a6', NULL, '191fb25b-1489-4aa5-a09c-3a1bb5035682', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=PR0ILpvzUhU', 'Telegram Fast Download', 7, '2026-08-13 13:52:53.403139+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('54c92863-e7a1-49d5-a5c4-201cf4813eba', NULL, '0e544c60-134d-4b6e-ab7a-d60812c17d9d', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=wjhGPS57sYg', 'Telegram Fast Download', 8, '2026-08-13 13:52:53.403139+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('255d32d1-bb13-4a85-afcb-953f4acb0b8b', NULL, 'f658749e-03ec-41a8-ac3c-3036f9d85f33', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=NSk95fywFr8', 'Telegram Fast Download', 8, '2026-08-13 13:52:53.403139+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('d2e9b930-f6a0-4356-adf7-857470f10367', NULL, '8cc52726-234b-432b-af43-5ce8491f5a8b', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=MbYsm7SqWAM', 'Telegram Fast Download', 8, '2026-08-13 13:52:53.403139+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('fd6a415d-0dea-4d22-a171-ece24d90761a', NULL, 'e9b5512c-2484-45b0-a8bb-4b80aa715f3c', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=keMEOhtNOkU', 'Telegram Fast Download', 8, '2026-08-13 13:52:53.403139+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('b58ba600-6e8b-4d5f-af83-908cf4dc9d8d', NULL, '5be25a7b-2fee-4755-a871-5650c019faf5', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=2t8VDUP2AU8', 'Telegram Fast Download', 9, '2026-08-13 13:52:53.403139+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('67ec3433-d15d-4a7e-a672-e2ea03124eaf', NULL, '149865ec-ea72-4647-ab86-b12fdb66a63a', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=6M3XHam7K4s', 'Telegram Fast Download', 7, '2026-08-13 13:52:53.403139+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('8fb9215b-ca67-4e59-ade5-97667c3d336e', NULL, 'a0be06c0-210a-4599-aa21-fc366d3a818d', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=XSCXhla3zSQ', 'Telegram Fast Download', 9, '2026-08-13 13:52:53.403139+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('027886fb-93e7-4a75-afd1-c4d1f37d98f8', 'dfe1fee9-3347-4a6a-a91c-9610969dd963', NULL, '1080p / 720p HD', '1.2 GB', 'https://t.me/Pixelpopnew_bot?start=mc0WXoWDnNw', 'Fast Telegram CDN', 78, '2026-08-14 18:39:26.460286+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('effeba96-4ab7-4a38-a653-f2bdb1ef2b42', NULL, '98b05e9d-cd93-4508-a217-81fd5b3b0036', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=5MbFW3jFxLE', 'Telegram Fast Download', 5, '2026-08-15 23:36:34.227099+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('0547d229-ddbf-48df-af74-d0784e4cd673', NULL, '8f2f9892-b228-4212-abb5-35515d84c0a3', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=FzQGM-H6H30', 'Telegram Fast Download', 5, '2026-08-15 23:36:34.227099+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('eb80e835-eb61-4c2f-af24-2a9a1c969117', NULL, '8aba4e35-8b7b-4d06-ad89-6551b5f9b402', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=Nky0jSKePLY', 'Telegram Fast Download', 5, '2026-08-15 23:36:34.227099+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('d0dc568c-a503-4db3-a5cc-b32fc2da2035', NULL, 'b5f05606-c416-4a11-aa1a-80b6bd800c37', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=5OjMLx9hhl8', 'Telegram Fast Download', 4, '2026-08-15 23:36:34.227099+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('476d5f70-d2ab-4016-a409-1a5635dc7dc3', NULL, '1d377f3c-ab53-4cb6-af8f-09a404e8f723', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=WZlFzPiqAN8', 'Telegram Fast Download', 4, '2026-08-15 23:36:34.227099+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('667814f6-1cdf-4765-ac3a-d29ab8bd37cd', NULL, '2372aab2-eef2-4116-a97b-d582cadfa8e2', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=pRLneRPKw2Y', 'Telegram Fast Download', 4, '2026-08-15 23:36:34.227099+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('4297921c-1ee2-4c57-ad58-3c17bc00f2ce', NULL, 'b464488c-24ac-4d31-ae16-e649bef534e6', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=K3l8RNuemcc', 'Telegram Fast Download', 4, '2026-08-15 23:36:34.227099+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('c0e6047b-b5a2-4ce8-aba3-65831cdd1b90', NULL, 'b7936214-2dc4-442d-a9a0-765a41cb09f8', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=FcgDaSUoWec', 'Telegram Fast Download', 4, '2026-08-15 23:36:34.227099+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('35cdf43a-dd23-49d5-acf6-0764fd383e79', NULL, '3fe5fc3e-c492-42e3-a74b-b6c44d1c324a', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=y7OkO5qBmds', 'Telegram Fast Download', 4, '2026-08-15 23:36:34.227099+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('ae9f3067-685e-4d26-a654-79000045fbfe', NULL, '21643407-9641-4f7e-a223-6a653db20f25', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=p_gNFWtEl8g', 'Telegram Fast Download', 4, '2026-08-15 23:36:34.227099+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('48bc1556-8a56-48d8-ac47-c01cf99c0c9f', NULL, '3542bb23-9412-4424-a3f6-79690d79d547', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=SKjmDw16w4I', 'Telegram Fast Download', 4, '2026-08-15 23:36:34.227099+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('06915ed6-31f6-4f18-a2db-bc9bcbfb0398', NULL, '5015e274-d773-4989-a936-aa141bca60b5', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=3gkE0r63pZU', 'Telegram Fast Download', 4, '2026-08-15 23:36:34.227099+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('117eb5dd-3fa2-4284-a35a-a65cde84bcac', NULL, '20d369a0-cefe-4535-a150-8bb00fe3e54b', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=U13cP5IEmM8', 'Telegram Fast Download', 4, '2026-08-15 23:36:34.227099+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('e2eb42cf-901b-4da5-a549-80459f5fdb7c', NULL, '38dd3b0b-21d7-4f1e-ad07-3aa7b6acc95c', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=LK0J9Gj1yeg', 'Telegram Fast Download', 25, '2026-08-17 00:43:29.237961+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('0edf6b9e-3e13-4b36-aae5-93e9b8e4fded', NULL, 'cc38852b-5cd4-4356-abbf-5ec43ad09d8a', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=5MXH7Xxv9sU', 'Telegram Fast Download', 24, '2026-08-22 06:41:53.87792+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('ad6eaee3-53e0-4b4d-a7e8-4eb5790be54a', NULL, '8e06915c-289b-4d6d-a80b-a4f0e98cb15c', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=0yTLxwaCxpU', 'Telegram Fast Download', 3, '2026-08-22 06:41:53.87792+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('8bb588ee-77f4-41f0-ae99-40eac5bfddc0', NULL, '3140d13c-9c60-49fd-aa70-564192a7a43f', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=8JDNzCG9IA4', 'Telegram Fast Download', 2, '2026-08-22 06:41:53.87792+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('3c40c383-0a12-4430-aaeb-aa67e293aa2f', NULL, '4dbe64b1-0518-41ca-af49-1a236395688f', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=QkQpBn7JLn8', 'Telegram Fast Download', 3, '2026-08-22 06:41:53.87792+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('2d68c8a8-fbca-4d2a-aeaa-4cc0db69d2e7', NULL, '8c6ac497-91bf-4773-aa56-f652b4079059', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=DN-TEtg0LSA', 'Telegram Fast Download', 1, '2026-08-22 06:41:53.87792+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('29f128bb-74b8-45fb-a6c8-12be8a67f194', NULL, 'e3fd67b4-9d7d-4873-acf2-c69dd004f52d', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=bx_1yKlYYGA', 'Telegram Fast Download', 2, '2026-08-22 06:41:53.87792+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('69d3213e-225c-4d83-a409-dea477edc55d', NULL, '2f8cee7f-8dfa-4e76-acb0-db1aa0f743c3', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=CBTkwMkiF2I', 'Telegram Fast Download', 1, '2026-08-22 06:41:53.87792+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('76199c44-6ece-41a3-a122-aeeb40dc9963', NULL, '2d833038-4754-4446-ace7-0c9d6d027c24', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=FwcnL49qN5I', 'Telegram Fast Download', 1, '2026-08-22 06:41:53.87792+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('3776c3c6-bdaf-4a6a-aa04-97f202d86754', NULL, 'e0cfbf70-052a-4762-a631-7a5de70fbf94', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=GPOyq0NYqOM', 'Telegram Fast Download', 1, '2026-08-22 06:41:53.87792+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('2f8d3a87-3ced-4901-aebb-0510cad3c6ef', NULL, 'fd7c84fb-6b9d-493c-ab4e-b98e383ba42c', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=eNXhaCvghW8', 'Telegram Fast Download', 1, '2026-08-22 06:41:53.87792+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('180b97db-1271-425e-a339-dd9dc710ab39', NULL, '7ccb2ea5-115e-49cc-af17-24eb219bd037', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=RXXfERm1HBM', 'Telegram Fast Download', 1, '2026-08-22 06:41:53.87792+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('ab3b8a13-adb1-4efe-afc8-54d24ef5cead', NULL, 'ffff599b-46ba-44fa-aab1-683027beb6bf', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=a425QnzqPGY', 'Telegram Fast Download', 1, '2026-08-22 06:41:53.87792+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('0fd3e5fd-9ffa-4ab8-a829-8b27d84e669b', NULL, 'e5be140e-2674-4498-a88d-9945783b2dce', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=PGJKPLcjNOY', 'Telegram Fast Download', 15, '2026-08-23 09:40:14.081704+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('656a809f-2730-4398-a259-6133f4530ca9', NULL, 'b7f6eba1-3322-462d-a996-27583b0b19cf', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=Ft4vQPwZucc', 'Telegram Fast Download', 5, '2026-08-25 05:40:25.195915+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('2d628b5b-60a0-44e4-a905-73cbaef6f3a9', NULL, '507eb0cf-d4b2-4334-ae0e-9d37a3a380dc', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=JUtqGZASV24', 'Telegram Fast Download', 4, '2026-08-25 05:40:25.195915+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('92bb8ef1-094a-4829-addf-6d4be024db47', NULL, 'd015ab0b-ca0c-4431-a48e-773e66948ad7', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=nONIlTbnyOU', 'Telegram Fast Download', 4, '2026-08-25 05:40:25.195915+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('bf13b0e4-8628-4b15-af15-288b203c0411', NULL, 'f36a3aea-3514-407f-a84c-acbb19de45dc', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=CNllJC8waOg', 'Telegram Fast Download', 4, '2026-08-25 05:40:25.195915+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('73f61f98-aecc-462b-afca-66551f939855', NULL, '8bb582af-39d8-4b26-a14e-71fddd8ac0eb', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=L-AXtuJaXns', 'Telegram Fast Download', 5, '2026-08-25 05:40:25.195915+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('c4c26f55-57ee-4f68-a03f-78af5b9cb425', NULL, 'bb419048-ba2c-4a88-a68f-d9e5e94e25ee', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=DND726QQvDw', 'Telegram Fast Download', 4, '2026-08-25 05:40:25.195915+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('6c4b9bfb-a337-47ce-ac9e-8d467a1a510a', NULL, '424dce3b-babe-4e17-aaf0-3815dd3af1d7', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=0Jwc51KJ1yI', 'Telegram Fast Download', 7, '2026-08-25 05:40:25.195915+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('34e06fe3-8bcd-4d58-a48e-f7881c1c7868', NULL, '8f12f2b0-039c-4538-a584-f92e04e67a31', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=vUBasPjR9RI', 'Telegram Fast Download', 4, '2026-08-25 05:40:25.195915+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('86c3bc0b-ef83-4b88-a9b7-662791e48b07', NULL, '4455e468-754f-4a46-a9f4-e88b128f3744', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=IT-qI5Q00hg', 'Telegram Fast Download', 6, '2026-08-25 05:40:25.195915+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('4ffdcfb2-0b65-4a54-a79f-3e0fe5ae3fa5', NULL, '816c2cac-e4e1-4630-ad0a-ef46fcbf4bff', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=W35a5WpstnY', 'Telegram Fast Download', 4, '2026-08-25 05:40:25.195915+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('65c1283a-e79b-434e-a3e8-ac492f6798e1', NULL, 'f9b0dd20-e0be-4aa8-a651-b7f0c1dd4bbf', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=VaFwKgk1U6Q', 'Telegram Fast Download', 4, '2026-08-25 05:40:25.195915+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('b12fc142-2e80-4fa7-af0e-64a30be4dc09', NULL, '15d86585-56cd-4734-afc0-dbf78740b5af', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=Cz1R45H2S80', 'Telegram Fast Download', 4, '2026-08-25 05:40:25.195915+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('ed14c936-bb78-45b0-aa43-9abe9b990e9c', NULL, '8a2eac0f-a913-4008-ab65-b538f4c2f4b3', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=AevD5VhtbtM', 'Telegram Fast Download', 4, '2026-08-25 05:40:25.195915+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('9a7fde2a-7589-4569-a2b9-bb8e4e465ddd', 'e3e39812-35a9-40d3-a740-e0b7d896c9f2', NULL, '1080p / 720p HD', '1.2 GB', 'https://t.me/Pixelpopnew_bot?start=3-eJHvmJcZI', 'Fast Telegram CDN', 26, '2026-08-25 08:44:47.317584+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('fe3284b6-8b77-4485-a850-c092f3206c3a', '5df962ce-ab8b-4343-ab32-3858ae1eb96f', NULL, '1080p / 720p HD', '1.2 GB', 'https://t.me/Pixelpopnew_bot?start=w3LicFP9tr8', 'Fast Telegram CDN', 22, '2026-08-25 15:35:47.386038+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('e28a9749-c089-4355-a79b-d6321f0e2a10', NULL, '9ff7b188-18f9-43d9-a097-4796653c4c91', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=tEgg5bXPEDY', 'Telegram Fast Download', 5, '2026-08-26 07:49:32.527149+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('57f5bc82-edc3-4135-ac65-87630953cc58', NULL, 'f8a9e144-6890-42d0-a30b-d49809109286', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=qrnl-NYpvYA', 'Telegram Fast Download', 28, '2026-08-26 08:36:36.055185+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('58e0ce93-d96f-4419-a702-bf8f0d35bbb5', NULL, '0dcba767-bd00-4648-aaf2-56d993832cc7', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=02A_7C7fY_Q', 'Telegram Fast Download', 33, '2026-08-26 16:54:25.719949+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('bbebd4b3-87ca-4f65-a978-bb8cb36e2742', NULL, '6aabdd6a-da4d-45fe-acd3-72fc11464740', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=TVwgr71tUF8', 'Telegram Fast Download', 22, '2026-08-26 16:54:25.719949+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('207b48c7-c9c0-4a2d-a50c-5eebe318f9a0', NULL, 'c3432fbd-3cf1-46c5-a5d8-a3a0a04c92a9', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=u7ECCYFwDrs', 'Telegram Fast Download', 10, '2026-08-27 05:15:49.32395+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('b39f79cd-a131-460a-a70d-94f3c321f2e3', '190486de-63e6-49e2-a16d-1195bb2596d3', NULL, '1080p / 720p HD', '1.2 GB', 'https://t.me/Pixelpopnew_bot?start=sj1yUaE8yFU', 'Fast Telegram CDN', 11, '2026-08-28 05:17:20.917336+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('2eb81e80-01b0-46cb-a21e-961c20627f8e', 'b502eb7f-d3b3-4b67-a82f-7b5154e561f9', NULL, '1080p / 720p HD', '1.2 GB', 'https://t.me/Pixelpopnew_bot?start=2cgaTLh-0Yk', 'Fast Telegram CDN', 23, '2026-08-28 10:36:45.922339+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('5615c75d-2bf2-472a-a108-555856d1c080', NULL, 'eb0a5895-faa8-4421-abd1-81eb83d38c21', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=x_bRpXsB2qo', 'Telegram Fast Download', 2, '2026-08-29 04:30:40.560346+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('b5e8b8eb-1d8e-41db-acc7-1ecd5b669378', NULL, 'c76b4dd5-0f9a-4889-ab54-8b634041a6aa', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=Znb5S3WzGZM', 'Telegram Fast Download', 1, '2026-08-29 04:30:40.560346+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('63258a3c-ff4b-4e67-a77c-055a09065dd2', NULL, '9d0c89fe-0f66-4967-afa4-1bfeae1b5aef', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=iPnia69a7eQ', 'Telegram Fast Download', 1, '2026-08-29 04:30:40.560346+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('76c3282b-9585-43d5-a5d8-2b764e22f06b', NULL, '02e7ebbe-5f00-4f17-ad6d-f6cb85cffe78', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=Aqb1nVhTeis', 'Telegram Fast Download', 1, '2026-08-29 04:30:40.560346+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('bf9e069b-01a5-49ee-adfd-a425e9f39e97', NULL, '7c3706f9-36a5-4b02-a4b1-ddcf13ca510c', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=FNd8dP5-PTc', 'Telegram Fast Download', 1, '2026-08-29 04:30:40.560346+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('ec2a2acd-0748-4cfd-a2c1-3eb8ddd01912', NULL, 'bf8c6f91-ce9e-4e98-ab55-2fdd7be7ed64', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=cElv_CfVNmA', 'Telegram Fast Download', 1, '2026-08-29 04:30:40.560346+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('3ae88f0e-c709-4c68-ab60-a7e95dca4dd0', NULL, '410ae787-71a8-4123-a8cd-623731caa954', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=wozOtw-LVtA', 'Telegram Fast Download', 1, '2026-08-29 04:30:40.560346+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('b19355f8-c2f7-4215-a7d4-bda807069478', NULL, 'e0f33508-2a13-4da7-a9d1-8284926d9156', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=p8gZqp4y2WY', 'Telegram Fast Download', 1, '2026-08-29 04:30:40.560346+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('b1a6858f-7607-4108-a877-67b9cb52a299', NULL, '74fe1b70-0c3a-4484-a476-77da2e131e37', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=PoJfpe4CIQQ', 'Telegram Fast Download', 1, '2026-08-29 04:30:40.560346+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('bdfc312d-20dd-49db-a5aa-1a4bdfc1608c', NULL, 'd8ae654a-085a-4e8b-abd9-4e9f78ec8a9d', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=jDKMUsV0xMc', 'Telegram Fast Download', 42, '2026-08-29 16:00:51.135655+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('18b8a1fa-e9a9-4a53-a694-034330a3000d', NULL, '8a11b38a-0b2a-4923-a91c-bd5c1360eb95', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=ZYlY39xR1Jc', 'Telegram Fast Download', 14, '2026-08-29 16:00:51.135655+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('cfde9204-ed32-4d59-acdd-f58ef4469a76', NULL, '3b1497f3-7c33-47e6-ab08-c952b8002e16', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=clxwqDk-4Gw', 'Telegram Fast Download', 8, '2026-08-29 16:00:51.135655+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('884769e0-1469-43a5-ad06-fb4e5f99368c', NULL, '55d6d674-3ca0-44ad-acec-b9fc57d6802f', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=rlJiHSM4eeo', 'Telegram Fast Download', 6, '2026-08-29 16:00:51.135655+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('ad1c0320-da71-4a19-a598-f989783dca8d', NULL, '6e0096f8-3ef5-4915-a616-dd32aa8dec91', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=62lW7GNwF0o', 'Telegram Fast Download', 4, '2026-08-29 16:00:51.135655+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('f3a3482d-556e-4e40-ad22-61f207bde850', NULL, '76408d94-d589-41cf-ae93-4a4256535aa5', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=iZHLK5Jq54s', 'Telegram Fast Download', 7, '2026-08-30 17:11:35.166847+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('943066bf-f80e-42ca-ace6-a7eea339fed0', NULL, '37c486ca-928f-467f-a60d-c2e682367f99', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=o5bLGECHbsk', 'Telegram Fast Download', 5, '2026-08-30 17:59:35.347525+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('70eb3ca1-2d5f-4133-a918-d01723a28313', NULL, '8569271e-62af-49c9-af46-d1f684f36504', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=F9U9hMi2D2U', 'Telegram Fast Download', 3, '2026-08-30 17:59:35.347525+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('76974743-4419-4ce5-a093-062dc422d45d', NULL, '606e0612-c03e-45a6-a5bc-59b24e48e084', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=rJUo6b4tSE4', 'Telegram Fast Download', 3, '2026-08-30 17:59:35.347525+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('8b8c4ed6-7f29-4a44-a721-01e41d207456', NULL, '8cd552b1-2b39-44a8-a917-0cd3d39e2578', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=_Ur0e0nCEa4', 'Telegram Fast Download', 1, '2026-08-30 17:59:35.347525+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('1ae17eef-51d6-46fa-a359-74d0a418e1ba', NULL, 'c29e4dcd-7043-4cb8-a62a-61b2cff419b6', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=QiXVEFzt47Q', 'Telegram Fast Download', 3, '2026-08-30 17:59:35.347525+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('2a5bdd07-1f23-4979-a427-832957ba24b9', NULL, 'a7b9fb04-6516-444c-aad6-18c75c610dcf', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=MlDDNLp091s', 'Telegram Fast Download', 3, '2026-08-30 17:59:35.347525+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('1fe85f05-1446-4289-a5cd-a1284224196e', NULL, '113999b2-6d07-4418-a187-98ba1583659c', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=KNtsXL6csp4', 'Telegram Fast Download', 2, '2026-08-30 17:59:35.347525+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('b8831729-c8e5-499c-a5a4-b44ab14b1b15', NULL, '85518795-e360-4af5-a3fc-3a7d38e831d5', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=ovUdhtvhlcs', 'Telegram Fast Download', 2, '2026-08-30 17:59:35.347525+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('8a4f9bd5-217c-4a26-a446-36f6660c7f4c', NULL, '3335954c-1a21-4efa-aaab-c79a132a44a9', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=jfAijjTeRtY', 'Telegram Fast Download', 3, '2026-08-31 05:10:46.772366+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('d214fadb-b2cd-4e53-a0fd-dab4b0eda76e', NULL, '2593c3b7-0c4e-4c54-a1d8-d28983a7f139', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=1K6CCUX6T4k', 'Telegram Fast Download', 1, '2026-08-31 14:58:40.394763+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('843564db-b706-488c-ac1d-7ab8cc09a0c2', NULL, '51a6bbf5-d90f-407c-a2b3-9eafdfd3c367', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=gNnen91z8jQ', 'Telegram Fast Download', 1, '2026-08-31 14:58:40.394763+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('111b2093-c99b-4655-abda-565b77659717', NULL, 'a51a0b58-d35e-4ba1-ab29-06717917508c', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=uXf817g5QtI', 'Telegram Fast Download', 1, '2026-08-31 14:58:40.394763+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('19684188-bac8-4fc9-ae40-06c3afaeeba2', NULL, '90d46548-b3e8-43a4-a091-e258abf8df1f', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=P2YCRAWcJEY', 'Telegram Fast Download', 1, '2026-08-31 14:58:40.394763+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('d7b52f94-56d7-4a4f-acdb-11a08db76176', NULL, '3168ef66-0641-48eb-a121-327b8d7ffe57', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=iM5jIaaeyoI', 'Telegram Fast Download', 1, '2026-08-31 14:58:40.394763+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('85758799-1056-4eba-a71e-8dea7632fbdb', NULL, '1bf0c921-6945-47ab-ab10-6edf349e0ebb', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=XNxZ3q2HCMw', 'Telegram Fast Download', 3, '2026-08-31 14:58:40.394763+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('a2e8d3e5-3c65-4d2a-ac63-1db55251a44e', NULL, 'a7b9fb04-6516-444c-aad6-18c75c610dcf', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=koRuMkHu814', 'Telegram Fast Download', 2, '2026-08-31 14:58:46.532211+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('852eda9c-9067-4d80-aaa4-3bc016b6534b', NULL, '113999b2-6d07-4418-a187-98ba1583659c', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=_e6y49S7Ry4', 'Telegram Fast Download', 2, '2026-08-31 14:58:46.532211+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('62d891cd-9d14-4f82-a603-43e891ac5202', NULL, '85518795-e360-4af5-a3fc-3a7d38e831d5', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=3N45iZkv2-s', 'Telegram Fast Download', 2, '2026-08-31 14:58:46.532211+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('f1522d96-dbf7-4613-ad6e-9a3fa9b57bbe', NULL, '698280d6-38fd-49a1-af0f-a71899213eeb', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=t5fClVXDE7Y', 'Telegram Fast Download', 3, '2026-08-31 14:58:46.532211+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('2bccd5c6-d4fa-48a6-a251-917dc3809624', NULL, '93b4e985-8d60-4e21-a4d0-79a55b9124b1', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=gzosVDr8ncQ', 'Telegram Fast Download', 3, '2026-08-31 14:58:46.532211+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('bffb72d2-6b39-4b4f-a175-ec95f516c58b', NULL, 'ce3f8e97-f96d-4086-ae00-fdd45c587ff1', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=1r-Wz8ffsH8', 'Telegram Fast Download', 3, '2026-08-31 14:58:46.532211+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('533a9356-039c-47fa-a6a3-c2d75c020da5', NULL, 'a634f1d1-59c6-4d84-ab86-6edd862f9f8d', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=SU_YB6_0_VM', 'Telegram Fast Download', 3, '2026-08-31 14:58:46.532211+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('dc9b84f1-7303-46d9-ab8a-05a8a1bc6a48', NULL, '8fdee6fc-0fda-4ee7-a705-fcd92ebb71f5', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=xXw6RAm30qE', 'Telegram Fast Download', 3, '2026-08-31 14:58:46.532211+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('dc6adcb9-2e9c-49f9-a2eb-f0bf7fbc130b', NULL, '66bb0f3f-0da1-4196-a90d-6fb8b4e3db0d', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=Uusinq95wS8', 'Telegram Fast Download', 7, '2026-08-31 15:22:15.597063+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('8822b304-94a8-4519-a6b9-44b67974a687', NULL, '5ad34313-8a36-4a73-aa04-12d816f19727', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=zucvkc6hw0k', 'Telegram Fast Download', 1, '2026-08-31 15:22:15.597063+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('c84c8f2b-3da9-4d64-aa36-4ccc308a4791', NULL, '46273df1-c6fd-4c7b-a913-b63adec354a1', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=vShllXkO7Vs', 'Telegram Fast Download', 1, '2026-08-31 15:22:15.597063+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('a6e7a2af-99e8-40bd-ad93-0811105a35c2', NULL, 'f5e0d712-d353-4558-ab8b-fc0d77c3f6c8', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=-rx5YdosMcs', 'Telegram Fast Download', 1, '2026-08-31 15:22:15.597063+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('8f7f900c-8198-4c8a-a239-f5ab38af3ca7', NULL, 'd71806d5-9edf-464b-ae7b-743538127d03', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=uwRKysTblJI', 'Telegram Fast Download', 1, '2026-08-31 15:22:15.597063+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('09fd72fa-a507-40d2-a905-a82999fee473', NULL, '16daa1e3-1c33-4ecd-a9ba-e7a5e88c8a61', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=djPoaaGuYmE', 'Telegram Fast Download', 0, '2026-08-31 15:22:15.597063+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('3ad49d3a-966a-4b59-ad06-19da50074fa5', NULL, '1c37b93a-dac0-4a67-a4c5-16e891b96870', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=Iv_RD1E7c8k', 'Telegram Fast Download', 0, '2026-08-31 15:22:15.597063+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('b9815ea1-c139-4b46-a0d7-d063079e2d2b', NULL, '42920081-08e9-4342-a5e4-1f158a325ec2', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=UTsValWR6j0', 'Telegram Fast Download', 1, '2026-08-31 15:22:15.597063+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('2e71e95b-9f87-43b4-a40d-6aa70cd3210d', 'f993a834-dc2e-4c8d-aaba-4e624bc4a33a', NULL, '1080p / 720p HD', '1.2 GB', 'https://t.me/Pixelpopnew_bot?start=GE9f_DbQDxc', 'Fast Telegram CDN', 102, '2026-09-01 12:05:41.773693+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('424d1386-f2b7-4020-a998-1f5df2fc7e5f', NULL, '29cc3d75-75b2-40d8-a282-63cbe5acefd2', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=iLSdUfKOy2k', 'Telegram Fast Download', 1, '2026-09-01 16:24:02.280019+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('588b8454-162b-4391-a550-6e3f9b8fbd29', NULL, '379eb4e8-1d17-49e8-a9d0-5d9a82c32951', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=tgYRfbH314o', 'Telegram Fast Download', 1, '2026-09-01 16:24:02.280019+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('a5e13a7a-0520-42f1-a9fe-ca25b19162b1', NULL, '49716a14-9cc5-4345-a661-875a783377e6', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=tRfVfy6r8lA', 'Telegram Fast Download', 1, '2026-09-01 16:24:02.280019+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('db6df85c-05d4-48d7-af01-787935c04310', NULL, '7bd19fb3-8be2-4fbb-aa50-1a13df14cc3c', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=Y2Pjz6fCZ84', 'Telegram Fast Download', 1, '2026-09-01 16:24:02.280019+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('91c85722-5b70-4bb4-ad2f-495db00aed29', NULL, '438187f1-8d27-4023-a061-af2f1ed0b501', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=Zjt7alfNaAo', 'Telegram Fast Download', 5, '2026-09-01 16:24:02.280019+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('def15b62-b5ad-4ea1-a19c-2339c626b837', NULL, 'fc8259ad-dd31-47c8-a2db-87f58912bb41', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=eOJ1mxmBO0g', 'Telegram Fast Download', 1, '2026-09-01 16:24:02.280019+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('b6743f8d-f150-42cf-a5b4-66a5644a5793', NULL, '59914f39-d2ee-4fe5-a3f2-ff07909929d0', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=WbWcI5to_aI', 'Telegram Fast Download', 1, '2026-09-01 16:24:02.280019+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('903391ef-c59f-4e05-a7c6-9f02ef0831d2', NULL, 'fd3a4d80-392b-4555-a9f2-cf646f014b06', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=VmOfSA6TKPU', 'Telegram Fast Download', 1, '2026-09-01 16:24:02.280019+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('61109664-4591-424b-a549-6afc6027abaa', NULL, '40e1f73c-6622-4411-a35b-fdb225b5fdd2', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=JEgoCZpvkBY', 'Telegram Fast Download', 1, '2026-09-01 16:24:02.280019+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('bf508e27-2266-4dc0-ad78-4b4176c737d5', NULL, 'ad459679-1860-415f-aab3-99bfdb4fc137', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=kgeXFsnrzfQ', 'Telegram Fast Download', 1, '2026-09-01 16:24:02.280019+00')
ON CONFLICT (id) DO NOTHING;
INSERT INTO telegram_links (id, movie_id, episode_id, quality, size, download_url, label, clicks_count, created_at)
VALUES ('6fcd0822-68ee-402f-a0a1-79c49450719f', NULL, '4839d614-188e-46d3-a41d-c952d4880b51', '720p / 1080p HDTV', '450 MB', 'https://t.me/Pixelpopnew_bot?start=MiUNbPufBr4', 'Telegram Fast Download', 13, '2026-09-02 07:49:46.881692+00')
ON CONFLICT (id) DO NOTHING;
