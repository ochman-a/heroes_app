import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dice.dart';
import 'createEquipement.dart';
import 'singletons/diceData.dart';

int numb1 = 0;
int numb2 = 0;

class CreateCharacter extends StatefulWidget {
  CreateCharacter({Key key, this.selectedBook, this.playerStats})
      : super(key: key);

  final List<dynamic> selectedBook;
  final Map<String, dynamic> playerStats;

  @override
  _CreateCharacterState createState() =>
      _CreateCharacterState(selectedBook, playerStats);
}

class _CreateCharacterState extends State<CreateCharacter> {
  List<String> text = [
    "Nous allons maintenant déterminer l'HABILITE de votre personnage. Le total sera calculer avec 1d6 + 6",
    "Nous allons maintenant déterminer l'ENDURANCE de votre personnage. Le total sera calculer avec 2d6 + 12",
    "Nous allons maintenant déterminer la CHANCE de votre personnage. Le total sera calculer avec 1d6 + 6"
  ];
  List<int> nbrDice = [1, 2, 1];
  int hability = 0;
  int endurance = 0;
  int luck = 0;
  int step = 0;
  int reroll = 3;
  List<dynamic> selectedBook;
  Map<String, dynamic> playerStats;
  BuildContext genCtx;

  void diceRolled(PointerEvent details) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              title: step % 2 == 0
                  ? Text("Le résultat est: " + (diceData.nbr2 + 6).toString())
                  : Text("Le résultat est: " +
                      (diceData.nbr1 + diceData.nbr2 + 12).toString()),
              children: reroll != 0
                  ? <Widget>[
                      SimpleDialogOption(
                        onPressed: () {
                          reroll--;
                          setState(() {});
                          Navigator.pop(context, 'Reroll');
                        },
                        child: Text("Relancer"),
                      ),
                      SimpleDialogOption(
                          onPressed: () {
                            switch (step) {
                              case 0:
                                hability = diceData.nbr2 + 6;
                                break;
                              case 1:
                                endurance = diceData.nbr1 + diceData.nbr2 + 12;
                                break;
                              case 2:
                                luck = diceData.nbr2 + 6;
                                break;
                            }
                            if (step != 2) {
                              step++;
                            } else {
                              playerStats = {
                                "last_chapter": "000",
                                "last_safe_chapter": "000",
                                "player_stats": {
                                  "max_hability": hability,
                                  "current_hability": hability,
                                  "max_endurance": endurance,
                                  "current_endurance": endurance,
                                  "max_luck": luck,
                                  "current_luck": luck
                                },
                                "player_inv": {}
                              };
                            }
                            setState(() {});
                            Navigator.pop(context, 'Accepted');
                          },
                          child: Text("Accepter"))
                    ]
                  : <Widget>[
                      SimpleDialogOption(
                          onPressed: () {
                            switch (step) {
                              case 0:
                                hability = diceData.nbr2 + 6;
                                break;
                              case 1:
                                endurance = diceData.nbr1 + diceData.nbr2 + 12;
                                break;
                              case 2:
                                luck = diceData.nbr2 + 6;
                                break;
                            }
                            if (step != 2) {
                              step++;
                            } else {
                              playerStats = {
                                "last_chapter": "000",
                                "last_safe_chapter": "000",
                                "player_stats": {
                                  "max_hability": hability,
                                  "current_hability": hability,
                                  "max_endurance": endurance,
                                  "current_endurance": endurance,
                                  "max_luck": luck,
                                  "current_luck": luck
                                },
                                "player_inv": {}
                              };
                            }
                            setState(() {});
                            Navigator.pop(context, 'Accepted');
                          },
                          child: Text("Accepter")),
                    ]);
        });
    setState(() {});
  }

  void toCreateEquipment() {
    print("We finished");
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CreateEquipment(
              selectedBook: selectedBook, playerStats: playerStats)),
    );
  }

  _CreateCharacterState(this.selectedBook, this.playerStats);
  @override
  Widget build(BuildContext context) {
    if (step == 2) {
      toCreateEquipment();
    }
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
              Text("Habilité: " + hability.toString()),
              Text("Endurance: " + endurance.toString()),
              Text("Chance: " + luck.toString()),
              reroll != 0
                  ? Text("Vous pouvez faire encore " +
                      reroll.toString() +
                      " relance.")
                  : Text("Vous ne pouvez plus faire de relance."),
              Center(
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 70,
                        minHeight: 70,
                        maxWidth: 500,
                        maxHeight: 150,
                      ),
                      child: Listener(
                          onPointerUp: diceRolled,
                          child: Dices(nbrDice: nbrDice[step]))))
            ])));
  }
}
