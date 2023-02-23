import 'dart:convert';
import 'dart:io';

import 'package:menusc/core/command_matcher.dart';

import 'core/core.dart';
import 'services/services.dart';

Future<void> app(List<String> args) async {
  final RunnerService runner = ProcessRunnerService();
  final DisplayService display = ConsoleDisplaySevice();
  final matcher = CommandMatcher();
  display.init();

  final config = ConfigReader().read();
  final commands = ConfigParser().parse(config);
  display.clear();

// we run program forever
  while (true) {
    String input = '';
    bool isPrefix = true;
    // selecting the command
    Command? selectedCommand;

    while (isPrefix) {
      final character = utf8.decode([stdin.readByteSync()]);
      final newInput = input + character;
      isPrefix = matcher.getPotentialMatches(commands, newInput) > 0;
      if (isPrefix) {
        input = newInput;
        display.drawMatchingCommands(input, commands);
        print(input);

        final selectedCommand = matcher.getFromTree(commands, input);
        if (selectedCommand != null) {
          input = '';
          break;
        }
      } else {
        input = '';
        display.clear();
        print('$newInput didnt matchin any of keys in ${commands.keys.map((e) => e).join(',')}');
      }
    }

    if (selectedCommand != null) {
      display.clear();
      stdout.writeln('executing command:$selectedCommand');
      if (selectedCommand.script != null) {
        await runner.run(selectedCommand.script!);
      }
      selectedCommand = null;
    }
  }
}
