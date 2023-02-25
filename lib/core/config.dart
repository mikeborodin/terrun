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
  final String preCommand;

  Hooks(this.preCommand);
}
