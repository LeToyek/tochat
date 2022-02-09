import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String text, sender;
  final bool isMyChat;
  MessageBubble(
      {required this.text, required this.sender, required this.isMyChat});

  final bubbleBorderRadius = BorderRadius.only(
    topLeft: Radius.circular(20),
    bottomRight: Radius.circular(20),
    topRight: Radius.circular(20),
  );
  final otherBorderRadius = BorderRadius.only(
    topRight: Radius.circular(20),
    topLeft: Radius.circular(20),
    bottomLeft: Radius.circular(20),
  );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment:
            isMyChat ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
          InkWell(
            onLongPress: () => showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: Text('delete'),
                    )),
            child: Material(
              color: isMyChat ? Colors.blue : Colors.white,
              borderRadius: isMyChat ? otherBorderRadius : bubbleBorderRadius,
              elevation: 5.0,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Text(
                  text,
                  style: TextStyle(
                    color: isMyChat ? Colors.white : Colors.black54,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
