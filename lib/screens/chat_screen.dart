import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/chat/messages.dart';
import '../widgets/chat/new_message.dart';

const FIREBASE_PATH = 'chatApp/7FfQOsjCpagrQsn55Yl3/messages';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chat'),
        actions: [
          DropdownButton(
              icon: Icon(
                Icons.more_vert,
                // color: Theme.of(context).iconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.exit_to_app,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text('Logout'),
                      ],
                    ),
                  ),
                  value: 'logout',
                ),
              ],
              onChanged: (itemIndentifier) {
                if (itemIndentifier == 'logout') {
                  return FirebaseAuth.instance.signOut();
                }
              })
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
