import 'package:flutter/material.dart';

void main() {
  runApp(const IntrinsicHeightDemoApp());
}

class IntrinsicHeightDemoApp extends StatelessWidget {
  const IntrinsicHeightDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intrinsic Height Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const IntrinsicHeightPage(),
    );
  }
}

class IntrinsicHeightPage extends StatelessWidget {
  const IntrinsicHeightPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Column Sizing with IntrinsicHeight'),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min, // Constrain row width to its children
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.red,
                      padding: const EdgeInsets.all(32.0),
                      child: const Center(child: Text('Flex 2')),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.green,
                      padding: const EdgeInsets.all(32.0),
                      child: const Center(child: Text('Flex 1')),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 100,
              color: Colors.blue,
              child: const Center(child: Text('Container with fixed height')),
            ),
            const SizedBox(height: 20),
            const Text(
              'The row above uses IntrinsicHeight to match the taller of its two Expanded children.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}