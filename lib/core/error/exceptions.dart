// Data-layer exceptions that get caught and converted to Failures
// by repository implementations.

/// Thrown when a network request fails.
class NetworkException implements Exception {
  const NetworkException({this.message = 'Network error', this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => 'NetworkException($statusCode): $message';
}

/// Thrown when local database operations fail.
class DatabaseException implements Exception {
  const DatabaseException({this.message = 'Database error'});

  final String message;

  @override
  String toString() => 'DatabaseException: $message';
}

/// Thrown when cache lookup returns nothing.
class CacheException implements Exception {
  const CacheException({this.message = 'No cached data found'});

  final String message;

  @override
  String toString() => 'CacheException: $message';
}

/// Thrown when a file system operation fails.
class FileSystemException implements Exception {
  const FileSystemException({this.message = 'File system error'});

  final String message;

  @override
  String toString() => 'FileSystemException: $message';
}

/// Thrown when an API rate limit is hit.
class RateLimitException implements Exception {
  const RateLimitException({
    this.message = 'Rate limit exceeded',
    this.retryAfter,
  });

  final String message;
  final Duration? retryAfter;

  @override
  String toString() => 'RateLimitException: $message';
}

/// Thrown when RSS/XML parsing fails.
class ParseException implements Exception {
  const ParseException({this.message = 'Parse error'});

  final String message;

  @override
  String toString() => 'ParseException: $message';
}
