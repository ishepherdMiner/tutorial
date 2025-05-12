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

class _BindingObserverState extends State<BindingObserver> {
  late final AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();
    // 添加App事件变化的观察者
    _listener = AppLifecycleListener(onStateChange: _onStateChanged);
  }

  void _onStateChanged(AppLifecycleState state) {
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
  void dispose() {
    // Do not forget to dispose the listener
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("监听事件")),
      body: Center(child: Text("生命周期")),
    );
  }
}
