import 'package:flutter/material.dart';

void main() {
  runApp(const ThemePage());
}

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  /// 主题模式
  Brightness brightness = Brightness.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Theme 主题修改",
      theme: ThemeData(brightness: brightness, primarySwatch: Colors.blue),

      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Theme 123",
            style: TextStyle(
              fontFamily: 'google_kavivanar',
              decoration: TextDecoration.lineThrough,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w400,
              wordSpacing: 20,
              letterSpacing: 10,
              height: 30,
            ),
          ),
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  brightness = Brightness.light;
                });
              },
              child: Text("切换到日间主题"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  brightness = Brightness.dark;
                });
              },
              child: Text("切换到夜间主题"),
            ),
            Center(
              child: Text(
                "123456789ABCDEF",
                style: TextStyle(fontFamily: 'google_kavivanar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
