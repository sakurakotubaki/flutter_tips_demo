import 'package:flutter/material.dart';

mixin AppThemeDataMixin {
  Color get primaryColor;
  Color get accentColor;
  Color get surfaceColor;
  Color get onSurfaceColor;
  TextStyle get headlineStyle;
  TextStyle get bodyStyle;
  TextStyle get captionStyle;
}

enum AppThemeEnum with AppThemeDataMixin {
  light(
    primaryColor: Colors.blue,
    accentColor: Colors.amber,
    surfaceColor: Colors.white,
    onSurfaceColor: Colors.black,
    headlineStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    bodyStyle: TextStyle(fontSize: 16),
    captionStyle: TextStyle(fontSize: 12, color: Colors.grey),
  ),
  dark(
    primaryColor: Colors.blueGrey,
    accentColor: Colors.deepOrange,
    surfaceColor: Colors.black,
    onSurfaceColor: Colors.white,
    headlineStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
    bodyStyle: TextStyle(fontSize: 16, color: Colors.white70),
    captionStyle: TextStyle(fontSize: 12, color: Colors.white54),
  );

  @override
  final Color primaryColor;
  @override
  final Color accentColor;
  @override
  final Color surfaceColor;
  @override
  final Color onSurfaceColor;
  @override
  final TextStyle headlineStyle;
  @override
  final TextStyle bodyStyle;
  @override
  final TextStyle captionStyle;

  const AppThemeEnum({
    required this.primaryColor,
    required this.accentColor,
    required this.surfaceColor,
    required this.onSurfaceColor,
    required this.headlineStyle,
    required this.bodyStyle,
    required this.captionStyle,
  });
}

extension AppThemeDataExt on ThemeData {
  AppThemeEnum get appTheme {
    return brightness == Brightness.dark ? AppThemeEnum.dark : AppThemeEnum.light;
  }
}

extension BuildContextAppThemeExtension on BuildContext {
  AppThemeEnum get appTheme => Theme.of(this).appTheme;
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Record Theme',
      theme: ThemeData(
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Record Theme'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Primary Color',
              style: theme.headlineStyle.copyWith(color: theme.primaryColor),
            ),
            Text(
              'Accent Color',
              style: theme.bodyStyle.copyWith(color: theme.accentColor),
            ),
            Text(
              'Surface Color',
              style: theme.captionStyle.copyWith(color: theme.surfaceColor),
            ),
            // headlineStyle, bodyStyle, captionStyle
            Text(
              'Headline Style',
              style: theme.headlineStyle,
            ),
            Text(
              'Body Style',
              style: theme.bodyStyle,
            ),
            Text(
              'Caption Style',
              style: theme.captionStyle,
            ),
          ],
        ),
      ),
    );
  }
}