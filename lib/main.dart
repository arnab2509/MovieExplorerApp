import 'package:flutter/material.dart';
// import 'package:movie_explorer/config/api_config.dart';
import 'package:movie_explorer/pages/landing_page.dart';
import 'package:movie_explorer/providers/movie_provider.dart';
import 'package:movie_explorer/services/movie_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MovieProvider(
            MovieService(
              apiKey: movieService.apiKey,
              baseUrl: movieService.baseUrl
            )
        // MovieService()
          ),
        ),
      ],
      child: MovieExplorerApp(),
    ),
  );
}

class MovieExplorerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Explorer',
      
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LandingPage(),
    );
  }
}