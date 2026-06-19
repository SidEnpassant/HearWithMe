import 'package:flutter/material.dart';
import 'package:hearwithme/core/theme/app_theme.dart';
import 'package:hearwithme/router.dart';

/// Root application widget.
class HearWithMeApp extends StatelessWidget {
  const HearWithMeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'HearWithMe',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      routerConfig: appRouter,
    );
  }
}
