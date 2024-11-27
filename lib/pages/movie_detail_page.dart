import 'package:flutter/material.dart';
import 'package:movie_explorer/widget/custom-widget.dart';
import '../models/movie_model.dart';


class MovieDetailPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailPage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster Image
            movie.posterPath.isNotEmpty
              ? Image.network(
                  movie.posterPath,
                  width: double.infinity,
                  height: 500,
                  fit: BoxFit.cover,
                )
              : SizedBox.shrink(),

            // Movie Details
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Movie Title
                  MovieDetailTextStyles.title(movie.title, context),
                  SizedBox(height: 10),

                  // Release Date
                  MovieDetailTextStyles.metadata(
                    'Release Date: ${movie.releaseDate}', 
                    context
                  ),
                  SizedBox(height: 10),

                  // Rating
                  MovieDetailTextStyles.metadata(
                    'Rating: ${movie.voteAverage.toStringAsFixed(1)}/10', 
                    context
                  ),
                  SizedBox(height: 20),

                  // Overview Section Title
                  MovieDetailTextStyles.sectionTitle('Overview', context),
                  SizedBox(height: 10),

                  // Overview Text
                  MovieDetailTextStyles.overview(movie.overview, context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}