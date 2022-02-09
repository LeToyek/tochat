import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tochat/pages/login_page.dart';
import 'package:tochat/widget/message_bubble.dart';

class ChatPage extends StatefulWidget {
  static const String id = 'chat_page';

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  User? _activeUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WA nendang'),
        actions: [
          IconButton(
              tooltip: 'Logout',
              onPressed: () async {
                await _auth.signOut();
                Navigator.pushReplacementNamed(context, LoginPage.id);
              },
              icon: Icon(Icons.close)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: _firestore
                      .collection('messages')
                      .orderBy('dateCreated', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView(
                      reverse: true,
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 16.0,
                      ),
                      children: snapshot.data!.docs.map((document) {
                        final messageText = document.data()['text'];
                        final messageSender = document.data()['sender'];
                        return MessageBubble(
                          text: messageText,
                          sender: messageSender,
                          isMyChat: messageSender == _activeUser?.email,
                        );
                      }).toList(),
                    );
                  })),
          Padding(
            padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: _messageTextController,
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      border: OutlineInputBorder()),
                )),
                SizedBox(
                  width: 8,
                ),
                InkWell(
                  onTap: () {
                    if (_messageTextController.text.isEmpty) {
                    } else {
                      _firestore.collection('messages').add({
                        'text': _messageTextController.text,
                        'sender': _activeUser?.email,
                        'dateCreated': Timestamp.now()
                      });
                      _messageTextController.clear();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.blue),
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void getCurrentUser() async {
    try {
      var currentUser = await _auth.currentUser;
      if (currentUser != null) {
        _activeUser = currentUser;
      }
    } catch (e) {
      print(e);
    }
  }
}
