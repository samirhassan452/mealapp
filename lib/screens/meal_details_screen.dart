import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:provider/provider.dart';

class MealDetailsScreen extends StatelessWidget {
  static const routeName = '/meals_details';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final Meal meal = ModalRoute.of(context).settings.arguments as Meal;

    final lan = Provider.of<LanguageProvider>(context, listen: true);

    /*
      if we pass only mealId of meal, we can search on DUMMY_MEALS about meal which match this id
      
      final categoryMeals = DUMMY_ME.firstWhere((meal) => meal.id == mealId);
      // if condition is true, then return meal and close
    */
    List<String> ingredientsList = lan.getTexts(('ingredients-${meal.id}'));
    List<String> setpsList = lan.getTexts(('steps-${meal.id}'));

    Widget ingradList = ListView.builder(
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) => Card(
        color: Theme.of(context).accentColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          child: Text(
            //meal.ingredients[index],
            ingredientsList[index],
            style: TextStyle(
              color: Theme.of(context).accentColor.computeLuminance() > 0.5
                  ? Colors.black
                  : Colors.white,
            ),
          ),
        ),
      ),
      //itemCount: meal.ingredients.length,
      itemCount: ingredientsList.length,
    );

    Widget stepsList = ListView.builder(
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) => Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Text("#${index + 1}"),
            ),
            title: Text(
              //meal.steps[index],
              setpsList[index],
            ),
          ),
          Divider(),
        ],
      ),
      //itemCount: meal.steps.length,
      itemCount: setpsList.length,
    );

    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true, // make AppBar fixed while scrolling
              expandedHeight: size.height / 2.1,
              flexibleSpace: FlexibleSpaceBar(
                title: Container(
                  padding: EdgeInsets.all(8.0),
                  color: Theme.of(context).buttonColor.computeLuminance() < 0.5
                      ? Colors.white38
                      : Colors.black45,
                  child: Text(lan.getTexts('meal-${meal.id}')),
                ),
                background: Hero(
                  tag: meal.id,
                  child: InteractiveViewer(
                    /*child: FadeInImage(image:NetworkImage(), placeholder:AssetImage(), fit:BoxFit.cover)*/
                    child: CachedNetworkImage(
                      placeholder: (context, url) =>
                          Image.asset('assets/images/placeholder.png'),
                      imageUrl: meal.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              // check if orientation is landscape, then put ingradiants and steps together
              if (isLandscape)
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          buildSectionTitle(
                              context, lan.getTexts('Ingredients')),
                          buildSectionContents(
                            size: size,
                            child: ingradList,
                            isLandscape: isLandscape,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          buildSectionTitle(context, lan.getTexts('Steps')),
                          buildSectionContents(
                            size: size,
                            child: stepsList,
                            isLandscape: isLandscape,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

              // else put them under each other
              if (!isLandscape)
                buildSectionTitle(context, lan.getTexts('Ingredients')),
              if (!isLandscape)
                buildSectionContents(
                  size: size,
                  child: ingradList,
                  isLandscape: isLandscape,
                ),
              if (!isLandscape)
                buildSectionTitle(context, lan.getTexts('Steps')),
              if (!isLandscape)
                buildSectionContents(
                  size: size,
                  child: stepsList,
                  isLandscape: isLandscape,
                ),
            ])),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          // onPressed: () {
          //   Navigator.of(context).pop(meal.id);
          // },
          onPressed: () => Provider.of<MealProvider>(context, listen: false)
              .addRemoveMealFromFavorite(meal.id),
          child: Icon(
              Provider.of<MealProvider>(context, listen: true)
                      .isMealFavorited(meal.id)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.red),
        ),
      ),
    );
  }

  Container buildSectionTitle(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
      ),
    );
  }

  Container buildSectionContents({Size size, Widget child, bool isLandscape}) {
    return Container(
        height: isLandscape ? size.height * 0.5 : size.height * 0.3,
        //width: size.width / 1.1,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        child: child);
  }
}
