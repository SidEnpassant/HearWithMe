import 'dart:async';

/// Debounces calls to action by delay.
///
/// Usage:
/// ```dart
/// final debouncer = Debouncer(delay: Duration(milliseconds: 300));
/// debouncer.run(() => searchApi(query));
/// ```
class Debouncer {
  Debouncer({this.delay = const Duration(milliseconds: 300)});

  final Duration delay;
  Timer? _timer;

  /// Schedule [action] after [delay]. Cancels any pending action.
  void run(void Function() action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  /// Cancel any pending action.
  void cancel() {
    _timer?.cancel();
    _timer = null;
  }

  /// Whether a debounced action is currently pending.
  bool get isPending => _timer?.isActive ?? false;

  /// Clean up timer resources.
  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}
