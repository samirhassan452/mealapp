import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/screens/bottom_navigation_screen.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/themes_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage("assets/images/image.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: size.width * 0.75,
                      height: size.height / 10,
                      color:
                          Theme.of(context).buttonColor.computeLuminance() < 0.5
                              ? Colors.white38
                              : Colors.black45,
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Text(
                        lan.getTexts("drawer_name"),
                        style: Theme.of(context).textTheme.headline5,
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    Container(
                      width: size.width * 0.9,
                      height: size.height / 5.5,
                      color:
                          Theme.of(context).buttonColor.computeLuminance() < 0.5
                              ? Colors.white38
                              : Colors.black45,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          Text(
                            lan.getTexts('drawer_switch_title'),
                            style: Theme.of(context).textTheme.headline5,
                            textAlign: TextAlign.center,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(lan.getTexts('drawer_switch_item2'),
                                  style: Theme.of(context).textTheme.headline6),
                              Switch(
                                activeColor: primaryColor,
                                value: lan.isEn,
                                onChanged: (newValue) {
                                  Provider.of<LanguageProvider>(context,
                                          listen: false)
                                      .changeLan(newValue);
                                },
                              ),
                              Text(lan.getTexts('drawer_switch_item1'),
                                  style: Theme.of(context).textTheme.headline6),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ThemesScreen(fromOnBoardingScreen: true),
              FiltersScreen(fromOnBoardingScreen: true),
            ],
            onPageChanged: (newIndex) {
              setState(() {
                _currentIndex = newIndex;
              });
            },
          ),
          Indicator(index: _currentIndex),
          // put btn in Builder widget to generate new context for this btn
          Builder(
              builder: (ctx) => Align(
                    alignment: Alignment(0, 0.85),
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: RaisedButton(
                        padding:
                            lan.isEn ? EdgeInsets.all(7) : EdgeInsets.all(0),
                        color: primaryColor,
                        child: Text(lan.getTexts('start'),
                            style: TextStyle(
                                color: primaryColor.computeLuminance() < 0.5
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 25)),
                        onPressed: () async {
                          Navigator.of(ctx).pushReplacementNamed(
                              BottomNavigationScreen.routeName);

                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setBool('watched', true);
                        },
                      ),
                    ),
                  )),
        ],
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final int index;

  const Indicator({this.index});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildBubbles(context, 0),
          buildBubbles(context, 1),
          buildBubbles(context, 2),
        ],
      ),
    );
  }

  Widget buildBubbles(BuildContext ctx, int bubbleIndex) {
    return index == bubbleIndex
        ? Icon(
            Icons.star,
            color: Theme.of(ctx).primaryColor,
          )
        : Container(
            margin: EdgeInsets.all(4),
            height: 15,
            width: 15,
            decoration: BoxDecoration(
              color: Theme.of(ctx).accentColor,
              shape: BoxShape.circle,
            ),
          );
  }
}
