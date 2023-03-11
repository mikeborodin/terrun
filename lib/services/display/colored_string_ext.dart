import 'package:ansicolor/ansicolor.dart';

extension ColoredStringExt on String {
  String colored(int code, {int? bg}) {
    final pen = AnsiPen();
    pen.xterm(code);
    if (bg != null) {
      pen.xterm(bg, bg: true);
    }
    return pen(this);
  }
}
