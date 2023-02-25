import 'command.dart';

class Config {
  final Hooks hooks;
  final Map<String, Command> commands;

  Config({
    required this.hooks,
    required this.commands,
  });
}

class Hooks {
  final List<PreCommandHook> preCommand;

  Hooks(this.preCommand);
}

class PreCommandHook {
  final String command;

  PreCommandHook(this.command);
}
