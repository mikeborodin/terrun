import 'dart:convert';
import 'dart:io';

import 'package:menusc/config_parser.dart';
import 'package:menusc/config_reader.dart';

Future<void> app(List<String> args) async {
  final config = ConfigReader().read();
  final commands = ConfigParser().parse(config);

  while (true) {
    String buffer = '';
    while (buffer.length < 2) {
      stdin.echoMode = false;
      stdin.echoNewlineMode = false;
      stdin.lineMode = false;
      final letter = utf8.decode([stdin.readByteSync()]);
      buffer += letter;
      print("\x1B[2J\x1B[0;0H");
      stdout.writeln('Typing: $buffer');
      final matchingCommands = commands.entries.where(
        (entry) => entry.key.startsWith(buffer),
      );
      for (final command in matchingCommands) {
        stdout.writeln('[${command.key}] ${command.value}');
      }
    }
    final selectedCommand = commands[buffer];
    if (selectedCommand != null) {
      stdout.writeln('');
      stdout.writeln('executing command:$selectedCommand');
    }
  }
}
