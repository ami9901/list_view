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
  List<String> listItem = ['India'];
  final TextEditingController eCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          TextField(
            obscureText: false,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(20.0),
                border: OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                ),
                labelText: 'Enter a country'),
            controller: eCtrl,
            onSubmitted: (text) {
              listItem.add(text);
              eCtrl.clear();
              setState(() {});
            },
            keyboardType: TextInputType.text,
          ),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: new ListView.builder(
                itemCount: listItem.length,
                itemBuilder: (BuildContext context, int index) {
                  return new Text(
                    listItem[index],
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
