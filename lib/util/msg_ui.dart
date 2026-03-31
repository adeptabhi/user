// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:user/main.dart';
import 'package:user/util/theme/theme_color.dart';

void msgToast(String value) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
    msg: value,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: ThemeColor.bgBlue,
    textColor: ThemeColor.textBlue,
    fontSize: 12.0,
  );
}

void msgSnackBar(String msg) {
  ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
    SnackBar(
      content: Text(
        msg,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 13,
          color: ThemeColor.bgBlue,
        ),
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: ThemeColor.textBlue,
    ),
  );
}
