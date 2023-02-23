import '../../core/core.dart';

abstract class DisplayService {
  void drawMatchingCommands(
    String input,
    Map<String, Command> commands,
  );
  void init();
  void clear();
}
