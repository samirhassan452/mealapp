import 'package:flutter/material.dart';
import 'package:meal_app/models/category.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/screens/category_meals_screen.dart';
import 'package:provider/provider.dart';

class CategoryItem extends StatelessWidget {
  final Category category;

  const CategoryItem({
    this.category,
  });

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      CategoryMealsScreen.routeName,
      arguments: category,
    );
  }

  @override
  Widget build(BuildContext context) {
    final lan = Provider.of<LanguageProvider>(context, listen: true);

    return InkWell(
      onTap: () => selectCategory(context),
      // color changing when click on button
      splashColor: Theme.of(context).primaryColor,
      // applying radius on splash color when click on button, must match radius of container if exist
      borderRadius: BorderRadius.circular(15),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              category.color,
              category.color.withOpacity(0.85),
              category.color.withOpacity(0.65),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          //category.title,
          lan.getTexts('cat-${category.id}'),
          style: Theme.of(context).textTheme.title,
        ),
      ),
    );
  }
}
