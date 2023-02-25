import 'command.dart';

class Config {
  final Map<String, Command> commands;
  final Hooks hooks;

  Config({
    required this.hooks,
    required this.commands,
  });
}

class Hooks {
  final List<CommandHook> preRun;
  final List<CommandHook> postRun;

  Hooks(
    this.preRun,
    this.postRun,
  );
}

class CommandHook {
  final String command;

  CommandHook(this.command);
}
