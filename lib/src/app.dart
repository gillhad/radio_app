import 'package:flutter/material.dart';
import 'package:radio_app/src/config/app_style.dart';
import 'package:radio_app/src/config/navigation/nav_router.dart';
import 'package:radio_app/src/config/navigation/nav_routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RadioApp extends StatefulWidget {
  const RadioApp({super.key});

  @override
  State<RadioApp> createState() => _RadioAppState();
}

class _RadioAppState extends State<RadioApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppStyle.mainTheme,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: NavigatorRoutes.home,
      localizationsDelegates: AL.localizationsDelegates,
        supportedLocales: AL.supportedLocales,
    );
  }
}
