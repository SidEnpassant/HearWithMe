/// Network and P2P protocol constants.
abstract final class NetworkConstants {
  /// TCP server default port (0 = OS-assigned).
  static const tcpServerPort = 0;

  /// UDP broadcast port for local discovery.
  static const udpBroadcastPort = 41234;

  /// Loopback address for local HTTP stream server.
  static const loopbackAddress = '127.0.0.1';

  /// mDNS/NSD service type.
  static const nsdServiceType = '_hearwithme._tcp';

  /// Heartbeat interval for peer presence.
  static const heartbeatInterval = Duration(seconds: 2);

  /// Peer timeout threshold.
  static const peerTimeout = Duration(seconds: 10);

  /// Mesh failover target time.
  static const meshFailoverTarget = Duration(milliseconds: 300);

  /// Clock sync UDP interval.
  static const clockSyncInterval = Duration(seconds: 5);

  /// Maximum drift before hard seek (ms).
  static const maxDriftBeforeSeekMs = 200;

  /// Playback sync broadcast interval.
  static const syncBroadcastInterval = Duration(milliseconds: 500);

  /// Socket reconnection base delay.
  static const reconnectBaseDelay = Duration(seconds: 1);

  /// Maximum reconnection attempts.
  static const maxReconnectAttempts = 5;

  /// Jamendo API base URL.
  static const jamendoBaseUrl = 'https://api.jamendo.com/v3.0';

  /// Podcast Index API base URL.
  static const podcastIndexBaseUrl = 'https://api.podcastindex.org/api/1.0';

  /// iTunes Search API base URL.
  static const itunesSearchBaseUrl = 'https://itunes.apple.com';

  /// MusicBrainz API base URL.
  static const musicBrainzBaseUrl = 'https://musicbrainz.org/ws/2';

  /// MusicBrainz rate limit delay.
  static const musicBrainzRateDelay = Duration(seconds: 1);

  /// Jamendo monthly rate limit.
  static const jamendoMonthlyRateLimit = 35000;

  /// iTunes rate limit (requests per minute).
  static const itunesRatePerMinute = 20;
}
