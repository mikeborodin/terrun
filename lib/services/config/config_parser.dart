import 'package:menusc/core/core.dart';
import 'package:yaml/yaml.dart';

class ConfigParser {
  Config parse(String file) {
    final document = loadYamlDocument(file);
    final map = document.contents.value as YamlMap;

    final parsedMap = _parseCommands(map);
    final hooks = _parseHooks(map);

    return Config(
      hooks: hooks,
      commands: parsedMap,
    );
  }

  Hooks _parseHooks(YamlMap map) {
    final hooksYaml = map.value['hooks'] as YamlMap;
    var hooks = Hooks(
      (hooksYaml.value['preCommand'] as YamlList).nodes.map(
        (yamlHook) {
          final yaml = yamlHook.value as YamlMap;
          return PreCommandHook(yaml.value['command'] as String);
        },
      ).toList(),
    );
    return hooks;
  }

  Map<String, Command> _parseCommands(YamlMap map) {
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
