import 'package:flutter/material.dart';
import 'package:marvel_app_test/providers/providers.dart';
import 'package:marvel_app_test/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../search/seach_delegate.dart';
import '../share_preferences/preferences.dart';

class HomeScreen extends StatelessWidget {
  static const String nameRoute = 'home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final marvelProvider = Provider.of<MarvelProvider>(context);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);


    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar:  AppbarCustom(
        onPressed: () => showSearch(context: context, delegate: MarvelSearchDelegate()) ,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SwitchListTile.adaptive(
                    title: Text('DarkMode (SharedPrefs)'),
                    value: Preferences.isDarkMode,
                    onChanged: (value){
                      Preferences.isDarkMode = value;
                      value ? themeProvider.setDarkMode() : themeProvider.setLightMode();
                    }
                ),
                SizedBox(
                  height: size.height * 0.35,
                  child: SliderHorizontalCard(
                    characters: marvelProvider.charactersMarvel,
                    onNextPage: () {
                      marvelProvider.getCharacters();
                    },
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  height: size.height * 0.8,
                  child: SwipVertical(
                    listComics: marvelProvider.comicsMarvel,
                    onNextPage: () => marvelProvider.getComics(),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
