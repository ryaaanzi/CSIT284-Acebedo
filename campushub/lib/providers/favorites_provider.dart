import 'package:flutter/material.dart';
import '../models/activity.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Activity> _favorites = [];

  List<Activity> get favorites => List.unmodifiable(_favorites);

  bool isFavorite(String activityId) {
    return _favorites.any(
      (activity) => activity.id == activityId,
    );
  }

  void toggleFavorite(Activity activity) {
    if (isFavorite(activity.id)) {
      _favorites.removeWhere(
        (item) => item.id == activity.id,
      );
    } else {
      _favorites.add(activity);
    }

    notifyListeners();
  }

  void addFavorite(Activity activity) {
    if (!isFavorite(activity.id)) {
      _favorites.add(activity);
      notifyListeners();
    }
  }

  void removeFavorite(String activityId) {
    _favorites.removeWhere(
      (activity) => activity.id == activityId,
    );

    notifyListeners();
  }
}