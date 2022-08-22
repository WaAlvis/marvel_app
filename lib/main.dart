import 'package:flutter/material.dart';
import 'package:marvel_app_test/providers/providers.dart';
import 'package:marvel_app_test/screens/screens.dart';
import 'package:marvel_app_test/share_preferences/preferences.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Preferences.init();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(isDarkMode: Preferences.isDarkMode),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => MarvelProvider(),
          lazy: false,
        )
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marvel SuperHeroes',
      initialRoute: HomeScreen.nameRoute,
      routes: {
        HomeScreen.nameRoute: (_) => const HomeScreen(),
        DetailComicScreen.nameRoute: (_) => const DetailComicScreen(),
        DetailCharacterScreen.nameRoute: (_) => const DetailCharacterScreen(),
      },
      theme: Provider.of<ThemeProvider>(context).currentTheme,
    );
  }
}
