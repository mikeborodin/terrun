// ignore_for_file: unnecessary_string_escapes

final defaultsYaml=r'''commands:
  j:
    name: apps
    children:
      j:
        name: Chrome
        command: open -a Google\ Chrome.app
      t:
        name: Telegram
        command: open -a telegram
      p:
        name: Spotify
        command: open -a spotify
      k:
        name: Slack
        command: open -a slack
      d:
        name: VSCode
        command: open -a Visual\ Studio\ Code.app

  # todo(user): customize it
  # f:
  #   name: projects
  #   children:
  #     a:
  #       name: project a
  #       command: code ~/path/to/my_projects/a
  #     b:
  #       name: project b
  #       command: code ~/path/to/my_projects/b

# hooks:
  # preRun:
    # - command: osascript -e "tell application \"System Events\" to key code 24 using {shift down, control down}"
  # postRun:
    # - command: say "good job $USER"
''';
