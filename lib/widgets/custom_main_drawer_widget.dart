import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:meal_app/screens/bottom_navigation_screen.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/themes_screen.dart';
import 'package:provider/provider.dart';

class CustomMainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lan = Provider.of<LanguageProvider>(context, listen: true);
    final tm = Provider.of<ThemeProvider>(context, listen: true);
    final size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Drawer(
        elevation: 0,
        child: Column(
          children: [
            Container(
              height: size.height / 4,
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: Theme.of(context).accentColor,
              alignment:
                  lan.isEn ? Alignment.centerLeft : Alignment.centerRight,
              child: Text(
                lan.getTexts('drawer_name'),
                style: TextStyle(
                  fontSize: size.width / 11,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            buildListTile(size, Icons.restaurant, lan.getTexts("drawer_item1"),
                () {
              Navigator.of(context)
                  .pushReplacementNamed(BottomNavigationScreen.routeName);
            }, context),
            buildListTile(size, Icons.settings, lan.getTexts("drawer_item2"),
                () {
              Navigator.of(context)
                  .pushReplacementNamed(FiltersScreen.routeName);
            }, context),
            buildListTile(
                size, Icons.color_lens_outlined, lan.getTexts("drawer_item3"),
                () {
              Navigator.of(context)
                  .pushReplacementNamed(ThemesScreen.routeName);
            }, context),
            Divider(
              height: 10,
              color: tm.accentColor,
            ),
            Container(
              alignment:
                  lan.isEn ? Alignment.centerLeft : Alignment.centerRight,
              padding: EdgeInsets.only(
                  top: 15, right: lan.isEn ? 0 : 20, left: lan.isEn ? 20 : 0),
              child: Text(
                lan.getTexts("drawer_switch_title"),
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: (lan.isEn ? 0 : 20),
                  left: (lan.isEn ? 20 : 0),
                  bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    lan.getTexts("drawer_switch_item2"),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Switch(
                    value: Provider.of<LanguageProvider>(context, listen: true)
                        .isEn,
                    onChanged: (newVal) {
                      Provider.of<LanguageProvider>(context, listen: false)
                          .changeLan(newVal);
                      Navigator.of(context).pop();
                    },
                    inactiveTrackColor:
                        tm.tm == ThemeMode.dark ? Colors.black54 : null,
                  ),
                  Text(
                    lan.getTexts("drawer_switch_item1"),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ),
            Divider(
              height: 10,
              color: tm.accentColor,
            ),
          ],
        ),
      ),
    );
  }

  ListTile buildListTile(Size size, IconData icon, String title,
      Function tapHandler, BuildContext ctx) {
    return ListTile(
      leading: Icon(
        icon,
        size: size.width * 0.08,
        color: Theme.of(ctx).buttonColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: size.width * 0.07,
          fontFamily: 'RobotoCondensed',
          fontWeight: FontWeight.bold,
          color: Theme.of(ctx).textTheme.bodyText1.color,
        ),
      ),
      onTap: tapHandler,
    );
  }
}
