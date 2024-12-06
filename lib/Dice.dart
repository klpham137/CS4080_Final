import 'package:flutter/material.dart';
import 'dart:math';
import 'ScoreCard.dart';

class Dice extends StatefulWidget {
  @override
  _DiceState createState() => _DiceState();
}

class _DiceState extends State<Dice> {
  final Random _random = Random();
  List<int> _diceValues = [1, 1, 1, 1, 1];
  List<bool> _keptDice = [false, false, false, false, false];
  int rollCount = 0, roundCount = 1;

  void _toggleDiceHold(int index) {
    setState(() {
      _keptDice[index] = !_keptDice[index];
    });
  }

  void _rollDice() {
    setState(() {
      if (rollCount < 3) {
        _diceValues = List.generate(5, (index) {
          // don't roll the dice that the user chooses to keep
          return _keptDice[index] ? _diceValues[index] : _random.nextInt(6) + 1;
        });
        rollCount++;
      }
      else{
        _keptDice = [true, true, true, true, true];
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Out of Rolls'),
              content: Text('You are out of rolls! Please record score and start a new round.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    });
  }

  void _startNewRound() {
    setState(() {
      if (roundCount > 13){
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Game Over'),
              content: Text('The game is over! Tally up your score!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }else{
        // reset everything for next round
        roundCount ++;
        rollCount = 0;
        _diceValues = [1, 1, 1, 1, 1];
        _keptDice = [false, false, false, false, false];
      }
    });
  }

  Widget _buildDice(int value, int index) {
    return GestureDetector(
      onTap: () => _toggleDiceHold(index),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: _keptDice[index] ? Colors.green : Colors.transparent,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/dice$value.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yahtzee Game'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double diceSize = constraints.maxWidth / 6;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0), // Adjust horizontal padding as needed
                  child: const Text(
                    'Welcome to Yahtzee! \n\nRoll the dice and click on a die face to lock it in for the next roll',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 50),
                // top row has 3 dice
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return SizedBox(
                      width: diceSize,
                      height: diceSize,
                      child: _buildDice(_diceValues[index], index),
                    );
                  }),
                ),
                SizedBox(height: 16),
                // bottom row has 2 dice
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(2, (index) {
                    return SizedBox(
                      width: diceSize,
                      height: diceSize,
                      child: _buildDice(_diceValues[index + 3], index + 3),
                    );
                  }),
                ),
                SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _rollDice,
                        child: Text('Roll'),
                      ),
                      SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: _startNewRound,
                        child: Text('Next Round'),
                      ),
                    ]
                ),
                SizedBox(height:15),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Scorecard(diceValues: _diceValues)),
                    );
                  },
                  child: Text('See Scorecard'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
