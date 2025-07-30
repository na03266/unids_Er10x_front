import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

Page<void> buildCupertinoPage(Widget child) {
  return CustomTransitionPage(
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return CupertinoPageTransition(
        primaryRouteAnimation: animation,
        secondaryRouteAnimation: secondaryAnimation,
        linearTransition: true,
        child: child,
      );
    },
  );
}
