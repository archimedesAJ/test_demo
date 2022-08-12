import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class SchoolSelection extends StatefulWidget {
  const SchoolSelection({Key? key}) : super(key: key);

  @override
  State<SchoolSelection> createState() => _SchoolSelectionState();
}

class _SchoolSelectionState extends State<SchoolSelection> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0D47A1),
        title: Center(
          child: Text("School Selection"),
        ),
        leading: Icon(Icons.home),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              print("Page  is refreshed!");
            },
          )
        ],
      ),
      body: SafeArea(child: Column()),
    ));
  }
}
