import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextTheme {
  static final TextTheme textTheme = TextTheme(
    displayLarge: GoogleFonts.robotoCondensed(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    displayMedium: GoogleFonts.robotoCondensed(
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    displaySmall: GoogleFonts.robotoCondensed(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headlineMedium: GoogleFonts.robotoCondensed(
      fontSize: 20.0,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    bodyLarge: GoogleFonts.robotoCondensed(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    bodyMedium: GoogleFonts.robotoCondensed(
      fontSize: 14.0,
      // fontWeight: FontWeight.bold,
      color: Colors.blue,
    ),
    titleMedium: GoogleFonts.robotoCondensed(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: Colors.black54,
    ),
    titleSmall: GoogleFonts.robotoCondensed(
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
      color: Colors.black54,
    ),
    labelLarge: GoogleFonts.robotoCondensed(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );
}
