import 'package:card_space/string_card.dart';
import 'package:flutter/material.dart';
import "package:provider/provider.dart";

class View extends StatelessWidget {
  const View({Key? key}) : super(key: key);

  static const String appName = "Card Space";

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        title: appName,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: const MyHomePage(title: appName),
      ),
      providers: [
        ChangeNotifierProvider(
          create: (context) => String_CardModel(),
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

  //文章カード作成関数
  void _createStringCard() async {
    //テキストコントローラ
    TextEditingController myController = TextEditingController();
    //カードリスト
    //var cardLists = Provider.of<String_CardModel>(context);
    print("now");

    String value = await showDialog(
      context: context,
      builder: (_) {
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

    setState(() {
      Widget card =
          String_Card(text: value, pos: Offset(0, 0)); //creat new card
      //rcardLists.add(card); //add new card to cardlists
      //print(cardLists); //debug
    });
  }

  //画像カード作成関数
  void _createImageCard() {}
  //URLカード作成関数
  void _createURLCard() {}
  //全カード削除関数
  void _clearAllCard() {
    //カードリスト
    var cardLists = Provider.of<String_CardModel>(context);
    //setState(() {
    cardLists.clear();
    print("clear"); //debug
    //cardLists = getCards();
    //});
  }

  @override
  Widget build(BuildContext context) {
    //カードリスト
    var string_cardModel = Provider.of<String_CardModel>(context);

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
            //onPressed: _createStringCard, //文字列カードを作成する
            onPressed: () {
              string_cardModel.createStringCard(context);
            },
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
      body: Consumer<String_CardModel>(
        builder: (context, value, child) => Stack(
          //children: getCards(),
          children: string_cardModel.getCards(),
        ),
      ),
      /*
      body: Stack(
          //Widgetを自由に配置
          children: getCards()),
      */
    );
  }
}
