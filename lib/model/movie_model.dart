class Movie {
  final int id;
  final String title;
  final String backdrop_path;
  final String poster_path;
  final String release_date;
  final String vote_average;
  final String overview;

  Movie(
      {required this.backdrop_path,
      required this.id,
      required this.title,
      required this.poster_path,
      required this.overview,
      required this.release_date,
      required this.vote_average});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        backdrop_path: json['backdrop_path'] ?? '',
        id: json['id'],
        title: json['title'] ?? '',
        poster_path: json['poster_path'] ?? '',
        overview: json['overview'] ?? '',
        release_date: json['release_date'] ?? '',
        vote_average: json['vote_average'].toString());
  }
}
