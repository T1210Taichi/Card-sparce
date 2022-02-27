import 'dart:html';

import 'package:flutter/material.dart';

class String_Card extends StatefulWidget {
  //変数定義すると、UIのところから"widget.変数名""で呼ぶことができる

  final String text;
  Offset pos;
  String_Card({required this.text, required this.pos});
  //createState()で"State"(Stateを継承したクラス)を返す
  @override
  _String_Card createState() => _String_Card();
}

class _String_Card extends State<String_Card> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.pos.dx,
      top: widget.pos.dy,
      child: Draggable(
        feedback: Material(
          //移動中のカード
          child: Container(
            width: 200,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                widget.text, //カードのテキスト
                style: TextStyle(color: Colors.black, fontSize: 30.0),
              ),
            ),
          ),
        ),
        child: Container(
          //移動前のカード
          width: 200,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              widget.text, //カードのテキスト
              style: TextStyle(color: Colors.black, fontSize: 30.0),
            ),
          ),
        ),
        childWhenDragging: Container(),
        onDraggableCanceled: (view, offset) {
          setState(() {
            widget.pos = Offset(offset.dx, offset.dy - 56);
          });
        },
      ),
    );
  }
}
