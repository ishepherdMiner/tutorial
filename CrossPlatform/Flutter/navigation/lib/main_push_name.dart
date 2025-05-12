import 'package:flutter/material.dart';
import 'package:navigation/second_route.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "导航示例",
      home: Builder(
        builder:
            (context) => Scaffold(
              appBar: AppBar(title: Text("导航")),
              body: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/second');
                  },
                  child: const Text("到第二个页面"),
                ),
              ),
            ),
      ),
      routes: {'/second': (context) => const SecondRoute()},
    );
  }
}
