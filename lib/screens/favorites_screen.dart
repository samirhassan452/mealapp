import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/widgets/meal_item_widget.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  //Widget resultWidget = Text("No Items Founded!!!");
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final lan = Provider.of<LanguageProvider>(context, listen: true);
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final List<Meal> favoriteMeals =
        Provider.of<MealProvider>(context).favoriteMeals;
    if (favoriteMeals.isEmpty)
      return Center(
          child: Text(
        lan.getTexts('favorites_text'),
        style: Theme.of(context).textTheme.bodyText1,
      ));
    else {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: size.width <= 400
              ? 400
              : 500, // each item has width of 400, means 2 items in row
          childAspectRatio: isLandscape
              ? size.width / (size.width * 0.666)
              : size.width / (size.width * 0.775),
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
        ),
        itemBuilder: (context, index) => MealItem(
          meal: favoriteMeals[index],
        ),
        itemCount: favoriteMeals.length,
      );
    }
  }
}
