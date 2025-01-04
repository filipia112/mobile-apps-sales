import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// colors
const Color kPrimaryBlue = Color(0xFF024CAA);
const Color kWhite = Color(0xFFFFFFFF);
const Color kLightBlue = Color(0xFFE3F2FD);
const Color kSoftBlue = Color(0xFF50ACF8);
const Color kRed = Color(0xFFFD3949);
const Color kLightGrey = Color(0xFF8C9DA5);
const Color kOffWhite = Color(0xFFF5F5F5);


// text style
final TextStyle kHeading5 =
TextStyle(fontFamily: 'SansSerif', fontSize: 23, fontWeight: FontWeight.w400);
final TextStyle kHeading6 = TextStyle(
    fontFamily: 'SansSerif', fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15);
final TextStyle kSubtitle = TextStyle(
    fontFamily: 'SansSerif', fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15);
final TextStyle kBodyText = TextStyle(
    fontFamily: 'SansSerif', fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.25);

const kColorScheme = ColorScheme(
  primary: kPrimaryBlue,
  secondary: kSoftBlue,
  secondaryContainer: kLightBlue,
  surface: kWhite,
  error: kRed,
  onPrimary: kWhite,
  onSecondary: kPrimaryBlue,
  onSurface: kPrimaryBlue,
  onError: kWhite,
  brightness: Brightness.light,
);
