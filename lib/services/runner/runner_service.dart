import 'package:terrun/core/core.dart';

abstract class RunnerService {
  Future<String> run(String command, Hooks hooks);
}
