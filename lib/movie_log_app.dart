import 'package:flutter/material.dart';

import 'screens/start_screen.dart';
import 'theme/app_theme.dart';

class MovieLogApp extends StatelessWidget {
  const MovieLogApp({super.key, this.home = const StartScreen()});
  final Widget home;
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'MovieLog',
    theme: AppTheme.light,
    home: home,
  );
}
