import 'package:menusc/services/config_parser.dart';
import 'package:test/test.dart';

void main() {
  late ConfigParser parser;

  setUp(() {
    parser = ConfigParser();
  });
  test('should parse 3 items from nested yaml config', () async {
    final commands = parser.parse("""
commands:
  n:
    name: apps 
    children:
      y: 
        name: chrome browser
        command: open -a chrome
      n: 
        name: telegram
        command: open -a telegram
""");
    expect(commands, {
      'n': 'apps',
      'ny': 'open -a chrome',
      'nn': 'open -a telegram',
    });
  });
}
