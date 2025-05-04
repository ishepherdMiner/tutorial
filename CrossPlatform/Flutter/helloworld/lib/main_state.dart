import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  const Counter({super.key});

  // 继承StatefulWidget的类要重写createState()方法,内容返回是_CounterState对象
  // ``=>`` (胖箭头)简写语法用于仅包含一条语句的函数。该语法在将匿名函数作为参数传递时非常有用
  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;
  
  // _ 代表私有方法
  void _increment() {
    // 调用setState()通知Flutter状态变化了,然后重新执行build方法实现实时刷新的效果
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 每次setState都会调用,Flutter已经优化过该方法
    // 一个Row布局,ElevatedButton点击事件关联_increment函数
    // 点击后更新_counter值
    // 调用setState()方法通知Flutter重新调用build
    // Text Widget组件显示新的_counter值
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(onPressed: _increment, child: const Text('Increment')),
        const SizedBox(width: 16),
        Text('Count: $_counter'),
      ],
    );
  }
}

void main() {
  runApp(const MaterialApp(home: Scaffold(body: Center(child: Counter()))));
}