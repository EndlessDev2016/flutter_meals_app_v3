import 'package:flutter/material.dart';
import 'package:flutter_meals_app_v3/models/meal.dart';
// import 'package:flutter_meals_app_v3/screens/meal_detail.dart';
import 'package:flutter_meals_app_v3/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal,
    required this.onSelectetMeal,
  });

  final Meal meal;
  final void Function(Meal meal) onSelectetMeal;

  String get complexityText {
    // meal.complexity.name[0].toUpperCase() -> 'simple' -> 'S'
    // meal.complexity.name[1].toUpperCase() -> 'simple' -> 'I'
    // meal.complexity.name[2].toUpperCase() -> 'simple' -> 'M'
    // meal.complexity.name[3].toUpperCase() -> 'simple' -> 'P'
    // return meal.complexity.name[0].toUpperCase();

    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      // Clip.antiAlias is used to make the edges of the card smooth.
      // Clip.antiAliasは、カードのエッジを滑らかにするために使用されます。
      // Clip.hardEdge is used to make the edges of the card sharp.
      // Clip.hardEdgeは、カードのエッジを鋭くするために使用されます。
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        // onTap: () {
        //   Navigator.of(context).push(
        //     MaterialPageRoute(
        //       builder: (_) => MealDetailsScreen(meal: meal),
        //     ),
        //   );
        // },
        onTap: () => onSelectetMeal(meal),
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            // Positioned is used to position the child relative to the parent.
            // Positionedとは、親に対して子を配置するために使用されます。
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                // EdgeInsets.symmetricのverticalは、上下のpaddingを指定する。
                // EdgeInsets.symmetricのhorizontalは、左右のpaddingを指定する。
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis, // Very long text...
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                          icon: Icons.schedule,
                          label: '${meal.duration} min',
                        ),
                        const SizedBox(width: 12),
                        MealItemTrait(
                          icon: Icons.work,
                          label: complexityText,
                        ),
                        const SizedBox(width: 12),
                        MealItemTrait(
                          icon: Icons.attach_money,
                          label: affordabilityText,
                        ),
                      ],
                    )
                  ],
                ),
                // width: 300,
                // color: Colors.black54,
                // padding: const EdgeInsets.symmetric(
                //   vertical: 5,
                //   horizontal: 20,
                // ),
                // child: Text(
                //   meal.title,
                //   style: Theme.of(context).textTheme.titleLarge!.copyWith(
                //         color: Colors.white,
                //       ),
                //   softWrap: true,
                //   overflow: TextOverflow.fade,
                // ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
