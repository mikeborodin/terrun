import 'package:menusc/core/command_matcher.dart';
import 'package:menusc/core/core.dart';
import 'package:test/test.dart';

void main() {
  test('getPotential matches should return one with one match', () async {
    final numberOfMathes = CommandMatcher().getPotentialMatches({
      'nn': Command(
        name: 'test',
        isGroup: false,
        script: null,
      ),
    }, 'n');

    expect(numberOfMathes, equals(1));
  });
  test('getPotential matches should return one with for full match', () async {
    final numberOfMathes = CommandMatcher().getPotentialMatches({
      'nnn': Command(
        name: 'test',
        isGroup: false,
        script: null,
      ),
    }, 'nnn');

    expect(numberOfMathes, equals(1));
  });

  test('getPotential matches should return 2 with 2 matches', () async {
    final numberOfMathes = CommandMatcher().getPotentialMatches({
      'nn': Command(
        name: 'test',
        isGroup: false,
        script: null,
      ),
      'nt': Command(
        name: 'test',
        isGroup: false,
        script: null,
      ),
    }, 'n');

    expect(numberOfMathes, equals(2));
  });
}
