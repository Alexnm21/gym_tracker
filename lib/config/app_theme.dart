import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppTheme {
  static const Color primary = Color(0xFFff6a14); //0xFFE2211C
  static const Color primaryLight = Color(0xFFffb470); //0xFFFF9996
  static const Color secondary = Color(0xFF000000); //0xFF393939
  static const Color secondaryLight = Color.fromARGB(255, 231, 231, 184);
  static const Color hover = Color(0xFFf04c06); //0xFFE2211C
  static const Color backgroundColor = Color.fromARGB(255, 250, 246, 215);
  static const Color addColor = Color(0xFF06d6a0);
  static const Color blackCardDescription = Color.fromRGBO(0, 0, 0, 0.6);
  static const Color gradientBegin = Color.fromRGBO(33, 33, 33, 1);
  static const Color gradientEnd = Color.fromRGBO(33, 33, 33, 0);
  static const Color darkGrey = Color.fromRGBO(53, 53, 53, 1);
  static const Color grey = Color.fromRGBO(117, 117, 117, 1);



  static TextStyle body_2 = const TextStyle(fontFamily: 'Montserrat-Medium', fontSize: 14, fontWeight: FontWeight.w500);
  static TextStyle bodyNegrita = const TextStyle(fontFamily: 'Montserrat-Bold', fontSize: 14, fontWeight: FontWeight.w700);
  static TextStyle h2Bold = const TextStyle(fontFamily: 'Montserrat-Bold', fontSize: 40, fontWeight: FontWeight.w700);
  static TextStyle bodyNormal = const TextStyle(fontFamily: 'Montserrat-Medium', fontSize: 16, fontWeight: FontWeight.w500);
  static TextStyle h4Bold = const TextStyle(fontFamily: 'Montserrat-Bold', fontSize: 20, fontWeight: FontWeight.w700, );
  static TextStyle h4Medium = const TextStyle(fontFamily: 'Montserrat-Medium', fontSize: 20, fontWeight: FontWeight.w500);
  static TextStyle textoDescriptivoNormal = const TextStyle(fontFamily: 'Montserrat-Medium', fontSize: 12, fontWeight: FontWeight.w500);
  static TextStyle textoPequenos = const TextStyle(fontFamily: 'Montserrat-Medium', fontSize: 10, fontWeight: FontWeight.w500);
  static TextStyle h1Bold = TextStyle(fontFamily: 'Montserrat-Bold', fontSize: 50.sp, fontWeight: FontWeight.w700, letterSpacing: 0.8);
  static TextStyle textoPequenoNegrita = const TextStyle(fontFamily: 'Montserrat-Bold', fontSize: 10, fontWeight: FontWeight.w700);
  static TextStyle h3Normal = const TextStyle(fontFamily: 'Montserrat-Medium', fontSize: 24, fontWeight: FontWeight.w500);
  static TextStyle h3Bold = const TextStyle(fontFamily: 'Montserrat-Medium', fontSize: 24, fontWeight: FontWeight.w700);
  static TextStyle h6Medium = const TextStyle(fontFamily: 'Montserrat-Medium', fontSize: 16, fontWeight: FontWeight.w500,  );
  static TextStyle h6Bold = const TextStyle(fontFamily: 'Montserrat-Bold', fontSize: 16, fontWeight: FontWeight.w700);

  static ThemeData customThemeData = ThemeData(
    primaryColor: primary,
    focusColor: hover,
    colorScheme: const ColorScheme.light(
      primary: primary
    ),
    appBarTheme: const AppBarTheme(
      color: primary,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 22)
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: primary
    )
  );
}