import 'dart:io';

import 'package:ansicolor/ansicolor.dart';

import '../../core/core.dart';
import 'display_service.dart';

class ConsoleDisplaySevice implements DisplayService {
  @override
  void drawMatchingCommands(
    String input,
    Map<String, Command> commands,
  ) {
    _clear();
    final blueOnWhite = AnsiPen()
      ..white(bg: true)
      ..blue();

    stdout.writeln(blueOnWhite('Typing: $input'));
    final matchingCommands = commands.entries.where(
      (entry) => entry.key.startsWith(input),
    );
    for (final entry in matchingCommands) {
      final shortcut = entry.key;
      final command = entry.value;

      String result = '';
      if (command.isGroup) {
        result = '[$shortcut] ${command.name}';
      } else {
        result = '[$shortcut] ${command.script}';
      }
      stdout.writeln(result);
    }
  }

  @override
  void init() {
    stdin.echoMode = false;
    stdin.echoNewlineMode = false;
    stdin.lineMode = false;
    _clear();
  }

  @override
  void clear() => _clear();

  void _clear() => print("\x1B[2J\x1B[0;0H");
}
