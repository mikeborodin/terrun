import 'dart:io';

import 'package:terrun/services/shell/shell_service.dart';

class ShellServiceImpl implements ShellService {
  @override
  Future<ProcessResult> run(String commands) async {
    final shell = Platform.environment['SHELL'] ?? 'bash';
    final result = await Process.run(shell, [
      '-c',
      commands,
    ]);
    return result;
  }
}
