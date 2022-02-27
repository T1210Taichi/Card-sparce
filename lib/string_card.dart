import 'dart:html';

import 'package:flutter/material.dart';

class String_Card extends StatefulWidget {
  //変数定義すると、UIのところから"widget.変数名""で呼ぶことができる

  final String text;

  String_Card({required this.text});
  //createState()で"State"(Stateを継承したクラス)を返す
  @override
  _String_Card createState() => _String_Card();
}

class _String_Card extends State<String_Card> {
  Offset? _pos = Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: this._pos?.dx,
      top: this._pos?.dy,
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
            this._pos = Offset(offset.dx, offset.dy - 56);
          });
        },
      ),
    );
  }
}
