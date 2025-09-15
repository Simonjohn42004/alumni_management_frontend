import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String fullName;
  final String? profilePictureUrl;
  final String roleName;

  const ProfileHeader({
    super.key,
    required this.fullName,
    required this.roleName,
    this.profilePictureUrl,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        CircleAvatar(
          radius: 48,
          backgroundImage:
              (profilePictureUrl != null && profilePictureUrl!.isNotEmpty)
              ? NetworkImage(profilePictureUrl!)
              : null,
          child: (profilePictureUrl == null || profilePictureUrl!.isEmpty)
              ? Text(
                  fullName.isNotEmpty ? fullName[0] : '?',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                  ),
                )
              : null,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(fullName, style: theme.textTheme.headlineMedium),
              const SizedBox(height: 4),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: Text(roleName, style: theme.textTheme.bodyMedium),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
