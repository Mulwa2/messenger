import 'package:flutter/material.dart';
import 'package:messenger/Screens/login.dart';
import 'package:messenger/theme.dart';

import 'Screens/HomeScreen.dart';

void main() {
  runApp(MyApp(
    appTheme: AppTheme(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appTheme}) : super(key: key);

  final AppTheme appTheme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme.light,
      darkTheme: appTheme.dark,
      themeMode: ThemeMode.light,
      home: const MyLogin(),
    );
  }
}
