class Command {
  final String name;
  final bool isGroup;
  final String? script;

  Command({
    required this.name,
    required this.isGroup,
    required this.script,
  });
}
