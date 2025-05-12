import 'package:flutter/material.dart';

void main() {
  // 1. 创建MainApp Widget
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Fade Demo',
      // 2. 创建MyFadeTest
      home: MyFadeTest(title: 'Fade Demo'),
    );
  }
}

class MyFadeTest extends StatefulWidget {
  const MyFadeTest({super.key, required this.title});

  final String title;

  @override
  // The framework can call this method multiple times over the lifetime of a [StatefulWidget].
  // For example, if the widget is inserted into the tree in multiple locations,
  // the framework will create a separate [State] object for each location.
  // 添加到tree中的每个MyFadeTest Widget都会创建对应的State<MyFadeTest>对象
  // 3.创建_MyFadeTest
  State<MyFadeTest> createState() => _MyFadeTest();
}

class _MyFadeTest extends State<MyFadeTest>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late CurvedAnimation curve;

  @override
  // Called when this object is inserted into the tree.
  // 添加到tree中时调用
  // 4. 调用initState,指定AnimationController
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      // TickerProvider(抽象类)，用于接收动画变化过程中的通知，类似于接口回调
      vsync: this,
    );
    // 指定生成0.0到1.0的规则
    curve = CurvedAnimation(parent: controller, curve: Curves.easeIn);
  }

  @override
  // Called when this object is removed from the tree permanently.
  void dispose() {
    // 8.当对象对tree中移除时,回收AnimationController的资源
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: FadeTransition(
          // 5. 应用透明效果,opacity的变化规则指定为上面创建的curve
          opacity: curve,
          // 6. 动画包装的Widget
          child: const FlutterLogo(size: 100),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Starts running this animation forwards (towards the end).
          // 7. 正向播放动画
          controller.forward();
        },
        tooltip: 'Fade',
        child: const Icon(Icons.brush),
      ),
    );
  }
}
