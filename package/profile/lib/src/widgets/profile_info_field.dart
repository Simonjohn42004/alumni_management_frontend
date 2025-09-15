import 'package:flutter/material.dart';

class ProfileInfoField extends StatelessWidget {
  final String title;
  final String content;
  final bool isEditable;

  const ProfileInfoField({
    super.key,
    required this.title,
    required this.content,
    this.isEditable = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 1000),
          transitionBuilder: (child, animation) {
            final offsetAnimation = Tween<Offset>(
              begin: const Offset(0.0, 0.2), // slide up slightly
              end: Offset.zero,
            ).animate(animation);
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(position: offsetAnimation, child: child),
            );
          },
          child: isEditable
              ? Text(
                  content,
                  key: ValueKey('editable-$content'),
                  style: theme.textTheme.bodyMedium,
                )
              : Text(
                  content,
                  key: ValueKey('noneditable-$content'),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.disabledColor,
                  ),
                ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
