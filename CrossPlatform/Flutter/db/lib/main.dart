import 'package:db/company_provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void test() async {
    /// 添加2条测试数据
    CompanyProvider cp = CompanyProvider();
    await cp.open();
    List<Map> maps = [
      {"name": "Google"},
      {"name": "Apple"},
    ];

    /// 新增数据
    int firstId = 0;
    for (int i = 0; i < maps.length; ++i) {
      Company c = Company.fromMap(maps[i]);
      cp.insert(c);
    }

    /// 查找数据
    List<Company> companys = await cp.find();
    if (companys.isNotEmpty) {
      firstId = companys.first.id!;
    }

    if (firstId > 0) {
      Company firstCompany = await cp.findById(firstId);
      print(firstCompany.toMap());

      /// 更新数据
      Company chgCompany = Company();
      chgCompany.id = firstId;
      chgCompany.name = DateTime.now().microsecondsSinceEpoch.toString();
      cp.update(chgCompany);

      firstCompany = await cp.findById(firstId);
      print(firstCompany.toMap());

      /// 删除数据
      cp.delete(firstId);

      /// 数据库迁移
      firstCompany.description = "版本2新增的字段";
      print(firstCompany.toMap());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("数据库示例"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text('1', style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: test,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
