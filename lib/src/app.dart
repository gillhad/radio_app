import 'package:flutter/material.dart';
import 'package:radio_app/src/config/navigation/nav_router.dart';
import 'package:radio_app/src/config/navigation/nav_routes.dart';

class RadioApp extends StatefulWidget {
  const RadioApp({super.key});

  @override
  State<RadioApp> createState() => _RadioAppState();
}

class _RadioAppState extends State<RadioApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: NavigatorRoutes.home,
    );
  }
}
