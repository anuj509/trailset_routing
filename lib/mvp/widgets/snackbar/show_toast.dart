import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast({required String title, int timeInSecForIosWeb = 1}) {
  return Fluttertoast.showToast(
      msg: title,
      webPosition: 'center',
      webBgColor: 'linear-gradient(to right, #000000, #000000)',
      backgroundColor: Colors.black,
      textColor: Colors.white,
      timeInSecForIosWeb: timeInSecForIosWeb);
}
