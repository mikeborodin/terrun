import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart' as runner;
import 'package:terrun/core/core.dart';
import 'package:terrun/services/services.dart';

class LoopCommand extends runner.Command<void> {
  final RunnerService shellRunner;
  final DisplayService display;
  final Env env;

  LoopCommand(
    this.shellRunner,
    this.display,
    this.env,
  );

  @override
  String get description => 'Runs commands defined in config file';

  @override
  String get name => 'loop';

  @override
  Future<void> run() async {
    final matcher = CommandMatcher();

    final configContent = ConfigReader(env).read();
    if (configContent == null) {
      display.drawMessage(
        'Error: config.yaml file not found. Run `terrun config` to add it.',
        type: MessageType.error,
      );
      return;
    }

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
          await shellRunner.run(
            selectedCommand.script!,
            config.hooks,
          );
        }
        selectedCommand = null;
        display.drawMatchingCommands('', commands);
      }
    }
  }
}
