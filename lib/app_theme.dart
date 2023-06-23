import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/app_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'utils/app_colors.dart';
import 'utils/app_constants.dart';

class AppTheme {
  //
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: PRIMARY_COLOR,
      scaffoldBackgroundColor: scaffoldLightColor,
      fontFamily: GoogleFonts.workSans().fontFamily,
      useMaterial3: true,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.white),
      iconTheme: IconThemeData(color: textPrimaryColorCommon),
      textTheme: GoogleFonts.workSansTextTheme(),
      dialogBackgroundColor: Colors.white,
      unselectedWidgetColor: Colors.black,
      dividerColor: borderColor,
      bottomSheetTheme: BottomSheetThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(defaultRadius), topRight: Radius.circular(defaultRadius))),
        backgroundColor: Colors.white,
      ),
      cardColor: cardColor,
      appBarTheme: AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light)),
      dialogTheme: DialogTheme(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultRadius))),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: PRIMARY_COLOR,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
      ),
      scaffoldBackgroundColor: scaffoldDarkColor,
      fontFamily: GoogleFonts.workSans().fontFamily,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: scaffoldSecondaryDark),
      iconTheme: IconThemeData(color: Colors.white),
      textTheme: GoogleFonts.workSansTextTheme(),
      dialogBackgroundColor: scaffoldSecondaryDark,
      unselectedWidgetColor: Colors.white60,
      useMaterial3: true,
      bottomSheetTheme: BottomSheetThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(defaultRadius), topRight: Radius.circular(defaultRadius))),
        backgroundColor: scaffoldDarkColor,
      ),
      dividerColor: dividerDarkColor,
      cardColor: cardDarkColor,
      dialogTheme: DialogTheme(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultRadius))),
    );
  }
}
