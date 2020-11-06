import 'package:flutter/material.dart';
import 'dice.dart';

class CreateCharacter extends StatefulWidget {
  CreateCharacter({Key key, this.selectedBook, this.playerStats})
      : super(key: key);

  final List<dynamic> selectedBook;
  final Map<String, dynamic> playerStats;

  @override
  _CreateCharacterState createState() => _CreateCharacterState();
}

class _CreateCharacterState extends State<CreateCharacter> {
  void loadChapter() {}

  @override
  Widget build(BuildContext context) {
    loadChapter();
    return Scaffold(
        appBar: AppBar(
          title: Text("Création de personnage"),
        ),
        body: Container(margin: const EdgeInsets.all(8.0), child: Dices()));
  }
}
