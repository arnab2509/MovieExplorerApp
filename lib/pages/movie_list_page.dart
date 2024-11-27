import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import 'movie_detail_page.dart';

class MovieListPage extends StatefulWidget {
  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Fetch initial movies
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MovieProvider>(context, listen: false).fetchMovies();
    });

    // Setup scroll listener for pagination
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final provider = Provider.of<MovieProvider>(context, listen: false);
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      if (!provider.isLoading && provider.hasMorePages) {
        provider.fetchMovies();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search movies...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    final query = _searchController.text.trim();
                    if (query.isNotEmpty) {
                      Provider.of<MovieProvider>(context, listen: false).searchMovies(query);
                    }
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Consumer<MovieProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.movies.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${provider.error}'),
                  ElevatedButton(
                    child: const Text('Retry'),
                    onPressed: () => provider.fetchMovies(reset: true),
                  ),
                ],
              ),
            );
          }

          if (provider.movies.isEmpty) {
            return Center(
              child: Text(
                'No movies found',
               // style: Theme.of(context).textTheme.headline6,
              ),
            );
          }

          return ListView.builder(
            controller: _scrollController,
            itemCount: provider.movies.length + (provider.isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == provider.movies.length) {
                return const Center(child: CircularProgressIndicator());
              }

              final movie = provider.movies[index];
              return ListTile(
                leading: movie.posterPath != null && movie.posterPath.isNotEmpty
                    ? Image.network(
                        movie.posterPath,
                        width: 50,
                        height: 75,
                        fit: BoxFit.cover,
                      )
                    : const SizedBox(width: 50, height: 75),
                title: Text(movie.title),
                subtitle: Text(
                  'Release: ${movie.releaseDate} | '
                  'Rating: ${movie.voteAverage.toStringAsFixed(1)}/10',
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailPage(movie: movie),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
