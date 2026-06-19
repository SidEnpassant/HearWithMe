
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hearwithme/core/constants/ui_constants.dart';
import 'package:hearwithme/core/theme/app_colors.dart';
import 'package:hearwithme/core/theme/app_text_styles.dart';
import 'package:hearwithme/core/widgets/glass_container.dart';
import 'package:go_router/go_router.dart';

/// Home Dashboard — hero screen with welcome, peers, trending, and quick actions.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: UIConstants.spacing20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: UIConstants.spacing16),
              // Welcome header
              const _WelcomeHeader()
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .slideX(begin: -0.1, end: 0, curve: Curves.easeOut),

              const SizedBox(height: UIConstants.spacing24),

              // Nearby peers card
              const _NearbyPeersCard()
                  .animate()
                  .fadeIn(delay: 150.ms, duration: 500.ms)
                  .slideY(begin: 0.15, end: 0),

              const SizedBox(height: UIConstants.spacing24),

              // Quick actions
              const _QuickActionsRow()
                  .animate()
                  .fadeIn(delay: 250.ms, duration: 500.ms)
                  .slideY(begin: 0.15, end: 0),

              const SizedBox(height: UIConstants.spacing32),

              // Trending Music section
              _SectionHeader(
                title: 'Trending Music',
                subtitle: 'From Jamendo',
                onSeeAll: () => context.go('/discover'),
              )
                  .animate()
                  .fadeIn(delay: 350.ms, duration: 500.ms),

              const SizedBox(height: UIConstants.spacing12),

              const _TrendingMusicRow()
                  .animate()
                  .fadeIn(delay: 400.ms, duration: 500.ms),

              const SizedBox(height: UIConstants.spacing32),

              // Trending Podcasts section
              _SectionHeader(
                title: 'Popular Podcasts',
                subtitle: 'From Podcast Index',
                onSeeAll: () => context.go('/discover'),
              )
                  .animate()
                  .fadeIn(delay: 500.ms, duration: 500.ms),

              const SizedBox(height: UIConstants.spacing12),

              const _TrendingPodcastRow()
                  .animate()
                  .fadeIn(delay: 550.ms, duration: 500.ms),

              const SizedBox(height: UIConstants.spacing32),

              // Recent listens
              _SectionHeader(
                title: 'Recent Listens',
                subtitle: 'Continue where you left off',
                onSeeAll: () => context.go('/library'),
              )
                  .animate()
                  .fadeIn(delay: 650.ms, duration: 500.ms),

              const SizedBox(height: UIConstants.spacing12),

              const _RecentListensCarousel()
                  .animate()
                  .fadeIn(delay: 700.ms, duration: 500.ms),

              const SizedBox(height: UIConstants.spacing32),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Welcome Header ──

class _WelcomeHeader extends StatelessWidget {
  const _WelcomeHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Avatar
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.accentGradient,
          ),
          child: const Center(
            child: Text('🎧', style: TextStyle(fontSize: 24)),
          ),
        ),
        const SizedBox(width: UIConstants.spacing12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome back', style: AppTextStyles.bodyMedium),
              const SizedBox(height: 2),
              Text(
                'Music Lover', // TODO(Level4): Read from identity
                style: AppTextStyles.headlineMedium,
              ),
            ],
          ),
        ),
        // Notification bell
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.surfacePrimary,
            border: Border.all(color: AppColors.glassBorder),
          ),
          child: const Icon(
            Icons.notifications_none_rounded,
            color: AppColors.textSecondary,
            size: 22,
          ),
        ),
      ],
    );
  }
}

// ── Nearby Peers Card ──

