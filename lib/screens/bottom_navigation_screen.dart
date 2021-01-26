import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:meal_app/screens/categories_screen.dart';
import 'package:meal_app/screens/favorites_screen.dart';
import 'package:meal_app/widgets/custom_main_drawer_widget.dart';
import 'package:provider/provider.dart';

class BottomNavigationScreen extends StatefulWidget {
  static const routeName = '/bottom_nav';
  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _selectedPageIndex;
  List<Map<String, Object>> _pages;
  @override
  void initState() {
    //Provider.of<MealProvider>(context, listen: false).setFilters();
    Provider.of<MealProvider>(context, listen: false).setFiltersDataToScreen();
    Provider.of<ThemeProvider>(context, listen: false)
        .getThemeDataFromSharedPref();
    Provider.of<LanguageProvider>(context, listen: false)
        .getAppLangDataFromSharedPref();

    _selectedPageIndex = 0;
    _pages = [
      {'page': CategoriesScreen(), 'title': 'Categories'},
      {'page': FavoritesScreen(), 'title': 'Favorites'}
    ];
    super.initState();
  }

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lan = Provider.of<LanguageProvider>(context, listen: true);
    _pages[0]['title'] = lan.getTexts('categories');
    _pages[1]['title'] = lan.getTexts('your_favorites');
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_pages[_selectedPageIndex]['title']),
        ),
        body: _pages[_selectedPageIndex]['page'],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectedPage,
          currentIndex: _selectedPageIndex,
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: lan.getTexts('categories'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: lan.getTexts('your_favorites'),
            ),
          ],
        ),
        drawer: CustomMainDrawer(),
      ),
    );
  }
}
