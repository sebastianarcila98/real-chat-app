import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(this.message, this.isCurrentUser);
  final String message;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 7.5, vertical: 7.5),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).accentColor,
          ),
          child: Text(
            message,
            style: Theme.of(context).accentTextTheme.headline6,
          ),
        ),
      ],
    );
  }
}
