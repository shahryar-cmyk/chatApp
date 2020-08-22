import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, i) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('This works'),
        ),
        itemCount: 10,
      ),
    );
  }
}
