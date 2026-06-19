import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hearwithme/core/theme/app_colors.dart';
import 'package:hearwithme/features/discover/presentation/pages/discover_page.dart';
import 'package:hearwithme/features/home/presentation/pages/home_page.dart';
import 'package:hearwithme/features/library/presentation/pages/library_page.dart';
import 'package:hearwithme/features/marketplace/presentation/pages/marketplace_page.dart';
import 'package:hearwithme/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:hearwithme/features/p2p/presentation/pages/mesh_chat_page.dart';
import 'package:hearwithme/features/p2p/presentation/pages/p2p_discovery_page.dart';
import 'package:hearwithme/features/p2p/presentation/pages/silent_disco_page.dart';
import 'package:hearwithme/features/player/presentation/pages/player_page.dart';
import 'package:hearwithme/features/settings/presentation/pages/settings_page.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// App-level route paths.
abstract final class AppRoutes {
  static const home = '/';
  static const discover = '/discover';
  static const p2p = '/p2p';
  static const library = '/library';
  static const settings = '/settings';
  static const onboarding = '/onboarding';
  static const player = '/player';
  static const meshChat = '/mesh-chat';
  static const silentDisco = '/silent-disco';
  static const marketplace = '/marketplace';
}

/// GoRouter configuration with bottom navigation shell.
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.onboarding,
  routes: [
    // Onboarding (no bottom nav)
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) => const OnboardingPage(),
    ),

    // Full-screen player (modal)
    GoRoute(
      path: AppRoutes.player,
      builder: (context, state) => const PlayerPage(),
    ),

    // Mesh Chat
    GoRoute(
      path: AppRoutes.meshChat,
      builder: (context, state) => const MeshChatPage(),
    ),

    // Silent Disco
    GoRoute(
      path: AppRoutes.silentDisco,
      builder: (context, state) => const SilentDiscoPage(),
    ),

    // Marketplace
    GoRoute(
      path: AppRoutes.marketplace,
      builder: (context, state) => const MarketplacePage(),
    ),

    ShellRoute(
      builder: (context, state, child) {
        return _AppShell(child: child);
      },
      routes: [
        GoRoute(
          path: AppRoutes.home,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HomePage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.discover,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: DiscoverPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.p2p,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: P2PDiscoveryPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.library,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: LibraryPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.settings,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: SettingsPage(),
          ),
        ),
      ],
    ),
  ],
);

/// App shell with bottom navigation bar and mini player slot.
class _AppShell extends StatelessWidget {
  const _AppShell({required this.child});

  final Widget child;

  static const _tabs = [
    AppRoutes.home,
    AppRoutes.discover,
    AppRoutes.p2p,
    AppRoutes.library,
    AppRoutes.settings,
  ];

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final index = _tabs.indexWhere(location.startsWith);
    return index >= 0 ? index : 0;
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _currentIndex(context);

    return Scaffold(
      body: child,
      // TODO(Level3): Replace with custom mini player bar + bottom nav widget
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.surfacePrimary,
          border: Border(
            top: BorderSide(color: AppColors.glassBorder, width: 0.5),
          ),
        ),
        child: NavigationBar(
          selectedIndex: selectedIndex,
          backgroundColor: Colors.transparent,
          indicatorColor: AppColors.accentPrimary.withValues(alpha: 0.15),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          onDestinationSelected: (index) {
            context.go(_tabs[index]);
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(LucideIcons.house, size: 22),
              selectedIcon: Icon(
                LucideIcons.house,
                size: 22,
                color: AppColors.accentPrimary,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(LucideIcons.search, size: 22),
              selectedIcon: Icon(
                LucideIcons.search,
                size: 22,
                color: AppColors.accentPrimary,
              ),
              label: 'Discover',
            ),
            NavigationDestination(
              icon: Icon(LucideIcons.radioReceiver, size: 22),
              selectedIcon: Icon(
                LucideIcons.radioReceiver,
                size: 22,
                color: AppColors.accentPrimary,
              ),
              label: 'P2P',
            ),
            NavigationDestination(
              icon: Icon(LucideIcons.library, size: 22),
              selectedIcon: Icon(
                LucideIcons.library,
                size: 22,
                color: AppColors.accentPrimary,
              ),
              label: 'Library',
            ),
            NavigationDestination(
              icon: Icon(LucideIcons.settings, size: 22),
              selectedIcon: Icon(
                LucideIcons.settings,
                size: 22,
                color: AppColors.accentPrimary,
              ),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
