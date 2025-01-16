import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'movie_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _theme = 'light';

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _theme = prefs.getString('theme') ?? 'light';
    });
  }

  Future<void> _toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final newTheme = _theme == 'light' ? 'dark' : 'light';
    setState(() {
      _theme = newTheme;
    });
    await prefs.setString('theme', newTheme);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: _theme == 'light' ? ThemeData.light() : ThemeData.dark(),
      home: MovieListScreen(toggleTheme: _toggleTheme),
    );
  }
}