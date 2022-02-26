import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String appName = "Card Space";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: appName),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Offset pos = Offset(0, 0);
  Offset pos1 = Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Colors.grey[100], //背景色
      body: Stack(
        //Widgetを自由に配置
        children: <Widget>[
          Positioned(
            //位置を指定
            left: pos.dx,
            top: pos.dy,
            child: Draggable(
              //ドラッグで移動可能に
              feedback: Container(
                //移動中のWidget
                width: 200,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "test",
                    style: TextStyle(color: Colors.black, fontSize: 25.0),
                  ),
                ),
              ),
              child: Container(
                //移動する前のWidget
                width: 200,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "test",
                    style: TextStyle(color: Colors.black, fontSize: 25.0),
                  ),
                ),
              ),
              childWhenDragging: Container(), //移動中の移動する前のWidget
              onDraggableCanceled: (view, offset) {
                //ドラッグを離した処理
                setState(() {
                  //Widgetの位置を更新
                  pos = Offset(offset.dx, offset.dy - 56);
                });
              },
            ),
          ),
          Positioned(
            //位置を指定
            left: pos1.dx,
            top: pos1.dy,
            child: Draggable(
              //ドラッグで移動可能に
              feedback: Container(
                //移動中のWidget
                width: 200,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "test",
                    style: TextStyle(color: Colors.black, fontSize: 25.0),
                  ),
                ),
              ),
              child: Container(
                //移動する前のWidget
                width: 200,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "test2",
                    style: TextStyle(color: Colors.black, fontSize: 25.0),
                  ),
                ),
              ),
              childWhenDragging: Container(), //移動中の移動する前のWidget
              onDraggableCanceled: (view, offset) {
                //ドラッグを離した処理
                setState(() {
                  //Widgetの位置を更新
                  pos1 = Offset(offset.dx, offset.dy - 56);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
