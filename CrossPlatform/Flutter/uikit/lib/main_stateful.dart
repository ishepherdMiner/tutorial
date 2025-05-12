import 'package:flutter/material.dart';

void main() {
  // 1. 创建MainApp Widget
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 2.调用
    return MaterialApp(title: 'Sample App', home: CustomStatefulPage());
  }
}

class _CustomStatefulePageState extends State<CustomStatefulPage> {
  String text = 'I Like Flutter';
  // 5.点击按钮触发_updateText
  void _updateText() {
    // 6.通知Flutter更新
    setState(() {
      text = "Flutter is Awesome!";
    });
  }
  @override
  // 7.调用build方法,刷新页面
  // 4.调用build方法,按钮点击方法绑定_updateText方法
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App')),
      body: Center(
        child: Text(text)
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _updateText,
        tooltip: 'Update Text',
        child: const Icon(Icons.update),
      ),
    );
  }
}

class CustomStatefulPage extends StatefulWidget {
  const CustomStatefulPage({super.key});
  @override
  // 3.创建_CustomStatefulePageState对象
  State<StatefulWidget> createState() => _CustomStatefulePageState();
}
