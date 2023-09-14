import 'package:flutter/material.dart';
import 'package:radio_app/src/config/navigation/nav_routes.dart';
import 'package:radio_app/src/ui/screen/home.dart';

class AppRouter{
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NavigatorRoutes.home:
        return MaterialPageRoute(builder: (context) {
          return RadioStations();
        });


}
  }
}