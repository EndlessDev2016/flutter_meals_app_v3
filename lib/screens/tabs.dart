import 'package:flutter/material.dart';

import 'package:flutter_meals_app_v3/providers/favorites_provider.dart';
import 'package:flutter_meals_app_v3/providers/meals_provider.dart';
import 'package:flutter_meals_app_v3/screens/categories.dart';
import 'package:flutter_meals_app_v3/screens/filters.dart';
import 'package:flutter_meals_app_v3/screens/meals.dart';
import 'package:flutter_meals_app_v3/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_meals_app_v3/providers/filters_provider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

/// ConsumerStatefulWidget -> StatefulWidget
/// ConsumerState -> State
/// ConsumerWidget -> StatelessWidget
class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _showInfoMessage(String message) {}

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      // pushは、現在の画面の上に新しい画面を追加する。（画面をStackする。）
      // pushReplacementは、現在の画面を削除して新しい画面を上書きする。
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
      // print(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    // package:flutter_riverpod/src/consumer.dart
    // refのrecommended usageは、readとwatch
    // ref.readは、Providerの値を読み取る。
    // ref.watchは、Providerの値を監視する。
    // refer site https://docs-v2.riverpod.dev/docs/concepts/reading
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealScreen(
        meals: favoriteMeals,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
