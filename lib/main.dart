import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:text_editing_controller_study/models/note.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NotesScreen(),
    );
  }
}

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final String? notesString = prefs.getString('notes');
    if (notesString != null) {
      final List<dynamic> notesJson = jsonDecode(notesString);
      setState(() {
        notes = notesJson.map((json) => Note.fromJson(json)).toList();
      });
    }
  }

  Future<void> _saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final String notesString = jsonEncode(notes.map((note) => note.toJson()).toList());
    await prefs.setString('notes', notesString);
  }

  void _addOrEditNote([Note? note]) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NoteEditorScreen(
          note: note,
          onSave: (label, text) {
            setState(() {
              if (note == null) {
                notes.add(Note(label: label, text: text));
              } else {
                note.label = label;
                note.text = text;
              }
              _saveNotes();
            });
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  void _deleteNote(Note note) {
    setState(() {
      notes.remove(note);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Заметки')),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return ListTile(
            title: Text(note.label),
            subtitle: Text(note.text),
            onTap: () => _addOrEditNote(note),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteNote(note),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _addOrEditNote(),
      ),
    );
  }
}

class NoteEditorScreen extends StatelessWidget {
  final Note? note;
  final Function(String label, String text) onSave;

  final TextEditingController labelController;
  final TextEditingController textController;

  NoteEditorScreen({
    Key? key,
    this.note,
    required this.onSave,
  })  : labelController = TextEditingController(text: note?.label ?? ''),
        textController = TextEditingController(text: note?.text ?? ''),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(note == null ? 'Добавить заметку' : 'Изменение заметки')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: labelController,
              decoration: const InputDecoration(labelText: 'Заголовок'),
            ),
            TextField(
              controller: textController,
              decoration: const InputDecoration(labelText: 'Текст заметки'),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onSave(labelController.text, textController.text);
              },
              child: const Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }
}
