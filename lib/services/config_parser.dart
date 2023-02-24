import 'package:menusc/core/core.dart';
import 'package:yaml/yaml.dart';

class ConfigParser {
  Map<String, Command> parse(String file) {
    final doc = loadYamlDocument(file);
    final map = doc.contents.value as YamlMap;

    final list = _parseChildren('', map.value['commands'] as YamlMap);
    final parsedMap = Map.fromEntries(list);

    return parsedMap;
  }

  List<MapEntry<String, Command>> _parseChildren(
    String parentPath,
    YamlMap map,
  ) {
    var shellCommand = map['command'] as String?;
    var children = map['children'] as YamlMap?;
    var name = map['name'] as String?;

    if (shellCommand != null) {
      return [
        MapEntry(
          parentPath,
          Command(
            name: name ?? 'N/A',
            isGroup: false,
            script: shellCommand,
          ),
        ),
      ];
    } else if (children != null) {
      final parsedChildren = children.entries
          .map(
            (entry) => _parseChildren(
              parentPath + entry.key,
              entry.value as YamlMap,
            ),
          )
          .expand((pair) => pair);

      return [
        MapEntry(
          parentPath,
          Command(
            name: name!,
            isGroup: true,
            script: null,
          ),
        ),
        ...parsedChildren.toList(),
      ];
    } else if (map.keys.isNotEmpty) {
      final parsedChildren = map.entries
          .map(
            (entry) => _parseChildren(
              parentPath + entry.key,
              entry.value as YamlMap,
            ),
          )
          .expand((pair) => pair);
      return parsedChildren.toList();
    }
    throw Exception('could not parse $map');
  }
}
