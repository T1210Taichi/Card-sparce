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

  var _num = 0;

  //文章カード作成関数
  void _createStringCard() {
    setState(() {
      String_Card card = String_Card(text: "card ${_num++}", pos: Offset(0, 0));
      cardLists.add(card);
      print(cardLists);
      cardContens = _getCards();
    });
  }

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
          widget.title,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            fontSize: 30,
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
            onPressed: () {},
          ),
          IconButton(
            //URLカードのアイコン
            icon: const Icon(
              Icons.link,
              color: Colors.black,
            ),
            tooltip: "Create URL Card",
            onPressed: () {},
          ),
          IconButton(
            //全カード削除のアイコン
            icon: const Icon(
              Icons.clear,
              color: Colors.black,
            ),
            tooltip: "Clear All Card",
            onPressed: () {},
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
