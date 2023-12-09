import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightTheme=ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0XFFd7e3f7),
  textTheme: TextTheme(
    bodyMedium: GoogleFonts.notoSans(
        color: Colors.black54,
        fontSize: 20,
        fontWeight: FontWeight.w500
    ),
    labelSmall: GoogleFonts.notoSans(
      color: Colors.black54,
      fontSize: 13,
    ),
    labelMedium: GoogleFonts.notoSans(
      color: Colors.black,
      fontSize: 16,
    ),
    titleSmall: GoogleFonts.montserrat(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: const Color(0XFF636363),
    ),
    titleMedium: GoogleFonts.montserrat(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.black
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