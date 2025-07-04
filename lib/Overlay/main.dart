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
   
  OverlayEntry? overlayEntry;

  void createOverlay() {
    // Remove existing overlay first
    removeOverlay();

    overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Stack(
          children: [
            // Text Widget in left
            Positioned(
              top: 200,
              left: 40,
              child: Image.asset(
                'images/message.png',
                width: 200,
                height: 200,
              ),
            ),
            // Image.asset Widget right
            Positioned(
              top: 300,
              right: 20,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'images/dashimg.png',
                      width: 120,
                      height: 120,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context, debugRequiredFor: widget).insert(overlayEntry!);
  }

  void removeOverlay() {
    overlayEntry?.remove();
    overlayEntry?.dispose();
    overlayEntry = null;
  }

  @override
  void dispose() {
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
            GestureDetector(
              onTap: createOverlay,
              child: SizedBox(
                width: 100,
                height: 100,
                child: ColoredBox(
                  color: Colors.green,
                  child: Center(
                    child: Text(
                      '押してね',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
