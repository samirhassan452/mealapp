import 'package:flutter/material.dart';
import 'package:meal_app/models/category.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/widgets/meal_item_widget.dart';
import 'package:provider/provider.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category_meals';

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  Category category;
  List<Meal> categoryMeals;
  List<Meal> availableMeals;

  // this medthod is called immediately after [initState]
  // this also called before build any widget
  // this method called when change anything depends on this state,
  // so when pass arguments, state will change, then call this method to put data in categoryMeals

  // يعني لما انادى على البيلد ميثود والمفروض ان هى بتشاور على حاجة فى الانهيرتد ويدجت والحاجة دى ممكن تتغير فيما بعد
  // بعد ما يحصل تغيير الفريم ورك هيبلغ الاستيت ان حصل تغيير فى الحاجة دى ف اكن هيتعمل ست ستيت

  // when call build() method, and its refrenced to thing that will change later
  // framework will call this method to notify object about the change
  // means 'categoryMeals' required data from 'category' but category need context which means, should build widget
  // cause context related to widgets, so when call build and context initiated, this method will call
  // to notify categoryMeals that data is ready from category
  @override
  // Each time a state change occurs, this function is called
  void didChangeDependencies() {
    availableMeals = Provider.of<MealProvider>(context).availableFilteredMeals;

    category = ModalRoute.of(context).settings.arguments as Category;

    // filter meals which match with it's category only before viewing
    // if meal in DUMMY_MEALS contains this catergoryID, then add meal to list to return list of meals or one meal in final
    // updated: if meal in widget.availableMeals "these are all meals after filtered"
    categoryMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    super.didChangeDependencies();
  }

  // it is called when build screen for the first time
  @override
  void initState() {
    // here we found a error cause 'context' is not supported here cause 'context' is belongs to widgets
    // but initState() method is executed before build any widget, so we will find error,
    // so we will use didChangeDependencies() method to solve this error
    //category = ModalRoute.of(context).settings.arguments as Category;//

    super.initState();
  }

  void _removeMealItem(String mealId) {
    setState(() {
      categoryMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final lan = Provider.of<LanguageProvider>(context, listen: true);
    final size = MediaQuery.of(context).size;
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(lan.getTexts('cat-${category.id}')),
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: size.width <= 400
                ? 400
                : 500, // each item has width of 400, means 2 items in row
            childAspectRatio: isLandscape
                ? size.width / (size.width * 0.54)
                : size.width / (size.height * 0.47),
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
          ),
          itemBuilder: (context, index) => MealItem(
            meal: categoryMeals[index],
            removeMealItem: _removeMealItem,
          ),
          itemCount: categoryMeals.length,
        ),
      ),
    );
  }
}
