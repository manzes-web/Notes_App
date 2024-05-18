import 'package:flutter/material.dart';
import 'package:notes_app/Pages/note_page.dart';
import 'package:notes_app/Themes/theme_provider.dart';
import 'package:notes_app/models/note_database.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => NoteDatabase(),
      ),
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const NotePage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
