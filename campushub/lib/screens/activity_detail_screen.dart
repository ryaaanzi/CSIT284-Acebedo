
import 'package:flutter/material.dart';

import '../models/activity.dart';
import '../widgets/favorite_button.dart';

class ActivityDetailScreen extends StatelessWidget {
  final Activity activity;

  const ActivityDetailScreen({
    super.key,
    required this.activity,
  });

  // Convert duration from minutes to readable text
  String get formattedDuration {
    final hours = activity.duration ~/ 60;
    final minutes = activity.duration % 60;

    if (hours == 0) {
      return '$minutes minutes';
    }

    if (minutes == 0) {
      return '$hours ${hours == 1 ? 'hour' : 'hours'}';
    }

    return '$hours ${hours == 1 ? 'hour' : 'hours'} '
        '$minutes minutes';
  }

  // Convert SkillLevel enum to readable text
  String get formattedSkillLevel {
    switch (activity.skillLevel) {
      case SkillLevel.beginner:
        return 'Beginner';
      case SkillLevel.intermediate:
        return 'Intermediate';
      case SkillLevel.advanced:
        return 'Advanced';
    }
  }

  // Reusable section for requirements and benefits
  Widget _buildSection(
    BuildContext context,
    String title,
    List<String> items,
  ) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),

        if (items.isEmpty)
          Text(
            'No information available.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey,
            ),
          )
        else
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: theme.colorScheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(item),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Header Image and App Bar
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            title: const Text('Activity Details'),
            actions: [
              FavoriteButton(activity: activity),
              const SizedBox(width: 8),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'activity-${activity.id}',
                child: Image.network(
                  activity.imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade300,
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported,
                          size: 70,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // Activity Information
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Activity Title
                  Text(
                    activity.title,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Duration and Skill Level
                  Wrap(
                    spacing: 20,
                    runSpacing: 12,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.access_time,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(formattedDuration),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.bar_chart,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(formattedSkillLevel),
                        ],
                      ),
                    ],
                  ),

                  const Divider(height: 35),

                  // Description
                  Text(
                    'About this Activity',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    activity.description,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Venue
                  Text(
                    'Venue',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(activity.venue),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // Requirements
                  _buildSection(
                    context,
                    'Requirements',
                    activity.requirements,
                  ),

                  const SizedBox(height: 25),

                  // Benefits
                  _buildSection(
                    context,
                    'Benefits',
                    activity.benefits,
                  ),

                  const SizedBox(height: 30),

                  // Back Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Back to Activities'),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
