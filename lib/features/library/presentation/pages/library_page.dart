import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hearwithme/core/constants/ui_constants.dart';
import 'package:hearwithme/core/theme/app_colors.dart';
import 'package:hearwithme/core/theme/app_text_styles.dart';

/// Library page — downloaded music & podcasts with sub-tabs, grid/list toggle.
class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  bool _isGrid = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
            // Header row
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: UIConstants.spacing20,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Library',
                      style: AppTextStyles.displayMedium,
                    ),
                  ),
                  // Grid/List toggle
                  GestureDetector(
                    onTap: () => setState(() => _isGrid = !_isGrid),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.surfacePrimary,
                        borderRadius: BorderRadius.circular(
                          UIConstants.radiusMedium,
                        ),
                        border: Border.all(color: AppColors.glassBorder),
                      ),
                      child: Icon(
                        _isGrid
                            ? Icons.grid_view_rounded
                            : Icons.list_rounded,
                        color: AppColors.textSecondary,
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),
            )
                .animate()
                .fadeIn(duration: 400.ms)
                .slideX(begin: -0.1, end: 0),

            const SizedBox(height: UIConstants.spacing16),

            // Storage meter
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: UIConstants.spacing20,
              ),
              child: Container(
                padding: const EdgeInsets.all(UIConstants.spacing16),
                decoration: BoxDecoration(
                  color: AppColors.surfacePrimary,
                  borderRadius: BorderRadius.circular(UIConstants.radiusLarge),
                  border: Border.all(color: AppColors.glassBorder),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.storage_rounded,
                          size: 18,
                          color: AppColors.accentPrimary,
                        ),
                        const SizedBox(width: 8),
                        Text('1.2 GB', style: AppTextStyles.labelLarge),
                        Text(
                          ' / 2.0 GB',
                          style: AppTextStyles.bodySmall,
                        ),
                        const Spacer(),
                        Text(
                          '60%',
                          style: AppTextStyles.labelMedium.copyWith(
                            color: AppColors.accentPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: 0.6,
                        minHeight: 6,
                        backgroundColor: AppColors.surfaceTertiary,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.accentPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
                .animate()
                .fadeIn(delay: 100.ms, duration: 400.ms)
                .slideY(begin: 0.1, end: 0),

            const SizedBox(height: UIConstants.spacing16),

            // Sub-tabs
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: UIConstants.spacing20,
              ),
              child: TabBar(
                controller: _tabController,
                indicatorColor: AppColors.accentPrimary,
                indicatorWeight: 3,
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: AppTextStyles.labelLarge,
                labelColor: AppColors.accentPrimary,
                unselectedLabelColor: AppColors.textTertiary,
                dividerColor: AppColors.glassBorder,
                tabs: const [
                  Tab(text: 'All'),
                  Tab(text: '🎵 Music'),
                  Tab(text: '🎙️ Podcasts'),
                ],
              ),
            )
                .animate()
                .fadeIn(delay: 200.ms, duration: 400.ms),

            // Tab content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _DownloadedList(isGrid: _isGrid, type: 'all'),
                  _DownloadedList(isGrid: _isGrid, type: 'music'),
                  _DownloadedList(isGrid: _isGrid, type: 'podcast'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DownloadedList extends StatelessWidget {
  const _DownloadedList({required this.isGrid, required this.type});

  final bool isGrid;
  final String type;

  static const _mockItems = [
    _DownloadedItem('Sunset Waves', 'Luna Echo', '🌊', Color(0xFF1E88E5), '32 MB', '3:42', 'jamendo'),
    _DownloadedItem('Tech Daily #247', 'Tech News', '🎙️', Color(0xFF00ACC1), '18 MB', '45:12', 'podcast'),
    _DownloadedItem('Electric Dreams', 'Neon Pulse', '⚡', Color(0xFFE53935), '28 MB', '4:15', 'jamendo'),
    _DownloadedItem('True Stories #89', 'Crime Tales', '🔍', Color(0xFFD32F2F), '24 MB', '38:00', 'podcast'),
    _DownloadedItem('Midnight Jazz', 'Blue Notes', '🎷', Color(0xFF7B1FA2), '35 MB', '5:01', 'jamendo'),
    _DownloadedItem('Science Hour #156', 'Discovery', '🔬', Color(0xFF388E3C), '22 MB', '52:30', 'podcast'),
  ];

  List<_DownloadedItem> get _filtered {
    if (type == 'music') return _mockItems.where((i) => i.source == 'jamendo').toList();
    if (type == 'podcast') return _mockItems.where((i) => i.source == 'podcast').toList();
    return _mockItems;
  }

  @override
  Widget build(BuildContext context) {
    final items = _filtered;
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.download_done_rounded,
              size: 64,
              color: AppColors.textTertiary,
            ),
            const SizedBox(height: 16),
            Text(
              'No downloads yet',
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Discover music & podcasts to download',
              style: AppTextStyles.bodySmall,
            ),
          ],
        ),
      );
    }

    if (isGrid) {
      return GridView.builder(
        padding: const EdgeInsets.all(UIConstants.spacing20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return _GridItem(item: items[index], index: index);
        },
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(UIConstants.spacing20),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        return _ListItem(item: items[index], index: index);
      },
    );
  }
}

class _DownloadedItem {
  const _DownloadedItem(
    this.title,
    this.artist,
    this.emoji,
    this.color,
    this.size,
    this.duration,
    this.source,
  );
  final String title;
  final String artist;
  final String emoji;
  final Color color;
  final String size;
  final String duration;
  final String source;
}

class _GridItem extends StatelessWidget {
  const _GridItem({required this.item, required this.index});

  final _DownloadedItem item;
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
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(UIConstants.radiusLarge),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    item.color.withValues(alpha: 0.5),
                    item.color.withValues(alpha: 0.15),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      item.emoji,
                      style: const TextStyle(fontSize: 40),
                    ),
                  ),
                  // Source badge
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        item.source == 'jamendo' ? '🎵' : '🎙️',
                        style: const TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text(item.size, style: AppTextStyles.labelSmall),
                    const SizedBox(width: 8),
                    Text(item.duration, style: AppTextStyles.labelSmall),
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
          delay: Duration(milliseconds: 60 * index),
          duration: 400.ms,
        )
        .scale(
          begin: const Offset(0.9, 0.9),
          end: const Offset(1, 1),
          delay: Duration(milliseconds: 60 * index),
          curve: Curves.easeOutQuart,
        );
  }
}

class _ListItem extends StatelessWidget {
  const _ListItem({required this.item, required this.index});

  final _DownloadedItem item;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(UIConstants.spacing12),
      decoration: BoxDecoration(
        color: AppColors.surfacePrimary,
        borderRadius: BorderRadius.circular(UIConstants.radiusMedium),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(UIConstants.radiusMedium),
              color: item.color.withValues(alpha: 0.2),
            ),
            child: Center(
              child: Text(item.emoji, style: const TextStyle(fontSize: 24)),
            ),
          ),
          const SizedBox(width: UIConstants.spacing12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: AppTextStyles.labelLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(item.artist, style: AppTextStyles.bodySmall),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(item.size, style: AppTextStyles.labelSmall),
              const SizedBox(height: 4),
              Text(item.duration, style: AppTextStyles.labelSmall),
            ],
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: 60 * index),
          duration: 400.ms,
        )
        .slideX(begin: 0.1, end: 0, delay: Duration(milliseconds: 60 * index));
  }
}
