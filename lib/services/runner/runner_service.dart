import 'package:menusc/core/core.dart';

abstract class RunnerService {
  Future<String> run(String command, Hooks hooks);
}
