import 'package:flutter/material.dart';

// -----------------------------------------------------
// Record を使用したテーマデータ（学習用シンプル版）
// -----------------------------------------------------

// テーマカラーをRecordで定義
// 🔥 Record型: 名前付きフィールドを持つタプル型
typedef AppColors = ({
  Color primary,
  Color accent,
  Color surface,
  Color onSurface,
});

// テーマテキストスタイルをRecordで定義
// 🔥 Record型: TextStyleのセットを構造化
typedef AppTextTheme = ({
  TextStyle headline,
  TextStyle body,
  TextStyle caption,
});

// メインのテーマデータ - Recordを使用
// 🔥 Record型: 他のRecord型を組み合わせた複合型
typedef AppThemeData = ({
  AppColors colors,
  AppTextTheme textTheme,
});

// -----------------------------------------------------
// Dart 3.0 Extension Types implementation
// -----------------------------------------------------

// 🔥 Extension Type: より軽量でタイプセーフなアプローチ
extension type AppTheme(AppThemeData data) {
  // 便利なゲッター - Record型のフィールドへのアクセス
  AppColors get colors => data.colors;
  AppTextTheme get textTheme => data.textTheme;
  
  // ファクトリーコンストラクタでテーマを作成
  AppTheme.light() : data = AppThemes.light;
  AppTheme.dark() : data = AppThemes.dark;
}

// 🔥 Extension Type: ThemeDataを拡張してAppThemeにアクセス
extension type AppThemeDataExt(ThemeData themeData) {
  AppTheme? get appTheme {
    // 簡易的な実装: テーマモードに基づいて決定
    final brightness = themeData.brightness;
    return brightness == Brightness.dark 
        ? AppTheme.dark() 
        : AppTheme.light();
  }
}

// BuildContext拡張
extension AppThemeBuildContextExtension on BuildContext {
  AppTheme get appTheme => AppThemeDataExt(Theme.of(this)).appTheme!;
}

// -----------------------------------------------------
// 定義済みテーマ
// -----------------------------------------------------

class AppThemes {
  // ライトテーマ
  // 🔥 Record型のインスタンス: constで定義された静的なRecord値
  static const AppThemeData light = (
    // 🔥 Record: colorsフィールドの値
    colors: (
      primary: Color(0xFF6366F1),      // Indigo
      accent: Color(0xFFF59E0B),       // Amber
      surface: Color(0xFFFFFFFF),      // White
      onSurface: Color(0xFF111827),    // Gray-900
    ),
    // 🔥 Record: textThemeフィールドの値
    textTheme: (
      headline: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF111827),
      ),
      body: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Color(0xFF374151),
      ),
      caption: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Color(0xFF9CA3AF),
      ),
    ),
  );

  // ダークテーマ
  // 🔥 Record型のインスタンス: ダークテーマ用のRecord値
  static const AppThemeData dark = (
    // 🔥 Record: colorsフィールドの値
    colors: (
      primary: Color(0xFF818CF8),      // Indigo-400
      accent: Color(0xFFFBBF24),       // Amber-400
      surface: Color(0xFF1F2937),      // Gray-800
      onSurface: Color(0xFFF9FAFB),    // Gray-50
    ),
    // 🔥 Record: textThemeフィールドの値
    textTheme: (
      headline: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFFF9FAFB),
      ),
      body: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Color(0xFFD1D5DB),
      ),
      caption: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Color(0xFF9CA3AF),
      ),
    ),
  );
}

// -----------------------------------------------------
// 使用例のウィジェット
// -----------------------------------------------------

class ThemeDemo extends StatelessWidget {
  const ThemeDemo({super.key});

  @override
  Widget build(BuildContext context) {
    // Record型のテーマデータに簡潔にアクセス
    // 🔥 Record型のフィールドアクセス: .colors, .textTheme
    final colors = context.appTheme.colors;
    final textTheme = context.appTheme.textTheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Record Theme Demo', style: textTheme.headline),
              const SizedBox(height: 20),
              
              Text('Primary Color Sample', style: textTheme.body),
              Container(
                width: 100,
                height: 50,
                color: colors.primary,
                margin: const EdgeInsets.symmetric(vertical: 8),
              ),
              
              Text('Accent Color Sample', style: textTheme.body),
              Container(
                width: 100,
                height: 50,
                color: colors.accent,
                margin: const EdgeInsets.symmetric(vertical: 8),
              ),
              
              const SizedBox(height: 20),
              Text('Body text sample', style: textTheme.body),
              Text('Caption text sample', style: textTheme.caption),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------
// メインアプリ
// -----------------------------------------------------

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

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
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: MainScreen(
        isDarkMode: isDarkMode,
        onThemeToggle: () {
          setState(() {
            isDarkMode = !isDarkMode;
          });
        },
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onThemeToggle;

  const MainScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Record Theme'),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: onThemeToggle,
          ),
        ],
      ),
      body: const ThemeDemo(),
    );
  }
}
