import 'package:flutter/material.dart';

// 🔥 Record型でテーマデータを定義 - @overrideが不要
typedef AppThemeData = ({
  Color primaryColor,
  Color accentColor,
  Color surfaceColor,
  Color onSurfaceColor,
  TextStyle headlineStyle,
  TextStyle bodyStyle,
  TextStyle captionStyle,
});

// 🔥 定義済みテーマ - Record型のインスタンス
class AppThemes {
  static const AppThemeData light = (
    primaryColor: Colors.blue,
    accentColor: Colors.amber,
    surfaceColor: Colors.white,
    onSurfaceColor: Colors.black,
    headlineStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    bodyStyle: TextStyle(fontSize: 16),
    captionStyle: TextStyle(fontSize: 12, color: Colors.grey),
  );

  static const AppThemeData dark = (
    primaryColor: Colors.blueGrey,
    accentColor: Colors.deepOrange,
    surfaceColor: Colors.black,
    onSurfaceColor: Colors.white,
    headlineStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
    bodyStyle: TextStyle(fontSize: 16, color: Colors.white70),
    captionStyle: TextStyle(fontSize: 12, color: Colors.white54),
  );
}

extension AppThemeDataExt on ThemeData {
  AppThemeData get appTheme {
    return brightness == Brightness.dark ? AppThemes.dark : AppThemes.light;
  }
}

extension BuildContextAppThemeExtension on BuildContext {
  AppThemeData get appTheme => Theme.of(this).appTheme;
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
    // 🔥 Record型のフィールドに直接アクセス
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