import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ProfileSkeleton extends StatelessWidget {
  const ProfileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonLoader(
      enabled: true,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            CircleAvatar(radius: 48, backgroundColor: Colors.grey[300]),
            const SizedBox(height: 16),
            Container(height: 30, color: Colors.grey[300]),
            const SizedBox(height: 8),
            Container(height: 20, width: 100, color: Colors.grey[300]),
            const SizedBox(height: 24),
            ...List.generate(
              10,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Container(height: 20, color: Colors.grey[300]),
              ),
            ),
            Container(height: 140, color: Colors.grey[300]),
          ],
        ),
      ),
    );
  }
}
