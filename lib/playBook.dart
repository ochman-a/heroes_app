import 'package:flutter/material.dart';

class PlayBook extends StatefulWidget {
  PlayBook({Key key, this.selectedBook, this.playerStats}) : super(key: key);

  final List<dynamic> selectedBook;
  final Map<String, dynamic> playerStats;

  @override
  _PlayBookState createState() => _PlayBookState();
}

class _PlayBookState extends State<PlayBook> {
  void loadChapter() {}

  @override
  Widget build(BuildContext context) {
    print(widget.selectedBook[1]);
    loadChapter();
    return Scaffold(
      appBar: AppBar(
        title: Text("Jeu"),
      ),
    );
  }
}
