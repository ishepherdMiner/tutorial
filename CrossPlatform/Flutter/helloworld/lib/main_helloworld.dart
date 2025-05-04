import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // Hello world
  // @override
  // Widget build(BuildContext context) {
  //   return const MaterialApp(
  //     home: Scaffold(
  //       body: Center(
  //         child: Text('Hello 123123',overflow: TextOverflow.ellipsis,),
  //       ),
  //     ),
  //   );
  // }

  // Text: overflow,softWrap,maxLines
  // }
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     home:Scaffold(
  //       body:Center(
  //         child:Container(
  //             width: 100,
  //             height:30,
  //             decoration: BoxDecoration(border: Border.all()),
  //             child: Text(softWrap: true,overflow:TextOverflow.visible, 'Hello world, how are you?'))
  //     ))
  //   );
  // }
 
  // Text rich
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     home: Scaffold(
  //       body: Center(
  //         child: const Text.rich(
  //           TextSpan(
  //             text: 'Hello', // default text style
  //             children: <TextSpan>[
  //               TextSpan(
  //                 text: ' beautiful ',
  //                 style: TextStyle(fontStyle: FontStyle.italic),
  //               ),
  //               TextSpan(
  //                 text: 'world',
  //                 style: TextStyle(fontWeight: FontWeight.bold),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  
  /// Text tap
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: GestureDetector(
            child: Text('Hello world',overflow: TextOverflow.ellipsis,),
            onTap: ()=> {
              print("123")
            },)
        ),
      ),
    );
  }
}
