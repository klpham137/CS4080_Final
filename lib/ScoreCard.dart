import 'package:final_project/Score.dart';
import 'package:flutter/material.dart';
///
/// This class will keep track of scores and log each chosen score
/// after each dice roll.

/// Define the categories and their corresponding indexes
const List<String> categories = [
  "Ones",
  "Twos",
  "Threes",
  "Fours",
  "Fives",
  "Sixes",
  "Three of a Kind",
  "Four of a Kind",
  "Full House",
  "Small Straight",
  "Large Straight",
  "Yahtzee",
  "Chance",
  "Yahtzee Bonus"
];

class Scorecard extends StatefulWidget {
  final List<int> diceValues;

  const Scorecard({Key? key, required this.diceValues}) : super(key: key);

  @override
  _ScorecardState createState() => _ScorecardState();
}


class _ScorecardState extends State<Scorecard> {
  Score score = Score.uninitializedList();
  late List<int> currentRoll;
  Map<String, int> scoreMap = {};
  Set<String> lockedScores = {};

  @override
  void initState() {
    super.initState();
    currentRoll = widget.diceValues;
    if (currentRoll.length != 5) {
      print("Error: currentRoll list must have exactly 5 elements.");
    }
    score.setList(currentRoll);  /// Initialize with the current dice roll
    scoreMap = _getScoreMap();
  }

  /// Function to update score categories dynamically
  Map<String, int> _getScoreMap() {
    return {
      "Ones": lockedScores.contains("Ones") ? scoreMap["Ones"] ?? 0 : score.upperSectionScore(1),
      "Twos": lockedScores.contains("Twos") ? scoreMap["Twos"] ?? 0 : score.upperSectionScore(2),
      "Threes": lockedScores.contains("Threes") ? scoreMap["Threes"] ?? 0 : score.upperSectionScore(3),
      "Fours": lockedScores.contains("Fours") ? scoreMap["Fours"] ?? 0 : score.upperSectionScore(4),
      "Fives": lockedScores.contains("Fives") ? scoreMap["Fives"] ?? 0 : score.upperSectionScore(5),
      "Sixes": lockedScores.contains("Sixes") ? scoreMap["Sixes"] ?? 0 : score.upperSectionScore(6),
      "Three of a Kind": lockedScores.contains("Three of a Kind") ? scoreMap["Three of a Kind"] ?? 0 : score.nOfAKindScore(3),
      "Four of a Kind": lockedScores.contains("Four of a Kind") ? scoreMap["Four of a Kind"] ?? 0 : score.nOfAKindScore(4),
      "Full House": lockedScores.contains("Full House") ? scoreMap["Full House"] ?? 0 : score.fullHouseScore(),
      "Small Straight": lockedScores.contains("Small Straight") ? scoreMap["Small Straight"] ?? 0 : score.smallStraightScore(),
      "Large Straight": lockedScores.contains("Large Straight") ? scoreMap["Large Straight"] ?? 0 : score.largeStraightScore(),
      "Yahtzee": lockedScores.contains("Yahtzee") ? scoreMap["Yahtzee"] ?? 0 : score.yahtzeeScore(),
      "Yahtzee Bonus": lockedScores.contains("Yahtzee Bonus") ? scoreMap["Yahtzee Bonus"] ?? 0 : score.yahtzeeBonusScore(1),
      "Chance": lockedScores.contains("Chance") ? scoreMap["Chance"] ?? 0 : score.chanceScore(),
    };
  }

  /// Function to lock the score when a category is tapped
  void _lockScore(String category) {
    setState(() {
      /// Check if score is already locked. If not, calculate and lock it.
      if (!lockedScores.contains(category)) {
        int scoreForCategory = 0;

        switch (category) {
          case "Ones":
            scoreForCategory = score.upperSectionScore(1);
            break;
          case "Twos":
            scoreForCategory = score.upperSectionScore(2);
            break;
          case "Threes":
            scoreForCategory = score.upperSectionScore(3);
            break;
          case "Fours":
            scoreForCategory = score.upperSectionScore(4);
            break;
          case "Fives":
            scoreForCategory = score.upperSectionScore(5);
            break;
          case "Sixes":
            scoreForCategory = score.upperSectionScore(6);
            break;
          case "Three of a Kind":
            scoreForCategory = score.nOfAKindScore(3);
            break;
          case "Four of a Kind":
            scoreForCategory = score.nOfAKindScore(4);
            break;
          case "Full House":
            scoreForCategory = score.fullHouseScore();
            break;
          case "Small Straight":
            scoreForCategory = score.smallStraightScore();
            break;
          case "Large Straight":
            scoreForCategory = score.largeStraightScore();
            break;
          case "Yahtzee":
            scoreForCategory = score.yahtzeeScore();  // Example without bonus
            break;
          case "Yahtzee Bonus":
            scoreForCategory = score.yahtzeeBonusScore(1);  // Example without bonus
            break;
          case "Chance":
            scoreForCategory = score.chanceScore();
            break;
          default:
            scoreForCategory = 0;
        }

        /// If score is valid (greater than zero), lock the score; otherwise, lock it as zero.
        lockedScores.add(category);
        scoreMap[category] = scoreForCategory > 0 ? scoreForCategory : 0;
      }
    });
  }

  /// Every time the dice are rolled one of the score card cells are
  /// filled when the player presses it. To prevent it from being changed
  /// after the turn is over we will implements buttons for every cell
  /// that will be disabled after being pressed once.
  /// ex: onPressed: null

  /// Function to simulate scoring for each category
  /// Display scorecard with scores
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Yahtzee Scorecard")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  String category = categories[index];
                  return ListTile(
                    title: Text(category),
                    trailing: Text(
                      scoreMap[category] == 0 ? "Not Scored" : scoreMap[category].toString(),
                    ),
                    onTap: lockedScores.contains(category)
                        ? null // Disable tap if score is locked
                        : () {
                      _lockScore(category); // Lock score when tapped
                    },
                  );
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    scoreMap = _getScoreMap();
                  });
                },
                child: Text("Refresh Scores"),
              ),
              SizedBox(height: 20),
              Text(
                "Total Score: ${scoreMap.values.fold(0, (prev, score) => prev + score)}",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
