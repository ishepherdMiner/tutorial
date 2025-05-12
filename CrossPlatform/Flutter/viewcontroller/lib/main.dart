import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(title: "TextFile", home: MyForm()));
}

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  String? _errorText;
  // 1. 创建text控制器来获取textFiled的值
  final myController = TextEditingController();

  @override
  void dispose() {
    // 4. 清理生成的myController
    myController.dispose();
    super.dispose();
  }

  bool isEmail(String em) {
    String emailRegexp =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|'
        r'(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|'
        r'(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(emailRegexp);

    return regExp.hasMatch(em);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Retrieve Text Input')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            // 2.TextField绑定控制器
            child: TextField(
              controller: myController,
              onSubmitted:
                  (text) => {
                    setState(() {
                      if (!isEmail(text)) {
                        _errorText = '错误: 邮箱地址不合法';
                      } else {
                        _errorText = null;
                      }
                    }),
                  },
              decoration: InputDecoration(
                hintText: "邮箱",
                errorText: _errorText,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        /// 3. 当用户点击按钮时,弹出dialog,显示textField的值
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(content: Text(myController.text));
            },
          );
        },
        tooltip: 'Show me the value!',
        child: const Icon(Icons.text_fields),
      ),
    );
  }
}
