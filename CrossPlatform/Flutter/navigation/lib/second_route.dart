import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("第二个路由页面")),
      body: Center(
        child: CupertinoButton(
          onPressed: () {
            // Navigator.pop(context);
            context.go('/');
          },
          child: const Text("返回"),
        ),
      ),
    );
  }
}
