import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:real_chat_app/widgets/chat/message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return StreamBuilder(
          stream: Firestore.instance
              .collection('chat')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (context, mssgSnapshot) {
            if (mssgSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            final doc = mssgSnapshot.data.documents;
            return ListView.builder(
              reverse: true,
              itemCount: doc.length,
              itemBuilder: (context, index) {
                return Container(
                  child: MessageBubble(
                    doc[index]['text'],
                    doc[index]['userId'] == snapshot.data.uid,
                    doc[index]['username'],
                    doc[index]['userImg'],
                    key: ValueKey(doc[index].documentID),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
