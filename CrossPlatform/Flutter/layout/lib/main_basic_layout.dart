import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter布局学习",
      home: Scaffold(
        appBar: AppBar(title: Text("Flutter 布局学习")),
        body: Column(
          spacing: 6,
          children: [
            Column(
              spacing: 10,
              children: [
                Text("回乡偶书", style: TextStyle(fontSize: 24)),
                Text("唐.贺知章"),
                Text(
                  "少小离家老大回，乡音无改鬓毛衰。",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
                Text(
                  "儿童相见不相识，笑问客从何处来。",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ],
            ),
            Column(
              spacing: 6,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
                  child: Text("译文:", textAlign: TextAlign.left),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
                  child: Text(
                    "年少时离乡老年才归家，我的乡音虽未改变，但鬓角的毛发却已经疏落。家乡的儿童们看见我，没有一个认识我。他们笑着询问我：你是从哪里来的呀？",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 8, 8, 4),
                  child: Text("创作背景:"),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
                  child: SizedBox(
                    width: 360,
                    child: Text(
                      "贺知章在公元744年（天宝三载），辞去朝廷官职，告老返回故乡越州永兴（今浙江萧山），时已八十六岁，这时，距他中年离乡已经很久了，此诗便作于此时。",
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                  child: Image.asset(
                    'assets/images/layout_01@3x.png',
                    width: 160,
                    alignment: Alignment.center,
                  ),
                ),
                Expanded(
                  child: Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 16),
                        // padding: EdgeInsets.fromLTRB(0, 0, 16,0),
                        padding: EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(border: Border.all()),
                        child: Text(
                          "问题:请问这首诗表达了作者的什么样的感情?",
                          maxLines: 4,
                          softWrap: true,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 30),
                        child: Text(
                          "如果现在是北京时间早上八点整，我飞往巴黎，到达后巴黎当地时间为早上八点整，请问：我的生命相对延长了吗？",
                        ),
                      ),
                      Text("答：你把表的电池扣了你是不是就不死了？"),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /**
   *  Center(
          child: Text('Hello World!'),
        ),
   */
}
