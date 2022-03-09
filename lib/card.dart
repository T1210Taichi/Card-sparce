import 'package:card_space/view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:metadata_fetch/metadata_fetch.dart';
import 'package:provider/provider.dart';
import 'string_card.dart';
import 'image_card.dart';
import 'url_card.dart';
//OGPを抽出
import 'package:metadata_fetch/metadata_fetch.dart';
import 'package:http/http.dart' as http;

class CardModel extends ChangeNotifier {
  List<Widget> cardLists = <Widget>[];

  //文章カード作成関数
  void createStringCard(BuildContext context) async {
    //テキストコントローラ
    TextEditingController myController = TextEditingController();

    //print("createStringCard");//debug
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

    Widget card = String_Card(text: value, pos: Offset(0, 0)); //creat new card
    cardLists.add(card); //追加
    notifyListeners(); //通知
    //print(cardLists); //debug
  }

  //画像カード作成関数
  void createImageCard(BuildContext context) async {
    Widget card = Image_Card(pos: Offset(0, 0)); //カード画像の作成
    cardLists.add(card); //追加
    notifyListeners(); //通知
  }

  //URLカード作成関数
  void createURLCard(BuildContext context) async {
    //テキストコントローラ
    TextEditingController myController = TextEditingController();

    //print("create URL Card");//debug
    BuildContext innerContext;
    String value = await showDialog(
      context: context,
      builder: (BuildContext context) {
        innerContext = context;
        return AlertDialog(
          title: Text("Create URL Card"),
          content: TextFormField(
            autofocus: true, //画面を開くとキーボードが開かれる
            enabled: true, //入力可能か
            //maxLength: 12, //最大数
            controller: myController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: "Enter URL",
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

    Widget card = URL_Card(url: value, pos: Offset(0, 0)); //creat new card
    cardLists.add(card); //追加
    notifyListeners(); //通知

    print(cardLists); //debug
  }

  //OGPを取得する関数
  Future fetchOgpFrom(String url) async {
    //Uri.parse(String)でStringをUri(URL)型に変更
    final myURL = Uri.parse(url);

    var response = await http.get(myURL);
    var document = MetadataFetch.responseToDocument(response);
    var ogp = MetadataParser.openGraph(document);

    return ogp;
  }

  //全カード削除関数
  void clearAllCard(BuildContext context) {
    cardLists.clear();
    notifyListeners(); //通知
    print("clear"); //debug
  }

  //カードの追加
  void add(Widget w) {
    cardLists.add(w); //カードを追加
    notifyListeners(); //通知
  }

  //カード表示関数
  List<Widget> getCards() {
    //カードリスト
    final List<Widget> _cardListWidgets = <Widget>[];
    cardLists.forEach((element) {
      _cardListWidgets.add(element);
    });
    return _cardListWidgets;
  }

  //削除の処理
  void deleteCard(Widget w) {
    cardLists.remove(w); //カードの削除
    notifyListeners(); //通知
    print("delete");
  }
}
