import 'package:flutter/material.dart';
import 'dart:math';

class Dice extends StatefulWidget {
  @override
  _DiceState createState() => _DiceState();
}

class _DiceState extends State<Dice> {
  final Random _random = Random();
  List<int> _diceValues = [1, 1, 1, 1, 1];

  void _rollDice() {
    setState(() {
      _diceValues = List.generate(5, (_) => _random.nextInt(6) + 1);
    });
  }

  Widget _buildDice(int value) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/dice$value.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dice Screen'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate dynamic sizes based on screen constraints
          double diceSize = constraints.maxWidth / 6; // Adjust size as needed
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Top row with 3 dice
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _diceValues
                      .sublist(0, 3) // Take the first 3 dice values
                      .map((value) => SizedBox(
                    width: diceSize,
                    height: diceSize,
                    child: _buildDice(value),
                  ))
                      .toList(),
                ),
                // Bottom row with 2 dice
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _diceValues
                      .sublist(3, 5) // Take the last 2 dice values
                      .map((value) => SizedBox(
                    width: diceSize,
                    height: diceSize,
                    child: _buildDice(value),
                  ))
                      .toList(),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _rollDice,
                  child: Text('Roll Dice'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
