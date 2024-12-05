import 'package:final_project/Score.dart';
import 'package:test/test.dart';

main(){

  var testValues = [4, 2, 2, 4, 4];
  Score testScore = Score(testValues);
  var yahtzeeTotal = 2;

  test('Testing upper section scores', () {
    var ace = testScore.upperSectionScore(1);
    var twos = testScore.upperSectionScore(2);
    var threes = testScore.upperSectionScore(3);
    var fours = testScore.upperSectionScore(4);
    var fives = testScore.upperSectionScore(5);
    var sixes = testScore.upperSectionScore(6);

    expect(ace, 0);
    expect(twos, 4);
    expect(threes, 0);
    expect(fours, 12);
    expect(fives, 0);
    expect(sixes, 0);
  });

  test('Testing n of a kind scores', () {
    var nOfAKind_3 = testScore.nOfAKindScore(3);
    var nOfAKind_4 = testScore.nOfAKindScore(4);
    var nOfAKind = testScore.nOfAKindScore(2);

    expect(nOfAKind_3, 16);
    expect(nOfAKind_4, 0);
    expect(nOfAKind, 0);
  });

  test('Testing full house scores', () {
    var fullHouse = testScore.fullHouseScore();

    expect(fullHouse, 25);
  });

  test('Testing straight scores', () {
    var smallStraight = testScore.smallStraightScore();
    var largeStraight = testScore.largeStraightScore();

    expect(smallStraight, 0);
    expect(largeStraight, 0);
  });

  test('Testing Yahtzee scores', () {
    var yahtzee = testScore.yahtzeeScore(yahtzeeTotal);

    expect(yahtzee, 0);
  });

  test('Testing chance scores', () {
    var chance = testScore.chanceScore();

    expect(chance, 16);
  });
}