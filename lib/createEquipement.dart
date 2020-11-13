import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateEquipment extends StatefulWidget {
  CreateEquipment({Key key, this.selectedBook, this.playerStats})
      : super(key: key);

  final List<dynamic> selectedBook;
  final Map<String, dynamic> playerStats;

  @override
  _CreateEquipmentState createState() =>
      _CreateEquipmentState(selectedBook, playerStats);
}

class _CreateEquipmentState extends State<CreateEquipment> {
  List<dynamic> selectedBook;
  Map<String, dynamic> playerStats;

  _CreateEquipmentState(this.selectedBook, this.playerStats);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Création d'équipement"),
        ),
        body: Text("Create Equipement"));
  }
}
