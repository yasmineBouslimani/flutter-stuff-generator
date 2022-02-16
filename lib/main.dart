import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome to Flutter',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Générateur de nom de start-up'),
        ),
        body: const Center(
          child: RandomWords()
        ),
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();

    return  Text(wordPair.asCamelCase,
      style: const TextStyle(
        fontFamily: 'Allison',
        fontWeight: FontWeight.bold,
        fontSize: 80,
      ),);
  }
}

