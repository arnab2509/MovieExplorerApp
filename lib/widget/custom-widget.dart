// lib/styles/movie_detail_text_styles.dart
import 'package:flutter/material.dart';

class MovieDetailTextStyles {
  // Private constructor to prevent instantiation
  MovieDetailTextStyles._();

  // Movie Title Style
  static TextStyle movieTitle(BuildContext context) => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
        letterSpacing: 0.5,
      );

  // Metadata Styles (Release Date, Rating)
  static TextStyle metadataText(BuildContext context) => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black54,
        letterSpacing: 0.3,
      );

  // Section Header Style
  static TextStyle sectionHeader(BuildContext context) => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
        letterSpacing: 0.4,
      );

  // Overview Text Style
  static TextStyle overviewText(BuildContext context) => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.black87,
        height: 1.6,
        letterSpacing: 0.2,
      );

  // Styled Text Widgets
  static Widget title(String text, BuildContext context) {
    return Text(
      text,
      style: movieTitle(context),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  static Widget metadata(String text, BuildContext context) {
    return Text(
      text,
      style: metadataText(context),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  static Widget sectionTitle(String text, BuildContext context) {
    return Text(
      text,
      style: sectionHeader(context),
      maxLines: 1,
    );
  }

  static Widget overview(String text, BuildContext context) {
    return Text(
      text,
      style: overviewText(context),
    );
  }
}