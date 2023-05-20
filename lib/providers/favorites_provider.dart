import 'package:flutter_meals_app_v3/models/meal.dart';
import 'package:flutter_meals_app_v3/providers/filters_provider.dart';
import 'package:flutter_meals_app_v3/providers/meals_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteMealsNotifider extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifider() : super([]);

  bool toggleMealFavoriteStatus(Meal meal) {
    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifider, List<Meal>>((ref) {
  return FavoriteMealsNotifider();
});

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);

  return meals.where((meal) {
    if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
