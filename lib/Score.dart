import 'package:flutter/material.dart';

/// This class has methods for determining available score options
/// depending on the current values of the dice
/// 1. Set dice values of last roll
/// 2. Determine all categories of roll
/// 3. Return all values of vaild categories

class Score{
  List<int> dice = List.filled(5, 0);
  Map<String, int> listOfDuplicates = {};

  /// Creates dice list
  /// and sets list of duplicates
  /// Param: list of dice values
  void setLists(List<int> diceList){
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
  int nOfAKindScore(int num){
    /// check for duplicates of 3
    bool kind_3 = listOfDuplicates.containsValue(3);
    bool kind_4 = listOfDuplicates.containsValue(4);
    if(num == 3 && (kind_3 || kind_4)){
      return sumOf(dice);
    }
    else if(num == 4 && kind_4){
      return sumOf(dice);
    }
    else{
      return 0;
    }
  }

  /// Full House: three of one number and two of another
  /// Return: scores of 0 or 25
  int fullHouseScore(){
    bool kind_3 = listOfDuplicates.containsValue(3);
    bool kind_2 = listOfDuplicates.containsValue(2);
    if(kind_3 && kind_2){
      return 25;
    }
    else{
      return 0;
    }
  }

  /// Small Straight: any sequence of 4 numbers (ex: 2,3,4,5)
  /// list of small straights:
  /// - 1, 2, 3, 4
  /// - 2, 3, 4, 5
  /// - 3, 4, 5, 6
  /// Return: scores of 0 or 30
  int smallStraightScore(){
    List<int> sequence1 = [1, 2, 3, 4];
    List<int> sequence2 = [2, 3, 4, 5];
    List<int> sequence3 = [3, 4, 5, 6];
    bool list1 = containsSequence(dice, sequence1);
    bool list2 = containsSequence(dice, sequence2);
    bool list3 = containsSequence(dice, sequence3);

    if(list1 || list2 || list3){
      return 30;
    }
    else{
      return 0;
    }

  }

  /// Large Straight: any sequence of 5 numbers (ex: 2,3,4,5,6)
  /// list of large straights:
  /// - 1, 2, 3, 4, 5
  /// - 2, 3, 4, 5, 6
  /// Return: scores of 0 or 40
  int largeStraightScore(){
    List<int> sequence1 = [1, 2, 3, 4, 5];
    List<int> sequence2 = [2, 3, 4, 5, 6];
    bool list1 = containsSequence(dice, sequence1);
    bool list2 = containsSequence(dice, sequence2);

    if(list1 || list2){
      return 40;
    }
    else{
      return 0;
    }

  }

  /// YAHTZEE: 5 of the same number
  /// First YAHTZEE is worth 50 points
  /// Additional YAHTZEE is worth 100 points
  /// Param: the number of yahtzees already won by player
  /// Return: scores of 0, 50, 100
  int YAHTZEE_Score(int yahtzee){
    bool kind_5 = listOfDuplicates.containsValue(5);

    if(kind_5){
      if(yahtzee == 0) {
        return 50;
      }
      else {
        return 100;
      }
    }
    else{
      return 0;
    }
  }

  /// Chance: any combination of dice
  /// Returns sum total of dice
  int chanceScore(){
    return sumOf(dice);
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
  int sumOf(List<int> numbers) {
    int sum = 0;
    for (int number in numbers) {
      sum += number;
    }
    return sum;
  }

  /// Method for detecting sequences in a list
  /// Returns: boolean value
  bool containsSequence(List<int> list, List<int> sequence) {
    for (int i = 0; i <= list.length - sequence.length; i++) {
      if (list.sublist(i, i + sequence.length).every((element) =>
                                      element == sequence[element - i])) {
        return true;
      }
    }
    return false;
  }

}