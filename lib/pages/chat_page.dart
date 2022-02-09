import 'package:flutter/material.dart';
import 'package:tochat/pages/login_page.dart';

class ChatPage extends StatefulWidget {
  static const String id = 'chat_page';

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room'),
        actions: [
          IconButton(
              tooltip: 'Logout',
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, LoginPage.id),
              icon: Icon(Icons.close)),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: Placeholder()),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                  child: TextField(
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    border: OutlineInputBorder()),
              )),
              SizedBox(
                width: 8,
              ),
              MaterialButton(
                onPressed: () {},
                child: Text('Send'),
                color: Colors.blue,
                textTheme: ButtonTextTheme.primary,
              )
            ],
          )
        ],
      ),
    );
  }
}
