import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../chat/message_bubble.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        var chatDocs = chatSnapshot.data.docs;
        return ListView.builder(
          reverse: true,
          itemBuilder: (context, index) {
            return MessageBubble(
              chatDocs[index].get('text'),
              chatDocs[index].get('userId') ==
                  FirebaseAuth.instance.currentUser.uid,
              chatDocs[index].get('username'),
              key: ValueKey(chatDocs[index].documentID),
            );
          },
          itemCount: chatDocs.length,
        );
      },
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
    );
  }
}
