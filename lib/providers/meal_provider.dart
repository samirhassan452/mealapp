import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/models/category.dart';
import 'package:meal_app/models/meal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MealProvider with ChangeNotifier {
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false,
  };
  List<Meal> availableFilteredMeals = DUMMY_MEALS;
  List<Meal> favoriteMeals = [];

  List<Category> availabeFilteredCategories = [];

  void setFilters(/*Map<String, bool> filtersData*/) async {
    //filters = filtersData;

    availableFilteredMeals = DUMMY_MEALS.where((meal) {
      // check if user need meal without gluten && check each meal, if meal has gluten, then return false
      // means that don't return this meal
      // isGlutenFree == true : means this meal does't has gluten
      if (filters['gluten'] && !meal.isGlutenFree) return false;
      if (filters['lactose'] && !meal.isLactoseFree) return false;
      if (filters['vegetarian'] && !meal.isVegetarian) return false;
      if (filters['vegan'] && !meal.isVegan) return false;
      // if all conditions are false, then return this meal, which is compatible with our needs
      return true;
    }).toList();

    List<Category> tempAvailableCat = [];
    availableFilteredMeals.forEach((meal) {
      meal.categories.forEach((categoryId) {
        DUMMY_CATEGORIES.forEach((category) {
          if (category.id == categoryId) {
            if (!tempAvailableCat.any((cat) => cat.id == categoryId)) {
              tempAvailableCat.add(category);
            }
          }
        });
      });
    });
    availabeFilteredCategories = tempAvailableCat;

    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("gluten", filters['gluten']);
    prefs.setBool("lactose", filters['lactose']);
    prefs.setBool("vegetarian", filters['vegetarian']);
    prefs.setBool("vegan", filters['vegan']);
  }

  void setFiltersDataToScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    filters['gluten'] = prefs.getBool("gluten") ?? false;
    filters['lactose'] = prefs.getBool("lactose") ?? false;
    filters['vegetarian'] = prefs.getBool("vegetarian") ?? false;
    filters['vegan'] = prefs.getBool("vegan") ?? false;

    List<String> prefsMealId = prefs.getStringList("prefsMealId") ?? [];
    //print(prefsMealId);
    for (var mealId in prefsMealId) {
      if (!favoriteMeals.any((favMeal) => favMeal.id == mealId)) {
        favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      }
    }

    //print(favoriteMeals);

    setFilters();

    // to update favrotie screen after making any filter
    List<Meal> avTempFavMeals = [];
    favoriteMeals.forEach((favMeal) {
      availableFilteredMeals.forEach((avFilteredMeal) {
        if (favMeal.id == avFilteredMeal.id) {
          avTempFavMeals.add(favMeal);
        }
      });
    });

    favoriteMeals = avTempFavMeals;

    notifyListeners();
  }

  // here we will check, cause user can click on favorite button to add meal to favorites, and click again to remove it
  void addRemoveMealFromFavorite(String mealId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> prefsMealId = prefs.getStringList("prefsMealId") ?? [];

    // check if this meal already exist or not, to know what we will do 'add' or 'remove'
    // if meal doesn't exist, indexWhere() method will return '-1', otherwise will return index of meal
    final existingMealIndex =
        favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if (existingMealIndex >= 0) {
      // we will remove meal, cause this means user click on favorite button to remove meal from favorties
      favoriteMeals.removeAt(existingMealIndex);
      prefsMealId.remove(mealId);
    } else {
      // add meal to favorites
      favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      prefsMealId.add(mealId);
    }

    notifyListeners();

    //print(prefsMealId);

    prefs.setStringList("prefsMealId", prefsMealId);
  }

  bool isMealFavorited(String mealId) {
    return favoriteMeals.any((meal) => meal.id == mealId);
  }
}
