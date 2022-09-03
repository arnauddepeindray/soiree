/*
 * *
 *  * Created by Vishal Patolia on 9/20/21, 1:11 PM
 *  * Copyright (c) 2021 . All rights reserved.
 *  * Sdreatech Solutions Pvt. Ltd.
 *  * Last modified 9/20/21, 1:11 PM
 *
 */
import 'package:flutter/widgets.dart';

class Routes {
  static const String splash = "/";

  static Route<T> fadeThrough<T>(RouteSettings settings, WidgetBuilder page,
      {int duration = 0}) {
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: Duration(milliseconds: duration),
      pageBuilder: (context, animation, secondaryAnimation) => page(context),
    );
  }
}
