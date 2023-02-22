import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:real_chat_app/widgets/chat/message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('chat')
          .orderBy('createdAt')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        final doc = snapshot.data.documents;
        return ListView.builder(
          itemCount: doc.length,
          itemBuilder: (context, index) {
            return Container(
              child: MessageBubble(doc[index]['text'], true),
            );
          },
        );
      },
    );
  }
}
