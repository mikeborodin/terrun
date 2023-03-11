yaml=`cat terrun.starter.yaml`

echo "// ignore_for_file: unnecessary_string_escapes

final defaultsYaml=r'''$yaml
''';" > lib/features/configure/defaults.dart
