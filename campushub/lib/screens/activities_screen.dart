
import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../models/activity.dart';
import '../models/activity_category.dart';
import '../widgets/activity_card.dart';
import '../widgets/empty_state.dart';
import 'activity_detail_screen.dart';

class ActivitiesScreen extends StatefulWidget {
  final ActivityCategory category;

  const ActivitiesScreen({
    super.key,
    required this.category,
  });

  @override
  State<ActivitiesScreen> createState() =>
      _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  String searchQuery = '';

  // Open activity details
  void _openActivity(Activity activity) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ActivityDetailScreen(
          activity: activity,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    // Filter activities by category and search query
    final categoryActivities = dummyActivities
        .where((activity) {
          return activity.categories.contains(widget.category.id);
        })
        .where((activity) {
          return activity.title
              .toLowerCase()
              .contains(searchQuery.toLowerCase());
        })
        .toList();

    // Responsive grid layout
    final width = MediaQuery.of(context).size.width;

    final crossAxisCount = width >= 1000
        ? 3
        : width >= 600
            ? 2
            : 1;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.title),
        backgroundColor: widget.category.color,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: Column(
        children: [

          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search activities...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            searchQuery = '';
                          });
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Activity Count
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Row(
              children: [
                Text(
                  '${categoryActivities.length} Activities',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Activity List
          Expanded(
            child: categoryActivities.isEmpty
                ? EmptyState(
                    icon: Icons.event_busy,
                    title: 'No activities available',
                    message: searchQuery.isNotEmpty
                        ? 'No activities match your search.'
                        : 'No activities available in this category.',
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: categoryActivities.length,
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      mainAxisExtent: 285,
                    ),
                    itemBuilder: (context, index) {
                      final activity =
                          categoryActivities[index];

                      return ActivityCard(
                        activity: activity,
                        onTap: () {
                          _openActivity(activity);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
