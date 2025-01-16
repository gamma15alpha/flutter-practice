import 'dart:io';

import 'package:database_demo/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../movie.dart';

class MovieDialog extends StatefulWidget {
  final Movie? movie;
  final VoidCallback onSave;

  const MovieDialog({Key? key, this.movie, required this.onSave}) : super(key: key);

  @override
  _MovieDialogState createState() => _MovieDialogState();
}

class _MovieDialogState extends State<MovieDialog> {
  late TextEditingController _titleController;
  late TextEditingController _genreController;
  late TextEditingController _yearController;
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.movie?.title ?? '');
    _genreController = TextEditingController(text: widget.movie?.genre ?? '');
    _yearController = TextEditingController(text: widget.movie?.year.toString() ?? '');
    _imagePath = widget.movie?.imagePath;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.movie == null ? 'Add Movie' : 'Edit Movie'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _genreController,
              decoration: InputDecoration(labelText: 'Genre'),
            ),
            TextField(
              controller: _yearController,
              decoration: InputDecoration(labelText: 'Year'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            _imagePath != null
                ? Image.file(File(_imagePath!), height: 100)
                : Text('No Image Selected'),
            TextButton(
              onPressed: () async {
                final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  setState(() {
                    _imagePath = pickedFile.path;
                  });
                }
              },
              child: Text('Choose Image'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            final title = _titleController.text;
            final genre = _genreController.text;
            final year = int.tryParse(_yearController.text) ?? 0;

            if (title.isNotEmpty && genre.isNotEmpty && year > 0) {
              final newMovie = Movie(
                id: widget.movie?.id,
                title: title,
                genre: genre,
                year: year,
                imagePath: _imagePath,
              );

              if (widget.movie == null) {
                await DatabaseHelper().insertMovie(newMovie);
              } else {
                await DatabaseHelper().updateMovie(newMovie);
              }
              widget.onSave();
              Navigator.pop(context);
            }
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
