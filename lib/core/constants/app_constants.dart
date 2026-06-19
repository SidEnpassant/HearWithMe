/// App-wide constants for HearWithMe.
abstract final class AppConstants {
  /// Application name.
  static const appName = 'HearWithMe';

  /// Application version string.
  static const appVersion = '1.0.0';

  /// Maximum cache size in bytes (default 2GB).
  static const defaultMaxCacheBytes = 2 * 1024 * 1024 * 1024; // 2 GB

  /// Chunk size for audio file splitting in bytes (512KB).
  static const chunkSizeBytes = 512 * 1024; // 512 KB

  /// Maximum concurrent downloads.
  static const maxConcurrentDownloads = 3;

  /// Cache TTL for API search results (24 hours).
  static const searchCacheTtl = Duration(hours: 24);

  /// Cache TTL for artist/album metadata (7 days).
  static const metadataCacheTtl = Duration(days: 7);

  /// Display name constraints.
  static const displayNameMinLength = 3;
  static const displayNameMaxLength = 20;

  /// Maximum peer connections for Silent Disco.
  static const maxPeerConnections = 8;

  /// Ring buffer slots count.
  static const ringBufferSlots = 8;

  /// Ring buffer memory cap (4MB).
  static const ringBufferMaxBytes = 4 * 1024 * 1024; // 4 MB

  /// Preload ahead size in bytes (5MB).
  static const preloadAheadBytes = 5 * 1024 * 1024; // 5 MB
}
