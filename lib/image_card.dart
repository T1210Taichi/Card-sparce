//import 'dart:html';
import 'dart:io';
import 'package:card_space/view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'card.dart';

class Image_Card extends StatefulWidget {
  //変数定義すると、UIのところから"widget.変数名""で呼ぶことができる
  Offset pos;
  var image;
  Image_Card({this.image, required this.pos});
  //createState()で"State"(Stateを継承したクラス)を返す
  @override
  _Image_Card createState() => _Image_Card();
}

class _Image_Card extends State<Image_Card> {
  final picker = ImagePicker();

  //ギャラリーから画像を取得
  Future getImageFromGallery() async {
    final fromPicker = await ImagePickerWeb.getImageAsWidget();
    if (fromPicker != null) {
      setState(() {
        widget.image = fromPicker;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //カードリスト
    var string_cardModel = Provider.of<CardModel>(context);
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
              color: Colors.white, //背景色
              border: Border.all(color: Colors.blue), //ふち
              borderRadius: BorderRadius.circular(10), //角を丸める
            ),
            child: widget.image,
          ),
        ),
        child: GestureDetector(
          onDoubleTap: () async {
            //カード削除処理
            //タップ処理
            var value = await showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Text("Delete Text Card"),
                  content: Text("Can I delete this Text Card?"),
                  actions: <Widget>[
                    // ボタン領域
                    FlatButton(
                      child: Text("Cancel"),
                      onPressed: () => Navigator.of(context).pop(0),
                    ),
                    FlatButton(
                      child: Text("OK"),
                      onPressed: () => Navigator.of(context).pop(1),
                    ),
                  ],
                );
              },
            );
            if ('$value' == "1") {
              //カードを削除
              string_cardModel.deleteCard(widget);
              //変更を通知
            }
          },
          child: Container(
            //移動前のカード
            width: 200,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(child: widget.image),
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
