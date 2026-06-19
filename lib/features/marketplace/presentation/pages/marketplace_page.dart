import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hearwithme/core/constants/ui_constants.dart';
import 'package:hearwithme/core/theme/app_colors.dart';
import 'package:hearwithme/core/theme/app_text_styles.dart';

/// Decentralized Media Marketplace — browse and trade CC-licensed content.
class MarketplacePage extends StatelessWidget {
  const MarketplacePage({super.key});

  static const _mockListings = [
    _Listing('Ambient Soundscapes Vol. 3', 'AudioWave', '🌊', Color(0xFF1E88E5), 'CC BY', 12, '320 MB'),
    _Listing('Lo-Fi Study Beats', 'ChillFactory', '🎹', Color(0xFF8E24AA), 'CC BY-NC', 28, '450 MB'),
    _Listing('World Music Archive', 'GlobalSound', '🌍', Color(0xFF43A047), 'CC BY-SA', 45, '1.2 GB'),
    _Listing('Indie Rock Collection', 'RockVault', '🎸', Color(0xFFE53935), 'CC BY', 19, '680 MB'),
    _Listing('Podcast Starter Kit', 'PodLab', '🎙️', Color(0xFFFF8F00), 'CC0', 8, '120 MB'),
    _Listing('Classical Piano Works', 'PianoArch', '🎹', Color(0xFF5C6BC0), 'CC BY', 32, '890 MB'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: UIConstants.spacing16),

            // Header
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: UIConstants.spacing20,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Marketplace',
                      style: AppTextStyles.displayMedium,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(
                        UIConstants.radiusCircular,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.verified_rounded,
                          size: 14,
                          color: AppColors.success,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'P2P',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.success,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
                .animate()
                .fadeIn(duration: 400.ms)
                .slideX(begin: -0.1, end: 0),

            const SizedBox(height: UIConstants.spacing16),

            // Stats bar
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: UIConstants.spacing20,
              ),
              child: Container(
                padding: const EdgeInsets.all(UIConstants.spacing16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.accentPrimary.withValues(alpha: 0.08),
                      AppColors.accentSecondary.withValues(alpha: 0.04),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(UIConstants.radiusLarge),
                  border: Border.all(
                    color: AppColors.accentPrimary.withValues(alpha: 0.12),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _Stat(label: 'Collections', value: '142'),
                    _Stat(label: 'Peers Sharing', value: '23'),
                    _Stat(label: 'Total Tracks', value: '8.4K'),
                  ],
                ),
              ),
            )
                .animate()
                .fadeIn(delay: 100.ms, duration: 400.ms)
                .slideY(begin: 0.1, end: 0),

            const SizedBox(height: UIConstants.spacing16),

            // Filter chips
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: UIConstants.spacing20,
                ),
                children: const [
                  _FilterChip(label: '🔥 Trending', isSelected: true),
                  SizedBox(width: 8),
                  _FilterChip(label: '🆕 New'),
                  SizedBox(width: 8),
                  _FilterChip(label: '⭐ Popular'),
                  SizedBox(width: 8),
                  _FilterChip(label: '🎵 Music'),
                  SizedBox(width: 8),
                  _FilterChip(label: '🎙️ Podcasts'),
                ],
              ),
            )
                .animate()
                .fadeIn(delay: 200.ms, duration: 400.ms),

            const SizedBox(height: UIConstants.spacing16),

            // Listings grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: UIConstants.spacing20,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.72,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: _mockListings.length,
                itemBuilder: (context, index) {
                  return _ListingCard(
                    listing: _mockListings[index],
                    index: index,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Stat Widget ──

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.titleLarge.copyWith(
            color: AppColors.accentPrimary,
          ),
        ),
        const SizedBox(height: 2),
        Text(label, style: AppTextStyles.labelSmall),
      ],
    );
  }
}

// ── Filter Chip ──

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, this.isSelected = false});

  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.accentPrimary : AppColors.surfaceSecondary,
        borderRadius: BorderRadius.circular(UIConstants.radiusCircular),
        border: isSelected ? null : Border.all(color: AppColors.glassBorder),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelMedium.copyWith(
          color: isSelected ? Colors.white : AppColors.textSecondary,
        ),
      ),
    );
  }
}

// ── Listing Card ──

class _ListingCard extends StatelessWidget {
  const _ListingCard({required this.listing, required this.index});

  final _Listing listing;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfacePrimary,
        borderRadius: BorderRadius.circular(UIConstants.radiusLarge),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cover art
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(UIConstants.radiusLarge),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    listing.color.withValues(alpha: 0.6),
                    listing.color.withValues(alpha: 0.15),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      listing.emoji,
                      style: const TextStyle(fontSize: 44),
                    ),
                  ),
                  // License badge
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        listing.license,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.success,
                          fontSize: 9,
                        ),
                      ),
                    ),
                  ),
                  // Track count badge
                  Positioned(
                    right: 8,
                    bottom: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${listing.tracks} tracks',
                        style: AppTextStyles.labelSmall.copyWith(
                          fontSize: 9,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Info
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    listing.title,
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    listing.creator,
                    style: AppTextStyles.labelSmall,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        listing.size,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accentPrimary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Get',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.accentPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: 250 + 80 * index),
          duration: 400.ms,
        )
        .scale(
          begin: const Offset(0.9, 0.9),
          end: const Offset(1, 1),
          delay: Duration(milliseconds: 250 + 80 * index),
          curve: Curves.easeOutQuart,
        );
  }
}

class _Listing {
  const _Listing(
    this.title,
    this.creator,
    this.emoji,
    this.color,
    this.license,
    this.tracks,
    this.size,
  );
  final String title;
  final String creator;
  final String emoji;
  final Color color;
  final String license;
  final int tracks;
  final String size;
}
