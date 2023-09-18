import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_app/src/app.dart';
import 'package:radio_app/src/provider/radio_provider.dart';

void main() {
WidgetsFlutterBinding.ensureInitialized;
runApp(
  ChangeNotifierProvider(
    create: (_)=>RadioProvider(),
    child: RadioApp(),
  )
  );
}