class _NearbyPeersCard extends StatelessWidget {
  const _NearbyPeersCard();

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(UIConstants.spacing20),
      child: Row(
        children: [
          // Animated radar icon
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.accentPrimary.withValues(alpha: 0.12),
            ),
            child: const Icon(
              Icons.radar_rounded,
              color: AppColors.accentPrimary,
              size: 28,
            ),
          )
              .animate(
                onPlay: (c) => c.repeat(reverse: true),
              )
              .scale(
                begin: const Offset(0.95, 0.95),
                end: const Offset(1.05, 1.05),
                duration: 2000.ms,
                curve: Curves.easeInOut,
              ),
          const SizedBox(width: UIConstants.spacing16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('3 peers nearby', style: AppTextStyles.titleMedium),
                    const SizedBox(width: 8),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.peerOnline,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Tap to discover and connect',
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: AppColors.textTertiary,
          ),
        ],
      ),
    );
  }
}

// ── Quick Actions Row ──

class _QuickActionsRow extends StatelessWidget {
  const _QuickActionsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _QuickActionChip(
          icon: Icons.cell_tower_rounded,
          label: 'Broadcast',
          color: AppColors.accentPrimary,
          onTap: () {},
        ),
        const SizedBox(width: UIConstants.spacing12),
        _QuickActionChip(
          icon: Icons.group_rounded,
          label: 'Join Mesh',
          color: AppColors.info,
          onTap: () => context.go('/p2p'),
        ),
        const SizedBox(width: UIConstants.spacing12),
        _QuickActionChip(
          icon: Icons.library_music_rounded,
          label: 'Library',
          color: AppColors.success,
          onTap: () => context.go('/library'),
        ),
      ],
    );
  }
}

class _QuickActionChip extends StatelessWidget {
  const _QuickActionChip({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: UIConstants.spacing12,
            horizontal: UIConstants.spacing8,
          ),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(UIConstants.radiusLarge),
            border: Border.all(color: color.withValues(alpha: 0.15)),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 6),
              Text(
                label,
                style: AppTextStyles.labelMedium.copyWith(color: color),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Section Header ──

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.subtitle,
    required this.onSeeAll,
  });

  final String title;
  final String subtitle;
  final VoidCallback onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.headlineMedium),
              const SizedBox(height: 2),
              Text(subtitle, style: AppTextStyles.bodySmall),
            ],
          ),
        ),
        TextButton(
          onPressed: onSeeAll,
          child: Text(
            'See All',
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.accentPrimary,
            ),
          ),
        ),
      ],
    );
  }
}

// ── Trending Music Row (mock data) ──

class _TrendingMusicRow extends StatelessWidget {
  const _TrendingMusicRow();

  static const _mockTracks = [
    _MockTrack('Sunset Waves', 'Luna Echo', '🌊', Color(0xFF1E88E5)),
    _MockTrack('Electric Dreams', 'Neon Pulse', '⚡', Color(0xFFE53935)),
    _MockTrack('Midnight Jazz', 'Blue Notes', '🎷', Color(0xFF7B1FA2)),
    _MockTrack('Forest Rain', 'Ambient Sky', '🌿', Color(0xFF43A047)),
    _MockTrack('City Lights', 'Synthwave', '🌃', Color(0xFFFF8F00)),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _mockTracks.length,
        separatorBuilder: (_, __) =>
            const SizedBox(width: UIConstants.spacing12),
        itemBuilder: (context, index) {
          final track = _mockTracks[index];
          return _MusicCard(track: track, index: index);
        },
      ),
    );
  }
}

class _MockTrack {
  const _MockTrack(this.title, this.artist, this.emoji, this.color);
  final String title;
  final String artist;
  final String emoji;
  final Color color;
}

class _MusicCard extends StatelessWidget {
  const _MusicCard({required this.track, required this.index});

  final _MockTrack track;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Album art placeholder
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(UIConstants.radiusLarge),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  track.color.withValues(alpha: 0.7),
                  track.color.withValues(alpha: 0.3),
                ],
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: Text(
                    track.emoji,
                    style: const TextStyle(fontSize: 48),
                  ),
                ),
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withValues(alpha: 0.5),
                    ),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            track.title,
            style: AppTextStyles.labelLarge,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            track.artist,
            style: AppTextStyles.bodySmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: 100 * index),
          duration: 400.ms,
        )
        .slideX(
          begin: 0.2,
          end: 0,
          delay: Duration(milliseconds: 100 * index),
          curve: Curves.easeOutQuart,
        );
  }
}

