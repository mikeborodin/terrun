import 'dart:convert';
import 'dart:io';

Future<void> app(List<String> args) async {
  while (true) {
    String buffer = '';
    while (buffer.length < 3) {
      stdin.echoMode = false;
      stdin.echoNewlineMode = false;
      stdin.lineMode = false;
      final letter = utf8.decode([stdin.readByteSync()]);
      buffer += letter;
      print("\x1B[2J\x1B[0;0H");
      stdout.writeln('Typing: $buffer');
    }
    stdout.writeln('');
    stdout.writeln('executed command:$buffer');
  }
}
