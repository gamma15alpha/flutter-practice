class Movie {
  final int? id;
  final String title;
  final String genre;
  final int year;
  final String? imagePath;

  Movie({this.id, required this.title, required this.genre, required this.year, this.imagePath});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'genre': genre,
      'year': year,
      'imagePath': imagePath,
    };
  }

  static Movie fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      title: map['title'],
      genre: map['genre'],
      year: map['year'],
      imagePath: map['imagePath'],
    );
  }
}
