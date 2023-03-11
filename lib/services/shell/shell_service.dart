import 'dart:io';

abstract class ShellService {
  Future<ProcessResult> run(String commands);
}
