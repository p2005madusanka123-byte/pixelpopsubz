'use client';

import { useState, useEffect, useRef } from 'react';
import { useRouter } from 'next/navigation';
import {
  Film,
  Tv,
  PlusCircle,
  Download,
  Trash2,
  Loader2,
  RefreshCw,
  BarChart3,
  TrendingUp,
  Send,
  Search,
  ExternalLink,
  Layers,
  Sparkles,
  CheckCircle2,
  FileSpreadsheet,
  Bot,
  Edit3,
  X,
  Upload,
  MessageSquare,
  Eye,
  ListOrdered,
  Plus,
  ChevronDown,
  ChevronRight,
} from 'lucide-react';
import Link from 'next/link';

interface Movie {
  id: string;
  title: string;
  originalTitle?: string | null;
  type: string;
  description?: string | null;
  releaseDate: string | null;
  posterPath?: string | null;
  backdropPath?: string | null;
  tmdbId: string | null;
}

interface TopContentItem {
  id: string;
  title: string;
  type: string;
  releaseDate?: string | null;
  posterPath?: string | null;
  subtitlesCount: number;
  totalSubDownloads: number;
  telegramLinksCount: number;
  totalTelegramClicks: number;
  totalEngagement: number;
}

interface AnalyticsData {
  totalMovies: number;
  totalTvSeries: number;
  totalSubtitles: number;
  totalSubtitleDownloads: number;
  totalTelegramLinks: number;
  totalTelegramClicks: number;
  topContent: TopContentItem[];
}

interface AdminPanelProps {
  movies: Movie[];
  analytics?: AnalyticsData;
}

