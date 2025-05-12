import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: DemoApp()));

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(body: Signature());
}

class Signature extends StatefulWidget {
  const Signature({super.key});

  @override
  State<Signature> createState() => SignatureState();
}

class SignatureState extends State<Signature> {
  List<Offset?> _points = <Offset?>[];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 绘制时移动的回调
      onPanUpdate: (details) {
        setState(() {
          // 当前Widget关联的RenderObject
          RenderBox? referenceBox = context.findRenderObject() as RenderBox;
          // 坐标转换: 全局坐标转换为局部坐标
          // globalPosition表示当前手势触点在全局坐标系位置与对应组件顶点坐标的偏移量
          // localPosition则就表示当前手势触点在对应组件坐标系位置与对应组件顶点坐标的偏移量
          Offset localPosition = referenceBox.globalToLocal(
            details.globalPosition,
          );
          _points = List.from(_points)..add(localPosition);
        });
      },
      // 绘制结束时调用
      onPanEnd: (details) => _points.add(null),
      child: CustomPaint(
        // 具体的绘制操作调用Canvas
        painter: SignaturePainter(_points),
        // 不限制长度
        size: Size.infinite,
      ),
    );
  }
}

class SignaturePainter extends CustomPainter {
  SignaturePainter(this.points);

  final List<Offset?> points;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint =
        //「..」意思是 「级联 操作符」，为了方便配置而使用。
        //「..」和「.」不同的是 调用「..」后返回的相当于是 this
        Paint()
          ..color = const Color.fromARGB(255, 29, 25, 25)
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 5;
    for (int i = 0; i < points.length - 1; i++) {
      // 起点与终点都不为null,说明是一个线段,然后执行绘制
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(SignaturePainter oldDelegate) =>
      oldDelegate.points != points;
}
