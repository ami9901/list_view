import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ListDisplay());
  }
}

class ListDisplay extends StatefulWidget {
  @override
  _ListDisplayState createState() => _ListDisplayState();
}

class _ListDisplayState extends State<ListDisplay> {
  final List<WordPair> _words = <WordPair>[];
  final _saved = Set<WordPair>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List View In Flutter'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildWords(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          final tiles = _saved.map(
            (WordPair pair) => _buildRow(pair),
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
            //color: Colors.black
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  Widget _buildWords() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: (BuildContext _context, int i) {
          //following loop only returns divider on odd indexes
          if (i.isOdd) {
            //print("odd index: " + i.toString());
            return Divider(); // returns divider and exits the itemBuilder loop
          }
          //for even indexes:
          final int index = i ~/ 2;
          //print("index: " + index.toString());

          // we generate more 10 words and add it to the list,here, on index=0, words.length becomes 10 and for 10 iterations
          // the following if loop is false, not generating further word pairs and just returning ListTile.
          if (index >= _words.length) {
            _words.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_words[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(
        pair); // contains() returns a bool value checking if the value exists in the _saved set
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
}
