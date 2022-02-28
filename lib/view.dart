import 'package:card_space/string_card.dart';
import 'package:flutter/material.dart';

class View extends StatelessWidget {
  const View({Key? key}) : super(key: key);

  static const String appName = "Card Space";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
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
  //カードリスト
  var cardLists = <Widget>[];
  var cardContens = <Widget>[];

  //文章カード作成関数
  void _createStringCard() async {
    //テキストコントローラ
    final myController = TextEditingController();

    String value = await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("Create Card"),
          content: TextField(
            controller: myController,
            decoration: InputDecoration(hintText: "ここに入力"),
          ),
          actions: <Widget>[
            // ボタン領域
            FlatButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            FlatButton(
              child: Text("OK"),
              onPressed: () => Navigator.pop(context, myController.text),
            ),
          ],
        );
      },
    );

    setState(() {
      String_Card card =
          String_Card(text: value, pos: Offset(0, 0)); //creat new card
      cardLists.add(card); //add new card to cardlists
      print(cardLists); //debug
      cardContens = _getCards(); //reload cardlists
    });
  }

  //画像カード作成関数
  void _createImageCard() {}
  //URLカード作成関数
  void _createURLCard() {}
  //全カード削除関数
  void _clearAllCard() {}

  //カード表示関数
  List<Widget> _getCards() {
    final List<Widget> _cardListWidgets = <Widget>[];
    setState(() {
      cardLists.forEach((element) {
        _cardListWidgets.add(element);
      });
    });
    return _cardListWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title, //表示する文字
          style: TextStyle(
            color: Colors.black, //appBarの文字の色
            fontFamily: 'Roboto', //フォント
            fontWeight: FontWeight.bold, //太字
            fontSize: 30, //フォントサイズ
          ),
        ),
        elevation: 3, //bodyとの境界線
        backgroundColor: Colors.white, //背景色
        iconTheme: IconThemeData(size: 50),
        actions: <Widget>[
          IconButton(
            //文字カードのアイコン
            icon: const Icon(
              Icons.edit_note,
              color: Colors.black,
            ),
            tooltip: 'Create String Card', //カバー時に表示される
            onPressed: _createStringCard, //文字列カードを作成する
          ),
          IconButton(
            //画像カードのアイコン
            icon: const Icon(
              Icons.image,
              color: Colors.black,
            ),
            tooltip: "Create Image Card",
            onPressed: _createImageCard,
          ),
          IconButton(
            //URLカードのアイコン
            icon: const Icon(
              Icons.link,
              color: Colors.black,
            ),
            tooltip: "Create URL Card",
            onPressed: _createURLCard,
          ),
          IconButton(
            //全カード削除のアイコン
            icon: const Icon(
              Icons.clear,
              color: Colors.black,
            ),
            tooltip: "Clear All Card",
            onPressed: _clearAllCard,
          ),
        ],
      ),
      //backgroundColor: Colors.white, //背景色
      body: Stack(
          //Widgetを自由に配置
          children: _getCards()),
    );
  }
}
