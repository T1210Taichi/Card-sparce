import 'package:card_space/string_card.dart';
import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import 'card.dart';

class View extends StatelessWidget {
  const View({Key? key}) : super(key: key);

  static const String appName = "Card Space";

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        title: appName, //タイトル
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: const MyHomePage(title: appName),
      ),
      providers: [
        ChangeNotifierProvider(
          create: (context) => CardModel(),
        )
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  var cardLists = <Widget>[];

  @override
  Widget build(BuildContext context) {
    //カードリスト
    var cardModel = Provider.of<CardModel>(context);

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
            //文字列カードを作成する
            onPressed: () {
              cardModel.createStringCard(context);
            },
          ),
          IconButton(
            //画像カードのアイコン
            icon: const Icon(
              Icons.image,
              color: Colors.black,
            ),
            tooltip: "Create Image Card",
            onPressed: () {
              //画像カードの作成
              cardModel.createImageCard(context);
            },
          ),
          IconButton(
            //URLカードのアイコン
            icon: const Icon(
              Icons.link,
              color: Colors.black,
            ),
            tooltip: "Create URL Card",
            onPressed: () {
              cardModel.createURLCard(context);
            },
          ),
          IconButton(
            //全カード削除のアイコン
            icon: const Icon(
              Icons.clear,
              color: Colors.black,
            ),
            tooltip: "Clear All Card",
            onPressed: () {
              cardModel.clearAllCard(context);
            },
          ),
        ],
      ),
      backgroundColor: Colors.white, //背景色
      body: Consumer<CardModel>(
        builder: (context, value, child) => Stack(
          children: cardModel.getCards(),
        ),
      ),
    );
  }
}
