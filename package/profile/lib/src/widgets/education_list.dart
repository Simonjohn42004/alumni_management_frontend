import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:core/core.dart';

class EducationList extends StatefulWidget {
  final List<Education> educations;

  const EducationList({super.key, required this.educations});

  @override
  EducationListState createState() => EducationListState();
}

class EducationListState extends State<EducationList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<Offset>> _slideAnimations;

  @override
  void initState() {
    super.initState();

    const int animationDurationMs = 800;
    const int staggerDelayMs = 300;

    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds:
            animationDurationMs + widget.educations.length * staggerDelayMs,
      ),
    );

    _slideAnimations = List.generate(widget.educations.length, (index) {
      final start =
          (staggerDelayMs * index) / _controller.duration!.inMilliseconds;
      final end =
          (staggerDelayMs * index + animationDurationMs) /
          _controller.duration!.inMilliseconds;
      return Tween<Offset>(
        begin: const Offset(-1.0, 0.0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(start, end, curve: Curves.easeOut),
        ),
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
    if (widget.educations.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Text(
          'No educational records available',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    final theme = Theme.of(context);
    final dateFormat = DateFormat.yMMMd();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Educations', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12),
        for (int i = 0; i < widget.educations.length; i++)
          SlideTransition(
            position: _slideAnimations[i],
            child: Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.educations[i].degree,
                      style: theme.textTheme.titleSmall,
                    ),
                    if (widget.educations[i].fieldOfStudy != null)
                      Text(
                        widget.educations[i].fieldOfStudy!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    const SizedBox(height: 6),
                    Text(
                      '${dateFormat.format(widget.educations[i].startDate)} - ${dateFormat.format(widget.educations[i].endDate)}',
                      style: theme.textTheme.labelSmall,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'CGPA: ${widget.educations[i].cgpa}',
                      style: theme.textTheme.bodyMedium,
                    ),
                    if (widget.educations[i].description != null &&
                        widget.educations[i].description!.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        widget.educations[i].description!,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
