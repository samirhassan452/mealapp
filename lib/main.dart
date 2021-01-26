import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:meal_app/screens/bottom_navigation_screen.dart';
import 'package:meal_app/screens/categories_screen.dart';
import 'package:meal_app/screens/category_meals_screen.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/meal_details_screen.dart';
import 'package:meal_app/screens/on_boarding_screen.dart';
import 'package:meal_app/screens/themes_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  Widget mainScreen = prefs.getBool('watched') ?? false
      ? BottomNavigationScreen()
      : OnBoardingScreen();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<MealProvider>(
        create: (ctx) => MealProvider(),
      ),
      ChangeNotifierProvider<ThemeProvider>(
        create: (ctx) => ThemeProvider(),
      ),
      ChangeNotifierProvider<LanguageProvider>(
        create: (ctx) => LanguageProvider(),
      ),
    ],
    //child: MyApp(mainScreen: mainScreen),
    child: MyApp(mainScreen: mainScreen),
  ));
}

class MyApp extends StatelessWidget {
  final Widget mainScreen;
  const MyApp({this.mainScreen});

  @override
  Widget build(BuildContext context) {
    var primaryColor =
        Provider.of<ThemeProvider>(context, listen: true).primaryColor;
    var accentColor =
        Provider.of<ThemeProvider>(context, listen: true).accentColor;
    var tm = Provider.of<ThemeProvider>(context, listen: true).tm;

    return MaterialApp(
      title: 'Find Meal',
      debugShowCheckedModeBanner: false,
      themeMode: tm,
      // locale: DevicePreview.locale(context), // Add the locale here
      // builder: DevicePreview.appBuilder, // Add the builder here
      theme: ThemeData(
        fontFamily: 'Raleway',
        primarySwatch: primaryColor,
        accentColor: accentColor,
        canvasColor:
            Color.fromRGBO(255, 250, 229, 1), // whole/background color of app
        buttonColor: Colors.black87,
        cardColor: Colors.white,
        shadowColor: Colors.black54,
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 50, 50, 1),
              ),
              headline6: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
      ),
      darkTheme: ThemeData(
        fontFamily: 'Raleway',
        primarySwatch: primaryColor,
        accentColor: accentColor,
        canvasColor:
            Color.fromRGBO(14, 22, 33, 1), // whole/background color of app
        buttonColor: Colors.white70,
        cardColor: Color.fromRGBO(35, 34, 39, 1),
        shadowColor: Colors.white60,
        unselectedWidgetColor: Colors.white60,
        textTheme: ThemeData.dark().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Colors.white60,
              ),
              headline6: TextStyle(
                fontSize: 20,
                color: Colors.white60,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      //home: MyHomePage(),
      routes: {
        '/': (context) => mainScreen,
        BottomNavigationScreen.routeName: (context) => BottomNavigationScreen(),
        CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(),
        MealDetailsScreen.routeName: (context) => MealDetailsScreen(),
        FiltersScreen.routeName: (context) => FiltersScreen(),
        ThemesScreen.routeName: (context) => ThemesScreen(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meal App"),
      ),
      body: CategoriesScreen(),
    );
  }
}
