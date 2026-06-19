import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hearwithme/core/constants/ui_constants.dart';
import 'package:hearwithme/core/theme/app_colors.dart';
import 'package:hearwithme/core/theme/app_text_styles.dart';
import 'package:hearwithme/core/widgets/glass_container.dart';

/// Mesh Chat Room — real-time text chat between connected peers.
class MeshChatPage extends StatefulWidget {
  const MeshChatPage({super.key});

  @override
  State<MeshChatPage> createState() => _MeshChatPageState();
}

class _MeshChatPageState extends State<MeshChatPage> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();

  static final _mockMessages = [
    _ChatMessage('Alex', '🎸', 'Hey! Anyone listening to something good?', false, '2:31 PM'),
    _ChatMessage('Maya', '🎧', 'Just found this amazing ambient track on Jamendo 🎵', false, '2:32 PM'),
    _ChatMessage('You', '🎧', 'Nice! Can you broadcast it?', true, '2:33 PM'),
    _ChatMessage('Alex', '🎸', 'I\'m streaming it now — join my session!', false, '2:33 PM'),
    _ChatMessage('Sam', '🎵', 'Joined! This is 🔥', false, '2:34 PM'),
    _ChatMessage('You', '🎧', 'Love this P2P vibe, no internet needed 💪', true, '2:35 PM'),
    _ChatMessage('Maya', '🎧', 'Right?! Perfect for the subway commute', false, '2:35 PM'),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: UIConstants.spacing16,
                vertical: UIConstants.spacing12,
              ),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.glassBorder, width: 0.5),
                ),
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
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.accentPrimary.withValues(alpha: 0.15),
                    ),
                    child: const Icon(
                      Icons.group_rounded,
                      color: AppColors.accentPrimary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Mesh Chat', style: AppTextStyles.titleMedium),
                        Text(
                          '4 peers connected',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.peerOnline,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Now playing indicator
                  GlassContainer(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    borderRadius: UIConstants.radiusCircular,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.music_note_rounded,
                          size: 14,
                          color: AppColors.accentPrimary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Live',
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
                .fadeIn(duration: 300.ms),

            // Messages
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(UIConstants.spacing16),
                itemCount: _mockMessages.length,
                itemBuilder: (context, index) {
                  final msg = _mockMessages[index];
                  return _MessageBubble(message: msg, index: index);
                },
              ),
            ),

            // Input bar
            Container(
              padding: const EdgeInsets.all(UIConstants.spacing12),
              decoration: const BoxDecoration(
                color: AppColors.surfacePrimary,
                border: Border(
                  top: BorderSide(color: AppColors.glassBorder, width: 0.5),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: UIConstants.spacing16,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceTertiary,
                        borderRadius: BorderRadius.circular(
                          UIConstants.radiusCircular,
                        ),
                      ),
                      child: TextField(
                        controller: _messageController,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textPrimary,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Message the mesh...',
                          hintStyle: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textTertiary,
                          ),
                          border: InputBorder.none,
                          filled: false,
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          AppColors.accentPrimary,
                          AppColors.accentSecondary,
                        ],
                      ),
                    ),
                    child: const Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
            )
                .animate()
                .fadeIn(delay: 400.ms, duration: 300.ms)
                .slideY(begin: 0.2, end: 0),
          ],
        ),
      ),
    );
  }
}

// ── Message Bubble ──

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message, required this.index});

  final _ChatMessage message;
  final int index;

  @override
  Widget build(BuildContext context) {
    final isMe = message.isMe;

    return Padding(
      padding: const EdgeInsets.only(bottom: UIConstants.spacing12),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe) ...[
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.surfaceSecondary,
              ),
              child: Center(
                child: Text(
                  message.emoji,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: UIConstants.spacing16,
                vertical: UIConstants.spacing12,
              ),
              decoration: BoxDecoration(
                color: isMe
                    ? AppColors.accentPrimary.withValues(alpha: 0.15)
                    : AppColors.surfaceSecondary,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(UIConstants.radiusLarge),
                  topRight: const Radius.circular(UIConstants.radiusLarge),
                  bottomLeft: Radius.circular(
                    isMe ? UIConstants.radiusLarge : 4,
                  ),
                  bottomRight: Radius.circular(
                    isMe ? 4 : UIConstants.radiusLarge,
                  ),
                ),
                border: isMe
                    ? Border.all(
                        color: AppColors.accentPrimary.withValues(alpha: 0.2),
                      )
                    : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isMe)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        message.sender,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.accentSecondary,
                        ),
                      ),
                    ),
                  Text(
                    message.text,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message.time,
                    style: AppTextStyles.labelSmall.copyWith(fontSize: 9),
                  ),
                ],
              ),
            ),
          ),
          if (isMe) const SizedBox(width: 40),
        ],
      ),
    )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: 100 * index),
          duration: 300.ms,
        )
        .slideX(
          begin: isMe ? 0.2 : -0.2,
          end: 0,
          delay: Duration(milliseconds: 100 * index),
          curve: Curves.easeOutQuart,
        );
  }
}

class _ChatMessage {
  const _ChatMessage(
    this.sender,
    this.emoji,
    this.text,
    this.isMe,
    this.time,
  );
  final String sender;
  final String emoji;
  final String text;
  final bool isMe;
  final String time;
}
