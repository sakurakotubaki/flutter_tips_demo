import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InteractiveViewer Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const InteractiveViewerPage(),
    );
  }
}

class InteractiveViewerPage extends StatefulWidget {
  const InteractiveViewerPage({super.key});

  @override
  State<InteractiveViewerPage> createState() => _InteractiveViewerPageState();
}

class _InteractiveViewerPageState extends State<InteractiveViewerPage>
    with TickerProviderStateMixin {
  final TransformationController _transformationController =
      TransformationController();
  late AnimationController _animationController;
  Animation<Matrix4>? _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }
  
  @override
  void dispose() {
    _transformationController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _resetZoom() {
    _transformationController.value = Matrix4.identity();
  }

  void _handleDoubleTap(TapDownDetails details) {
    final Matrix4 currentTransform = _transformationController.value.clone();
    final double currentScale = currentTransform.getMaxScaleOnAxis();
    
    Matrix4 targetTransform;
    
    if (currentScale < 2.0) {
      // タップした位置を中心にズームイン
      final Offset tapPosition = details.localPosition;
      final double scale = 2.0 / currentScale;
      
      targetTransform = currentTransform.clone()
        ..translate(tapPosition.dx, tapPosition.dy)
        ..scale(scale)
        ..translate(-tapPosition.dx, -tapPosition.dy);
    } else {
      // リセット
      targetTransform = Matrix4.identity();
    }
    
    _animation = Matrix4Tween(
      begin: currentTransform,
      end: targetTransform,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _animationController.removeListener(() {});
    _animationController.addListener(() {
      _transformationController.value = _animation!.value;
    });
    
    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InteractiveViewer Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: _resetZoom,
            icon: const Icon(Icons.zoom_out_map),
            tooltip: 'リセット',
          ),
        ],
      ),
      body: Center(
        child: GestureDetector(
          onDoubleTapDown: _handleDoubleTap,
          child: InteractiveViewer(
            transformationController: _transformationController,
            boundaryMargin: const EdgeInsets.all(20.0),
            minScale: 0.1,
            maxScale: 5.0,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  'images/dashimg.png', // プロジェクトにある画像を使用
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    // 画像が見つからない場合のフォールバック
                    return Container(
                      width: 300,
                      height: 300,
                      color: Colors.grey[300],
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_not_supported,
                              size: 50,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'サンプル画像',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'ピンチしてズーム\nドラッグしてパン',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '操作方法:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                Icon(Icons.zoom_in, size: 20),
                SizedBox(width: 8),
                Text('ピンチイン/アウトでズーム'),
              ],
            ),
            const SizedBox(height: 4),
            const Row(
              children: [
                Icon(Icons.pan_tool, size: 20),
                SizedBox(width: 8),
                Text('ドラッグでパン（移動）'),
              ],
            ),
            const SizedBox(height: 4),
            const Row(
              children: [
                Icon(Icons.touch_app, size: 20),
                SizedBox(width: 8),
                Text('ダブルタップでズームイン'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
