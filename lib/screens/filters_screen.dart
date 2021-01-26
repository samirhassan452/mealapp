import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:meal_app/widgets/custom_main_drawer_widget.dart';
import 'package:provider/provider.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final bool fromOnBoardingScreen;

  const FiltersScreen({this.fromOnBoardingScreen = false});

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  // bool _glutenFree = false,
  //     _lactoseFree = false,
  //     _vegan = false,
  //     _vegetarian = false;
  List<Map<String, Object>> _listOfFilters;
  //Function saveFilters;
  Map<String, bool> currentFilters;

  @override
  void initState() {
    //saveFilters = Provider.of<MealProvider>(context).setFilters;
    currentFilters = Provider.of<MealProvider>(context, listen: false).filters;
    _listOfFilters = [
      {
        'id': 'gluten',
        'title': 'Gluten-Free',
        'subTitle': 'Only include gluten-free meals.',
        'value': currentFilters['gluten'],
      },
      {
        'id': 'lactose',
        'title': 'Lactose-Free',
        'subTitle': 'Only include lactose-free meals.',
        'value': currentFilters['lactose'],
      },
      {
        'id': 'vegetarian',
        'title': 'Vegetarian',
        'subTitle': 'Only include vegetarian meals.',
        'value': currentFilters['vegetarian'],
      },
      {
        'id': 'vegan',
        'title': 'Vegan',
        'subTitle': 'Only include vegan meals.',
        'value': currentFilters['vegan'],
      },
    ];
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final lan = Provider.of<LanguageProvider>(context, listen: true);
    _listOfFilters[0]['title'] = lan.getTexts('Gluten-free');
    _listOfFilters[0]['subTitle'] = lan.getTexts('Gluten-free-sub');
    _listOfFilters[1]['title'] = lan.getTexts('Lactose-free');
    _listOfFilters[1]['subTitle'] = lan.getTexts('Lactose-free_sub');
    _listOfFilters[2]['title'] = lan.getTexts('Vegetarian');
    _listOfFilters[2]['subTitle'] = lan.getTexts('Vegetarian-sub');
    _listOfFilters[3]['title'] = lan.getTexts('Vegan');
    _listOfFilters[3]['subTitle'] = lan.getTexts('Vegan-sub');

    Map<String, bool> currentFilters2 =
        Provider.of<MealProvider>(context, listen: true).filters;
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: widget.fromOnBoardingScreen
            ? AppBar(
                backgroundColor: Theme.of(context).canvasColor,
                elevation: 0,
              )
            : AppBar(
                title: Text(lan.getTexts('filters_appBar_title')),
                /*actions: [
            Padding(
              padding: EdgeInsets.only(right: 30),
              child: IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  Map<String, bool> _filters = {};
                  for (var filter in _listOfFilters) {
                    _filters[filter['id']] = filter['value'];
                  }

                  //print(_filters);
                  Provider.of<MealProvider>(context, listen: false)
                      .setFilters(_filters);
                  //saveFilters(_filters);
                },
              ),
            )
          ],*/
              ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Text(
                lan.getTexts('filters_screen_title'),
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: _listOfFilters.length,
                    itemBuilder: (context, index) {
                      return buildSwitchListTile(
                          title: _listOfFilters[index]['title'],
                          subTitle: _listOfFilters[index]['subTitle'],
                          //currentValue: _listOfFilters[index]['value'],
                          currentValue:
                              currentFilters2[_listOfFilters[index]['id']],
                          updatedValue: (bool updatedValue) {
                            // setState(() {
                            //   //_listOfFilters[index]['value'] = updatedValue;
                            //   currentFilters2[_listOfFilters[index]['id']] =
                            //       updatedValue;
                            // });

                            currentFilters2[_listOfFilters[index]['id']] =
                                updatedValue;
                            context.read<MealProvider>().setFilters();
                          });
                    })),
          ],
        ),
        drawer: widget.fromOnBoardingScreen ? null : CustomMainDrawer(),
      ),
    );
  }

  SwitchListTile buildSwitchListTile(
      {String title,
      String subTitle,
      bool currentValue,
      Function updatedValue}) {
    return SwitchListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subTitle),
        inactiveTrackColor:
            Provider.of<ThemeProvider>(context, listen: true).tm ==
                    ThemeMode.light
                ? null
                : Colors.black26,
        value: currentValue,
        onChanged: updatedValue);
  }
}
