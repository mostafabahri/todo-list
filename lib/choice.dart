enum ChoiceAction { Delete }

class Choice {
  const Choice({this.title, this.action});

  final String title;
  final ChoiceAction action;
}
