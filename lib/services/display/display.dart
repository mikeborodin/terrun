import 'package:riverpod/riverpod.dart';

import 'console_display_service.dart';
import 'display_service.dart';

export 'console_display_service.dart';
export 'display_service.dart';
export 'colored_string_ext.dart';

final displayServiceProvider = Provider<DisplayService>(
  (ref) => ConsoleDisplaySevice(),
);
