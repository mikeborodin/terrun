// https://raw.github.com/google/ansicolor-dart/master/ansicolor-dart.png

//will be configurable in yaml later
class Theme {
  final int error;
  final int success;
  final int info;

  Theme({
    required this.error,
    required this.success,
    required this.info,
  });
}
