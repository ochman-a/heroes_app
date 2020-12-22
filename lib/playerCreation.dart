import 'package:flutter/material.dart';

class PlayerCreation extends StatefulWidget {
  PlayerCreation({Key key, this.selectedBook, this.playerStats})
      : super(key: key);

  final List<dynamic> selectedBook;
  final Map<String, dynamic> playerStats;

  @override
  _PlayerCreationState createState() => _PlayerCreationState();
}

class _PlayerCreationState extends State<PlayerCreation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Player Creation"),
      ),
    );
  }
}
