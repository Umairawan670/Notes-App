class NoteModel {
  final int? id;
  final String title;
  final String description;

  const NoteModel({
    this.id,
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      "s_no": id,
      "title": title,
      "desc": description,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map["s_no"],
      title: map["title"],
      description: map["desc"],
    );
  }
}