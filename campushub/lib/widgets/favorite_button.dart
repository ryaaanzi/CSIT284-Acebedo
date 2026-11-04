import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/activity.dart';
import '../providers/favorites_provider.dart';

class FavoriteButton extends StatelessWidget {
  final Activity activity;

  const FavoriteButton({
    super.key,
    required this.activity,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesProvider>(
      builder: (context, favoritesProvider, child) {
        final isFavorite =
            favoritesProvider.isFavorite(activity.id);

        return IconButton(
          tooltip: isFavorite
              ? 'Remove from favorites'
              : 'Add to favorites',
          onPressed: () {
            favoritesProvider.toggleFavorite(activity);
          },
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
            child: Icon(
              isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border,
              key: ValueKey(isFavorite),
              color: isFavorite ? Colors.red : null,
              size: 28,
            ),
          ),
        );
      },
    );
  }
}