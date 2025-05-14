import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Sample App', home: SampleAppPage());
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  List<Map<String, Object?>> data = [];

  @override
  void initState() {
    super.initState();

    /// 主1. 加载数据
    loadData();
  }

  bool get showLoadingDialog => data.isEmpty;

  Future<void> loadData() async {
    /// Opens a long-lived port for receiving messages.
    /// 打开端口用于接收数据
    final ReceivePort receivePort = ReceivePort();

    /// 主2.Isolate开启子线程
    /// The [entryPoint] function must be able to be called with a single
    /// argument, that is, a function which accepts at least one positional
    /// parameter and has at most one required positional parameter.
    ///
    /// The entry-point function is invoked in the new isolate with [message]
    /// as the only argument.
    /// 第一个参数:至少包含一个参数的函数指针,这里关联的是dataLoader,参数是SendPort
    ///
    /// [message] must be sendable between isolates. Objects that cannot be sent
    /// include open files and sockets (see [SendPort.send] for details). Usually
    /// the initial [message] contains a [SendPort] so that the spawner and
    /// spawnee can communicate with each other.
    /// 第二个参数: 不同Isolate之间传递的数据,通常初始化时传的message包含一个SendPort
    ///
    /// receivePort.sendPort
    /// [SendPort]s are created from [ReceivePort]s.
    /// Any message sent through a [SendPort] is delivered to its corresponding [ReceivePort].
    /// There might be many [SendPort]s for the same [ReceivePort].
    /// 通过SendPort发送的消息会传送给关联的ReceivePort
    await Isolate.spawn(dataLoader, receivePort.sendPort);

    /// 主3. first是一个Future,它会在接收到第一个消息时完成
    /// 一旦收到第一个消息,它就会关闭ReceivePort,并且不再监听其它消息
    /// 适用于只接收单个消息的情况
    final SendPort sendPort = await receivePort.first as SendPort;
    try {
      /// 主4. 使用await调用sendReceive
      final List<Map<String, dynamic>> msg = await sendReceive(
        sendPort,
        'https://jsonplaceholder.typicode.com/posts',
      );

      /// 主5.设置数据,通知Flutter刷新UI
      setState(() {
        data = msg;
      });
    } catch (e) {
      print('Error in loadData:$e');
    }
  }

  // 子1. 执行子线程上的函数
  static Future<void> dataLoader(SendPort sendPort) async {
    // 子2.打开端口接收数据
    final ReceivePort port = ReceivePort();

    /// 子3. 发送自己的接收端口
    sendPort.send(port.sendPort);

    /// 子4:等待消息
    await for (final dynamic msg in port) {
      /// 子5: 接收到url + 主线程的接收端口
      final String url = msg[0] as String;
      final SendPort replyTo = msg[1] as SendPort;

      /// 子6: 发起网络请求
      final Uri dataURL = Uri.parse(url);
      final http.Response response = await http.get(dataURL);

      /// 下面这种写法在sendReceive会报
      /// Unhandled
      /// Exception: type 'Future<dynamic>' is not a subtype of type
      /// 'Future<List<Map<String, dynamic>>>'
      ///
      /// replyTo.send(jsonDecode(response.body) as List<Map<String, dynamic>>);
      /// 因为Dart在运行时无法检查Future<T>中的T,直接转换Future的泛型参数会失败
      /// 强制类型转换
      final data = jsonDecode(response.body) as List;
      final typedata = data.cast<Map<String, dynamic>>();

      /// 主7: 将网络请求的结果发送到主线程
      replyTo.send(typedata);
    }
  }

  Future<dynamic> sendReceive(SendPort port, String msg) {
    // 主5.创建接收数据的端口
    final ReceivePort response = ReceivePort();
    // Sends an asynchronous [message] through this send port, to its corresponding [ReceivePort].
    // 主6. 主线程异步发送url + 通知其它线程接收端口
    port.send(<dynamic>[msg, response.sendPort]);
    return response.first;
  }

  Widget getBody() {
    bool showLoadingDialog = data.isEmpty;

    if (showLoadingDialog) {
      return getProgressDialog();
    } else {
      return getListView();
    }
  }

  Widget getProgressDialog() {
    return const Center(child: CircularProgressIndicator());
  }

  ListView getListView() {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, position) {
        return getRow(position);
      },
    );
  }

  Widget getRow(int i) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text("Row ${data[i]["title"]}"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App')),
      body: getBody(),
    );
  }
}
