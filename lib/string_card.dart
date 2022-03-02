//import 'dart:html';
import 'package:card_space/view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class String_CardModel extends ChangeNotifier {
  List<Widget> cardLists = <Widget>[];

  //文章カード作成関数
  void createStringCard(BuildContext context) async {
    //テキストコントローラ
    TextEditingController myController = TextEditingController();
    //カードリスト
    //var cardLists = Provider.of<String_CardModel>(context);
    print("createStringCard");
    BuildContext innerContext;
    String value = await showDialog(
      context: context,
      builder: (BuildContext context) {
        innerContext = context;
        return AlertDialog(
          title: Text("Create Card"),
          content: TextFormField(
            autofocus: true, //画面を開くとキーボードが開かれる
            enabled: true, //入力可能か
            maxLength: 12, //最大数
            controller: myController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: "Enter Text",
            ),
            onEditingComplete: () =>
                Navigator.pop(context, myController.text), //Enterを押した処理
          ),
          actions: <Widget>[
            // ボタン領域
            FlatButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            FlatButton(
              child: Text("OK"),
              onPressed: () =>
                  Navigator.pop(context, myController.text), //入力文を送る
            ),
          ],
        );
      },
    );

    //var value = "test";
    Widget card = String_Card(text: value, pos: Offset(0, 0)); //creat new card
    cardLists.add(card);
    notifyListeners();
    //rcardLists.add(card); //add new card to cardlists
    //print(cardLists); //debug
  }

  void add(Widget w) {
    cardLists.add(w); //カードを追加
    notifyListeners(); //通知
  } //カードを追加

  //配列を初期化
  void clear() {
    cardLists.clear();
    notifyListeners(); //通知
  }

  //カード表示関数
  List<Widget> getCards() {
    //カードリスト
    //var cardLists = Provider.of<String_CardModel>(context);
    //var cards = cardLists.getCard();
    final List<Widget> _cardListWidgets = <Widget>[];
    //setState(() {
    cardLists.forEach((element) {
      _cardListWidgets.add(element);
    });
    //});
    return _cardListWidgets;
  }

  //削除の処理
  void deleteCard(Widget w) {
    cardLists.remove(w); //カードの削除
    notifyListeners(); //通知
    print("delete");
  }
}

class String_Card extends StatefulWidget {
  //変数定義すると、UIのところから"widget.変数名""で呼ぶことができる

  String text;
  Offset pos;
  String_Card({required this.text, required this.pos});
  //createState()で"State"(Stateを継承したクラス)を返す
  @override
  _String_Card createState() => _String_Card();
}

class _String_Card extends State<String_Card> {
  @override
  Widget build(BuildContext context) {
    //カードリスト
    var string_cardModel = Provider.of<String_CardModel>(context);
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
            child: Center(
              child: Text(
                widget.text, //カードのテキスト
                style: TextStyle(color: Colors.black, fontSize: 30.0),
              ),
            ),
          ),
        ),
        child: GestureDetector(
          onTap: () async {
            //テキストコントローラ
            TextEditingController myController =
                TextEditingController(text: widget.text);
            //タップ処理
            String value = await showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Text("Change Text Card"),
                  content: TextFormField(
                    //initialValue: widget.text, //初期値
                    autofocus: true, //画面を開くとキーボードが開かれる
                    enabled: true, //入力可能か
                    maxLength: 12, //最大数
                    controller: myController, //コントローラ
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "Enter Text",
                    ),
                    onEditingComplete: () =>
                        Navigator.pop(context, myController.text), //Enterを押した処理
                  ),
                  actions: <Widget>[
                    // ボタン領域
                    FlatButton(
                      child: Text("Cancel"),
                      onPressed: () => Navigator.pop(context),
                    ),
                    FlatButton(
                      child: Text("OK"),
                      onPressed: () =>
                          Navigator.pop(context, myController.text),
                    ),
                  ],
                );
              },
            );

            //print(value);//debug

            setState(() {
              //カードの文字を更新
              widget.text = value;
            });
          },
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
            child: Center(
              child: Text(
                widget.text, //カードのテキスト
                style: TextStyle(color: Colors.black, fontSize: 30.0),
              ),
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

/*
class String_Card with ChangeNotifier {
  String text;
  Offset pos;
  String_Card(this.text, this.pos);
  //String_Card();

  @override
  Widget build(BuildContext context) {
    final mystringCardModel = Provider.of<String_CardModel>(context);
    return Positioned(
      left: this.pos.dx,
      top: this.pos.dy,
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
            child: Center(
              child: Text(
                this.text, //カードのテキスト
                style: TextStyle(color: Colors.black, fontSize: 30.0),
              ),
            ),
          ),
        ),
        child: GestureDetector(
          onTap: () async {
            //テキストコントローラ
            TextEditingController myController =
                TextEditingController(text: this.text);
            //タップ処理
            String value = await showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Text("Change Text Card"),
                  content: TextFormField(
                    //initialValue: widget.text, //初期値
                    autofocus: true, //画面を開くとキーボードが開かれる
                    enabled: true, //入力可能か
                    maxLength: 12, //最大数
                    controller: myController, //コントローラ
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "Enter Text",
                    ),
                    onEditingComplete: () =>
                        Navigator.pop(context, myController.text), //Enterを押した処理
                  ),
                  actions: <Widget>[
                    // ボタン領域
                    FlatButton(
                      child: Text("Cancel"),
                      onPressed: () => Navigator.pop(context),
                    ),
                    FlatButton(
                      child: Text("OK"),
                      onPressed: () =>
                          Navigator.pop(context, myController.text),
                    ),
                  ],
                );
              },
            );

            //print(value);//debug
            mystringCardModel.updateText(value);
            setState(() {
              //カードの文字を更新
              this.text = value;
            });
          },
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
              MyHomePageState.cardLists.remove(this);
              //変更を通知
              notifyListeners();
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
              child: Text(
                this.text, //カードのテキスト
                style: TextStyle(color: Colors.black, fontSize: 30.0),
              ),
            ),
          ),
        ),
        childWhenDragging: Container(),
        onDraggableCanceled: (view, offset) {
          mystringCardModel.updatePos(this.pos);
          setState(() {
            this.pos = Offset(offset.dx, offset.dy - 56);
          });
        },
      ),
    );
  }
}
*/
