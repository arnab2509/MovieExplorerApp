import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/movie_model.dart';

class MovieService {
  final String apiKey;
  final String baseUrl;


  MovieService({required this.apiKey, required this.baseUrl});

  Future<Map<String, dynamic>> fetchMovies({
    int page = 1, // OMDb doesn't support pagination, but you can implement it manually.
    String query = '',
  }) async {
    try {
      if (query.isEmpty) {
        throw Exception('Query cannot be empty for OMDb API');
      }

      // OMDb API endpoint for searching movies
      final Uri url = Uri.parse('$baseUrl/?apikey=$apiKey&s=$query&page=$page');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['Response'] == "True") {
          return {
            'movies': (data['Search'] as List)
                .map((movieJson) => Movie.fromJson(movieJson))
                .toList(),
            'totalResults': int.parse(data['totalResults']),
          };
        } else {
          throw Exception('Error: ${data['Error']}');
        }
      } else {
        throw Exception('Failed to load movies: ${response.body}');
      }
    } catch (e) {
      print(e);
      throw Exception('Network error: $e');
    }
  }

  Future<Movie> fetchMovieDetails(String imdbId) async {
    try {
      // OMDb API endpoint for fetching movie details by IMDb ID
      final Uri url = Uri.parse('$baseUrl/?apikey=$apiKey&i=$imdbId');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['Response'] == "True") {
          return Movie.fromJson(data);
        } else {
          throw Exception('Error: ${data['Error']}');
        }
      } else {
        throw Exception('Failed to load movie details: ${response.body}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
final movieService = MovieService(
  apiKey: 'Write_your_api_key',
  baseUrl: 'https://www.omdbapi.com',
);
