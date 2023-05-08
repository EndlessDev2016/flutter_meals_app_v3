import 'package:flutter/material.dart';
import 'package:flutter_meals_app_v3/data/dummy_data.dart';
import 'package:flutter_meals_app_v3/models/category.dart';
import 'package:flutter_meals_app_v3/models/meal.dart';
import 'package:flutter_meals_app_v3/screens/meals.dart';
import 'package:flutter_meals_app_v3/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.onToggleFavorite,
    required this.availableMeals,
  });

  final void Function(Meal meal) onToggleFavorite;
  final List<Meal> availableMeals;

  void _selecCategory(BuildContext context, Category category) {
    // whereは、javascriptのfilterと同じ。
    final filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    // Navigator.pushとNavigator.of(context).pushNamedの違いは、
    // Navigator.pushは引数にRouteを取るのに対して、
    // Navigator.of(context).pushNamedは引数にStringを取る。
    // Navigator.push(context, route); // same - Navigator.of(context).push(route);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => MealScreen(
        title: category.title,
        meals: filteredMeals,
        onToggleFavorite: onToggleFavorite,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        // alternative : availableCategories.map((category) => CategoryGridItem(category: category)).toList(),
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: () => _selecCategory(context, category),
          )
      ],
    );
  }
}
