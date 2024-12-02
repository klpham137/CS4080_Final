import 'package:flutter/material.dart';

/// This class has methods for determining available score options
/// depending on the current values of the dice
/// 1. Set dice values of last roll
/// 2. Determine all categories of roll
/// 3. Return all values of vaild categories

class Category{
  late int score;
  List<int> dice = List.filled(5, 0);
  Map<String, int> listOfDuplicates = {};

  /// Constructor for the Category class that takes in die values
  /// Param: list of dice values
  Category(List<int> diceList){
    dice = List.from(diceList);
    setDuplicateList();
  }
  /// Methods for upper section
  ///
  /// Returns: score = num * num value from map
  int upperSectionScore(int num){
    return num * listOfDuplicates["die$num"]!;
  }

  /// Methods for lower section
  ///
  /// n of a kind: 3 or more of the same number
  /// Param: num must be 3 or 4
  /// Returns: sum of all dice
  int nOfAKind(int num){
    /// check for duplicates of 3
    bool kind_3 = listOfDuplicates.containsValue(3);
    bool kind_4 = listOfDuplicates.containsValue(4);
    if(num == 3 && (kind_3 || kind_4)){
      return sumUsingLoop(dice);
    }
    else if(num == 4 && kind_4){
      return sumUsingLoop(dice);
    }
    else{
      return 0;
    }
  }

  /// Full House: three of one number and two of another
  /// Returns 25 points
  int fullHouse(){
    return score;
  }

  /// Small Straight: any sequence of 4 numbers (ex: 2,3,4,5)
  /// Returns 30 points
  int smallStraight(){
    return score;
  }

  /// Large Straight: any sequence of 5 numbers (ex: 2,3,4,5,6)
  /// Returns 40 points
  int largeStraight(){
    return score;
  }

  /// YAHTZEE: 5 of the same number
  /// First YAHTZEE is worth 50 points
  /// Additional YAHTZEE is worth 100 points
  int YAHTZEE(){
    return score;
  }

  /// Chance: any combination of dice
  /// Returns sum total of dice
  int chance(){
    return score;
  }

  /// Checks for duplicates of a specific num (1-6) in the list, dice
  /// Param: num is a number between (1-6)
  /// Returns: int between (0-6) that represents the amount of times num is
  /// in the list
  int checkForDuplicatesOf(int num){
    /// Checks for num
    bool containsNum = dice.contains(num);
    if(containsNum){
      int duplicates = dice.where((dice) => dice == num).length;
      return duplicates;
    }
    else {
      return 0;
    }
  }

  /// This method uses a for loop to check each dice number for duplicates
  /// and add them to the map, listOfDuplicates
  void setDuplicateList(){
    for (var num = 0; num < dice.length; num++) {
      listOfDuplicates["die$num"] = checkForDuplicatesOf(num);
    }
  }

  /// Sum of a list of numbers
  /// Returns: sum
  int sumUsingLoop(List<int> numbers) {
    int sum = 0;
    for (int number in numbers) {
      sum += number;
    }
    return sum;
  }

}