import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout demo',
      home: CustomStatefulPage(),
    );
  }
}

class CustomStatefulPage extends StatefulWidget {
  const CustomStatefulPage({super.key});
  @override
  State<StatefulWidget> createState() => _CustomStatefulePageState();
}

class _CustomStatefulePageState extends State<CustomStatefulPage> {
  double opacity = 0.3;
  String text = "透明度";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(text)),
      body: Center(
        child: Opacity(opacity: opacity, child: Text("透明度:$opacity")),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            opacity = 1.0;
          });
        },
        tooltip: 'Update Text',
        child: const Icon(Icons.update),
      ),
    );
  }
}
