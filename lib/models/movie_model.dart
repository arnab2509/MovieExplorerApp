class Movie {
  final int id;
  final String title;
  final String posterPath;
  final String overview;
  final String releaseDate;
  final double voteAverage;
  final List<String> genres;

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
    required this.genres,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'] ?? 'No Title',
      posterPath: json['poster_path'] != null 
        ? 'https://image.tmdb.org/t/p/w500${json['poster_path']}' 
        : 'https://via.placeholder.com/150',
      overview: json['overview'] ?? 'No description available',
      releaseDate: json['release_date'] ?? 'Unknown',
      voteAverage: (json['vote_average'] as num).toDouble(),
      genres: json['genre_ids'] != null 
        ? List<String>.from(json['genre_ids'].map((id) => id.toString())) 
        : [],
    );
  }
}