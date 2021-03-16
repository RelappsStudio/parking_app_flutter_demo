import 'package:flutter/material.dart';


InputDecorationTheme inputDecorationTheme()
{
  var outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: Colors.grey),
  );

  return InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 20
      ),
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      border: outlineInputBorder
  );
}