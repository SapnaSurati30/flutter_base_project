import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../main.dart';
import '../utils/app_constants.dart';

bool hasMatch(String? s, String p) {
  return (s == null) ? false : RegExp(p).hasMatch(s);
}

get getContext => navigatorKey.currentState?.overlay?.context;

showToast(String? value, {ToastGravity? gravity, length = Toast.LENGTH_SHORT, Color? bgColor, Color? textColor}) {
  Fluttertoast.showToast(
    msg: value!,
    toastLength: length,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: bgColor,
    textColor: textColor,
    fontSize: 16.0,
  );

}
void printLog(Object? value) {
  if (!kReleaseMode || forceEnableDebug) print(value);
}

heightSpacer(double? height) {
  return SizedBox(height: height);
}

widthSpacer(double? width) {
  return SizedBox(width: width);
}