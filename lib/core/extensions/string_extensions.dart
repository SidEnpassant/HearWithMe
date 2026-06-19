/// Extensions on [String] for common text manipulation.
extension StringExtensions on String {
  /// Truncates the string to [maxLength] and appends ellipsis if needed.
  String truncate(int maxLength) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}…';
  }

  /// Capitalizes the first letter.
  String get capitalized {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Capitalizes each word in the string.
  String get titleCase {
    return split(' ').map((word) => word.capitalized).join(' ');
  }

  /// Returns the initials (first letter of first two words).
  String get initials {
    final words = trim().split(RegExp(r'\s+'));
    if (words.isEmpty) return '';
    if (words.length == 1) return words[0][0].toUpperCase();
    return '${words[0][0]}${words[1][0]}'.toUpperCase();
  }

  /// Formats byte count as human-readable (e.g., "1.2 GB").
  static String formatBytes(int bytes, {int decimals = 1}) {
    if (bytes <= 0) return '0 B';
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB'];
    final i = (bytes == 0)
        ? 0
        : (bytes.bitLength - 1) ~/ 10; // log2(bytes) / 10
    final adjustedI = i.clamp(0, suffixes.length - 1);
    final value = bytes / (1 << (10 * adjustedI));
    return '${value.toStringAsFixed(decimals)} ${suffixes[adjustedI]}';
  }
}
