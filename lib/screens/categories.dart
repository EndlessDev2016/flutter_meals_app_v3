import 'package:flutter/material.dart';
import 'package:flutter_meals_app_v3/data/dummy_data.dart';
import 'package:flutter_meals_app_v3/models/category.dart';
import 'package:flutter_meals_app_v3/models/meal.dart';
import 'package:flutter_meals_app_v3/screens/meals.dart';
import 'package:flutter_meals_app_v3/widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
    required this.availableMeals,
  });

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animtationController;

  @override
  void initState() {
    super.initState();

    _animtationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    _animtationController.forward();
  }

  @override
  void dispose() {
    _animtationController.dispose();
    super.dispose();
  }

  void _selecCategory(BuildContext context, Category category) {
    // whereは、javascriptのfilterと同じ。
    final filteredMeals = widget.availableMeals
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
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    // childを使うと、childのwidgetは毎回buildされない。
    // これは、パフォーマンスの観点から、childを使うべき。
    return AnimatedBuilder(
      animation: _animtationController,
      builder: (ctx, child) => SlideTransition(
        position: Tween(
          begin: Offset(0, 0.3),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
              parent: _animtationController, curve: Curves.easeInOut),
        ),
        child: child,
      ),
      // builder: (ctx, child) => Padding(
      //   padding: EdgeInsets.only(
      //     top: 100 - _animtationController.value * 100,
      //   ),
      //   child: child,
      // ),
      child: GridView(
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
      ),
    );
  }
}
