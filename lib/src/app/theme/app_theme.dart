import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final Provider<AppTheme> themeDataProvider = Provider<AppTheme>(
  name: 'ThemeProvider',
  (ProviderRef<AppTheme> ref) => AppTheme(),
);

class AppTheme {
  // static const Color primaryColor = Color(0xFF6F35A5);
  // static const Color primaryLightColor = Color(0xFFF1E6FF);
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final Provider<AppTheme> themeDataProvider = Provider<AppTheme>(
  name: 'ThemeProvider',
  (ProviderRef<AppTheme> ref) => AppTheme(),
);

class AppTheme {
  final Color primaryColor = Color(0xFF5E35B1);
  final Color accentColor = Color(0xFFFFC107);

  final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: primaryColor,
    accentColor: accentColor,
    scaffoldBackgroundColor: Colors.grey[200],
    backgroundColor: Colors.white,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: accentColor,
      selectionColor: accentColor.withOpacity(0.4),
      selectionHandleColor: accentColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: accentColor),
      ),
      hintStyle: GoogleFonts.montserrat(
        fontSize: 16,
        color: Colors.grey[500],
        fontWeight: FontWeight.w500,
      ),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      iconTheme: IconThemeData(
        color: primaryColor,
      ),
      titleTextStyle: GoogleFonts.montserrat(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
    ),
    textTheme: GoogleFonts.montserratTextTheme().copyWith(
      headline1: GoogleFonts.montserrat(
        fontSize: 32,
        color: primaryColor,
        fontWeight: FontWeight.w800,
      ),
      headline2: GoogleFonts.montserrat(
        fontSize: 24,
        color: Colors.black,
        fontWeight: FontWeight.w700,
      ),
      subtitle1: GoogleFonts.montserrat(
        fontSize: 16,
        color: Colors.grey[700],
        fontWeight: FontWeight.w500,
      ),
      subtitle2: GoogleFonts.montserrat(
        fontSize: 14,
        color: Colors.grey[500],
        fontWeight: FontWeight.w500,
      ),
      bodyText1: GoogleFonts.montserrat(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      bodyText2: GoogleFonts.montserrat(
        fontSize: 14,
        color: Colors.grey[700],
        fontWeight: FontWeight.w500,
      ),
      button: GoogleFonts.montserrat(
        fontSize: 14,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  final ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: primaryColor,
    accentColor: accentColor,
    scaffoldBackgroundColor: Colors.grey[900],
    backgroundColor: Colors.grey[800],
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: accentColor,
      selectionColor: accentColor.withOpacity(0.4),
      selectionHandle

  //light theme
  final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.blue,
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: GoogleFonts.anekDevanagari(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: GoogleFonts.anekDevanagari(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(2, 64, 116, 1),
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    textTheme: GoogleFonts.anekDevanagariTextTheme().copyWith(
      labelLarge: GoogleFonts.kdamThmorPro(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      labelMedium: GoogleFonts.kdamThmorPro(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      labelSmall: GoogleFonts.kdamThmorPro(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  //dark theme
  final ThemeData darkTheme = ThemeData.dark().copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: GoogleFonts.anekDevanagari(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: GoogleFonts.anekDevanagari(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
    ),
    textTheme: GoogleFonts.anekDevanagariTextTheme().copyWith(
      labelLarge: GoogleFonts.kdamThmorPro(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      labelMedium: GoogleFonts.kdamThmorPro(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      labelSmall: GoogleFonts.kdamThmorPro(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
