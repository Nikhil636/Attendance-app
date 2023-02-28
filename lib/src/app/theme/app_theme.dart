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