// ── Trending Podcast Row (mock data) ──

class _TrendingPodcastRow extends StatelessWidget {
  const _TrendingPodcastRow();

  static const _mockPodcasts = [
    _MockPodcast('Tech Daily', 'Tech News', '🎙️', Color(0xFF00ACC1)),
    _MockPodcast('True Stories', 'Crime Tales', '🔍', Color(0xFFD32F2F)),
    _MockPodcast('Science Hour', 'Discovery Co.', '🔬', Color(0xFF388E3C)),
    _MockPodcast('Startup Life', 'Founders Hub', '🚀', Color(0xFFFF6F00)),
    _MockPodcast('Comedy Club', 'Laugh Studio', '😂', Color(0xFF8E24AA)),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _mockPodcasts.length,
        separatorBuilder: (_, __) =>
            const SizedBox(width: UIConstants.spacing12),
        itemBuilder: (context, index) {
          final podcast = _mockPodcasts[index];
          return _PodcastTile(podcast: podcast, index: index);
        },
      ),
    );
  }
}

class _MockPodcast {
  const _MockPodcast(this.title, this.author, this.emoji, this.color);
  final String title;
  final String author;
  final String emoji;
  final Color color;
}

class _PodcastTile extends StatelessWidget {
  const _PodcastTile({required this.podcast, required this.index});

  final _MockPodcast podcast;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(UIConstants.spacing12),
      decoration: BoxDecoration(
        color: AppColors.surfacePrimary,
        borderRadius: BorderRadius.circular(UIConstants.radiusLarge),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(UIConstants.radiusMedium),
              color: podcast.color.withValues(alpha: 0.2),
            ),
            child: Center(
              child: Text(podcast.emoji, style: const TextStyle(fontSize: 32)),
            ),
          ),
          const SizedBox(width: UIConstants.spacing12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  podcast.title,
                  style: AppTextStyles.labelLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  podcast.author,
                  style: AppTextStyles.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      Icons.headphones_rounded,
                      size: 12,
                      color: AppColors.textTertiary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${42 + index * 7} episodes',
                      style: AppTextStyles.labelSmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: 100 * index),
          duration: 400.ms,
        )
        .slideX(
          begin: 0.2,
          end: 0,
          delay: Duration(milliseconds: 100 * index),
          curve: Curves.easeOutQuart,
        );
  }
}

// ── Recent Listens Carousel (mock data) ──

class _RecentListensCarousel extends StatelessWidget {
  const _RecentListensCarousel();

  static const _recentItems = [
    _MockTrack('Morning Vibes', 'Chill Hop', '☀️', Color(0xFFFFA000)),
    _MockTrack('Deep Focus', 'Lo-Fi Lab', '🧠', Color(0xFF5C6BC0)),
    _MockTrack('Night Drive', 'Retrowave', '🌙', Color(0xFF3F51B5)),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _recentItems.length,
        separatorBuilder: (_, __) =>
            const SizedBox(width: UIConstants.spacing12),
        itemBuilder: (context, index) {
          final item = _recentItems[index];
          return Container(
            width: 240,
            padding: const EdgeInsets.all(UIConstants.spacing12),
            decoration: BoxDecoration(
              color: AppColors.surfacePrimary,
              borderRadius: BorderRadius.circular(UIConstants.radiusLarge),
              border: Border.all(color: AppColors.glassBorder),
            ),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      UIConstants.radiusMedium,
                    ),
                    gradient: LinearGradient(
                      colors: [
                        item.color.withValues(alpha: 0.5),
                        item.color.withValues(alpha: 0.2),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      item.emoji,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                const SizedBox(width: UIConstants.spacing12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item.title,
                        style: AppTextStyles.labelLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.artist,
                        style: AppTextStyles.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.play_circle_filled_rounded,
                  color: AppColors.accentPrimary,
                  size: 28,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
