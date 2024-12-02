import 'package:final_project/Score.dart';
import 'package:flutter/material.dart';
//
// /// This class will keep track of scores and log each chosen score
// /// after each dice roll.

class Scorecard extends StatefulWidget {
  @override
  _ScorecardState createState() => _ScorecardState();
}


class _ScorecardState extends State<Scorecard> {
  /// Map of scores
  var scores = {
    'ace' : 0,
    'twos' : 0,
    'threes' : 0,
    'fours' : 0,
    'fives' : 0,
    'sixes' : 0,
    '3ofAKind' : 0,
    '4ofAKind' : 0,
    'fullHouse' : 0,
    'smallStraight' : 0,
    'largeStraight' : 0,
    'YAHTZEE' : 0,
    'chance' : 0,
    'upperSectionTotal' : 0,
    'lowerSectionTotal' : 0,
    'grandTotal' : 0,
  };

  /// Every time the dice are rolled one of the score card cells are
  /// filled when the player presses it. To prevent it from being changed
  /// after the turn is over we will implements buttons for every cell
  /// that will be disabled after being pressed once.
  /// ex: onPressed: null

  /// Method for setting scores in map
  ///
  void setScore(String category, int score){
    scores[category] = score;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scorecard'),
      ),
    );
  }
}
