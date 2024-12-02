import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yahtzee Game',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blueGrey,
      ),
      home: Dice(),
    );
  }
}

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
        title: Text('Yahtzee Game'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double diceSize = constraints.maxWidth / 6; // adjust dice size to fit on screen
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // top row has 3 dice
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _diceValues
                      .sublist(0, 3) // first 3 dice values
                      .map((value) => SizedBox(
                    width: diceSize,
                    height: diceSize,
                    child: _buildDice(value),
                  ))
                      .toList(),
                ),
                // bottom row has 2 dice
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _diceValues
                      .sublist(3, 5)
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
                  child: Text('Roll'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
