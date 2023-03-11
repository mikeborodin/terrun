import 'dart:io';

export 'shell_service_impl.dart';

abstract class ShellService {
  Future<ProcessResult> run(String commands);
}
