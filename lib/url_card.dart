//import 'dart:html';
import 'package:card_space/view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'card.dart';
//OGPを抽出
import 'package:metadata_fetch/metadata_fetch.dart';
import 'package:http/http.dart' as http;

class URL_Card extends StatefulWidget {
  //変数定義すると、UIのところから"widget.変数名""で呼ぶことができる

  String url;
  Offset pos;
  URL_Card({required this.url, required this.pos});

  //createState()で"State"(Stateを継承したクラス)を返す
  @override
  _URL_Card createState() => _URL_Card();
}

class _URL_Card extends State<URL_Card> {
  //コンストラクタ
  /*
  _URL_Card() {
    //OGPを取得
    //fetchOgpFrom();
    //print("fetchOgpFrom complete");
  }
  */

  //OGPを取得する関数
  Future fetchOgpFrom(Metadata ogp) async {
    //Uri.parse(String)でStringをUri(URL)型に変更
    final myURL = Uri.parse(widget.url);

    var response = await http.get(myURL);
    var document = MetadataFetch.responseToDocument(response);
    setState(() {
      ogp = MetadataParser.openGraph(document);
    });
    return ogp;
    //print(data);
  }

  @override
  Widget build(BuildContext context) {
    //カードリスト
    var cardModel = Provider.of<CardModel>(context);
    return Positioned(
      left: widget.pos.dx,
      top: widget.pos.dy,
      child: Draggable(
        child: GestureDetector(
          //リンクに飛ぶ
          onTap: () {},
          //カードを削除
          onDoubleTap: () async {
            //カード削除処理
            //タップ処理
            var value = await showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Text("Delete URL Card"),
                  content: Text("Can I delete this URL Card?"),
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
              cardModel.deleteCard(widget);
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
            child: Center(
              child: Text(widget.url),
            ),
          ),
        ),
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
            child: Center(
              child: Text(widget.url),
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
