
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals2/providers/filters_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({
    super.key,
    required this.currentFilters,
  });

  final Map<Filter, bool> currentFilters;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: Column(
        children: [
          SwitchListTile(
            value: activeFilters[Filter.glutenFree] ?? false,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.glutenFree, isChecked);
            },
            title: const Text('Gluten-free'),
            subtitle: const Text('Only include gluten-free meals.'),
          ),
          SwitchListTile(
            value: activeFilters[Filter.lactoseFree] ?? false,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.lactoseFree, isChecked);
            },
            title: const Text('Lactose-free'),
            subtitle: const Text('Only include lactose-free meals.'),
          ),
          SwitchListTile(
            value: activeFilters[Filter.vegetarian] ?? false,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegetarian, isChecked);
            },
            title: const Text('Vegetarian'),
            subtitle: const Text('Only include vegetarian meals.'),
          ),
          SwitchListTile(
            value: activeFilters[Filter.vegan] ?? false,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegan, isChecked);
            },
            title: const Text('Vegan'),
            subtitle: const Text('Only include vegan meals.'),
          ),
        ],
      ),
    );
  }
}
