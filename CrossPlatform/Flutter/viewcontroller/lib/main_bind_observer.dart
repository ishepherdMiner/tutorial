import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: Center(child: BindingObserver())),
    );
  }
}

class BindingObserver extends StatefulWidget {
  const BindingObserver({super.key});

  @override
  State<BindingObserver> createState() => _BindingObserverState();
}

class _BindingObserverState extends State<BindingObserver>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    // 添加App事件变化的观察者
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  // 监听app生命周期变化的事件
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.detached:
        _onDetached();
      case AppLifecycleState.resumed:
        _onResumed();
      case AppLifecycleState.inactive:
        _onInactive();
      case AppLifecycleState.hidden:
        _onHidden();
      case AppLifecycleState.paused:
        _onPaused();
    }
  }

  void _onDetached() => print('detached');
  void _onResumed() => print('resumed');
  void _onInactive() => print('inactive');
  void _onHidden() => print('hidden');
  void _onPaused() => print('paused');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("监听事件")),
      body: Center(child: Text("生命周期")),
    );
  }
}
