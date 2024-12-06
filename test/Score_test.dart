import 'package:final_project/Score.dart';
import 'package:test/test.dart';

main(){

  test('Testing upper section scores', () {
    /// Test values
    var testValues123 = [2, 1, 1, 2, 3];
    var testValues456 = [6, 5, 6, 4, 4];
    /// Test score objects
    Score score123 = Score(testValues123);
    Score score456 = Score(testValues456);
    /// Test function calls
    var ace = score123.upperSectionScore(1);
    var twos = score123.upperSectionScore(2);
    var threes = score123.upperSectionScore(3);
    var fours = score456.upperSectionScore(4);
    var fives = score456.upperSectionScore(5);
    var sixes = score456.upperSectionScore(6);

    expect(ace, 2);
    expect(twos, 4);
    expect(threes, 3);
    expect(fours, 8);
    expect(fives, 5);
    expect(sixes, 12);
  });


  /// Testing for 3 of a kind
  test('Testing 3 of a kind scores', () {
    /// Test values
    var testValues1 = [1, 2, 1, 1, 2];
    var testValues2 = [2, 1, 2, 2, 1];
    var testValues3 = [3, 1, 3, 3, 1];
    var testValues4 = [4, 1, 4, 4, 1];
    var testValues5 = [5, 1, 5, 5, 1];
    var testValues6 = [6, 1, 6, 6, 1];
    /// Test score objects
    Score score1 = Score(testValues1);
    Score score2 = Score(testValues2);
    Score score3 = Score(testValues3);
    Score score4 = Score(testValues4);
    Score score5 = Score(testValues5);
    Score score6 = Score(testValues6);

    /// Test function calls
    var testFunction1 = score1.nOfAKindScore(3);
    var testFunction2 = score2.nOfAKindScore(3);
    var testFunction3 = score3.nOfAKindScore(3);
    var testFunction4 = score4.nOfAKindScore(3);
    var testFunction5 = score5.nOfAKindScore(3);
    var testFunction6 = score6.nOfAKindScore(3);

    expect(testFunction1, 7);
    expect(testFunction2, 8);
    expect(testFunction3, 11);
    expect(testFunction4, 14);
    expect(testFunction5, 17);
    expect(testFunction6, 20);
  });

  /// Testing for 4 of a kind
  test('Testing n of a kind scores', () {
    /// Test values
    var testValues1 = [1, 2, 1, 1, 1];
    var testValues2 = [2, 1, 2, 2, 2];
    var testValues3 = [3, 1, 3, 3, 3];
    var testValues4 = [4, 1, 4, 4, 4];
    var testValues5 = [5, 1, 5, 5, 5];
    var testValues6 = [6, 1, 6, 6, 6];
    /// Test score objects
    Score score1 = Score(testValues1);
    Score score2 = Score(testValues2);
    Score score3 = Score(testValues3);
    Score score4 = Score(testValues4);
    Score score5 = Score(testValues5);
    Score score6 = Score(testValues6);

    /// Test function calls
    var testFunction1 = score1.nOfAKindScore(4);
    var testFunction2 = score2.nOfAKindScore(4);
    var testFunction3 = score3.nOfAKindScore(4);
    var testFunction4 = score4.nOfAKindScore(4);
    var testFunction5 = score5.nOfAKindScore(4);
    var testFunction6 = score6.nOfAKindScore(4);

    expect(testFunction1, 6);
    expect(testFunction2, 9);
    expect(testFunction3, 13);
    expect(testFunction4, 17);
    expect(testFunction5, 21);
    expect(testFunction6, 25);
  });

  test('Testing full house scores', () {
    /// Test values
    var isAFullHouse = [6, 2, 6, 6, 2];
    var isNOTAFullHouse = [6, 2, 6, 1, 2];
    /// Test score objects
    Score score1 = Score(isAFullHouse);
    Score score2 = Score(isNOTAFullHouse);
    /// Test function calls
    var fullHouse = score1.fullHouseScore();
    var notFullHouse = score2.fullHouseScore();

    expect(fullHouse, 25);
    expect(notFullHouse, 0);
  });

  test('Testing straight scores', () {
    /// Test values
    var isASmallStraight = [6, 2, 1, 3, 4];
    var isALargeStraight = [5, 3, 6, 4, 2];
    var isNOTAStraight = [6, 2, 6, 1, 2];
    /// Test score objects
    Score score1 = Score(isASmallStraight);
    Score score2 = Score(isALargeStraight);
    Score score3 = Score(isNOTAStraight);
    /// Test function calls
    var smallStraight = score1.smallStraightScore();
    var largeStraight = score2.largeStraightScore();
    var notSmallStraight = score3.smallStraightScore();
    var notLargeStraight = score3.largeStraightScore();

    expect(smallStraight, 30);
    expect(largeStraight, 40);
    expect(notSmallStraight, 0);
    expect(notLargeStraight, 0);
  });

  /// Testing large and small straight scores SEPARATELY
  test('Testing SMALL straight scores', () {
    /// Test values
    var isASmallStraight = [6, 2, 1, 3, 4];
    var isNOTAStraight = [6, 2, 6, 1, 2];
    /// Test score objects
    Score score1 = Score(isASmallStraight);
    Score score2 = Score(isNOTAStraight);
    /// Test function calls
    var smallStraight = score1.smallStraightScore();
    var notSmallStraight = score2.smallStraightScore();

    expect(smallStraight, 30);
    expect(notSmallStraight, 0);
  });

  /// Testing large and small straight scores SEPARATELY
  test('Testing LARGE straight scores', () {
    /// Test values
    var isALargeStraight = [5, 3, 6, 4, 2];
    var isNOTAStraight = [6, 2, 6, 1, 2];
    /// Test score objects
    Score score1 = Score(isALargeStraight);
    Score score2 = Score(isNOTAStraight);
    /// Test function calls
    var largeStraight = score1.largeStraightScore();
    var notLargeStraight = score2.largeStraightScore();

    expect(largeStraight, 40);
    expect(notLargeStraight, 0);
  });

  test('Testing Yahtzee scores', () {
    var yahtzeeTotal = 2;

    var testValues1 = [2, 2, 2, 2, 2];
    var testValues2 = [2, 1, 2, 2, 2];

    Score testScore1 = Score(testValues1);
    Score testScore2 = Score(testValues2);

    var yahtzee = testScore1.yahtzeeScore(yahtzeeTotal);
    var yahtzee2 = testScore2.yahtzeeScore(yahtzeeTotal);

    expect(yahtzee, 250);
    expect(yahtzee2, 0);

  });

  test('Testing chance scores', () {
    var testValues = [2, 1, 4, 2, 1];

    Score testScore = Score(testValues);

    var chance = testScore.chanceScore();

    expect(chance, 10);
  });
}