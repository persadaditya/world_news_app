import 'package:flutter/material.dart';

class Source extends StatefulWidget {
  @override
  _SourceState createState() => _SourceState();
}

class _SourceState extends State<Source> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("this is source data"),
      ),
    );
  }
}
