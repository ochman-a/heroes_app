class DiceData {
  static final DiceData _diceData = new DiceData._internal();

  int nbr1 = 0;
  int nbr2 = 0;
  factory DiceData() {
    return _diceData;
  }
  DiceData._internal();
}

final diceData = DiceData();