export default function AdminPanel({ movies: initialMovies, analytics }: AdminPanelProps) {
  const router = useRouter();
  const [movies, setMovies] = useState<Movie[]>(initialMovies);
  const [activeTab, setActiveTab] = useState<
    'analytics' | 'unified' | 'movie' | 'subtitle' | 'telegram' | 'csv' | 'bot' | 'manage' | 'requests' | 'seasons'
  >('unified');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState<string | null>(null);

  // Unified Single-Page Publisher states
  const [uniType, setUniType] = useState<'MOVIE' | 'TV_SHOW'>('MOVIE');
  const [uniUseTmdb, setUniUseTmdb] = useState(true);
  const [uniTmdbId, setUniTmdbId] = useState('');
  const [uniTitle, setUniTitle] = useState('');
  const [uniDescription, setUniDescription] = useState('');
  const [uniReleaseDate, setUniReleaseDate] = useState('');
  const [uniPosterPath, setUniPosterPath] = useState('');
  const [uniBackdropPath, setUniBackdropPath] = useState('');
  const [uniGenres, setUniGenres] = useState('');
  const [uniImdbRating, setUniImdbRating] = useState('');
  // TV details
  const [uniSeasonNum, setUniSeasonNum] = useState('1');
  const [uniEpisodeNum, setUniEpisodeNum] = useState('1');
  const [uniEpisodeTitle, setUniEpisodeTitle] = useState('');
  const [uniEpisodeDesc, setUniEpisodeDesc] = useState('');
  // Subtitle & Telegram
  const [uniSubFileName, setUniSubFileName] = useState('');
  const [uniSubFileUrl, setUniSubFileUrl] = useState('');
  const [uniTgUrl, setUniTgUrl] = useState('');
  const [uniTgLabel, setUniTgLabel] = useState('');

  // Sync / Add Movie states
  const [isManualCreate, setIsManualCreate] = useState(false);
  const [tmdbId, setTmdbId] = useState('');
  const [type, setType] = useState('MOVIE');
  const [manualTitle, setManualTitle] = useState('');
  const [manualOriginalTitle, setManualOriginalTitle] = useState('');
  const [manualDescription, setManualDescription] = useState('');
  const [manualReleaseDate, setManualReleaseDate] = useState('');
  const [manualPosterPath, setManualPosterPath] = useState('');
  const [manualBackdropPath, setManualBackdropPath] = useState('');

  // Subtitle states
  const [selectedMovieId, setSelectedMovieId] = useState(initialMovies[0]?.id || '');
  const [subLanguage, setSubLanguage] = useState('Sinhala');
  const [subFileName, setSubFileName] = useState('');
  const [subFileUrl, setSubFileUrl] = useState('');

  // Telegram Link states
  const [telQuality, setTelQuality] = useState('1080p Full HD');
  const [telSize, setTelSize] = useState('');
  const [telDownloadUrl, setTelDownloadUrl] = useState('');

  // CSV Import states
  const [csvFile, setCsvFile] = useState<File | null>(null);
  const [parsedCsvRows, setParsedCsvRows] = useState<any[]>([]);
  const [csvImportResults, setCsvImportResults] = useState<{ success: number; failed: number; errors: string[] } | null>(null);
  const fileInputRef = useRef<HTMLInputElement>(null);

  // Telegram Bot Publisher states
  const [botToken, setBotToken] = useState('');
  const [botChatId, setBotChatId] = useState('@PixelSubzLk');
  const [botSelectedMovieId, setBotSelectedMovieId] = useState(initialMovies[0]?.id || '');
  const [botCustomMessage, setBotCustomMessage] = useState('');
  const [botPublishSuccessUrl, setBotPublishSuccessUrl] = useState<string | null>(null);

  // Edit Movie Modal states
  const [editingMovie, setEditingMovie] = useState<Movie | null>(null);
  const [editTitle, setEditTitle] = useState('');
  const [editOriginalTitle, setEditOriginalTitle] = useState('');
  const [editType, setEditType] = useState('MOVIE');
  const [editDescription, setEditDescription] = useState('');
  const [editReleaseDate, setEditReleaseDate] = useState('');
  const [editPosterPath, setEditPosterPath] = useState('');
  const [editBackdropPath, setEditBackdropPath] = useState('');
  const [editTmdbId, setEditTmdbId] = useState('');

  // Analytics filter state
  const [analyticsFilter, setAnalyticsFilter] = useState<'ALL' | 'MOVIE' | 'TV_SHOW'>('ALL');
  const [analyticsSearch, setAnalyticsSearch] = useState('');

  // Manage Catalog Search
  const [catalogSearch, setCatalogSearch] = useState('');

  // Requests state
  const [requestsList, setRequestsList] = useState<any[]>([]);
  const [loadingRequests, setLoadingRequests] = useState(false);

  // Season / Episode Manager state
  const [seasonMovieId, setSeasonMovieId] = useState(initialMovies.find(m => m.type === 'TV_SHOW')?.id || initialMovies[0]?.id || '');
  const [seasonsList, setSeasonsList] = useState<any[]>([]);
  const [loadingSeasons, setLoadingSeasons] = useState(false);
  const [expandedSeason, setExpandedSeason] = useState<string | null>(null);

  // Add Season form
  const [newSeasonNum, setNewSeasonNum] = useState('');
  const [newSeasonTitle, setNewSeasonTitle] = useState('');
  const [newSeasonDate, setNewSeasonDate] = useState('');
  const [newSeasonEpCount, setNewSeasonEpCount] = useState('');

  // Add Episode form
  const [addEpSeasonId, setAddEpSeasonId] = useState('');
  const [epNum, setEpNum] = useState('');
  const [epTitle, setEpTitle] = useState('');
  const [epDesc, setEpDesc] = useState('');
  const [epAirDate, setEpAirDate] = useState('');
  const [epRuntime, setEpRuntime] = useState('');
  const [epImdbRating, setEpImdbRating] = useState('');
  const [epSubFileName, setEpSubFileName] = useState('');
  const [epSubFileUrl, setEpSubFileUrl] = useState('');
  const [epTgQuality, setEpTgQuality] = useState('1080p Full HD');
  const [epTgSize, setEpTgSize] = useState('');
  const [epTgUrl, setEpTgUrl] = useState('');
  const [epTgLabel, setEpTgLabel] = useState('x265');

  useEffect(() => {
    // Load saved Telegram Bot token from localStorage for convenience
    const savedToken = localStorage.getItem('ps_tg_bot_token');
    const savedChatId = localStorage.getItem('ps_tg_chat_id');
    if (savedToken) setBotToken(savedToken);
    if (savedChatId) setBotChatId(savedChatId);
  }, []);

  const resetMessages = () => {
    setError(null);
    setSuccess(null);
    setCsvImportResults(null);
    setBotPublishSuccessUrl(null);
  };

  // ==============================================================================
  // HANDLER: Unified One-Page Publisher (Movie or Episode + Subtitle + Telegram)
  // ==============================================================================
  const handleUnifiedCreate = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!uniSubFileUrl.trim() && !uniTgUrl.trim()) {
      setError('Please provide at least a Subtitle URL or a Telegram Link URL.');
      return;
    }
    setLoading(true);
    resetMessages();
    try {
      const res = await fetch('/api/admin/quick-create', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          type: uniType,
          useTmdb: uniUseTmdb,
          tmdbId: uniTmdbId.trim() || null,
          title: uniTitle.trim() || null,
          description: uniDescription.trim() || null,
          releaseDate: uniReleaseDate.trim() || null,
          posterPath: uniPosterPath.trim() || null,
          backdropPath: uniBackdropPath.trim() || null,
          genres: uniGenres.trim() || null,
          imdbRating: uniImdbRating.trim() || null,
          seasonNumber: uniType === 'TV_SHOW' ? parseInt(uniSeasonNum) || 1 : null,
          episodeNumber: uniType === 'TV_SHOW' ? parseInt(uniEpisodeNum) || 1 : null,
          episodeTitle: uniEpisodeTitle.trim() || null,
          episodeDescription: uniEpisodeDesc.trim() || null,
          subFileName: uniSubFileName.trim() || null,
          subFileUrl: uniSubFileUrl.trim() || null,
          telegramUrl: uniTgUrl.trim() || null,
          telegramLabel: uniTgLabel.trim() || null,
        }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || 'Failed to publish');
      setSuccess(data.message || 'Successfully published!');
      // Reset all unified form fields
      setUniTmdbId(''); setUniTitle(''); setUniDescription('');
      setUniReleaseDate(''); setUniPosterPath(''); setUniBackdropPath('');
      setUniGenres(''); setUniImdbRating('');
      setUniSeasonNum('1'); setUniEpisodeNum('1');
      setUniEpisodeTitle(''); setUniEpisodeDesc('');
      setUniSubFileName(''); setUniSubFileUrl('');
      setUniTgUrl(''); setUniTgLabel('');
      router.refresh();
    } catch (err: any) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  // ==============================================================================
  // HANDLER: Add Movie / TV Series (TMDB or Manual)
  // ==============================================================================
  const handleAddMovie = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    resetMessages();

    try {
      let payload: any = { type };
      if (isManualCreate) {
        payload.manual = true;
        payload.title = manualTitle.trim();
        payload.originalTitle = manualOriginalTitle.trim();
        payload.description = manualDescription.trim();
        payload.releaseDate = manualReleaseDate.trim();
        payload.posterPath = manualPosterPath.trim();
        payload.backdropPath = manualBackdropPath.trim();
        payload.tmdbId = tmdbId.trim() || null;
      } else {
        if (!tmdbId.trim()) throw new Error('TMDB ID is required.');
        payload.tmdbId = tmdbId.trim();
      }

      const res = await fetch('/api/admin/movies', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || 'Failed to add title');

      setSuccess(`"${data.movie.title}" successfully added to database!`);
      setTmdbId('');
      setManualTitle('');
      setManualOriginalTitle('');
      setManualDescription('');
      setManualPosterPath('');
      setManualBackdropPath('');
      setManualReleaseDate('');
      router.refresh();
    } catch (err: any) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  // ==============================================================================
  // HANDLER: Edit Movie / TV Series
  // ==============================================================================
  const openEditModal = (movie: Movie) => {
    setEditingMovie(movie);
    setEditTitle(movie.title || '');
    setEditOriginalTitle(movie.originalTitle || '');
    setEditType(movie.type || 'MOVIE');
    setEditDescription(movie.description || '');
    setEditReleaseDate(movie.releaseDate || '');
    setEditPosterPath(movie.posterPath || '');
    setEditBackdropPath(movie.backdropPath || '');
    setEditTmdbId(movie.tmdbId || '');
  };

  const handleUpdateMovie = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!editingMovie) return;
    setLoading(true);
    resetMessages();

    try {
      const res = await fetch('/api/admin/movies', {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          id: editingMovie.id,
          title: editTitle.trim(),
          originalTitle: editOriginalTitle.trim() || null,
          type: editType,
          description: editDescription.trim() || null,
          releaseDate: editReleaseDate.trim() || null,
          posterPath: editPosterPath.trim() || null,
          backdropPath: editBackdropPath.trim() || null,
          tmdbId: editTmdbId.trim() || null,
        }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || 'Failed to update title');

      setSuccess(`"${data.movie.title}" updated successfully!`);
      setEditingMovie(null);
      router.refresh();
    } catch (err: any) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  // ==============================================================================
  // HANDLER: Add Subtitle
  // ==============================================================================
  const handleAddSubtitle = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!selectedMovieId || !subFileName.trim() || !subFileUrl.trim()) return;

    setLoading(true);
    resetMessages();

    try {
      const res = await fetch('/api/admin/subtitles', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          movieId: selectedMovieId,
          language: subLanguage,
          fileName: subFileName.trim(),
          fileUrl: subFileUrl.trim(),
        }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || 'Failed to add subtitle');

      setSuccess('Subtitle uploaded and published successfully!');
      setSubFileName('');
      setSubFileUrl('');
      router.refresh();
    } catch (err: any) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  // ==============================================================================
  // HANDLER: Add Telegram Link
  // ==============================================================================
  const handleAddTelegram = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!selectedMovieId || !telDownloadUrl.trim()) return;

    setLoading(true);
    resetMessages();

    try {
      const res = await fetch('/api/admin/telegram-links', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          movieId: selectedMovieId,
          quality: telQuality,
          size: telSize.trim() || null,
          downloadUrl: telDownloadUrl.trim(),
        }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || 'Failed to add Telegram link');

      setSuccess('Telegram download link added successfully!');
      setTelSize('');
      setTelDownloadUrl('');
      router.refresh();
    } catch (err: any) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  // ==============================================================================
  // HANDLER: Delete Movie
  // ==============================================================================
  const handleDeleteMovie = async (id: string, title: string) => {
    if (!confirm(`Are you sure you want to delete "${title}"? This will delete all its subtitles and links.`)) return;

    setLoading(true);
    resetMessages();

    try {
      const res = await fetch(`/api/admin/movies?id=${id}`, { method: 'DELETE' });
      if (!res.ok) throw new Error('Failed to delete movie');

      setSuccess(`"${title}" deleted successfully.`);
      router.refresh();
    } catch (err: any) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  // ==============================================================================
  // HANDLER: CSV File Parsing & Bulk Upload
  // ==============================================================================
  const handleCsvFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;
    setCsvFile(file);
    resetMessages();

    const reader = new FileReader();
    reader.onload = (event) => {
      const text = event.target?.result as string;
      if (!text) return;

      const lines = text.split(/\r\n|\n/).filter(line => line.trim());
      if (lines.length <= 1) {
        setError('CSV file is empty or missing headers.');
        return;
      }

      // Parse headers
      const headers = lines[0].split(',').map(h => h.trim().replace(/^["']|["']$/g, ''));
      const parsed = [];

      for (let i = 1; i < lines.length; i++) {
        const line = lines[i];
        // Handle basic comma separation
        const values = line.split(',').map(v => v.trim().replace(/^["']|["']$/g, ''));
        if (values.length >= 1 && values[0]) {
          const rowObj: any = {};
          headers.forEach((header, index) => {
            rowObj[header] = values[index] || '';
          });
          parsed.push(rowObj);
        }
      }

      setParsedCsvRows(parsed);
    };
    reader.readAsText(file);
  };

  const handleBulkImportSubmit = async () => {
    if (parsedCsvRows.length === 0) return;
    setLoading(true);
    resetMessages();

    try {
      const res = await fetch('/api/admin/bulk-import', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ rows: parsedCsvRows }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || 'Failed to import CSV data');

      setCsvImportResults({
        success: data.successCount,
        failed: data.failedCount,
        errors: data.errors || [],
      });
      setParsedCsvRows([]);
      setCsvFile(null);
      if (fileInputRef.current) fileInputRef.current.value = '';
      router.refresh();
    } catch (err: any) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  const downloadSampleCsv = () => {
    const csvContent = `title,originalTitle,type,description,releaseDate,posterPath,backdropPath,tmdbId
Avatar: The Way of Water,Avatar 2,MOVIE,"Set more than a decade after the events of the first film.",2022-12-16,https://image.tmdb.org/t/p/w500/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg,https://image.tmdb.org/t/p/original/s16H6tpK2utvwDtzZIMQn06qjwN.jpg,76600
House of the Dragon,House of the Dragon,TV_SHOW,"The Targaryen dynasty is at the absolute apex of its power.",2022-08-21,https://image.tmdb.org/t/p/w500/t9Xke5724fqW02636TyV6ZULgJR.jpg,https://image.tmdb.org/t/p/original/etj5CuMuam3hD6MfP2bgNp9Whmv.jpg,94997`;

    const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
    const url = URL.createObjectURL(blob);
    const link = document.createElement('a');
    link.href = url;
    link.setAttribute('download', 'pixelsubz_movies_template.csv');
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
  };

  // ==============================================================================
  // HANDLER: Telegram Bot Channel Publisher
  // ==============================================================================
  const handlePublishToTelegram = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!botSelectedMovieId) return;

    setLoading(true);
    resetMessages();

    // Save tokens in localStorage
    if (botToken) localStorage.setItem('ps_tg_bot_token', botToken.trim());
    if (botChatId) localStorage.setItem('ps_tg_chat_id', botChatId.trim());

    try {
      const res = await fetch('/api/admin/telegram-publish', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          movieId: botSelectedMovieId,
          botToken: botToken.trim(),
          chatId: botChatId.trim(),
          customMessage: botCustomMessage.trim() || undefined,
        }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || 'Failed to publish to Telegram');

      setSuccess('Successfully published post to Telegram channel! 🎉');
      if (data.postUrl) setBotPublishSuccessUrl(data.postUrl);
      setBotCustomMessage('');
    } catch (err: any) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  // ==============================================================================
  // HANDLER: Requests Management
  // ==============================================================================
  const fetchRequests = async () => {
    setLoadingRequests(true);
    try {
      const res = await fetch('/api/admin/requests');
      if (res.ok) {
        const data = await res.json();
        setRequestsList(data.requests || []);
      }
    } catch {}
    setLoadingRequests(false);
  };

  const handleUpdateRequestStatus = async (id: string, newStatus: string) => {
    try {
      const res = await fetch('/api/admin/requests', {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ id, status: newStatus }),
      });
      if (res.ok) {
        setRequestsList(prev => prev.map(r => r.id === id ? { ...r, status: newStatus } : r));
        setSuccess('Request status updated!');
      }
    } catch (err: any) {
      setError(err.message);
    }
  };

  // ==============================================================================
  // HANDLER: Season / Episode Manager
  // ==============================================================================
  const fetchSeasons = async (movieId: string) => {
    if (!movieId) return;
    setLoadingSeasons(true);
    try {
      const res = await fetch(`/api/admin/seasons?movieId=${movieId}`);
      if (res.ok) {
        const data = await res.json();
        setSeasonsList(data.seasons || []);
      }
    } catch {}
    setLoadingSeasons(false);
  };

  const handleAddSeason = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!seasonMovieId || !newSeasonNum) return;
    setLoading(true);
    resetMessages();
    try {
      const res = await fetch('/api/admin/seasons', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          movieId: seasonMovieId,
          seasonNumber: parseInt(newSeasonNum),
          title: newSeasonTitle.trim() || `Season ${newSeasonNum}`,
          releaseDate: newSeasonDate.trim() || null,
          episodeCount: newSeasonEpCount ? parseInt(newSeasonEpCount) : null,
        }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || 'Failed to save season');
      setSuccess(`Season ${newSeasonNum} saved!`);
      setNewSeasonNum(''); setNewSeasonTitle(''); setNewSeasonDate(''); setNewSeasonEpCount('');
      fetchSeasons(seasonMovieId);
    } catch (err: any) { setError(err.message); }
    finally { setLoading(false); }
  };

  const handleAddEpisode = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!addEpSeasonId || !epNum) return;
    setLoading(true);
    resetMessages();
    try {
      const res = await fetch('/api/admin/episodes', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          seasonId: addEpSeasonId,
          episodeNumber: parseInt(epNum),
          title: epTitle.trim() || null,
          description: epDesc.trim() || null,
          airDate: epAirDate.trim() || null,
          runtime: epRuntime ? parseInt(epRuntime) : null,
          imdbRating: epImdbRating ? parseFloat(epImdbRating) : null,
          subFileName: epSubFileName.trim() || null,
          subFileUrl: epSubFileUrl.trim() || null,
          telegramLinks: epTgUrl.trim() ? [{ quality: epTgQuality, size: epTgSize || null, downloadUrl: epTgUrl.trim(), label: epTgLabel || null }] : [],
        }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || 'Failed to save episode');
      setSuccess(`Episode ${epNum} saved!`);
      setEpNum(''); setEpTitle(''); setEpDesc(''); setEpAirDate(''); setEpRuntime('');
      setEpImdbRating(''); setEpSubFileName(''); setEpSubFileUrl(''); setEpTgUrl('');
      fetchSeasons(seasonMovieId);
    } catch (err: any) { setError(err.message); }
    finally { setLoading(false); }
  };

  const handleDeleteSeason = async (id: string) => {
    if (!confirm('Delete this season and all its episodes?')) return;
    try {
      await fetch(`/api/admin/seasons?id=${id}`, { method: 'DELETE' });
      setSuccess('Season deleted.'); fetchSeasons(seasonMovieId);
    } catch (err: any) { setError(err.message); }
  };

  const handleDeleteEpisode = async (id: string) => {
    if (!confirm('Delete this episode?')) return;
    try {
      await fetch(`/api/admin/episodes?id=${id}`, { method: 'DELETE' });
      setSuccess('Episode deleted.'); fetchSeasons(seasonMovieId);
    } catch (err: any) { setError(err.message); }
  };

  const selectedBotMovie = initialMovies.find(m => m.id === botSelectedMovieId);

  // Filtered analytics content
  const filteredTopContent = (analytics?.topContent || []).filter(item => {
    let matchesType = true;
    if (analyticsFilter !== 'ALL') {
      matchesType = item.type === analyticsFilter;
    }
    let matchesSearch = true;
    if (analyticsSearch.trim()) {
      matchesSearch = item.title.toLowerCase().includes(analyticsSearch.toLowerCase());
    }
    return matchesType && matchesSearch;
  });

  const maxEngagement = Math.max(...(analytics?.topContent?.map(i => i.totalEngagement) || [1]), 1);

  // Filtered Catalog
  const filteredCatalog = initialMovies.filter(m =>
    !catalogSearch.trim() || m.title.toLowerCase().includes(catalogSearch.toLowerCase())
  );

  return (
    <div className="space-y-6">

      {/* Modern Navigation Tabs */}
      <div className="flex flex-wrap gap-2 border-b pb-4" style={{ borderColor: 'var(--color-border)' }}>
        <button
          onClick={() => { setActiveTab('analytics'); resetMessages(); }}
          className={`flex items-center gap-2 px-3.5 py-2 rounded-xl font-bold text-xs sm:text-sm transition-all ${
            activeTab === 'analytics' ? 'bg-[#E50914] text-white shadow-lg shadow-red-900/30' : 'hover:bg-neutral-800/40'
          }`}
          style={{
            background: activeTab === 'analytics' ? '#E50914' : 'var(--color-bg-card)',
            border: activeTab === 'analytics' ? 'none' : '1px solid var(--color-border)',
            color: activeTab === 'analytics' ? '#ffffff' : 'var(--color-text)',
          }}
        >
          <BarChart3 className="h-4 w-4" />
          <span>Analytics &amp; Stats</span>
        </button>

        <button
          onClick={() => { setActiveTab('unified'); resetMessages(); }}
          className={`flex items-center gap-2 px-3.5 py-2 rounded-xl font-bold text-xs sm:text-sm transition-all ${
            activeTab === 'unified' ? 'bg-[#E50914] text-white shadow-lg shadow-red-900/30' : 'hover:bg-neutral-800/40'
          }`}
          style={{
            background: activeTab === 'unified' ? '#E50914' : 'var(--color-bg-card)',
            border: activeTab === 'unified' ? 'none' : '1px solid var(--color-border)',
            color: activeTab === 'unified' ? '#ffffff' : 'var(--color-text)',
          }}
        >
          <Sparkles className="h-4 w-4 text-yellow-400" />
          <span>🚀 Quick Publish</span>
        </button>

        <button
          onClick={() => { setActiveTab('movie'); resetMessages(); }}
          className={`flex items-center gap-2 px-3.5 py-2 rounded-xl font-bold text-xs sm:text-sm transition-all ${
            activeTab === 'movie' ? 'bg-[#E50914] text-white shadow-lg shadow-red-900/30' : 'hover:bg-neutral-800/40'
          }`}
          style={{
            background: activeTab === 'movie' ? '#E50914' : 'var(--color-bg-card)',
            border: activeTab === 'movie' ? 'none' : '1px solid var(--color-border)',
            color: activeTab === 'movie' ? '#ffffff' : 'var(--color-text)',
          }}
        >
          <PlusCircle className="h-4 w-4" />
          <span>Add / Sync Title</span>
        </button>

        <button
          onClick={() => { setActiveTab('csv'); resetMessages(); }}
          className={`flex items-center gap-2 px-3.5 py-2 rounded-xl font-bold text-xs sm:text-sm transition-all ${
            activeTab === 'csv' ? 'bg-[#E50914] text-white shadow-lg shadow-red-900/30' : 'hover:bg-neutral-800/40'
          }`}
          style={{
            background: activeTab === 'csv' ? '#E50914' : 'var(--color-bg-card)',
            border: activeTab === 'csv' ? 'none' : '1px solid var(--color-border)',
            color: activeTab === 'csv' ? '#ffffff' : 'var(--color-text)',
          }}
        >
          <FileSpreadsheet className="h-4 w-4 text-emerald-400" />
          <span>CSV Bulk Upload</span>
        </button>

        <button
          onClick={() => { setActiveTab('bot'); resetMessages(); }}
          className={`flex items-center gap-2 px-3.5 py-2 rounded-xl font-bold text-xs sm:text-sm transition-all ${
            activeTab === 'bot' ? 'bg-[#E50914] text-white shadow-lg shadow-red-900/30' : 'hover:bg-neutral-800/40'
          }`}
          style={{
            background: activeTab === 'bot' ? '#E50914' : 'var(--color-bg-card)',
            border: activeTab === 'bot' ? 'none' : '1px solid var(--color-border)',
            color: activeTab === 'bot' ? '#ffffff' : 'var(--color-text)',
          }}
        >
          <Bot className="h-4 w-4 text-sky-400" />
          <span>Telegram Auto-Publisher</span>
        </button>

        <button
          onClick={() => { setActiveTab('subtitle'); resetMessages(); }}
          className={`flex items-center gap-2 px-3.5 py-2 rounded-xl font-bold text-xs sm:text-sm transition-all ${
            activeTab === 'subtitle' ? 'bg-[#E50914] text-white shadow-lg shadow-red-900/30' : 'hover:bg-neutral-800/40'
          }`}
          style={{
            background: activeTab === 'subtitle' ? '#E50914' : 'var(--color-bg-card)',
            border: activeTab === 'subtitle' ? 'none' : '1px solid var(--color-border)',
            color: activeTab === 'subtitle' ? '#ffffff' : 'var(--color-text)',
          }}
        >
          <Download className="h-4 w-4" />
          <span>Upload Subtitle</span>
        </button>

        <button
          onClick={() => { setActiveTab('telegram'); resetMessages(); }}
          className={`flex items-center gap-2 px-3.5 py-2 rounded-xl font-bold text-xs sm:text-sm transition-all ${
            activeTab === 'telegram' ? 'bg-[#E50914] text-white shadow-lg shadow-red-900/30' : 'hover:bg-neutral-800/40'
          }`}
          style={{
            background: activeTab === 'telegram' ? '#E50914' : 'var(--color-bg-card)',
            border: activeTab === 'telegram' ? 'none' : '1px solid var(--color-border)',
            color: activeTab === 'telegram' ? '#ffffff' : 'var(--color-text)',
          }}
        >
          <Send className="h-4 w-4" />
          <span>Add Telegram Link</span>
        </button>

        <button
          onClick={() => { setActiveTab('manage'); resetMessages(); }}
          className={`flex items-center gap-2 px-3.5 py-2 rounded-xl font-bold text-xs sm:text-sm transition-all ${
            activeTab === 'manage' ? 'bg-[#E50914] text-white shadow-lg shadow-red-900/30' : 'hover:bg-neutral-800/40'
          }`}
          style={{
            background: activeTab === 'manage' ? '#E50914' : 'var(--color-bg-card)',
            border: activeTab === 'manage' ? 'none' : '1px solid var(--color-border)',
            color: activeTab === 'manage' ? '#ffffff' : 'var(--color-text)',
          }}
        >
          <Layers className="h-4 w-4" />
          <span>Manage Catalog ({initialMovies.length})</span>
        </button>

        <button
          onClick={() => { setActiveTab('requests'); resetMessages(); fetchRequests(); }}
          className={`flex items-center gap-2 px-3.5 py-2 rounded-xl font-bold text-xs sm:text-sm transition-all ${
            activeTab === 'requests' ? 'bg-[#E50914] text-white shadow-lg shadow-red-900/30' : 'hover:bg-neutral-800/40'
          }`}
          style={{
            background: activeTab === 'requests' ? '#E50914' : 'var(--color-bg-card)',
            border: activeTab === 'requests' ? 'none' : '1px solid var(--color-border)',
            color: activeTab === 'requests' ? '#ffffff' : 'var(--color-text)',
          }}
        >
          <MessageSquare className="h-4 w-4 text-amber-400" />
          <span>User Requests</span>
        </button>

        <button
          onClick={() => { setActiveTab('seasons'); resetMessages(); fetchSeasons(seasonMovieId); }}
          className={`flex items-center gap-2 px-3.5 py-2 rounded-xl font-bold text-xs sm:text-sm transition-all ${
            activeTab === 'seasons' ? 'bg-[#E50914] text-white shadow-lg shadow-red-900/30' : 'hover:bg-neutral-800/40'
          }`}
          style={{
            background: activeTab === 'seasons' ? '#E50914' : 'var(--color-bg-card)',
            border: activeTab === 'seasons' ? 'none' : '1px solid var(--color-border)',
            color: activeTab === 'seasons' ? '#ffffff' : 'var(--color-text)',
          }}
        >
          <ListOrdered className="h-4 w-4 text-emerald-400" />
          <span>Seasons &amp; Episodes</span>
        </button>
      </div>

      {/* Global Status Messages */}
      {success && (
        <div className="bg-green-500/10 border border-green-500/30 text-green-400 p-4 rounded-xl text-xs sm:text-sm font-semibold flex items-center justify-between gap-2">
          <div className="flex items-center gap-2">
            <CheckCircle2 className="h-5 w-5 shrink-0" />
            <span>{success}</span>
          </div>
          {botPublishSuccessUrl && (
            <a
              href={botPublishSuccessUrl}
              target="_blank"
              rel="noreferrer"
              className="text-xs underline font-bold text-white hover:text-green-300"
            >
              View Telegram Post ↗
            </a>
          )}
        </div>
      )}
      {error && (
        <div className="bg-red-500/10 border border-red-500/30 text-red-400 p-4 rounded-xl text-xs sm:text-sm font-semibold">
          {error}
        </div>
      )}

      {/* ======================================================== */}
      {/* TAB 1: ANALYTICS & DOWNLOADS DASHBOARD */}
      {/* ======================================================== */}
      {activeTab === 'analytics' && analytics && (
        <div className="space-y-8">
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
            <div className="rounded-2xl p-5 space-y-2 relative overflow-hidden" style={{ background: 'var(--color-bg-card)', border: '1px solid var(--color-border)' }}>
              <div className="flex items-center justify-between">
                <span className="text-xs font-bold uppercase tracking-wider" style={{ color: 'var(--color-text-muted)' }}>Subtitle Downloads</span>
                <div className="p-2 rounded-xl bg-red-500/10 text-[#E50914]"><Download className="h-5 w-5" /></div>
              </div>
              <div className="text-3xl font-black" style={{ color: 'var(--color-text)' }}>{analytics.totalSubtitleDownloads.toLocaleString()}</div>
              <div className="text-xs text-neutral-400"><span className="text-[#E50914] font-bold">{analytics.totalSubtitles}</span> published files</div>
            </div>

            <div className="rounded-2xl p-5 space-y-2 relative overflow-hidden" style={{ background: 'var(--color-bg-card)', border: '1px solid var(--color-border)' }}>
              <div className="flex items-center justify-between">
                <span className="text-xs font-bold uppercase tracking-wider" style={{ color: 'var(--color-text-muted)' }}>Telegram Clicks</span>
                <div className="p-2 rounded-xl bg-sky-500/10 text-sky-400"><Send className="h-5 w-5" /></div>
              </div>
              <div className="text-3xl font-black" style={{ color: 'var(--color-text)' }}>{analytics.totalTelegramClicks.toLocaleString()}</div>
              <div className="text-xs text-neutral-400"><span className="text-sky-400 font-bold">{analytics.totalTelegramLinks}</span> direct links</div>
            </div>

            <div className="rounded-2xl p-5 space-y-2 relative overflow-hidden" style={{ background: 'var(--color-bg-card)', border: '1px solid var(--color-border)' }}>
              <div className="flex items-center justify-between">
                <span className="text-xs font-bold uppercase tracking-wider" style={{ color: 'var(--color-text-muted)' }}>Total Movies</span>
                <div className="p-2 rounded-xl bg-amber-500/10 text-amber-400"><Film className="h-5 w-5" /></div>
              </div>
              <div className="text-3xl font-black" style={{ color: 'var(--color-text)' }}>{analytics.totalMovies}</div>
              <div className="text-xs text-neutral-400">Feature films catalog</div>
            </div>

            <div className="rounded-2xl p-5 space-y-2 relative overflow-hidden" style={{ background: 'var(--color-bg-card)', border: '1px solid var(--color-border)' }}>
              <div className="flex items-center justify-between">
                <span className="text-xs font-bold uppercase tracking-wider" style={{ color: 'var(--color-text-muted)' }}>Total TV Series</span>
                <div className="p-2 rounded-xl bg-purple-500/10 text-purple-400"><Tv className="h-5 w-5" /></div>
              </div>
              <div className="text-3xl font-black" style={{ color: 'var(--color-text)' }}>{analytics.totalTvSeries}</div>
              <div className="text-xs text-neutral-400">TV series tracked</div>
            </div>
          </div>

          <div className="rounded-2xl p-6 space-y-6" style={{ background: 'var(--color-bg-card)', border: '1px solid var(--color-border)' }}>
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
              <div>
                <h3 className="text-lg font-black flex items-center gap-2" style={{ color: 'var(--color-text)' }}>
                  <TrendingUp className="h-5 w-5 text-[#E50914]" />
                  <span>Top Downloaded Content Leaderboard</span>
                </h3>
              </div>

              <div className="flex flex-wrap items-center gap-2">
                <div className="relative">
                  <input
                    type="text"
                    placeholder="Filter titles…"
                    value={analyticsSearch}
                    onChange={(e) => setAnalyticsSearch(e.target.value)}
                    className="nf-input pl-8 py-1.5 text-xs w-40 sm:w-48 h-8.5"
                  />
                  <Search className="absolute left-2.5 top-1/2 -translate-y-1/2 h-3.5 w-3.5" style={{ color: 'var(--color-text-subtle)' }} />
                </div>

                <div className="flex items-center p-1 rounded-xl" style={{ background: 'var(--color-bg-elevated)' }}>
                  <button onClick={() => setAnalyticsFilter('ALL')} className={`px-3 py-1 rounded-lg text-xs font-bold ${analyticsFilter === 'ALL' ? 'bg-[#E50914] text-white' : 'text-neutral-400'}`}>All</button>
                  <button onClick={() => setAnalyticsFilter('MOVIE')} className={`px-3 py-1 rounded-lg text-xs font-bold ${analyticsFilter === 'MOVIE' ? 'bg-[#E50914] text-white' : 'text-neutral-400'}`}>Movies</button>
                  <button onClick={() => setAnalyticsFilter('TV_SHOW')} className={`px-3 py-1 rounded-lg text-xs font-bold ${analyticsFilter === 'TV_SHOW' ? 'bg-[#6d28d9] text-white' : 'text-neutral-400'}`}>TV Series</button>
                </div>
              </div>
            </div>

            <div className="overflow-x-auto">
              <table className="w-full text-left text-xs sm:text-sm">
                <thead>
                  <tr className="border-b text-[11px] uppercase tracking-wider" style={{ borderColor: 'var(--color-border)', color: 'var(--color-text-muted)' }}>
                    <th className="pb-3 pl-2">Rank &amp; Title</th>
                    <th className="pb-3">Format</th>
                    <th className="pb-3">Subtitles Downloads</th>
                    <th className="pb-3">Telegram Clicks</th>
                    <th className="pb-3">Total Engagement</th>
                    <th className="pb-3 pr-2 text-right">Action</th>
                  </tr>
                </thead>
                <tbody className="divide-y" style={{ borderColor: 'var(--color-border)' }}>
                  {filteredTopContent.map((item, idx) => {
                    const isTv = item.type === 'TV_SHOW';
                    const percentage = Math.round((item.totalEngagement / maxEngagement) * 100);
                    return (
                      <tr key={item.id} className="hover:bg-neutral-800/20 transition-colors">
                        <td className="py-3.5 pl-2">
                          <div className="flex items-center gap-3">
                            <span className="w-6 text-center font-black text-xs text-neutral-500">#{idx + 1}</span>
                            <div className="w-9 h-12 rounded-md overflow-hidden bg-neutral-800 shrink-0">
                              {item.posterPath ? <img src={item.posterPath} alt={item.title} className="w-full h-full object-cover" /> : null}
                            </div>
                            <div>
                              <div className="font-bold line-clamp-1" style={{ color: 'var(--color-text)' }}>{item.title}</div>
                              <div className="text-[11px] text-neutral-400">{item.releaseDate ? item.releaseDate.split('-')[0] : 'N/A'}</div>
                            </div>
                          </div>
                        </td>
                        <td className="py-3.5">
                          <span className="text-[9px] uppercase font-black px-2 py-0.5 rounded text-white" style={{ background: isTv ? '#6d28d9' : '#E50914' }}>
                            {isTv ? 'TV Series' : 'Movie'}
                          </span>
                        </td>
                        <td className="py-3.5 font-bold text-[#E50914]">{item.totalSubDownloads.toLocaleString()}</td>
                        <td className="py-3.5 font-bold text-sky-400">{item.totalTelegramClicks.toLocaleString()}</td>
                        <td className="py-3.5 min-w-[160px]">
                          <div className="flex items-center justify-between text-xs font-black mb-1">
                            <span>{item.totalEngagement.toLocaleString()}</span>
                            <span className="text-[10px] text-neutral-400">{percentage}%</span>
                          </div>
                          <div className="w-full h-1.5 rounded-full bg-neutral-800 overflow-hidden">
                            <div className="h-full rounded-full" style={{ width: `${percentage}%`, background: isTv ? '#6d28d9' : '#E50914' }} />
                          </div>
                        </td>
                        <td className="py-3.5 pr-2 text-right">
                          <Link href={`/movies/${item.id}`} target="_blank" className="inline-flex items-center gap-1 px-2.5 py-1 rounded-lg text-xs hover:bg-neutral-800 text-neutral-400 hover:text-white">
                            <span>View</span>
                            <ExternalLink className="w-3 h-3" />
                          </Link>
                        </td>
                      </tr>
                    );
                  })}
                </tbody>
              </table>
            </div>
          </div>
        </div>
      )}

      {/* ======================================================== */}
      {/* TAB: 🚀 QUICK PUBLISH (Unified One-Page Publisher) */}
      {/* ======================================================== */}
      {activeTab === 'unified' && (
        <div className="rounded-2xl p-6 sm:p-8 max-w-2xl space-y-6" style={{ background: 'var(--color-bg-card)', border: '1px solid var(--color-border)' }}>
          <div className="flex items-center gap-3">
            <Sparkles className="h-6 w-6 text-yellow-400" />
            <div>
              <h3 className="text-xl font-bold" style={{ color: 'var(--color-text)' }}>Quick Publish</h3>
              <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>Add a Movie or TV Episode with subtitle + Telegram link in one go</p>
            </div>
          </div>

          <form onSubmit={handleUnifiedCreate} className="space-y-5">
            {/* Content Type */}
            <div className="grid grid-cols-2 gap-3">
              <button type="button"
                onClick={() => setUniType('MOVIE')}
                className={`flex items-center justify-center gap-2 py-3 rounded-xl font-bold text-sm transition-all border ${uniType === 'MOVIE' ? 'bg-red-600 text-white border-red-600' : 'border-neutral-700 text-neutral-300 hover:border-red-500'}`}
              >
                <Film className="h-4 w-4" /> Movie
              </button>
              <button type="button"
                onClick={() => setUniType('TV_SHOW')}
                className={`flex items-center justify-center gap-2 py-3 rounded-xl font-bold text-sm transition-all border ${uniType === 'TV_SHOW' ? 'bg-red-600 text-white border-red-600' : 'border-neutral-700 text-neutral-300 hover:border-red-500'}`}
              >
                <Tv className="h-4 w-4" /> TV Series
              </button>
            </div>

            {/* TMDB vs Manual toggle */}
            <div className="flex items-center gap-3">
              <label className="flex items-center gap-2 cursor-pointer select-none">
                <div
                  onClick={() => setUniUseTmdb(!uniUseTmdb)}
                  className={`relative w-11 h-6 rounded-full transition-colors ${uniUseTmdb ? 'bg-red-600' : 'bg-neutral-600'}`}
                >
                  <span className={`absolute top-0.5 left-0.5 w-5 h-5 bg-white rounded-full shadow transition-transform ${uniUseTmdb ? 'translate-x-5' : ''}`} />
                </div>
                <span className="text-sm font-semibold" style={{ color: 'var(--color-text)' }}>Fetch from TMDB</span>
              </label>
              {uniUseTmdb && (
                <input
                  type="text"
                  value={uniTmdbId}
                  onChange={e => setUniTmdbId(e.target.value)}
                  placeholder="TMDB ID (e.g. 550)"
                  className="flex-1 rounded-lg px-3 py-2 text-sm border"
                  style={{ background: 'var(--color-bg)', border: '1px solid var(--color-border)', color: 'var(--color-text)' }}
                />
              )}
            </div>

            {/* Manual fields (when TMDB off) */}
            {!uniUseTmdb && (
              <div className="space-y-3">
                <input type="text" value={uniTitle} onChange={e => setUniTitle(e.target.value)}
                  placeholder="Title *" required
                  className="w-full rounded-lg px-3 py-2 text-sm border"
                  style={{ background: 'var(--color-bg)', border: '1px solid var(--color-border)', color: 'var(--color-text)' }}
                />
                <textarea value={uniDescription} onChange={e => setUniDescription(e.target.value)}
                  placeholder="Description" rows={2}
                  className="w-full rounded-lg px-3 py-2 text-sm border resize-none"
                  style={{ background: 'var(--color-bg)', border: '1px solid var(--color-border)', color: 'var(--color-text)' }}
                />
                <div className="grid grid-cols-2 gap-3">
                  <input type="text" value={uniReleaseDate} onChange={e => setUniReleaseDate(e.target.value)}
                    placeholder="Release Date (YYYY-MM-DD)"
                    className="rounded-lg px-3 py-2 text-sm border"
                    style={{ background: 'var(--color-bg)', border: '1px solid var(--color-border)', color: 'var(--color-text)' }}
                  />
                  <input type="text" value={uniImdbRating} onChange={e => setUniImdbRating(e.target.value)}
                    placeholder="IMDB Rating (e.g. 8.5)"
                    className="rounded-lg px-3 py-2 text-sm border"
                    style={{ background: 'var(--color-bg)', border: '1px solid var(--color-border)', color: 'var(--color-text)' }}
                  />
                </div>
                <input type="text" value={uniPosterPath} onChange={e => setUniPosterPath(e.target.value)}
                  placeholder="Poster image URL (https://...)"
                  className="w-full rounded-lg px-3 py-2 text-sm border"
                  style={{ background: 'var(--color-bg)', border: '1px solid var(--color-border)', color: 'var(--color-text)' }}
                />
                <input type="text" value={uniGenres} onChange={e => setUniGenres(e.target.value)}
                  placeholder="Genres (comma-separated: Action, Drama)"
                  className="w-full rounded-lg px-3 py-2 text-sm border"
                  style={{ background: 'var(--color-bg)', border: '1px solid var(--color-border)', color: 'var(--color-text)' }}
                />
              </div>
            )}

            {/* TV Show episode fields */}
            {uniType === 'TV_SHOW' && (
              <div className="space-y-3 rounded-xl p-4" style={{ background: 'var(--color-bg)', border: '1px solid var(--color-border)' }}>
                <p className="text-xs font-bold uppercase tracking-wider" style={{ color: 'var(--color-text-muted)' }}>Episode Info</p>
                <div className="grid grid-cols-2 gap-3">
                  <input type="number" value={uniSeasonNum} onChange={e => setUniSeasonNum(e.target.value)}
                    placeholder="Season #" min="1"
                    className="rounded-lg px-3 py-2 text-sm border"
                    style={{ background: 'var(--color-bg-card)', border: '1px solid var(--color-border)', color: 'var(--color-text)' }}
                  />
                  <input type="number" value={uniEpisodeNum} onChange={e => setUniEpisodeNum(e.target.value)}
                    placeholder="Episode #" min="1"
                    className="rounded-lg px-3 py-2 text-sm border"
                    style={{ background: 'var(--color-bg-card)', border: '1px solid var(--color-border)', color: 'var(--color-text)' }}
                  />
                </div>
                <input type="text" value={uniEpisodeTitle} onChange={e => setUniEpisodeTitle(e.target.value)}
                  placeholder="Episode Title (optional)"
                  className="w-full rounded-lg px-3 py-2 text-sm border"
                  style={{ background: 'var(--color-bg-card)', border: '1px solid var(--color-border)', color: 'var(--color-text)' }}
                />
                <textarea value={uniEpisodeDesc} onChange={e => setUniEpisodeDesc(e.target.value)}
                  placeholder="Episode Description (optional)" rows={2}
                  className="w-full rounded-lg px-3 py-2 text-sm border resize-none"
                  style={{ background: 'var(--color-bg-card)', border: '1px solid var(--color-border)', color: 'var(--color-text)' }}
                />
              </div>
            )}

            {/* Subtitle */}
            <div className="space-y-3 rounded-xl p-4" style={{ background: 'var(--color-bg)', border: '1px solid var(--color-border)' }}>
              <p className="text-xs font-bold uppercase tracking-wider" style={{ color: 'var(--color-text-muted)' }}>Subtitle File (optional)</p>
              <input type="text" value={uniSubFileName} onChange={e => setUniSubFileName(e.target.value)}
                placeholder="File Name (e.g. Batman.2022.Sinhala.srt)"
                className="w-full rounded-lg px-3 py-2 text-sm border"
                style={{ background: 'var(--color-bg-card)', border: '1px solid var(--color-border)', color: 'var(--color-text)' }}
              />
              <input type="url" value={uniSubFileUrl} onChange={e => setUniSubFileUrl(e.target.value)}
                placeholder="Direct Download URL (https://...)"
                className="w-full rounded-lg px-3 py-2 text-sm border"
                style={{ background: 'var(--color-bg-card)', border: '1px solid var(--color-border)', color: 'var(--color-text)' }}
              />
            </div>

            {/* Telegram Link */}
            <div className="space-y-3 rounded-xl p-4" style={{ background: 'var(--color-bg)', border: '1px solid var(--color-border)' }}>
              <p className="text-xs font-bold uppercase tracking-wider" style={{ color: 'var(--color-text-muted)' }}>Telegram Download Link (optional)</p>
              <input type="url" value={uniTgUrl} onChange={e => setUniTgUrl(e.target.value)}
                placeholder="Telegram URL (https://t.me/...)"
                className="w-full rounded-lg px-3 py-2 text-sm border"
                style={{ background: 'var(--color-bg-card)', border: '1px solid var(--color-border)', color: 'var(--color-text)' }}
              />
              <input type="text" value={uniTgLabel} onChange={e => setUniTgLabel(e.target.value)}
                placeholder="Label (e.g. 1080p, 720p, 480p) — optional"
                className="w-full rounded-lg px-3 py-2 text-sm border"
                style={{ background: 'var(--color-bg-card)', border: '1px solid var(--color-border)', color: 'var(--color-text)' }}
              />
            </div>

            {error && <p className="text-red-400 text-sm bg-red-900/20 rounded-lg px-3 py-2">{error}</p>}
            {success && <p className="text-green-400 text-sm bg-green-900/20 rounded-lg px-3 py-2">{success}</p>}

            <button
              type="submit"
              disabled={loading}
              className="w-full flex items-center justify-center gap-2 py-3 rounded-xl font-bold text-sm text-white transition-all"
              style={{ background: loading ? '#666' : '#E50914' }}
            >
              {loading ? <Loader2 className="h-4 w-4 animate-spin" /> : <Sparkles className="h-4 w-4" />}
              {loading ? 'Publishing…' : '🚀 Publish Now'}
            </button>
          </form>
        </div>
      )}

      {/* ======================================================== */}
      {/* TAB 2: ADD / SYNC MOVIE & TV SERIES */}
      {/* ======================================================== */}
      {activeTab === 'movie' && (
        <div className="rounded-2xl p-6 sm:p-8 max-w-2xl space-y-6" style={{ background: 'var(--color-bg-card)', border: '1px solid var(--color-border)' }}>
          <div className="flex items-center justify-between">
            <div>
              <h3 className="text-xl font-bold" style={{ color: 'var(--color-text)' }}>
                {isManualCreate ? 'Create Title Manually' : 'Sync from TMDB (Automatic)'}
              </h3>
              <p className="text-xs mt-1" style={{ color: 'var(--color-text-muted)' }}>
                {isManualCreate ? 'Enter full metadata manually without needing TMDB API.' : 'Enter TMDB ID to automatically fetch all metadata and posters.'}
              </p>
            </div>
            <button
              onClick={() => setIsManualCreate(!isManualCreate)}
              className="text-xs font-bold text-[#E50914] hover:underline"
            >
              {isManualCreate ? '← Switch to TMDB Auto Sync' : 'Switch to Manual Form →'}
            </button>
          </div>

          <form onSubmit={handleAddMovie} className="space-y-4">
            <div>
              <label className="block text-xs font-semibold uppercase tracking-wider mb-1.5" style={{ color: 'var(--color-text-muted)' }}>Format Type</label>
              <select value={type} onChange={e => setType(e.target.value)} className="nf-input">
                <option value="MOVIE">Movie (Feature Film)</option>
                <option value="TV_SHOW">TV Series</option>
              </select>
            </div>

            {!isManualCreate ? (
              <div>
                <label className="block text-xs font-semibold uppercase tracking-wider mb-1.5" style={{ color: 'var(--color-text-muted)' }}>TMDB ID</label>
                <input
                  type="text"
                  required
                  value={tmdbId}
                  onChange={e => setTmdbId(e.target.value)}
                  placeholder="e.g. 533535"
                  className="nf-input"
                />
                <p className="text-[11px] text-neutral-400 mt-1">Get ID from themoviedb.org URL (e.g. /movie/533535-deadpool-wolverine)</p>
              </div>
            ) : (
              <>
                <div>
                  <label className="block text-xs font-semibold uppercase tracking-wider mb-1.5" style={{ color: 'var(--color-text-muted)' }}>Title</label>
                  <input type="text" required value={manualTitle} onChange={e => setManualTitle(e.target.value)} placeholder="e.g. Deadpool & Wolverine" className="nf-input" />
                </div>
                <div>
                  <label className="block text-xs font-semibold uppercase tracking-wider mb-1.5" style={{ color: 'var(--color-text-muted)' }}>Original Title (Optional)</label>
                  <input type="text" value={manualOriginalTitle} onChange={e => setManualOriginalTitle(e.target.value)} placeholder="e.g. Deadpool 3" className="nf-input" />
                </div>
                <div>
                  <label className="block text-xs font-semibold uppercase tracking-wider mb-1.5" style={{ color: 'var(--color-text-muted)' }}>Release Date (YYYY-MM-DD)</label>
                  <input type="text" value={manualReleaseDate} onChange={e => setManualReleaseDate(e.target.value)} placeholder="2024-07-26" className="nf-input" />
                </div>
                <div>
                  <label className="block text-xs font-semibold uppercase tracking-wider mb-1.5" style={{ color: 'var(--color-text-muted)' }}>Poster Image URL</label>
                  <input type="url" value={manualPosterPath} onChange={e => setManualPosterPath(e.target.value)} placeholder="https://image.tmdb.org/t/p/w500/..." className="nf-input" />
                </div>
                <div>
                  <label className="block text-xs font-semibold uppercase tracking-wider mb-1.5" style={{ color: 'var(--color-text-muted)' }}>Backdrop Image URL (Optional)</label>
                  <input type="url" value={manualBackdropPath} onChange={e => setManualBackdropPath(e.target.value)} placeholder="https://image.tmdb.org/t/p/original/..." className="nf-input" />
                </div>
                <div>
                  <label className="block text-xs font-semibold uppercase tracking-wider mb-1.5" style={{ color: 'var(--color-text-muted)' }}>Synopsis / Description</label>
                  <textarea rows={3} value={manualDescription} onChange={e => setManualDescription(e.target.value)} placeholder="Movie plot summary..." className="nf-input" />
                </div>
              </>
            )}

            <button type="submit" disabled={loading} className="nf-btn-primary w-full justify-center disabled:opacity-40">
              {loading ? <Loader2 className="h-4 w-4 animate-spin" /> : <RefreshCw className="h-4 w-4" />}
              <span>{isManualCreate ? 'Create Title in Database' : 'Sync & Save to Database'}</span>
            </button>
          </form>
        </div>
      )}

      {/* ======================================================== */}
      {/* TAB 3: CSV BULK IMPORT */}
      {/* ======================================================== */}
      {activeTab === 'csv' && (
        <div className="rounded-2xl p-6 sm:p-8 space-y-6" style={{ background: 'var(--color-bg-card)', border: '1px solid var(--color-border)' }}>
          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
            <div>
              <h3 className="text-xl font-black flex items-center gap-2" style={{ color: 'var(--color-text)' }}>
                <FileSpreadsheet className="h-6 w-6 text-emerald-400" />
                <span>CSV Bulk Movie &amp; TV Series Import</span>
              </h3>
              <p className="text-xs sm:text-sm mt-1" style={{ color: 'var(--color-text-muted)' }}>
                Upload hundreds of movies and series in one click using a spreadsheet / CSV file.
              </p>
            </div>

            <button
              onClick={downloadSampleCsv}
              className="inline-flex items-center gap-1.5 px-3 py-2 rounded-xl text-xs font-bold text-emerald-400 bg-emerald-500/10 border border-emerald-500/20 hover:bg-emerald-500/20 transition-all"
            >
              <Download className="h-4 w-4" />
              <span>Download Sample CSV Template</span>
            </button>
          </div>

          {/* File drop area */}
          <div
            onClick={() => fileInputRef.current?.click()}
            className="border-2 border-dashed rounded-2xl p-8 text-center cursor-pointer hover:border-emerald-500 transition-colors space-y-3"
            style={{ borderColor: 'var(--color-border)' }}
          >
            <input
              type="file"
              ref={fileInputRef}
              accept=".csv"
              onChange={handleCsvFileChange}
              className="hidden"
            />
            <div className="w-12 h-12 mx-auto rounded-2xl bg-emerald-500/10 text-emerald-400 flex items-center justify-center">
              <Upload className="h-6 w-6" />
            </div>
            <div>
              <p className="text-sm font-bold" style={{ color: 'var(--color-text)' }}>
                {csvFile ? csvFile.name : 'Click or Drag & Drop .CSV file here'}
              </p>
              <p className="text-xs text-neutral-400 mt-0.5">
                Supports columns: title, originalTitle, type (MOVIE/TV_SHOW), description, releaseDate, posterPath, backdropPath, tmdbId
              </p>
            </div>
          </div>

          {/* Parsed Rows Preview Table */}
          {parsedCsvRows.length > 0 && (
            <div className="space-y-4">
              <div className="flex items-center justify-between">
                <span className="text-xs font-bold uppercase tracking-wider text-emerald-400">
                  Ready to Import: {parsedCsvRows.length} Titles
                </span>
                <button
                  onClick={handleBulkImportSubmit}
                  disabled={loading}
                  className="nf-btn-primary px-5 py-2 text-xs font-bold"
                  style={{ background: '#10b981' }}
                >
                  {loading ? <Loader2 className="h-4 w-4 animate-spin" /> : <Upload className="h-4 w-4" />}
                  <span>Confirm &amp; Import All {parsedCsvRows.length} Titles</span>
                </button>
              </div>

              <div className="max-h-64 overflow-y-auto rounded-xl border" style={{ borderColor: 'var(--color-border)' }}>
                <table className="w-full text-left text-xs">
                  <thead className="sticky top-0 bg-neutral-900 border-b" style={{ borderColor: 'var(--color-border)' }}>
                    <tr>
                      <th className="p-2.5">Title</th>
                      <th className="p-2.5">Type</th>
                      <th className="p-2.5">Release Date</th>
                      <th className="p-2.5">TMDB ID</th>
                    </tr>
                  </thead>
                  <tbody className="divide-y" style={{ borderColor: 'var(--color-border)' }}>
                    {parsedCsvRows.map((r, i) => (
                      <tr key={i} className="hover:bg-neutral-800/30">
                        <td className="p-2.5 font-bold">{r.title}</td>
                        <td className="p-2.5 uppercase text-[10px]">{r.type || 'MOVIE'}</td>
                        <td className="p-2.5">{r.releaseDate || 'N/A'}</td>
                        <td className="p-2.5">{r.tmdbId || '—'}</td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </div>
          )}

          {/* Results Summary */}
          {csvImportResults && (
            <div className="p-4 rounded-xl bg-neutral-900 border space-y-2 text-xs" style={{ borderColor: 'var(--color-border)' }}>
              <div className="flex items-center gap-3">
                <span className="text-green-400 font-bold">✓ Successfully Imported: {csvImportResults.success}</span>
                <span className="text-red-400 font-bold">✗ Failed / Skipped: {csvImportResults.failed}</span>
              </div>
              {csvImportResults.errors.length > 0 && (
                <div className="text-neutral-400 space-y-1 pt-1 border-t border-neutral-800">
                  <span className="font-bold text-neutral-300">Errors log:</span>
                  {csvImportResults.errors.map((err, idx) => (
                    <p key={idx} className="text-red-400 text-[11px]">• {err}</p>
                  ))}
                </div>
              )}
            </div>
          )}
        </div>
      )}

      {/* ======================================================== */}
      {/* TAB 4: TELEGRAM BOT AUTO-PUBLISHER */}
      {/* ======================================================== */}
      {activeTab === 'bot' && (
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">

          {/* Bot Config & Send Form */}
          <div className="rounded-2xl p-6 sm:p-8 space-y-6" style={{ background: 'var(--color-bg-card)', border: '1px solid var(--color-border)' }}>
            <div>
              <h3 className="text-xl font-black flex items-center gap-2" style={{ color: 'var(--color-text)' }}>
                <Bot className="h-6 w-6 text-sky-400" />
                <span>Telegram Channel Auto-Publisher</span>
              </h3>
              <p className="text-xs sm:text-sm mt-1" style={{ color: 'var(--color-text-muted)' }}>
                Automatically post formatted movie cards with poster, description, and direct subtitle download buttons to your Telegram channel.
              </p>
            </div>

            <form onSubmit={handlePublishToTelegram} className="space-y-4">
              <div>
                <label className="block text-xs font-semibold uppercase tracking-wider mb-1.5" style={{ color: 'var(--color-text-muted)' }}>
                  Telegram Bot Token
                </label>
                <input
                  type="password"
                  required
                  value={botToken}
                  onChange={(e) => setBotToken(e.target.value)}
                  placeholder="123456789:ABCdefGhIJKlmNoPQRsTUVwxyZ"
                  className="nf-input text-xs"
                />
                <p className="text-[11px] text-neutral-400 mt-1">
                  Create a bot via <strong>@BotFather</strong> on Telegram and paste the token here.
                </p>
              </div>

              <div>
                <label className="block text-xs font-semibold uppercase tracking-wider mb-1.5" style={{ color: 'var(--color-text-muted)' }}>
                  Channel Username / Chat ID
                </label>
                <input
                  type="text"
                  required
                  value={botChatId}
                  onChange={(e) => setBotChatId(e.target.value)}
                  placeholder="@PixelSubzLk or -1001234567890"
                  className="nf-input text-xs"
                />
                <p className="text-[11px] text-neutral-400 mt-1">
                  Make sure your bot is added as an <strong>Administrator</strong> in the channel with Post Messages permission.
                </p>
              </div>

              <div>
                <label className="block text-xs font-semibold uppercase tracking-wider mb-1.5" style={{ color: 'var(--color-text-muted)' }}>
                  Select Title to Post
                </label>
                <select
                  value={botSelectedMovieId}
                  onChange={(e) => setBotSelectedMovieId(e.target.value)}
                  className="nf-input"
                  required
                >
                  {initialMovies.map((m) => (
                    <option key={m.id} value={m.id}>
                      [{m.type === 'MOVIE' ? 'Movie' : 'TV'}] {m.title} ({m.releaseDate ? m.releaseDate.split('-')[0] : 'N/A'})
                    </option>
                  ))}
                </select>
              </div>

              <div>
                <label className="block text-xs font-semibold uppercase tracking-wider mb-1.5" style={{ color: 'var(--color-text-muted)' }}>
                  Custom Caption Override (Optional)
                </label>
                <textarea
                  rows={4}
                  value={botCustomMessage}
                  onChange={(e) => setBotCustomMessage(e.target.value)}
                  placeholder="Leave empty to use automatic standard aesthetic template…"
                  className="nf-input text-xs font-mono"
                />
              </div>

              <button
                type="submit"
                disabled={loading || !botSelectedMovieId || !botToken.trim()}
                className="w-full flex items-center justify-center gap-2 py-3 px-4 rounded-xl text-sm font-bold text-white transition-all shadow-lg bg-sky-500 hover:bg-sky-600 disabled:opacity-40"
              >
                {loading ? <Loader2 className="h-4 w-4 animate-spin" /> : <Send className="h-4 w-4" />}
                <span>Publish Post to Telegram Channel</span>
              </button>
            </form>
          </div>

          {/* Live Telegram Message Preview */}
          <div className="rounded-2xl p-6 space-y-4 flex flex-col" style={{ background: '#17212b', border: '1px solid rgba(255,255,255,0.1)' }}>
            <div className="flex items-center justify-between border-b pb-3 border-neutral-700">
              <span className="text-xs font-bold uppercase tracking-wider text-sky-400 flex items-center gap-1.5">
                <Eye className="h-4 w-4" />
                Live Telegram Post Preview
              </span>
              <span className="text-[11px] text-neutral-400">{botChatId}</span>
            </div>

            {selectedBotMovie ? (
              <div className="space-y-3 flex-1">
                {/* Poster Preview */}
                <div className="aspect-[16/9] sm:aspect-[2/1] w-full rounded-xl overflow-hidden bg-black/40">
                  <img
                    src={selectedBotMovie.posterPath || selectedBotMovie.backdropPath || 'https://image.tmdb.org/t/p/w500/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg'}
                    alt="Preview"
                    className="w-full h-full object-cover"
                  />
                </div>

                {/* Caption text */}
                <div className="text-xs text-white/90 space-y-1 leading-relaxed bg-[#232e3c] p-4 rounded-xl font-sans">
                  <p className="font-bold text-sm">🎬 {selectedBotMovie.title} ({selectedBotMovie.releaseDate?.split('-')[0] || '2024'})</p>
                  <p>🎭 <b>Type:</b> {selectedBotMovie.type === 'TV_SHOW' ? '📺 TV Series' : '🍿 Feature Film'}</p>
                  <p>🇱🇰 <b>Sinhala Subtitle:</b> Available (.srt) ✅</p>
                  <p>⚡ <b>Qualities:</b> 1080p | 720p | 480p</p>
                  <p className="text-neutral-400 italic pt-1 line-clamp-3">
                    {selectedBotMovie.description || 'Experience the thrilling story with full synced Sinhala subtitles.'}
                  </p>
                  <p className="pt-2 text-sky-400">📥 <b>Download Sinhala Subtitles:</b></p>
                  <p className="text-sky-300 underline break-all">https://pixelsubz.lk/movies/{selectedBotMovie.id}</p>
                </div>

                {/* Inline Buttons Preview */}
                <div className="space-y-1.5 pt-1">
                  <div className="w-full py-2 bg-[#2b5278] hover:bg-[#2b5278]/80 text-white font-bold text-xs rounded-lg text-center cursor-default">
                    📥 Download Sinhala Subtitle
                  </div>
                  <div className="grid grid-cols-2 gap-1.5">
                    <div className="py-2 bg-[#2b5278] text-white font-bold text-xs rounded-lg text-center cursor-default">
                      ⚡ Open on Website
                    </div>
                    <div className="py-2 bg-[#2b5278] text-white font-bold text-xs rounded-lg text-center cursor-default">
                      📢 Join Channel
                    </div>
                  </div>
                </div>
              </div>
            ) : null}
          </div>

        </div>
      )}

      {/* ======================================================== */}
      {/* TAB 5: UPLOAD SUBTITLE */}
      {/* ======================================================== */}
      {activeTab === 'subtitle' && (
        <div className="rounded-2xl p-6 sm:p-8 max-w-2xl space-y-6" style={{ background: 'var(--color-bg-card)', border: '1px solid var(--color-border)' }}>
          <div>
            <h3 className="text-xl font-bold" style={{ color: 'var(--color-text)' }}>Add Sinhala Subtitle</h3>
            <p className="text-xs sm:text-sm mt-1" style={{ color: 'var(--color-text-muted)' }}>
              Attach a .srt subtitle download URL to an existing title in your catalog.
            </p>
          </div>

          <form onSubmit={handleAddSubtitle} className="space-y-4">
            <div>
              <label className="block text-xs font-semibold uppercase tracking-wider mb-1.5" style={{ color: 'var(--color-text-muted)' }}>Select Movie / TV Show</label>
              <select value={selectedMovieId} onChange={e => setSelectedMovieId(e.target.value)} className="nf-input" required>
                <option value="">-- Choose a title --</option>
                {initialMovies.map(m => (
                  <option key={m.id} value={m.id}>
                    [{m.type === 'MOVIE' ? 'Movie' : 'TV'}] {m.title} ({m.releaseDate ? m.releaseDate.split('-')[0] : 'N/A'})
                  </option>
                ))}
              </select>
            </div>

            <div>
              <label className="block text-xs font-semibold uppercase tracking-wider mb-1.5" style={{ color: 'var(--color-text-muted)' }}>Subtitle File Name</label>
              <input type="text" required value={subFileName} onChange={e => setSubFileName(e.target.value)} placeholder="e.g. Title.2024.1080p.WEBRip.Sinhala.srt" className="nf-input" />
            </div>

            <div>
              <label className="block text-xs font-semibold uppercase tracking-wider mb-1.5" style={{ color: 'var(--color-text-muted)' }}>Subtitle Direct Download File URL</label>
              <input type="url" required value={subFileUrl} onChange={e => setSubFileUrl(e.target.value)} placeholder="https://..." className="nf-input" />
            </div>

            <button type="submit" disabled={loading} className="nf-btn-primary w-full justify-center disabled:opacity-40">
              {loading ? <Loader2 className="h-4 w-4 animate-spin" /> : <Download className="h-4 w-4" />}
              <span>Publish Subtitle</span>
            </button>
          </form>
        </div>
      )}

      {/* ======================================================== */}
      {/* TAB 6: ADD TELEGRAM LINK */}
      {/* ======================================================== */}
      {activeTab === 'telegram' && (
        <div className="rounded-2xl p-6 sm:p-8 max-w-2xl space-y-6" style={{ background: 'var(--color-bg-card)', border: '1px solid var(--color-border)' }}>
          <div>
            <h3 className="text-xl font-bold" style={{ color: 'var(--color-text)' }}>Add Direct Telegram Download Link</h3>
          </div>

          <form onSubmit={handleAddTelegram} className="space-y-4">
            <div>
              <label className="block text-xs font-semibold uppercase tracking-wider mb-1.5" style={{ color: 'var(--color-text-muted)' }}>Select Movie / TV Show</label>
              <select value={selectedMovieId} onChange={e => setSelectedMovieId(e.target.value)} className="nf-input" required>
                <option value="">-- Choose a title --</option>
                {initialMovies.map(m => (
                  <option key={m.id} value={m.id}>
                    [{m.type === 'MOVIE' ? 'Movie' : 'TV'}] {m.title} ({m.releaseDate ? m.releaseDate.split('-')[0] : 'N/A'})
                  </option>
                ))}
              </select>
            </div>

            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
              <div>
                <label className="block text-xs font-semibold uppercase tracking-wider mb-1.5" style={{ color: 'var(--color-text-muted)' }}>Video Quality</label>
                <input type="text" required value={telQuality} onChange={e => setTelQuality(e.target.value)} placeholder="e.g. 1080p Full HD" className="nf-input" />
              </div>
              <div>
                <label className="block text-xs font-semibold uppercase tracking-wider mb-1.5" style={{ color: 'var(--color-text-muted)' }}>File Size (Optional)</label>
                <input type="text" value={telSize} onChange={e => setTelSize(e.target.value)} placeholder="e.g. 2.4 GB" className="nf-input" />
              </div>
            </div>

            <div>
              <label className="block text-xs font-semibold uppercase tracking-wider mb-1.5" style={{ color: 'var(--color-text-muted)' }}>Telegram Post / Download URL</label>
              <input type="url" required value={telDownloadUrl} onChange={e => setTelDownloadUrl(e.target.value)} placeholder="https://t.me/PixelSubzLk/12345" className="nf-input" />
            </div>

            <button type="submit" disabled={loading} className="w-full flex items-center justify-center gap-2 py-2.5 px-4 rounded-xl text-sm font-bold text-white shadow-md bg-sky-500 hover:bg-sky-600 disabled:opacity-40">
              {loading ? <Loader2 className="h-4 w-4 animate-spin" /> : <Send className="h-4 w-4" />}
              <span>Save Telegram Link</span>
            </button>
          </form>
        </div>
      )}

      {/* ======================================================== */}
      {/* TAB 7: MANAGE CATALOG & EDIT MODAL */}
      {/* ======================================================== */}
      {activeTab === 'manage' && (
        <div className="rounded-2xl p-6 space-y-4" style={{ background: 'var(--color-bg-card)', border: '1px solid var(--color-border)' }}>
          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3">
            <h3 className="text-lg font-bold" style={{ color: 'var(--color-text)' }}>
              Database Catalog ({filteredCatalog.length})
            </h3>
            <div className="relative">
              <input
                type="text"
                placeholder="Search catalog…"
                value={catalogSearch}
                onChange={(e) => setCatalogSearch(e.target.value)}
                className="nf-input pl-8 py-1.5 text-xs w-56 h-8.5"
              />
              <Search className="absolute left-2.5 top-1/2 -translate-y-1/2 h-3.5 w-3.5" style={{ color: 'var(--color-text-subtle)' }} />
            </div>
          </div>

          <div className="divide-y" style={{ borderColor: 'var(--color-border)' }}>
            {filteredCatalog.map(m => (
              <div key={m.id} className="py-3 flex items-center justify-between gap-4">
                <div>
                  <div className="font-bold text-sm" style={{ color: 'var(--color-text)' }}>{m.title}</div>
                  <div className="text-xs text-neutral-400 flex items-center gap-2 mt-0.5">
                    <span className="text-[10px] uppercase font-bold text-white bg-neutral-800 px-1.5 py-0.5 rounded">{m.type}</span>
                    <span>Release: {m.releaseDate || 'N/A'}</span>
                    {m.tmdbId && <span>TMDB: {m.tmdbId}</span>}
                  </div>
                </div>

                <div className="flex items-center gap-1.5">
                  <button
                    onClick={() => openEditModal(m)}
                    className="p-2 rounded-lg hover:bg-neutral-800 transition-colors text-neutral-400 hover:text-white"
                    title="Edit Title"
                  >
                    <Edit3 className="h-4 w-4" />
                  </button>

                  <Link
                    href={`/movies/${m.id}`}
                    target="_blank"
                    className="p-2 rounded-lg hover:bg-neutral-800 transition-colors text-neutral-400 hover:text-white"
                    title="View public page"
                  >
                    <ExternalLink className="h-4 w-4" />
                  </Link>

                  <button
                    onClick={() => handleDeleteMovie(m.id, m.title)}
                    className="p-2 rounded-lg hover:bg-red-500/10 text-neutral-500 hover:text-[#E50914] transition-colors"
                    title="Delete title"
                  >
                    <Trash2 className="h-4 w-4" />
                  </button>
                </div>
              </div>
            ))}
          </div>
        </div>
      )}

      {/* ======================================================== */}
      {/* TAB 8: COMMUNITY REQUESTS MANAGEMENT */}
      {/* ======================================================== */}
      {activeTab === 'requests' && (
        <div className="rounded-2xl p-6 space-y-4" style={{ background: 'var(--color-bg-card)', border: '1px solid var(--color-border)' }}>
          <div className="flex items-center justify-between">
            <h3 className="text-lg font-bold" style={{ color: 'var(--color-text)' }}>
              Community Subtitle Requests ({requestsList.length})
            </h3>
            <button
              onClick={fetchRequests}
              className="p-2 rounded-lg hover:bg-neutral-800 text-neutral-400 hover:text-white transition-colors"
              title="Refresh requests"
            >
              <RefreshCw className={`h-4 w-4 ${loadingRequests ? 'animate-spin' : ''}`} />
            </button>
          </div>

          {requestsList.length === 0 ? (
            <div className="p-8 text-center text-xs" style={{ color: 'var(--color-text-muted)' }}>
              No requests submitted yet.
            </div>
          ) : (
            <div className="divide-y" style={{ borderColor: 'var(--color-border)' }}>
              {requestsList.map((req) => (
                <div key={req.id} className="py-3 flex flex-col sm:flex-row sm:items-center justify-between gap-3">
                  <div>
                    <div className="font-bold text-sm" style={{ color: 'var(--color-text)' }}>{req.title}</div>
                    <div className="text-xs text-neutral-400 flex items-center gap-2 mt-0.5">
                      <span className="text-[10px] uppercase font-bold text-white bg-neutral-800 px-1.5 py-0.5 rounded">{req.type}</span>
                      <span>By {req.user?.email || 'Anonymous'}</span>
                      <span>• {new Date(req.createdAt).toLocaleDateString()}</span>
                    </div>
                  </div>

                  <div className="flex items-center gap-2">
                    <select
                      value={req.status}
                      onChange={(e) => handleUpdateRequestStatus(req.id, e.target.value)}
                      className="nf-input py-1 px-2.5 text-xs font-bold w-32"
                      style={{
                        color: req.status === 'FILLED' ? '#4ade80' : req.status === 'REJECTED' ? '#f87171' : '#facc15',
                      }}
                    >
                      <option value="PENDING">PENDING</option>
                      <option value="FILLED">FILLED ✓</option>
                      <option value="REJECTED">REJECTED ✗</option>
                    </select>
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>
      )}

      {/* ======================================================== */}
      {/* TAB 9: SEASONS & EPISODES MANAGEMENT */}
      {/* ======================================================== */}
      {activeTab === 'seasons' && (
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          {/* Left: TV Show Selector & Season List */}
          <div className="space-y-4">
            <div className="rounded-2xl p-5 space-y-3" style={{ background: 'var(--color-bg-card)', border: '1px solid var(--color-border)' }}>
              <label className="text-xs font-bold uppercase tracking-wider block" style={{ color: 'var(--color-text-muted)' }}>
                Select TV Series
              </label>
              <select
                value={seasonMovieId}
                onChange={(e) => {
                  setSeasonMovieId(e.target.value);
                  fetchSeasons(e.target.value);
                }}
                className="nf-input"
              >
                <option value="">-- Select a TV Series --</option>
                {initialMovies.filter(m => m.type === 'TV_SHOW').map((m) => (
                  <option key={m.id} value={m.id}>{m.title}</option>
                ))}
              </select>
            </div>

            {/* Quick Add Season Form */}
            {seasonMovieId && (
              <form onSubmit={handleAddSeason} className="rounded-2xl p-5 space-y-3" style={{ background: 'var(--color-bg-card)', border: '1px solid var(--color-border)' }}>
                <h3 className="text-sm font-bold flex items-center gap-2" style={{ color: 'var(--color-text)' }}>
                  <Plus className="h-4 w-4 text-emerald-400" />
                  Add New Season
                </h3>
                <div className="grid grid-cols-2 gap-2">
                  <input
                    type="number"
                    min={1}
                    value={newSeasonNum}
                    onChange={e => setNewSeasonNum(e.target.value)}
                    placeholder="Season No. (e.g. 1)"
                    className="nf-input text-xs"
                    required
                  />
                  <input
                    type="text"
                    value={newSeasonTitle}
                    onChange={e => setNewSeasonTitle(e.target.value)}
                    placeholder="Title (e.g. Season 1)"
                    className="nf-input text-xs"
                  />
                </div>
                <button
                  type="submit"
                  disabled={loading}
                  className="nf-btn-primary w-full justify-center py-2 text-xs font-bold disabled:opacity-40"
                >
                  {loading ? <Loader2 className="h-3.5 w-3.5 animate-spin" /> : <Plus className="h-3.5 w-3.5" />}
                  Create Season
                </button>
              </form>
            )}

            {/* Seasons Accordion */}
            <div className="space-y-2">
              {seasonsList.map((s: any) => (
                <div key={s.id} className="rounded-xl border overflow-hidden" style={{ borderColor: 'var(--color-border)', background: 'var(--color-bg-card)' }}>
                  <button
                    type="button"
                    onClick={() => setExpandedSeason(expandedSeason === s.id ? null : s.id)}
                    className="w-full px-4 py-3 flex items-center justify-between hover:bg-neutral-800/30 transition-colors"
                  >
                    <div className="text-left">
                      <p className="text-xs font-bold" style={{ color: 'var(--color-text)' }}>{s.title || `Season ${s.seasonNumber}`}</p>
                      <p className="text-[10px] text-neutral-500">{s.episodes?.length || 0} episodes • {s.releaseDate || 'N/A'}</p>
                    </div>
                    <div className="flex items-center gap-2">
                      <button onClick={e => { e.stopPropagation(); handleDeleteSeason(s.id); }} className="p-1.5 rounded text-neutral-600 hover:text-[#E50914] transition-colors">
                        <Trash2 className="h-3.5 w-3.5" />
                      </button>
                      {expandedSeason === s.id ? <ChevronDown className="h-4 w-4 text-neutral-500" /> : <ChevronRight className="h-4 w-4 text-neutral-500" />}
                    </div>
                  </button>

                  {/* Episode list for this season */}
                  {expandedSeason === s.id && (
                    <div className="px-4 pb-3 space-y-1.5" style={{ borderTop: '1px solid var(--color-border)', background: 'var(--color-bg-elevated)' }}>
                      {s.episodes?.map((ep: any) => (
                        <div key={ep.id} className="flex items-center justify-between text-xs py-1.5">
                          <div>
                            <span className="font-bold text-[#E50914]">E{ep.episodeNumber}</span>
                            <span className="ml-2" style={{ color: 'var(--color-text)' }}>{ep.title || `Episode ${ep.episodeNumber}`}</span>
                            <span className="ml-2 text-neutral-500 text-[10px]">
                              {ep.subtitles?.length > 0 ? '✓ Sub' : '–'} • {ep.telegramLinks?.length > 0 ? `✓ ${ep.telegramLinks.length} link(s)` : '– No links'}
                            </span>
                          </div>
                          <button onClick={() => handleDeleteEpisode(ep.id)} className="p-1 rounded text-neutral-600 hover:text-[#E50914]">
                            <Trash2 className="h-3 w-3" />
                          </button>
                        </div>
                      ))}
                      {/* Quick add episode from within season */}
                      <button
                        onClick={() => setAddEpSeasonId(s.id)}
                        className="w-full flex items-center justify-center gap-1.5 py-1.5 rounded-lg text-[11px] font-bold text-emerald-400 hover:bg-emerald-500/10 transition-colors border border-dashed border-emerald-500/30"
                      >
                        <Plus className="h-3.5 w-3.5" />
                        Add Episode to this Season
                      </button>
                    </div>
                  )}
                </div>
              ))}
            </div>
          </div>

          {/* Right: Add Episode form */}
          <div className="rounded-2xl p-5 space-y-4" style={{ background: 'var(--color-bg-card)', border: '1px solid var(--color-border)' }}>
            <h3 className="text-sm font-black flex items-center gap-2" style={{ color: 'var(--color-text)' }}>
              <Plus className="h-4 w-4 text-emerald-400" />
              Add / Update Episode
            </h3>

            <form onSubmit={handleAddEpisode} className="space-y-3">
              <div>
                <label className="text-[10px] font-bold uppercase tracking-wider block mb-1" style={{ color: 'var(--color-text-muted)' }}>Season</label>
                <select value={addEpSeasonId} onChange={e => setAddEpSeasonId(e.target.value)} className="nf-input" required>
                  <option value="">-- Select a Season --</option>
                  {seasonsList.map((s: any) => (
                    <option key={s.id} value={s.id}>{s.title || `Season ${s.seasonNumber}`} ({s.episodes?.length || 0} eps)</option>
                  ))}
                </select>
              </div>

              <div className="grid grid-cols-3 gap-2">
                <div>
                  <label className="text-[10px] font-bold uppercase tracking-wider block mb-1" style={{ color: 'var(--color-text-muted)' }}>Ep. No.*</label>
                  <input type="number" min={1} required value={epNum} onChange={e => setEpNum(e.target.value)} placeholder="1" className="nf-input" />
                </div>
                <div>
                  <label className="text-[10px] font-bold uppercase tracking-wider block mb-1" style={{ color: 'var(--color-text-muted)' }}>Runtime (min)</label>
                  <input type="number" min={1} value={epRuntime} onChange={e => setEpRuntime(e.target.value)} placeholder="45" className="nf-input" />
                </div>
                <div>
                  <label className="text-[10px] font-bold uppercase tracking-wider block mb-1" style={{ color: 'var(--color-text-muted)' }}>IMDb Rating</label>
                  <input type="number" step="0.1" min={0} max={10} value={epImdbRating} onChange={e => setEpImdbRating(e.target.value)} placeholder="8.5" className="nf-input" />
                </div>
              </div>

              <div>
                <label className="text-[10px] font-bold uppercase tracking-wider block mb-1" style={{ color: 'var(--color-text-muted)' }}>Episode Title</label>
                <input type="text" value={epTitle} onChange={e => setEpTitle(e.target.value)} placeholder="e.g. The Vanishing of Will Byers" className="nf-input" />
              </div>

              <div>
                <label className="text-[10px] font-bold uppercase tracking-wider block mb-1" style={{ color: 'var(--color-text-muted)' }}>Air Date (YYYY-MM-DD)</label>
                <input type="text" value={epAirDate} onChange={e => setEpAirDate(e.target.value)} placeholder="2023-01-15" className="nf-input" />
              </div>

              <div>
                <label className="text-[10px] font-bold uppercase tracking-wider block mb-1" style={{ color: 'var(--color-text-muted)' }}>Episode Synopsis</label>
                <textarea rows={2} value={epDesc} onChange={e => setEpDesc(e.target.value)} placeholder="Episode plot summary..." className="nf-input" />
              </div>

              {/* Subtitle for this episode */}
              <div className="space-y-2 pt-2 border-t" style={{ borderColor: 'var(--color-border)' }}>
                <p className="text-[10px] font-bold uppercase tracking-wider flex items-center gap-1.5 text-[#E50914]">
                  <Download className="h-3 w-3" /> Sinhala Subtitle (optional)
                </p>
                <input type="text" value={epSubFileName} onChange={e => setEpSubFileName(e.target.value)} placeholder="Series.S01E01.1080p.Sinhala.srt" className="nf-input text-xs" />
                <input type="url" value={epSubFileUrl} onChange={e => setEpSubFileUrl(e.target.value)} placeholder="https://... subtitle download URL" className="nf-input text-xs" />
              </div>

              {/* Telegram link for this episode */}
              <div className="space-y-2 pt-2 border-t" style={{ borderColor: 'var(--color-border)' }}>
                <p className="text-[10px] font-bold uppercase tracking-wider flex items-center gap-1.5 text-sky-400">
                  <Send className="h-3 w-3" /> Telegram Download Link (optional)
                </p>
                <div className="grid grid-cols-2 gap-2">
                  <input type="text" value={epTgQuality} onChange={e => setEpTgQuality(e.target.value)} placeholder="1080p Full HD" className="nf-input text-xs" />
                  <input type="text" value={epTgSize} onChange={e => setEpTgSize(e.target.value)} placeholder="650 MB" className="nf-input text-xs" />
                </div>
                <input type="text" value={epTgLabel} onChange={e => setEpTgLabel(e.target.value)} placeholder="x265 HEVC" className="nf-input text-xs" />
                <input type="url" value={epTgUrl} onChange={e => setEpTgUrl(e.target.value)} placeholder="https://t.me/PixelSubzLk/12345" className="nf-input text-xs" />
              </div>

              <button type="submit" disabled={loading || !addEpSeasonId} className="nf-btn-primary w-full justify-center py-2.5 text-sm disabled:opacity-40">
                {loading ? <Loader2 className="h-4 w-4 animate-spin" /> : <Plus className="h-4 w-4" />}
                Save Episode + Subtitle + Telegram Link
              </button>
            </form>
          </div>
        </div>
      )}

      {/* EDIT MODAL DIALOG */}
      {editingMovie && (
        <div className="fixed inset-0 z-50 bg-black/80 backdrop-blur-sm flex items-center justify-center p-4">
          <div className="w-full max-w-2xl max-h-[90vh] overflow-y-auto rounded-2xl p-6 sm:p-8 space-y-6 shadow-2xl" style={{ background: 'var(--color-bg)', border: '1px solid var(--color-border)' }}>
            <div className="flex items-center justify-between border-b pb-4" style={{ borderColor: 'var(--color-border)' }}>
              <h3 className="text-xl font-bold" style={{ color: 'var(--color-text)' }}>
                Edit &ldquo;{editingMovie.title}&rdquo;
              </h3>
              <button
                onClick={() => setEditingMovie(null)}
                className="p-1.5 rounded-full hover:bg-neutral-800 text-neutral-400 hover:text-white transition-colors"
              >
                <X className="h-5 w-5" />
              </button>
            </div>

            <form onSubmit={handleUpdateMovie} className="space-y-4">
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <div>
                  <label className="block text-xs font-semibold uppercase tracking-wider mb-1.5" style={{ color: 'var(--color-text-muted)' }}>Title</label>
                  <input type="text" required value={editTitle} onChange={e => setEditTitle(e.target.value)} className="nf-input" />
                </div>
                <div>
                  <label className="block text-xs font-semibold uppercase tracking-wider mb-1.5" style={{ color: 'var(--color-text-muted)' }}>Original Title</label>
                  <input type="text" value={editOriginalTitle} onChange={e => setEditOriginalTitle(e.target.value)} className="nf-input" />
                </div>
              </div>

              <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
                <div>
                  <label className="block text-xs font-semibold uppercase tracking-wider mb-1.5" style={{ color: 'var(--color-text-muted)' }}>Format Type</label>
                  <select value={editType} onChange={e => setEditType(e.target.value)} className="nf-input">
                    <option value="MOVIE">MOVIE</option>
                    <option value="TV_SHOW">TV_SHOW</option>
                  </select>
                </div>
                <div>
                  <label className="block text-xs font-semibold uppercase tracking-wider mb-1.5" style={{ color: 'var(--color-text-muted)' }}>Release Date</label>
                  <input type="text" value={editReleaseDate} onChange={e => setEditReleaseDate(e.target.value)} placeholder="YYYY-MM-DD" className="nf-input" />
                </div>
                <div>
                  <label className="block text-xs font-semibold uppercase tracking-wider mb-1.5" style={{ color: 'var(--color-text-muted)' }}>TMDB ID</label>
                  <input type="text" value={editTmdbId} onChange={e => setEditTmdbId(e.target.value)} placeholder="e.g. 533535" className="nf-input" />
                </div>
              </div>

              <div>
                <label className="block text-xs font-semibold uppercase tracking-wider mb-1.5" style={{ color: 'var(--color-text-muted)' }}>Poster Image URL</label>
                <input type="url" value={editPosterPath} onChange={e => setEditPosterPath(e.target.value)} className="nf-input" />
              </div>

              <div>
                <label className="block text-xs font-semibold uppercase tracking-wider mb-1.5" style={{ color: 'var(--color-text-muted)' }}>Backdrop Image URL</label>
                <input type="url" value={editBackdropPath} onChange={e => setEditBackdropPath(e.target.value)} className="nf-input" />
              </div>

              <div>
                <label className="block text-xs font-semibold uppercase tracking-wider mb-1.5" style={{ color: 'var(--color-text-muted)' }}>Description / Synopsis</label>
                <textarea rows={3} value={editDescription} onChange={e => setEditDescription(e.target.value)} className="nf-input" />
              </div>

              <div className="flex items-center justify-end gap-3 pt-3 border-t" style={{ borderColor: 'var(--color-border)' }}>
                <button
                  type="button"
                  onClick={() => setEditingMovie(null)}
                  className="px-4 py-2 rounded-xl text-xs font-bold hover:bg-neutral-800 text-neutral-400"
                >
                  Cancel
                </button>
                <button
                  type="submit"
                  disabled={loading}
                  className="nf-btn-primary px-5 py-2 text-xs font-bold"
                >
                  {loading ? <Loader2 className="h-4 w-4 animate-spin" /> : null}
                  <span>Save Changes</span>
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

    </div>
  );
}
