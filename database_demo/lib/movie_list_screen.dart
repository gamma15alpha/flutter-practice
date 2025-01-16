import 'dart:io';

import 'package:flutter/material.dart';
import '../movie.dart';
import '../database_helper.dart';
import '../movie_dialog.dart';

class MovieListScreen extends StatefulWidget {
  final Function toggleTheme;

  const MovieListScreen({Key? key, required this.toggleTheme}) : super(key: key);

  @override
  MovieListScreenState createState() => MovieListScreenState();
}

class MovieListScreenState extends State<MovieListScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Movie> _movies = [];

  @override
  void initState() {
    super.initState();
    _refreshMovies();
  }

  Future<void> _refreshMovies() async {
    final movies = await _dbHelper.getMovies();
    setState(() {
      _movies = movies;
    });
  }

  void _deleteMovie(int id) async {
    await _dbHelper.deleteMovie(id);
    _refreshMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie List'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () => widget.toggleTheme(),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _movies.length,
        itemBuilder: (BuildContext itemContext, int index) {
          final movie = _movies[index];
          return ListTile(
            leading: movie.imagePath != null
                ? Image.file(File(movie.imagePath!), width: 50, height: 50, fit: BoxFit.cover)
                : Icon(Icons.movie),
            title: Text(movie.title),
            subtitle: Text('${movie.genre} (${movie.year})'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) => MovieDialog(movie: movie, onSave: () {
                      _refreshMovies();
                    }),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteMovie(movie.id!),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext dialogContext) => MovieDialog(onSave: () {
            _refreshMovies();
          }),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}