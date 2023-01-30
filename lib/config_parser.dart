import 'package:yaml/yaml.dart';

class ConfigParser {
  Map<String, String> parse(String file) {
    final doc = loadYamlDocument(file);
    final map = doc.contents.value as YamlMap;

    final list = _parseChildren('', map.value['commands'] as YamlMap);
    final parsedMap = Map.fromEntries(list);

    return parsedMap;
  }

  List<MapEntry<String, String>> _parseChildren(
    String parentPath,
    YamlMap map,
  ) {
    var shellCommand = map['command'] as String?;
    var children = map['children'] as YamlMap?;
    var name = map['name'] as String?;

    if (shellCommand != null) {
      return [
        MapEntry(parentPath, name ?? 'no name'),
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
        MapEntry(parentPath, name!),
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
