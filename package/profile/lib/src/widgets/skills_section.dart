import 'package:flutter/material.dart';

class SkillsSection extends StatefulWidget {
  final List<String> skillSets;

  const SkillsSection({super.key, required this.skillSets});

  @override
  SkillsSectionState createState() => SkillsSectionState();
}

class SkillsSectionState extends State<SkillsSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;
  late final List<Animation<double>> _chipDropAnimations;

  @override
  void initState() {
    super.initState();

    const totalDurationMs = 1000;
    const dropDurationMs = 300;
    const staggerDelayMs = 150;

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: totalDurationMs),
    );

    // Slide in whole skills section from left
    _slideAnimation =
        Tween<Offset>(begin: const Offset(-1.0, 0.0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
          ),
        );

    // Create drop animations for each chip staggered in sequence
    _chipDropAnimations = List.generate(widget.skillSets.length, (index) {
      double start = 0.5 + (index * staggerDelayMs) / totalDurationMs;
      double end = start + dropDurationMs / totalDurationMs;
      if (end > 1.0) end = 1.0;
      return CurvedAnimation(
        parent: _controller,
        curve: Interval(start, end, curve: Curves.easeOutBack),
      );
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.skillSets.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);

    return SlideTransition(
      position: _slideAnimation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Skill Sets',
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: widget.skillSets.asMap().entries.map((entry) {
              int index = entry.key;
              String skill = entry.value;

              return AnimatedBuilder(
                animation: _chipDropAnimations[index],
                builder: (context, child) {
                  double animValue = _chipDropAnimations[index].value.clamp(
                    0.0,
                    1.0,
                  );
                  double dropValue = 1.0 - animValue; // from 1 to 0
                  return Transform.translate(
                    offset: Offset(0, dropValue * 20), // drop vertically 20 px
                    child: Opacity(opacity: animValue, child: child),
                  );
                },
                child: Chip(
                  label: Text(skill),
                  backgroundColor: theme.primaryColorLight,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
