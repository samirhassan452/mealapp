import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/screens/meal_details_screen.dart';
import 'package:provider/provider.dart';

class MealItem extends StatelessWidget {
  final Meal meal;
  final Function removeMealItem;

  const MealItem({
    this.meal,
    this.removeMealItem,
  });

  /*
  String get complexityText {
    switch (meal.complexity) {
      case Complexity.Simple:
        return 'Simple';
      case Complexity.Challenging:
        return 'Challenging';
      case Complexity.Hard:
        return 'Hard';
      default:
        return 'Unknown';
    }
  }

  String get affordabilityText {
    switch (meal.affordability) {
      case Affordability.Affordable:
        return 'Affordable';
      case Affordability.Pricey:
        return 'Pricey';
      case Affordability.Luxurious:
        return 'Luxuroius';
      default:
        return 'Unknown';
    }
  }
  */

  void selectMeal(BuildContext ctx) {
    Navigator.of(ctx)
        .pushNamed(
          MealDetailsScreen.routeName,
          arguments: meal,
        ) // then is performed when we use pop() and return value
        .then((returnedValue) =>
            returnedValue != null ? removeMealItem(returnedValue) : null);
  }

  @override
  Widget build(BuildContext context) {
    final lan = Provider.of<LanguageProvider>(context, listen: true);
    final height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: EdgeInsets.only(
          left: 25,
          right: 25,
          top: 15,
          bottom: 10,
        ),
        child: Column(
          children: [
            Stack(
              children: [
                // to force image for radius to match radius of card
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Hero(
                    tag: meal.id,
                    child: CachedNetworkImage(
                      imageUrl: meal.imageUrl,
                      height: height / 3,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      //fadeInDuration: Duration(seconds: 2),
                      placeholder: (context, url) => Image.asset(
                        'assets/images/placeholder.png',
                        fit: BoxFit.fill,
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),

                Positioned(
                  bottom: 15,
                  left: lan.isEn ? 0 : null,
                  right: lan.isEn ? 0 : null,
                  child: Container(
                    color: Colors.black.withOpacity(0.7),
                    padding: EdgeInsets.all(10),
                    width: 250,
                    child: Text(
                      lan.getTexts('meal-${meal.id}'),
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        color: Theme.of(context).buttonColor,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        "${meal.duration} " + lan.getTexts('min'),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.work,
                        color: Theme.of(context).buttonColor,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        lan.getTexts('${meal.complexity}'),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.attach_money,
                        color: Theme.of(context).buttonColor,
                      ),
                      Text(
                        lan.getTexts('${meal.affordability}'),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
