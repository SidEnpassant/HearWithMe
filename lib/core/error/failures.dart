/// Domain-level failure types for the Result pattern.
///
/// Used in domain layer to communicate errors without
/// leaking data-layer implementation details.
sealed class Failure {
  const Failure({this.message = ''});

  final String message;

  @override
  String toString() => 'Failure: $message';
}

/// Network-related failure (timeout, no connection, etc.).
final class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'A network error occurred'});
}

/// Server returned an unexpected response.
final class ServerFailure extends Failure {
  const ServerFailure({
    super.message = 'Server error',
    this.statusCode,
  });

  final int? statusCode;
}

/// Local database read/write failure.
final class DatabaseFailure extends Failure {
  const DatabaseFailure({super.message = 'Database error'});
}

/// Cache-related failure (eviction, corruption).
final class CacheFailure extends Failure {
  const CacheFailure({super.message = 'Cache error'});
}

/// File system operation failure.
final class FileSystemFailure extends Failure {
  const FileSystemFailure({super.message = 'File system error'});
}

/// Audio playback failure.
final class PlaybackFailure extends Failure {
  const PlaybackFailure({super.message = 'Playback error'});
}

/// P2P connection / discovery failure.
final class P2PFailure extends Failure {
  const P2PFailure({super.message = 'P2P connection error'});
}

/// Cryptographic operation failure.
final class CryptoFailure extends Failure {
  const CryptoFailure({super.message = 'Cryptography error'});
}

/// Input validation failure.
final class ValidationFailure extends Failure {
  const ValidationFailure({super.message = 'Validation error'});
}

/// Permission denied failure.
final class PermissionFailure extends Failure {
  const PermissionFailure({super.message = 'Permission denied'});
}

/// Rate limit exceeded for an external API.
final class RateLimitFailure extends Failure {
  const RateLimitFailure({
    super.message = 'Rate limit exceeded',
    this.retryAfter,
  });

  final Duration? retryAfter;
}
