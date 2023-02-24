import 'package:ansicolor/ansicolor.dart';

extension ColoredStringExt on String {
  String colored(int code) {
    return (AnsiPen()..xterm(code)).call(this);
  }
}
