import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void toast(text) {
  Fluttertoast.showToast(
    msg: text,
    gravity: ToastGravity.BOTTOM,
    toastLength: Toast.LENGTH_SHORT,
    backgroundColor: Colors.blue[200],
    textColor: Colors.black,
    timeInSecForIosWeb: 2,
  );
}
