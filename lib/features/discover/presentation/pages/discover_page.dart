import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hearwithme/core/constants/ui_constants.dart';
import 'package:hearwithme/core/theme/app_colors.dart';
import 'package:hearwithme/core/theme/app_text_styles.dart';

/// Tabbed discover page: Music | Podcasts with search and genre/category chips.
class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: UIConstants.spacing16),

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: UIConstants.spacing20,
              ),
              child: Text('Discover', style: AppTextStyles.displayMedium),
            )
                .animate()
                .fadeIn(duration: 400.ms)
                .slideX(begin: -0.1, end: 0),

            const SizedBox(height: UIConstants.spacing16),

            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: UIConstants.spacing20,
              ),
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.surfacePrimary,
                  borderRadius: BorderRadius.circular(UIConstants.radiusLarge),
                  border: Border.all(color: AppColors.glassBorder),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: UIConstants.spacing16),
                    const Icon(
                      Icons.search_rounded,
                      color: AppColors.textTertiary,
                      size: 22,
                    ),
                    const SizedBox(width: UIConstants.spacing12),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        style: AppTextStyles.bodyLarge,
                        decoration: InputDecoration(
                          hintText: 'Search music, podcasts, artists...',
                          hintStyle: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textTertiary,
                          ),
                          border: InputBorder.none,
                          filled: false,
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.mic_rounded,
                      color: AppColors.textTertiary,
                      size: 22,
                    ),
                    const SizedBox(width: UIConstants.spacing16),
                  ],
                ),
              ),
            )
                .animate()
                .fadeIn(delay: 100.ms, duration: 400.ms)
                .slideY(begin: 0.1, end: 0),

            const SizedBox(height: UIConstants.spacing16),

            // Tab bar
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: UIConstants.spacing20,
              ),
              child: TabBar(
                controller: _tabController,
                indicatorColor: AppColors.accentPrimary,
                indicatorWeight: 3,
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: AppTextStyles.titleMedium,
                labelColor: AppColors.accentPrimary,
                unselectedLabelColor: AppColors.textTertiary,
                dividerColor: AppColors.glassBorder,
                tabs: const [
                  Tab(text: '🎵  Music'),
                  Tab(text: '🎙️  Podcasts'),
                ],
              ),
            )
                .animate()
                .fadeIn(delay: 200.ms, duration: 400.ms),

            // Tab content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  _MusicTab(),
                  _PodcastTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Music Tab ──

class _MusicTab extends StatelessWidget {
  const _MusicTab();

  static const _genres = [
    '🎸 Rock',
    '🎹 Pop',
    '🎧 Electronic',
    '🎷 Jazz',
    '🎻 Classical',
    '🎤 Hip-Hop',
    '🌍 World',
    '🌊 Ambient',
    '🎶 Indie',
    '🪕 Folk',
    '🤘 Metal',
    '💃 Latin',
  ];

  static const _moods = [
    'Chill',
    'Energetic',
    'Focus',
    'Workout',
    'Romantic',
    'Melancholy',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: UIConstants.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Genre chips
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: UIConstants.spacing20,
              ),
              itemCount: _genres.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) => _GenreChip(label: _genres[i], index: i),
            ),
          ),

          const SizedBox(height: UIConstants.spacing12),

          // Mood tags
          SizedBox(
            height: 36,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: UIConstants.spacing20,
              ),
              itemCount: _moods.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) => _MoodTag(label: _moods[i]),
            ),
          ),

          const SizedBox(height: UIConstants.spacing24),

          // Trending grid header
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: UIConstants.spacing20,
            ),
            child: Text('Trending Now', style: AppTextStyles.headlineMedium),
          ),

          const SizedBox(height: UIConstants.spacing12),

          // 2-column grid of music cards
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: UIConstants.spacing20,
            ),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 12,
                mainAxisSpacing: 16,
              ),
              itemCount: _mockMusic.length,
              itemBuilder: (context, index) {
                final m = _mockMusic[index];
                return _MusicGridCard(track: m, index: index);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ── Podcast Tab ──

class _PodcastTab extends StatelessWidget {
  const _PodcastTab();

  static const _categories = [
    '💻 Technology',
    '😂 Comedy',
    '🔍 True Crime',
    '🔬 Science',
    '💼 Business',
    '❤️ Health',
    '📚 Education',
    '📰 News',
    '⚽ Sports',
    '🎨 Arts',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: UIConstants.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category chips
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: UIConstants.spacing20,
              ),
              itemCount: _categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) =>
                  _GenreChip(label: _categories[i], index: i),
            ),
          ),

          const SizedBox(height: UIConstants.spacing24),

          // Trending header
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: UIConstants.spacing20,
            ),
            child: Row(
              children: [
                Text(
                  'Trending Podcasts',
                  style: AppTextStyles.headlineMedium,
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: const Text('Add RSS'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.accentPrimary,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: UIConstants.spacing12),

          // Podcast grid
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: UIConstants.spacing20,
            ),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.78,
                crossAxisSpacing: 12,
                mainAxisSpacing: 16,
              ),
              itemCount: _mockPodcasts.length,
              itemBuilder: (context, index) {
                final p = _mockPodcasts[index];
                return _PodcastGridCard(podcast: p, index: index);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ── Shared Widgets ──

class _GenreChip extends StatefulWidget {
  const _GenreChip({required this.label, required this.index});

  final String label;
  final int index;

  @override
  State<_GenreChip> createState() => _GenreChipState();
}

class _GenreChipState extends State<_GenreChip> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _selected = !_selected),
      child: AnimatedContainer(
        duration: UIConstants.durationFast,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: _selected
              ? AppColors.accentPrimary
              : AppColors.surfaceSecondary,
          borderRadius: BorderRadius.circular(UIConstants.radiusCircular),
          border: _selected
              ? null
              : Border.all(color: AppColors.glassBorder),
        ),
        child: Text(
          widget.label,
          style: AppTextStyles.labelMedium.copyWith(
            color: _selected ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _MoodTag extends StatelessWidget {
  const _MoodTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(UIConstants.radiusCircular),
        border: Border.all(
          color: AppColors.accentPrimary.withValues(alpha: 0.3),
        ),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelSmall.copyWith(
          color: AppColors.accentSecondary,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

// ── Music Grid Card ──

class _MusicGridCard extends StatelessWidget {
  const _MusicGridCard({required this.track, required this.index});

  final _MockMusicItem track;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(UIConstants.radiusLarge),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  track.color.withValues(alpha: 0.7),
                  track.color.withValues(alpha: 0.2),
                ],
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: Text(track.emoji, style: const TextStyle(fontSize: 48)),
                ),
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withValues(alpha: 0.5),
                    ),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                // Duration badge
                Positioned(
                  left: 8,
                  bottom: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      track.duration,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
    )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: 80 * index),
          duration: 400.ms,
        )
        .scale(
          begin: const Offset(0.9, 0.9),
          end: const Offset(1, 1),
          delay: Duration(milliseconds: 80 * index),
          curve: Curves.easeOutQuart,
        );
  }
}

