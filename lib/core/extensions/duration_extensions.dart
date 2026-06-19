/// Extensions on [Duration] for human-readable formatting.
extension DurationExtensions on Duration {
  /// Formats as `mm:ss` (e.g., `03:42`).
  String get mmss {
    final minutes = inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  /// Formats as `HH:mm:ss` (e.g., `01:03:42`).
  String get hhmmss {
    final hours = inHours.toString().padLeft(2, '0');
    final minutes = inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  /// Smart format: uses `mm:ss` if under an hour, `HH:mm:ss` otherwise.
  String get formatted => inHours > 0 ? hhmmss : mmss;

  /// Human-readable relative text (e.g., "3 min", "1 hr 20 min").
  String get humanReadable {
    if (inHours > 0) {
      final mins = inMinutes.remainder(60);
      return mins > 0 ? '$inHours hr $mins min' : '$inHours hr';
    }
    if (inMinutes > 0) return '$inMinutes min';
    return '$inSeconds sec';
  }
}
