import 'package:flutter/foundation.dart';
import '../models/movie_model.dart';
import '../services/movie_service.dart';

class MovieProvider with ChangeNotifier {
  final MovieService _movieService;

  MovieProvider(this._movieService);

  List<Movie> _movies = [];
  bool _isLoading = false;
  String _error = '';
  int _currentPage = 1;
  int _totalResults = 0;
  String _searchQuery = '';

  List<Movie> get movies => _movies;
  bool get isLoading => _isLoading;
  String get error => _error;
  bool get hasMorePages =>
      _movies.length < _totalResults; // OMDb doesn't provide total pages.

  Future<void> fetchMovies({bool reset = false}) async {
    if (reset) {
      _currentPage = 1;
      _movies.clear();
      _totalResults = 0;
    }

    if (!hasMorePages && !reset) return;

    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final result = await _movieService.fetchMovies(
        page: _currentPage,
        query: _searchQuery,
      );
      print('result');
      print(result);
      final newMovies = result['movies'] as List<Movie>;
      _totalResults = result['totalResults'];

      if (reset) {
        _movies = newMovies;
      } else {
        _movies.addAll(newMovies);
      }

      _currentPage++;
      _isLoading = false;
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
    }

    notifyListeners();
  }

  Future<void> searchMovies(String query) async {
    _searchQuery = query;
    await fetchMovies(reset: true);
  }
}
