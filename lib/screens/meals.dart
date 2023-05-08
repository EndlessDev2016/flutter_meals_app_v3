import 'package:flutter/material.dart';
import 'package:flutter_meals_app_v3/models/meal.dart';
import 'package:flutter_meals_app_v3/widgets/meal_itam.dart';

import 'meal_detail.dart';

class MealScreen extends StatelessWidget {
  const MealScreen({
    super.key,
    this.title,
    required this.meals,
    this.onToggleFavorite,
  });

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal)? onToggleFavorite;

  void _selectMeal(BuildContext context, Meal meal) {
    // MaterialPageRouteは、引数にbuilderを取る。
    // MaterialPageRoute is a Route<T> that builds its widget based on the given builder callback.
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => MealDetailsScreen(
        meal: meal,
        onToggleFavorite: (meal) {
          if (onToggleFavorite != null) {
            onToggleFavorite!(meal);
          }
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (context, index) {
        return Text(meals[index].title);
      },
    );

    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'oh no!! >.< No meals found!',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'Try sleceting a different cateogry!',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ],
        ),
      );
    }

    if (meals.isNotEmpty) {
      // ListViewとListView.builderの違いは、
      // ListViewは全ての要素を一度にレンダリングするのに対して、
      // ListView.builderは必要な要素のみをレンダリングする。
      // ListView.builderの方がパフォーマンスが良い。
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) {
          return MealItem(
            meal: meals[index],
            onSelectetMeal: (meal) => _selectMeal(context, meal),
          );
        },
      );
    }

    if (title == null) return content;

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
