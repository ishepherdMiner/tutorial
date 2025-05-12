import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(CupertinoApp(home: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        children: [
          Divider(height: 10,),
          CupertinoButton(onPressed: () {}, child:Text('Button')),
          CupertinoButton(
            child: Text("ActionSheet"),
            onPressed: () {
              _showActionSheet(context);
            },
          ),
          // 加载提示
          CupertinoActivityIndicator(animating: true),
          // CupertinoAdaptiveTextSelectionToolbar(anchors: anchors,children: [Text("选中的菜单功能")])
          // Center(child: Text(),)
        ],
      ),
    );
  }

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder:
          (BuildContext context) => CupertinoActionSheet(
            title: const Text('Title'),
            message: const Text('Message'),
            actions: <CupertinoActionSheetAction>[
              CupertinoActionSheetAction(
                // 默认操作,字体加粗
                isDefaultAction: true,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Default Action'),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Action'),
              ),
              CupertinoActionSheetAction(
                /// 删除或离开之类的操作，字体颜色
                isDestructiveAction: true,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Destructive Action'),
              ),
            ],
          ),
    );
  }
}
