import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_app/src/config/app_style.dart';
import 'package:radio_app/src/config/globals.dart';
import 'package:radio_app/src/config/navigation/nav_router.dart';
import 'package:radio_app/src/config/navigation/nav_routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:radio_app/src/provider/radio_provider.dart';

class RadioApp extends StatefulWidget {
  const RadioApp({super.key});

  @override
  State<RadioApp> createState() => _RadioAppState();
}

class _RadioAppState extends State<RadioApp> {

@override
  void initState() {
    loadRadio(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: AppStyle.mainTheme,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: NavigatorRoutes.home,
      localizationsDelegates: AL.localizationsDelegates,
        supportedLocales: AL.supportedLocales,
    );
  }

  loadRadio(context)async{
    RadioProvider _notifier = Provider.of<RadioProvider>(context,listen: false);
    print("a coger radios");
    await _notifier.getRadios(context);
    print("pues ha acabado de cargar monguer");
  }
}
