import 'package:card_space/string_card.dart';
import 'package:flutter/material.dart';

class View extends StatelessWidget {
  final MaterialColor materialWhite = const MaterialColor(
    0xFFFFFFFF,
    const <int, Color>{
      50: const Color(0xFFFFFFFF),
      100: const Color(0xFFFFFFFF),
      200: const Color(0xFFFFFFFF),
      300: const Color(0xFFFFFFFF),
      400: const Color(0xFFFFFFFF),
      500: const Color(0xFFFFFFFF),
      600: const Color(0xFFFFFFFF),
      700: const Color(0xFFFFFFFF),
      800: const Color(0xFFFFFFFF),
      900: const Color(0xFFFFFFFF),
    },
  );

  const View({Key? key}) : super(key: key);

  static const String appName = "Card Space";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      //darkTheme: ThemeData.dark(),
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

  //カード作成関数
  void _makeCard() {
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

  //Widget card1 = String_Card(text: "card1", pos: Offset(0, 0));
  //Widget card2 = String_Card(text: "card2", pos: Offset(0, 0));

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
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.input),
                tooltip: 'make String Card', //カバー時に表示される
                onPressed: _makeCard, //文字列カードを作成する
              ),
            ],
          )
        ],
      ),
      //backgroundColor: Colors.white, //背景色
      body: Stack(
          //Widgetを自由に配置
          children: _getCards()),
    );
  }
}
