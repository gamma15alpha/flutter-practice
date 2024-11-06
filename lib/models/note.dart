class Note {
  String label;
  String text;

  Note({
    required this.label,
    required this.text
  });

  Map<String, dynamic> toJson() => {
    'label': label,
    'text': text,
  };

  static Note fromJson(Map<String, dynamic> json) => Note(
    label: json['label'],
    text: json['text'],
  );
}