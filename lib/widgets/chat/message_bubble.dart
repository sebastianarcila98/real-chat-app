import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  final String username;
  final String imageUrl;
  final Key key;

  const MessageBubble(
      this.message, this.isCurrentUser, this.username, this.imageUrl,
      {this.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              width: 150,
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: isCurrentUser ? Radius.circular(15) : Radius.zero,
                  bottomRight:
                      !isCurrentUser ? Radius.circular(15) : Radius.zero,
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                color: isCurrentUser
                    ? Colors.grey[300]
                    : Theme.of(context).accentColor,
              ),
              child: Column(
                crossAxisAlignment: isCurrentUser
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: isCurrentUser
                        ? Theme.of(context)
                            .accentTextTheme
                            .headline6
                            .copyWith(color: Colors.black)
                        : Theme.of(context).accentTextTheme.headline6,
                  ),
                  Text(
                    message,
                    textAlign: isCurrentUser ? TextAlign.right : TextAlign.left,
                    style: isCurrentUser
                        ? Theme.of(context)
                            .accentTextTheme
                            .bodyText1
                            .copyWith(color: Colors.black)
                        : Theme.of(context).accentTextTheme.bodyText1,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          left: isCurrentUser ? null : 130,
          right: isCurrentUser ? 130 : null,
          child: CircleAvatar(
            
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(imageUrl),
          ),
        ),
      ],
      clipBehavior: Clip.none,
    );
  }
}
