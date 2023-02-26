import 'package:terrun/services/display/console_display_service.dart';
import 'package:terrun/services/display/display_service.dart';
import 'package:test/test.dart';

void main() {
  late DisplayService display;

  setUp(() {
    display = ConsoleDisplaySevice();
  });

  tearDown(() {});

  test('should not throw', () async {
    display.drawMatchingCommands('ttt', {});
  });
}
