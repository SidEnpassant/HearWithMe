import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hearwithme/core/constants/ui_constants.dart';
import 'package:hearwithme/core/theme/app_colors.dart';
import 'package:hearwithme/core/theme/app_text_styles.dart';

/// Settings page — identity, cache, security, content sources.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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

              Text('Settings', style: AppTextStyles.displayMedium)
                  .animate()
                  .fadeIn(duration: 400.ms)
                  .slideX(begin: -0.1, end: 0),

              const SizedBox(height: UIConstants.spacing24),

              // Identity section
              const _IdentityCard()
                  .animate()
                  .fadeIn(delay: 100.ms, duration: 400.ms)
                  .slideY(begin: 0.1, end: 0),

              const SizedBox(height: UIConstants.spacing24),

              // Cache section
              _SectionTitle(title: 'Storage & Cache', delay: 200),
              const SizedBox(height: UIConstants.spacing12),
              _SettingsTile(
                icon: Icons.storage_rounded,
                title: 'Cache Limit',
                subtitle: '2.0 GB',
                trailing: const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.textTertiary,
                ),
                delay: 250,
              ),
              const SizedBox(height: UIConstants.spacing8),
              _SettingsTile(
                icon: Icons.delete_outline_rounded,
                title: 'Clear Cache',
                subtitle: '1.2 GB used',
                trailing: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Clear',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.error,
                    ),
                  ),
                ),
                delay: 300,
              ),

              const SizedBox(height: UIConstants.spacing24),

              // Security section
              _SectionTitle(title: 'Security', delay: 350),
              const SizedBox(height: UIConstants.spacing12),
              _SwitchTile(
                icon: Icons.fingerprint_rounded,
                title: 'Biometric Auth',
                subtitle: 'Require fingerprint for peer connections',
                value: false,
                delay: 400,
              ),
              const SizedBox(height: UIConstants.spacing8),
              _SwitchTile(
                icon: Icons.radar_rounded,
                title: 'Auto-Discovery',
                subtitle: 'Automatically scan for nearby peers',
                value: true,
                delay: 450,
              ),

              const SizedBox(height: UIConstants.spacing24),

              // Content Sources section
              _SectionTitle(title: 'Content Sources', delay: 500),
              const SizedBox(height: UIConstants.spacing12),
              _SwitchTile(
                icon: Icons.music_note_rounded,
                title: 'Jamendo',
                subtitle: '600K+ CC-licensed tracks',
                value: true,
                delay: 550,
              ),
              const SizedBox(height: UIConstants.spacing8),
              _SwitchTile(
                icon: Icons.album_rounded,
                title: 'Free Music Archive',
                subtitle: 'Curated indie & experimental',
                value: true,
                delay: 600,
              ),
              const SizedBox(height: UIConstants.spacing8),
              _SwitchTile(
                icon: Icons.podcasts_rounded,
                title: 'Podcast Index',
                subtitle: '4M+ open podcasts',
                value: true,
                delay: 650,
              ),
              const SizedBox(height: UIConstants.spacing8),
              _SwitchTile(
                icon: Icons.apple_rounded,
                title: 'iTunes Search',
                subtitle: 'Apple podcast directory',
                value: false,
                delay: 700,
              ),

              const SizedBox(height: UIConstants.spacing24),

              // Connections
              _SectionTitle(title: 'P2P Network', delay: 750),
              const SizedBox(height: UIConstants.spacing12),
              _SettingsTile(
                icon: Icons.group_rounded,
                title: 'Max Peer Connections',
                subtitle: '8 peers',
                trailing: const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.textTertiary,
                ),
                delay: 800,
              ),

              const SizedBox(height: UIConstants.spacing24),

              // About section
              _SectionTitle(title: 'About', delay: 850),
              const SizedBox(height: UIConstants.spacing12),
              _SettingsTile(
                icon: Icons.info_outline_rounded,
                title: 'Version',
                subtitle: '1.0.0',
                delay: 900,
              ),
              const SizedBox(height: UIConstants.spacing8),
              _SettingsTile(
                icon: Icons.description_outlined,
                title: 'Open Source Licenses',
                trailing: const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.textTertiary,
                ),
                delay: 950,
              ),

              const SizedBox(height: UIConstants.spacing48),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Identity Card ──

class _IdentityCard extends StatelessWidget {
  const _IdentityCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(UIConstants.spacing20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.accentPrimary.withValues(alpha: 0.1),
            AppColors.accentSecondary.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(UIConstants.radiusXLarge),
        border: Border.all(
          color: AppColors.accentPrimary.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.accentGradient,
            ),
            child: const Center(
              child: Text('🎧', style: TextStyle(fontSize: 28)),
            ),
          ),
          const SizedBox(width: UIConstants.spacing16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Music Lover', style: AppTextStyles.titleLarge),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text('Peer ID: ', style: AppTextStyles.bodySmall),
                    Expanded(
                      child: Text(
                        'a1b2c3d4-e5f6-7890-abcd',
                        style: AppTextStyles.labelSmall.copyWith(
                          fontFamily: 'monospace',
                          color: AppColors.textTertiary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.edit_rounded,
              color: AppColors.accentPrimary,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Section Title ──

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.delay});

  final String title;
  final int delay;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.headlineMedium.copyWith(fontSize: 18),
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: delay), duration: 400.ms);
  }
}

// ── Settings Tile ──

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.delay,
    this.subtitle,
    this.trailing,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final int delay;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(UIConstants.spacing16),
      decoration: BoxDecoration(
        color: AppColors.surfacePrimary,
        borderRadius: BorderRadius.circular(UIConstants.radiusMedium),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textSecondary, size: 22),
          const SizedBox(width: UIConstants.spacing12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.labelLarge),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(subtitle!, style: AppTextStyles.bodySmall),
                ],
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: delay), duration: 400.ms)
        .slideY(begin: 0.05, end: 0);
  }
}

// ── Switch Tile ──

class _SwitchTile extends StatefulWidget {
  const _SwitchTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.delay,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final int delay;

  @override
  State<_SwitchTile> createState() => _SwitchTileState();
}

class _SwitchTileState extends State<_SwitchTile> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(UIConstants.spacing16),
      decoration: BoxDecoration(
        color: AppColors.surfacePrimary,
        borderRadius: BorderRadius.circular(UIConstants.radiusMedium),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Row(
        children: [
          Icon(widget.icon, color: AppColors.textSecondary, size: 22),
          const SizedBox(width: UIConstants.spacing12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title, style: AppTextStyles.labelLarge),
                const SizedBox(height: 2),
                Text(widget.subtitle, style: AppTextStyles.bodySmall),
              ],
            ),
          ),
          Switch(
            value: _value,
            onChanged: (v) => setState(() => _value = v),
            activeThumbColor: AppColors.accentPrimary,
            inactiveTrackColor: AppColors.surfaceTertiary,
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: widget.delay), duration: 400.ms)
        .slideY(begin: 0.05, end: 0);
  }
}
