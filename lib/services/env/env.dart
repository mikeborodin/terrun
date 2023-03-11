import 'dart:io';

class Env {
  final String home;
  final String shell;

  Env(
    this.home,
    this.shell,
  );

  factory Env.load() {
    final values = Platform.environment;

    return Env(
      values['HOME']!,
      values['SHELL']!,
    );
  }
}
