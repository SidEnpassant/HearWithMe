import 'package:get_it/get_it.dart';

/// Global service locator instance.
final getIt = GetIt.instance;

/// Initialize all dependency injection bindings.
///
/// Called once at app startup before runApp().
/// When injectable codegen is added later, this will
/// call `$initGetIt(getIt)` from the generated config.
Future<void> configureDependencies() async {
  // TODO(injectable): Replace with generated config in Level 4
  // await $initGetIt(getIt);
}
