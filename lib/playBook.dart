import 'package:flutter/material.dart';

class PlayBook extends StatefulWidget {
  @override
  _PlayBookState createState() => _PlayBookState();
}

class _PlayBookState extends State<PlayBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to first screen when tapped.
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
