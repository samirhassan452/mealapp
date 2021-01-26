import 'package:flutter/material.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/widgets/category_item_widget.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return GridView(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent:
            200, // each item has width of 200, means 2 items in row
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      padding: EdgeInsets.all(20),
      children: Provider.of<MealProvider>(context, listen: true)
          .availabeFilteredCategories
          .map((categoryData) => CategoryItem(
                category: categoryData,
              ))
          .toList(),
    );
  }
}
