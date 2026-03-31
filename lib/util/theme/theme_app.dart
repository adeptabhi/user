import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user/util/theme/theme_color.dart';

class ThemeApp {
  ThemeApp._();
  static ThemeData light = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Poppins",
    appBarTheme: AppBarThemeData(
      surfaceTintColor: ThemeColor.blue,
      foregroundColor: ThemeColor.blue,
      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: ThemeColor.blue),
      toolbarHeight: 55,
      backgroundColor: ThemeColor.blue,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleSpacing: 5,
      iconTheme: IconThemeData(size: 25, color: Colors.white),
      titleTextStyle: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    dividerTheme: DividerThemeData(
      color: ThemeColor.borderBlue,
      space: 1.0,
      thickness: 1.0,
      indent: 56.0,
    ),
    textSelectionTheme: TextSelectionThemeData(cursorColor: ThemeColor.blue),
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: ThemeColor.valueGrey,
      ),
    ),
    iconTheme: IconThemeData(size: 20),
    colorScheme: ColorScheme.fromSeed(seedColor: ThemeColor.blue),
    useMaterial3: true,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        maximumSize: WidgetStateProperty.all(Size(double.infinity, 47)),
        minimumSize: WidgetStateProperty.all(Size(double.infinity, 47)),
        backgroundColor: WidgetStateProperty.all(ThemeColor.blue),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        elevation: WidgetStateProperty.all(4),
        shadowColor: WidgetStateProperty.all(ThemeColor.blue),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
        textStyle: WidgetStateProperty.all(
          TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
          ),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationThemeData(
      filled: true,
      fillColor: Colors.white,
      alignLabelWithHint: true,
      iconColor: ThemeColor.blue,
      suffixIconColor: ThemeColor.iconGrey,
      prefixIconColor: ThemeColor.iconGrey,
      suffixIconConstraints: BoxConstraints(minWidth: 42, maxWidth: 42),
      prefixIconConstraints: BoxConstraints(minWidth: 42, maxWidth: 42),
      labelStyle: TextStyle(
        color: ThemeColor.iconGrey,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      errorStyle: TextStyle(color: ThemeColor.red, fontSize: 13),
      hintStyle: TextStyle(
        color: ThemeColor.iconGrey,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: ThemeColor.borderBlue, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: ThemeColor.borderBlue, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: ThemeColor.blue, width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: ThemeColor.red, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: ThemeColor.red, width: 1.5),
      ),
      visualDensity: VisualDensity(horizontal: 0.0, vertical: 0.0),
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
    ),
  );
}
