import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // オーバーレイエントリを管理する変数
  OverlayEntry? overlayEntry;

  // オーバーレイを作成して画面に表示する関数
  void createOverlay() {
    // 既存のオーバーレイがあれば先に削除
    removeOverlay();

    // 新しいオーバーレイエントリを作成
    overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Stack(
          children: [
            // 左側にメッセージ画像を配置
            Positioned(
              top: 200, // 画面上から200ピクセルの位置
              left: 40, // 画面左から40ピクセルの位置
              child: Image.asset(
                'images/message.png',
                width: 200, // 画像の幅を200ピクセルに設定
                height: 200, // 画像の高さを200ピクセルに設定
              ),
            ),
            // 右側にDashくんの画像を配置（装飾付き）
            Positioned(
              top: 300, // 画面上から300ピクセルの位置
              right: 20, // 画面右から20ピクセルの位置
              child: Material(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // 背景色を白に設定
                    borderRadius: BorderRadius.circular(8), // 角を8ピクセル丸くする
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26, // 影の色（薄い黒）
                        blurRadius: 8, // 影のぼかし強度
                        offset: Offset(0, 2), // 影の位置（右に0、下に2ピクセル）
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8), // 画像の角も丸くする
                    child: Image.asset(
                      'images/dashimg.png',
                      width: 120, // 画像の幅を120ピクセルに設定
                      height: 120, // 画像の高さを120ピクセルに設定
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    // 作成したオーバーレイを画面の最上位レイヤーに挿入
    Overlay.of(context, debugRequiredFor: widget).insert(overlayEntry!);
  }

  // オーバーレイを削除する関数
  void removeOverlay() {
    overlayEntry?.remove(); // オーバーレイを画面から削除
    overlayEntry?.dispose(); // メモリを解放してリソースをクリーンアップ
    overlayEntry = null; // 変数をnullに初期化
  }

  @override
  void dispose() {
    // ウィジェットが破棄される際にオーバーレイも確実に削除
    removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Overlay Example"),
        actions: [
          // オーバーレイを削除するためのボタン
          IconButton(
            onPressed: removeOverlay,
            icon: Icon(Icons.close),
            tooltip: 'Remove Overlay',
          ),
        ],
      ),
      body: Center(
        child: Column(
          spacing: 20.0,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // タップするとオーバーレイが表示される緑のボックス
            GestureDetector(
              onTap: createOverlay, // タップ時にオーバーレイを作成
              child: SizedBox(
                width: 100, // ボックスの幅
                height: 100, // ボックスの高さ
                child: ColoredBox(
                  color: Colors.green, // 背景色を緑に設定
                  child: Center(
                    child: Text(
                      '押してね',
                      style: TextStyle(
                        color: Colors.white, // 文字色を白に設定
                        fontWeight: FontWeight.bold, // 文字を太字にする
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
