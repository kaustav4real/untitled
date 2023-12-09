import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightTheme=ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0XFFd7e3f7),
  textTheme: TextTheme(
    titleSmall: GoogleFonts.montserrat(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: const Color(0XFF636363),
    ),
    titleMedium: GoogleFonts.montserrat(
      fontSize: 20,
      fontWeight: FontWeight.w600
    ),
    titleLarge: GoogleFonts.openSans(
      fontSize: 24,
      fontWeight: FontWeight.w700
    ),
  ),
);


final ThemeData darkTheme=ThemeData(
  useMaterial3: true,

);