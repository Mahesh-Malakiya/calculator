import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PagesUtil {
  static bool hasBottomNavigationGesture(BuildContext context) {
    final windowPadding = View.of(context).viewInsets.bottom;
    return windowPadding > 0;
  }
}
