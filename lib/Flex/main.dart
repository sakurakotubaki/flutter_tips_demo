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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Flex Example"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // flex: 0 の例（子ウィジェットが自分のサイズを決定）
            Text(
              'flex: 0 - 子ウィジェットが自分のサイズを決定',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Column(
                children: [
                  Flexible(
                    flex: 0, // 子ウィジェットが自分のサイズを決定
                    child: Container(
                      height: 60,
                      color: Colors.blueAccent,
                      child: Center(
                        child: Text(
                          'flex: 0 (height: 60)',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 0, // 子ウィジェットが自分のサイズを決定
                    child: Container(
                      height: 40,
                      color: Colors.redAccent,
                      child: Center(
                        child: Text(
                          'flex: 0 (height: 40)',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            // flex: 1, 2 の例（利用可能なスペースを比率で分割）
            Text(
              'flex: 1, 2 - 利用可能なスペースを比率で分割',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Column(
                children: [
                  Flexible(
                    flex: 1, // 利用可能なスペースの1/3を取得
                    child: Container(
                      color: Colors.greenAccent,
                      child: Center(
                        child: Text(
                          'flex: 1 (1/3のスペース)',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 4, // 利用可能なスペースの2/3を取得
                    child: Container(
                      color: Colors.orangeAccent,
                      child: Center(
                        child: Text(
                          'flex: 4 (2/3のスペース)',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            // Expandedとの比較
            Text(
              'Expanded - 利用可能なスペースを全て使用',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 1, // Expandedは必ず利用可能なスペースを使用
                    child: Container(
                      color: Colors.purpleAccent,
                      child: Center(
                        child: Text(
                          'Expanded (flex: 1)',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: Colors.tealAccent,
                      child: Center(
                        child: Text(
                          'Expanded (flex: 1)',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
