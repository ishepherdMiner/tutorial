import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation/second_route.dart';

void main() {
  runApp(MaterialApp.router(title: '导航', routerConfig: _router));
}

// 定义路由信息
final _router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const FirstScreen()),
    GoRoute(path: '/second', builder: (context, state) => const SecondRoute()),
  ],
);

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('第一个界面')),
      body: Center(
        child: ElevatedButton(
          child: const Text('使用go_router跳转'),
          onPressed: () => context.go('/second'),
        ),
      ),
    );
  }
}
