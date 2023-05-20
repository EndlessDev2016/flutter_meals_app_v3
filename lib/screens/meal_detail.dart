import 'package:flutter/material.dart';
import 'package:flutter_meals_app_v3/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/favorites_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);

    final isFavorite = favoriteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(favoriteMealsProvider.notifier)
                  .toggleMealFavoriteStatus(meal);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      wasAdded ? 'Meal added as a favorite.' : 'Meal removed.'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            icon: Icon(isFavorite ? Icons.star : Icons.star_border),
          ),
        ],
      ),
      // Column widget自体には、Scroll機能がないため、
      // SingleChildScrollViewまたは、ListViewなどのscroll可能なウィジェットでラップする必要がある。
      // 特に、パフォーマンス観点から見ると、ListViewが望ましい。(※ そのなかでも、ListView.builderが最も望ましい)
      /// 抜粋: https://api.flutter.dev/flutter/widgets/Column-class.html
      /// --------------------------------------------------------------------------------
      /// FlutterのSingleChildScrollViewとListViewは、両方ともスクロール可能なウィジェットであり、異なる状況で使用されます。
      /// SingleChildScrollViewは、子要素が画面に収まりきらない場合に使用されます。
      /// 例えば、画面に表示されるテキストが非常に長い場合や、水平方向にスクロール可能なリストが必要な場合などです。
      ///
      /// SingleChildScrollViewは、その子要素をスクロールすることで表示することができます。
      /// ListViewは、スクロールする必要がある一連のアイテムを表示するために使用されます。
      /// これは、通常、リストの各要素が同じタイプのウィジェットである場合に使用されます。
      /// 例えば、ユーザーの一覧や、商品の一覧などです。ListViewは、アイテムの数が多い場合にも高速かつ効率的に動作するように最適化されています。
      /// つまり、SingleChildScrollViewは、画面に収まらない単一のウィジェットをスクロールするために使用され、
      /// ListViewは、同じタイプのアイテムが表示される長いリストをスクロールするために使用されます。
      /// --------------------------------------------------------------------------------
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              meal.imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 13),
            // for loop alternative -> meal.ingredients.map((ingredient) => Text(ingredient)).toList()
            for (final ingredient in meal.ingredients)
              Text(
                ingredient,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            const SizedBox(height: 13),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            for (final setp in meal.steps)
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                child: Text(
                  setp,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
