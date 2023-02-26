import 'dart:convert';
import 'dart:io';

import 'package:terrun/core/command_matcher.dart';

import 'core/core.dart';
import 'services/services.dart';

Future<void> app(List<String> args) async {
  final matcher = CommandMatcher();
  final RunnerService runner = ProcessRunnerService();
  final DisplayService display = ConsoleDisplaySevice()..init();

  final configContent = ConfigReader().read();
  final config = ConfigParser().parse(configContent);
  final commands = config.commands;

  display.drawMatchingCommands('', commands);

  while (true) {
    String input = '';
    bool isPrefix = true;
    Command? selectedCommand;

    while (isPrefix) {
      final character = utf8.decode([stdin.readByteSync()]);
      final newInput = input + character;
      isPrefix = matcher.getPotentialMatches(commands, newInput) > 0;
      if (isPrefix) {
        input = newInput;
        display.drawMatchingCommands(input, commands);
        selectedCommand = matcher.getFromTree(commands, input);

        if (selectedCommand != null) {
          input = '';
          stdout.writeln('running command:$selectedCommand');
          break;
        }
      } else {
        input = '';
        display.clear();
        display.drawMatchingCommands(input, commands);

        var errorMessage = 'Error: "$newInput" didnt matchin any of keys above';
        print(errorMessage.colored(1));
      }
    }

    if (selectedCommand != null) {
      if (selectedCommand.script != null) {
        await runner.run(
          selectedCommand.script!,
          config.hooks,
        );
      }
      selectedCommand = null;
      display.drawMatchingCommands('', commands);
    }
  }
}