// ── Podcast Grid Card ──

class _PodcastGridCard extends StatelessWidget {
  const _PodcastGridCard({required this.podcast, required this.index});

  final _MockPodcastItem podcast;
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
          // Podcast artwork
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(UIConstants.radiusLarge),
                ),
                color: podcast.color.withValues(alpha: 0.15),
              ),
              child: Center(
                child: Text(
                  podcast.emoji,
                  style: const TextStyle(fontSize: 48),
                ),
              ),
            ),
          ),
          // Info
          Padding(
            padding: const EdgeInsets.all(UIConstants.spacing12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  podcast.title,
                  style: AppTextStyles.labelLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  podcast.author,
                  style: AppTextStyles.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${podcast.episodes} episodes',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.accentPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: 80 * index),
          duration: 400.ms,
        )
        .scale(
          begin: const Offset(0.9, 0.9),
          end: const Offset(1, 1),
          delay: Duration(milliseconds: 80 * index),
          curve: Curves.easeOutQuart,
        );
  }
}

// ── Mock Data Models ──

class _MockMusicItem {
  const _MockMusicItem(
    this.title,
    this.artist,
    this.emoji,
    this.color,
    this.duration,
  );
  final String title;
  final String artist;
  final String emoji;
  final Color color;
  final String duration;
}

const _mockMusic = [
  _MockMusicItem('Sunset Waves', 'Luna Echo', '🌊', Color(0xFF1E88E5), '3:42'),
  _MockMusicItem('Electric Dreams', 'Neon Pulse', '⚡', Color(0xFFE53935), '4:15'),
  _MockMusicItem('Midnight Jazz', 'Blue Notes', '🎷', Color(0xFF7B1FA2), '5:01'),
  _MockMusicItem('Forest Rain', 'Ambient Sky', '🌿', Color(0xFF43A047), '6:30'),
  _MockMusicItem('City Lights', 'Synthwave', '🌃', Color(0xFFFF8F00), '3:58'),
  _MockMusicItem('Ocean Breeze', 'Chill Vibes', '🐚', Color(0xFF00ACC1), '4:22'),
];

class _MockPodcastItem {
  const _MockPodcastItem(
    this.title,
    this.author,
    this.emoji,
    this.color,
    this.episodes,
  );
  final String title;
  final String author;
  final String emoji;
  final Color color;
  final int episodes;
}

const _mockPodcasts = [
  _MockPodcastItem('Tech Daily', 'Tech News Co', '🎙️', Color(0xFF00ACC1), 247),
  _MockPodcastItem('True Stories', 'Crime Tales', '🔍', Color(0xFFD32F2F), 89),
  _MockPodcastItem('Science Hour', 'Discovery Lab', '🔬', Color(0xFF388E3C), 156),
  _MockPodcastItem('Startup Life', 'Founders Hub', '🚀', Color(0xFFFF6F00), 63),
  _MockPodcastItem('Comedy Club', 'Laugh Studio', '😂', Color(0xFF8E24AA), 312),
  _MockPodcastItem('History Bites', 'Past Present', '📜', Color(0xFF795548), 201),
];
