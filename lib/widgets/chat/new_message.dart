import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage();

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  var _newMessage = '';

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    _controller.clear();
    final _auth = await FirebaseAuth.instance.currentUser();
    final userData =
        await Firestore.instance.collection('users').document(_auth.uid).get();
    Firestore.instance.collection('chat').add({
      'text': _newMessage,
      'createdAt': Timestamp.now(),
      'userId': _auth.uid,
      'username': userData['username'],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: 'Send a message...'),
              controller: _controller,
              onChanged: (value) {
                setState(() {
                  _newMessage = value;
                });
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _newMessage.isEmpty ? null : _sendMessage,
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
