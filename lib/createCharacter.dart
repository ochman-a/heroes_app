import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dice.dart';
import 'singletons/diceData.dart';

int numb1 = 0;
int numb2 = 0;
int step = 0;

class CreateCharacter extends StatefulWidget {
  CreateCharacter({Key key, this.selectedBook, this.playerStats})
      : super(key: key);

  final List<dynamic> selectedBook;
  final Map<String, dynamic> playerStats;

  @override
  _CreateCharacterState createState() => _CreateCharacterState();
}

class _CreateCharacterState extends State<CreateCharacter> {
  List<String> text = [
    "Nous allons maintenant déterminer l'HABILITE de votre personnage. Le total sera calculer avec 1d6 + 6",
    "Nous allons maintenant déterminer l'ENDURANCE de votre personnage. Le total sera calculer avec 2d6 + 12",
    "Nous allons maintenant déterminer la CHANCE de votre personnage. Le total sera calculer avec 1d6 + 6"
  ];
  int hability = 0;
  int endurance = 0;
  int luck = 0;

  void diceRolled(PointerEvent details) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Création de personnage"),
        ),
        body: Container(
            margin: const EdgeInsets.all(8.0),
            child: new Column(children: [
              RichText(
                text: TextSpan(
                  text: text[step],
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 25),
                ),
              ),
              Center(
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 70,
                        minHeight: 70,
                        maxWidth: 500,
                        maxHeight: 150,
                      ),
                      child: Listener(onPointerUp: diceRolled, child: Dices())))
            ])));
  }
}
