import '../../core/core.dart';

enum MessageType {
  info,
  success,
  error,
}

abstract class DisplayService {
  void drawMatchingCommands(
    String input,
    Map<String, Command> commands,
  );
  void init();
  void clear();
  void drawMessage(
    String message, {
    MessageType? type = MessageType.info,
  });
}
