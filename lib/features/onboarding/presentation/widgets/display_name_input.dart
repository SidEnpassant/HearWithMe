import 'package:flutter/material.dart';
import 'package:hearwithme/core/constants/app_constants.dart';
import 'package:hearwithme/core/constants/ui_constants.dart';
import 'package:hearwithme/core/theme/app_colors.dart';
import 'package:hearwithme/core/theme/app_text_styles.dart';

/// Display name input field with emoji avatar picker grid.
class DisplayNameInput extends StatelessWidget {
  const DisplayNameInput({
    required this.controller,
    required this.emojis,
    required this.onEmojiSelected,
    super.key,
    this.selectedEmoji,
  });

  final TextEditingController controller;
  final String? selectedEmoji;
  final List<String> emojis;
  final ValueChanged<String> onEmojiSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Name input with glass card
        Container(
          padding: const EdgeInsets.all(UIConstants.spacing20),
          decoration: BoxDecoration(
            color: AppColors.surfacePrimary,
            borderRadius: BorderRadius.circular(UIConstants.radiusXLarge),
            border: Border.all(color: AppColors.glassBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What should we call you?',
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.accentPrimary,
                ),
              ),
              const SizedBox(height: UIConstants.spacing12),
              Row(
                children: [
                  // Emoji avatar circle
                  GestureDetector(
                    onTap: () => _showEmojiPicker(context),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.surfaceTertiary,
                        border: Border.all(
                          color: selectedEmoji != null
                              ? AppColors.accentPrimary
                              : AppColors.glassBorder,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          selectedEmoji ?? '😊',
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: UIConstants.spacing12),
                  // Text field
                  Expanded(
                    child: TextField(
                      controller: controller,
                      maxLength: AppConstants.displayNameMaxLength,
                      style: AppTextStyles.titleLarge,
                      decoration: InputDecoration(
                        hintText: 'Your display name',
                        hintStyle: AppTextStyles.titleLarge.copyWith(
                          color: AppColors.textTertiary,
                        ),
                        counterText: '',
                        filled: false,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: UIConstants.spacing8),
              Text(
                '${AppConstants.displayNameMinLength}-'
                '${AppConstants.displayNameMaxLength} characters',
                style: AppTextStyles.labelSmall,
              ),
            ],
          ),
        ),

        const SizedBox(height: UIConstants.spacing16),

        // Emoji picker label
        Padding(
          padding: const EdgeInsets.only(left: UIConstants.spacing4),
          child: Text(
            'Pick an avatar (optional)',
            style: AppTextStyles.labelMedium,
          ),
        ),
        const SizedBox(height: UIConstants.spacing8),

        // Emoji grid
        Container(
          padding: const EdgeInsets.all(UIConstants.spacing12),
          decoration: BoxDecoration(
            color: AppColors.surfacePrimary,
            borderRadius: BorderRadius.circular(UIConstants.radiusLarge),
            border: Border.all(color: AppColors.glassBorder),
          ),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: emojis.map((emoji) {
              final isSelected = emoji == selectedEmoji;
              return GestureDetector(
                onTap: () => onEmojiSelected(emoji),
                child: AnimatedContainer(
                  duration: UIConstants.durationFast,
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      UIConstants.radiusMedium,
                    ),
                    color: isSelected
                        ? AppColors.accentPrimary.withValues(alpha: 0.2)
                        : Colors.transparent,
                    border: isSelected
                        ? Border.all(color: AppColors.accentPrimary, width: 2)
                        : null,
                  ),
                  child: Center(
                    child: Text(emoji, style: const TextStyle(fontSize: 22)),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  void _showEmojiPicker(BuildContext context) {
    // The emoji grid is always visible below the input,
    // so this is a no-op. Future: could open a modal.
  }
}
