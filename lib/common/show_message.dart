import 'package:flutter/material.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';

showMessage(
    {required String message,
    required BuildContext context,
    required Color color}) {
  Flushbar(
    flushbarPosition: FlushbarPosition.BOTTOM,
    backgroundColor: color,
    duration: const Duration(seconds: 2),
    messageText: Text(
      message,
      style: const TextStyle(
          fontSize: 16.0,
          color: Colors.white,
          fontFamily: "ShadowsIntoLightTwo"),
    ),
  ).show(context);
}
