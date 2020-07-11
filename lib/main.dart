import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('List View In Flutter'),
        ),
        body: ListDisplay(),
      ),
    );
  }
}

class ListDisplay extends StatefulWidget {
  @override
  _ListDisplayState createState() => _ListDisplayState();
}

class _ListDisplayState extends State<ListDisplay> {
  final List<WordPair> _words = <WordPair>[];
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: (BuildContext _context, int i) {
          //following loop only returns divider on odd indexes
          if (i.isOdd) {
            print("odd index: " + i.toString());
            return Divider(); // returns divider and exits the itemBuilder loop
          }
          //for even indexes:
          final int index = i ~/ 2;
          print("index: " + index.toString());
          //printing all word pairs generated at a take of 10 and then when the end of list reached, index>=words.length,
          // we generate more 10 words and add it to the list,here, on index=0, words.length becomes 10 and for 10 iterations
          // the following if loop is false, not generating further word pairs and just returning ListTile.
          if (index >= _words.length) {
            _words.addAll(generateWordPairs().take(10));
          }
          return ListTile(
            title: Text(
              _words[index].asPascalCase,
              style: _biggerFont,
            ),
          );
        });
  }
}
