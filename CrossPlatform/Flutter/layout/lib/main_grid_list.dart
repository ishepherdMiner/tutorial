import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static const showGrid = false; // Set to false to show ListView

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter layout demo')),
        body: Center(child: showGrid ? _buildGrid() : _buildList()),
      ),
    );
  }

  Widget _buildGrid() => GridView.extent(
    // 单元格最大宽度
    maxCrossAxisExtent: 150,
    // 上下左右内边距
    padding: const EdgeInsets.all(4),
    // 上下单元格间距
    mainAxisSpacing: 8,
    // 左右单元格间距
    crossAxisSpacing: 10,
    children: _buildGridTileList(30),
  );

  List<Widget> _buildGridTileList(int count) =>
      List.generate(count, (i) => Image.asset('assets/images/pic$i.jpg'));

  Widget _buildList() {
    return ListView(
      children: [
        _tile('CineArts at the Empire', '85 W Portal Ave', Icons.theaters),
        _tile('The Castro Theater', '429 Castro St', Icons.theaters),
        _tile('Alamo Drafthouse Cinema', '2550 Mission St', Icons.theaters),
        _tile('Roxie Theater', '3117 16th St', Icons.theaters),
        _tile(
          'United Artists Stonestown Twin',
          '501 Buckingham Way',
          Icons.theaters,
        ),
        _tile('AMC Metreon 16', '135 4th St #3000', Icons.theaters),
        // 分割线
        const Divider(),
        _tile('K\'s Kitchen', '757 Monterey Blvd', Icons.restaurant),
        _tile('Emmy\'s Restaurant', '1923 Ocean Ave', Icons.restaurant),
        _tile('Chaiya Thai Restaurant', '272 Claremont Blvd', Icons.restaurant),
        _tile('La Ciccia', '291 30th St', Icons.restaurant),
      ],
    );
  }
  
  ListTile _tile(String title, String subtitle, IconData icon) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
      ),
      subtitle: Text(subtitle),
      leading: Icon(icon, color: Colors.blue[500]),
    );
  }
}
