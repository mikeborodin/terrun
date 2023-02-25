import 'package:menusc/services/config/config_parser.dart';
import 'package:test/test.dart';

void main() {
  late ConfigParser parser;

  setUp(() {
    parser = ConfigParser();
  });
  test('should parse 3 leveled yaml config', () async {
    final config = parser.parse("""
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
    expect(
      config.commands.keys,
      equals(
        [
          'n',
          'ny',
          'nn',
        ],
      ),
    );
  });

  test('should parse 3 leveled yaml config', () async {
    final config = parser.parse("""
commands:
  n:
    name: group1 
    children:
      y: 
        name: chrome browser
        command: open -a chrome
      n: 
        name: group2
        children:
          t:
            name: telegram
            command: open -a telegram
""");
    expect(
      config.commands.keys,
      equals(
        [
          'n',
          'ny',
          'nn',
          'nnt',
        ],
      ),
    );
  });
}
