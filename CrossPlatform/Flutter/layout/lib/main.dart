import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static const showCard = true; // Set to false to show Stack

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter layout demo')),
        body: Center(child: showCard ? _buildCard() : _buildStack()),
      ),
    );
  }

  Widget _buildStack() {
    return Stack(
      // 0.0时和基准的Widget中心重合
      // Alignment.topLeft = -1，-1 左上角
      // Alignment.bottomRight = 1,1 右下角
      alignment: const Alignment(0.5, 0.5),
      children: [
        // 第一个是基准Widget
        const CircleAvatar(
          backgroundImage: AssetImage('assets/images/pic.jpg'),
          // 半径
          radius: 100,
        ),
        Container(
          decoration: const BoxDecoration(color: Colors.black45),
          child: const Text(
            'Mia B',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCard() {
    return SizedBox(
      height: 210,
      child: Card(
        child: Column(
          children: [
            ListTile(
              title: const Text(
                '1625 Main Street',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: const Text('My City, CA 99984'),
              leading: Icon(Icons.restaurant_menu, color: Colors.blue[500]),
            ),
            const Divider(),
            ListTile(
              title: const Text(
                '(408) 555-1212',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              leading: Icon(Icons.contact_phone, color: Colors.blue[500]),
            ),
            ListTile(
              title: const Text('costa@example.com'),
              leading: Icon(Icons.contact_mail, color: Colors.blue[500]),
            ),
          ],
        ),
      ),
    );
  }
}
