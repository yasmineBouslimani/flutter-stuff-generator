import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

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
      theme: ThemeData(primarySwatch: Colors.pink),
      home: const RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestions = [];
  final _favoriteList = <WordPair>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Génération de nom de start-up"),
        actions: [
          IconButton(onPressed: _pushFavoris, icon: const Icon(Icons.favorite)),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushFavoris() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      final words = _favoriteList.map((pair) {
        return ListTile(
            title: Text(pair.asPascalCase,
                style: const TextStyle(fontSize: 18.0)));
      });

      final favorisWords = words.isNotEmpty
          ? ListTile.divideTiles(context: context, tiles: words).toList()
          : <Widget>[];
      return Scaffold(
        appBar: AppBar(
          title: const Text("Favoris"),
        ),
        body: ListView(children: favorisWords),
      );
    }));
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(15),
      itemBuilder: (context, index) {
        if (index.isOdd) {
          return const Divider(thickness: 2);
        }
        final i = index ~/ 2;
        if (i >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return buildRow(_suggestions[i]);
      },
    );
  }

  Widget buildRow(WordPair pair) {
    final alreadySaved = _favoriteList.contains(pair);
    return ListTile(
        title: Text(pair.asPascalCase, style: const TextStyle(fontSize: 18.0)),
        trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
            color: Colors.red),
        onTap: () {
          setState(() {
            if (alreadySaved) {
              _favoriteList.remove(pair);
            } else {
              _favoriteList.add(pair);
            }
          });
        });
  }
}
