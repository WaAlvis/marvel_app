import 'package:flutter/material.dart';


class AppTheme {

  static final ThemeData lightTheme  = ThemeData.light().copyWith(

    //AppBar
    appBarTheme: const AppBarTheme(
      foregroundColor: Colors.black,
      actionsIconTheme: IconThemeData(
        color: Colors.black,
        size: 30
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      titleTextStyle:  TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 20
      )
    )


  );

}