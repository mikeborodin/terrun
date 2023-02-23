import 'command.dart';

class CommandMatcher {
  Command? getFromTree(Map<String, Command> commands, String key) {
    final selected = commands[key];
    if (selected != null && !selected.isGroup) {
      return selected;
    }
    return null;
  }

  int getPotentialMatches(Map<String, Command> commands, String key) => commands.keys
      .where(
        (shortcut) => shortcut.startsWith(key),
      )
      .length;
}
