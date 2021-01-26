import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:meal_app/widgets/custom_main_drawer_widget.dart';
import 'package:provider/provider.dart';

class ThemesScreen extends StatelessWidget {
  static const routeName = "/themes";
  final bool fromOnBoardingScreen;

  const ThemesScreen({this.fromOnBoardingScreen = false});

  Widget build(BuildContext context) {
    final lan = Provider.of<LanguageProvider>(context, listen: true);

    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: fromOnBoardingScreen
            ? AppBar(
                backgroundColor: Theme.of(context).canvasColor,
                elevation: 0,
              )
            : AppBar(
                title: Text(lan.getTexts('theme_appBar_title')),
              ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Text(
                lan.getTexts('theme_screen_title'),
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Expanded(
                child: ListView(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  child: Text(
                    lan.getTexts('theme_mode_title'),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                buildRadioListTile(ThemeMode.system,
                    lan.getTexts('System_default_theme'), null, context),
                buildRadioListTile(ThemeMode.light, lan.getTexts('light_theme'),
                    Icons.wb_sunny_outlined, context),
                buildRadioListTile(ThemeMode.dark, lan.getTexts('dark_theme'),
                    Icons.nights_stay_outlined, context),
                buildListTile(context, lan.getTexts('primary')),
                buildListTile(context, lan.getTexts('accent')),
                // if we set screen to landscape, then we need to add extra height to save last text from hiding behind btn in boarding screen
                SizedBox(
                  height: fromOnBoardingScreen ? 80 : 0,
                ),
              ],
            )),
          ],
        ),
        drawer: fromOnBoardingScreen ? null : CustomMainDrawer(),
      ),
    );
  }

  ListTile buildListTile(BuildContext ctx, String txt) {
    var primaryColor =
        Provider.of<ThemeProvider>(ctx, listen: true).primaryColor;
    var accentColor = Provider.of<ThemeProvider>(ctx, listen: true).accentColor;

    bool checkTxt = txt.contains('primary') || txt.contains('الاساسي');

    return ListTile(
      title: Text(
        txt,
        style: Theme.of(ctx).textTheme.headline6,
      ),
      trailing: CircleAvatar(
        backgroundColor: checkTxt ? primaryColor : accentColor,
      ),
      onTap: () {
        showDialog(
            context: ctx,
            builder: (BuildContext ctx2) {
              return AlertDialog(
                elevation: 4,
                titlePadding: const EdgeInsets.all(0.0),
                contentPadding: const EdgeInsets.all(0.0),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: checkTxt
                        ? Provider.of<ThemeProvider>(ctx2, listen: true)
                            .primaryColor
                        : Provider.of<ThemeProvider>(ctx2, listen: true)
                            .accentColor,
                    onColorChanged: (newColor) =>
                        Provider.of<ThemeProvider>(ctx2, listen: false)
                            .onChanged(
                      newColor,
                      checkTxt ? 1 : 2,
                    ),
                    colorPickerWidth: 300.0,
                    pickerAreaHeightPercent: 0.8,
                    enableAlpha: false,
                    showLabel: false,
                    displayThumbColor:
                        true, // draw small circle by choosen color on slider
                  ),
                ),
              );
            });
      },
    );
  }

  RadioListTile buildRadioListTile(
      ThemeMode themeVal, String text, IconData icon, BuildContext ctx) {
    return RadioListTile(
      secondary: Icon(
        icon,
        color: Theme.of(ctx).buttonColor,
      ),
      value: themeVal,
      groupValue: Provider.of<ThemeProvider>(ctx, listen: true).tm,
      onChanged: (newThemeVal) => Provider.of<ThemeProvider>(ctx, listen: false)
          .themeModeChange(newThemeVal),
      title: Text(text),
    );
  }
}
