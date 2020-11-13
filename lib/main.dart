import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'playBook.dart';
import 'createCharacter.dart';
import 'dice.dart';
import 'createEquipement.dart';

Map<String, dynamic> player_file;

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/hero_player.txt');
}

Future<File> _createFile() async {
  final file = await _localFile;
  Map<String, dynamic> default_file = {
    "01": {
      "last_chapter": "000",
      "last_safe_chapter": "000",
      "player_stats": {},
      "player_inv": {}
    },
    "02": {
      "last_chapter": "000",
      "last_safe_chapter": "000",
      "player_stats": {},
      "player_inv": {}
    },
    "03": {
      "last_chapter": "000",
      "last_safe_chapter": "000",
      "player_stats": {},
      "player_inv": {}
    }
  };
  return file.writeAsString(jsonEncode(default_file));
}

void openPlayerFile() async {
  try {
    final file = await _localFile;

    String contents = await file.readAsString();
    player_file = jsonDecode(contents);
    print(contents);
  } catch (e) {
    await _createFile();
    openPlayerFile();
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    openPlayerFile();
    return MaterialApp(
      title: 'Heroes App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (context) =>
            MyHomePage(title: 'L\'application dont vous êtes le héros'),
        '/play': (context) => PlayBook(),
        '/create-character': (context) => CreateCharacter(),
        '/create-equipment': (context) => CreateEquipment(),
        '/dice': (context) => Dices()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> imgList = [];
  Map<String, dynamic> playerStats;

  void loadAssets() async {
    var file = await rootBundle.loadString('ressources/books/books.json');
    Map<String, dynamic> books = jsonDecode(file);
    for (var book in books.values) {
      var bookInfo = [
        book["number"],
        book["title"],
        book["img"],
        book["available"],
        book["text_link"]
      ];
      imgList.add(bookInfo);
    }
    setState(() {});
  }

  void selectBookNewGame(var book) {
    if (book[3] == true && player_file[book[0]]["last_chapter"] == "000") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                CreateCharacter(selectedBook: book, playerStats: playerStats)),
      );
    } else {
      print("Book not available");
    }
  }

  void selectBookContinue(var book) {
    if (book[3] == true && player_file[book[0]]["last_chapter"] != "000") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                PlayBook(selectedBook: book, playerStats: playerStats)),
      );
    } else {
      print("Book not available");
    }
  }

  @override
  Widget build(BuildContext context) {
    loadAssets();
    return Scaffold(
        backgroundColor: Color(0xFFEAECEE),
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CarouselSlider(
                  options: CarouselOptions(height: 530.0, aspectRatio: 2.0),
                  items: imgList
                      .map((item) => Container(
                          margin: const EdgeInsets.all(8.0),
                          child: FlatButton(
                            onPressed: () => showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return SimpleDialog(
                                    title: Text(item[1]),
                                    children: player_file[item[0]]
                                                ["last_chapter"] ==
                                            "000"
                                        ? <Widget>[
                                            SimpleDialogOption(
                                              onPressed: () {
                                                selectBookNewGame(item);
                                              },
                                              child: Text("Nouvelle partie"),
                                            )
                                          ]
                                        : <Widget>[
                                            SimpleDialogOption(
                                              onPressed: () {
                                                selectBookNewGame(item);
                                              },
                                              child: Text("Nouvelle partie"),
                                            ),
                                            SimpleDialogOption(
                                              onPressed: () {
                                                selectBookContinue(item);
                                              },
                                              child: Text(
                                                  "Continuer - chapitre " +
                                                      player_file[item[0]]
                                                          ["last_chapter"]),
                                            ),
                                          ],
                                  );
                                }),
                            child: Center(
                                child: Image.asset(item[2],
                                    fit: BoxFit.cover, width: 1000)),
                          )))
                      .toList())
            ],
          ),
        ));
  }
}
