import "package:flutter/material.dart";

void main() {
  runApp(MaterialApp(home: CustomWidget()));
}

class CustomWidget extends StatelessWidget {
  const CustomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Custom Widget")),
      body: Center(child: CustomButton("自定义按钮")),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () {}, child: Text(label));
  }
}
