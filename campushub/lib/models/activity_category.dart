
import 'package:flutter/material.dart';

class ActivityCategory {
  final String id;
  final String title;
  final Color color;
  final IconData icon;

  const ActivityCategory({
    required this.id,
    required this.title,
    required this.color,
    this.icon = Icons.category,
  });
}
