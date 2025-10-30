import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final bool isLoggedIn = false; // Replace with actual auth check
    if (!isLoggedIn && route != '/login') {
      return const RouteSettings(name: '/login');
    }
    return null;
  }
}
