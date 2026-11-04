enum SkillLevel {
  beginner,
  intermediate,
  advanced,
}

class Activity {
  final String id;
  final List<String> categories;
  final String title;
  final String imageUrl;
  final String description;
  final String venue;
  final int duration;
  final SkillLevel skillLevel;
  final List<String> requirements;
  final List<String> benefits;

  const Activity({
    required this.id,
    required this.categories,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.venue,
    required this.duration,
    required this.skillLevel,
    required this.requirements,
    required this.benefits,
  });
}