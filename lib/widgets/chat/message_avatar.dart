import 'package:flutter/material.dart';

class MessageAvatar extends StatelessWidget {
  const MessageAvatar(
    this.message,
    this.date,
    this.userName,
    this.userImage,
    this.isMe, {
    super.key,
  });

  final String message;
  final String userName;
  final String userImage;
  final String date;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isMe
                    ? Colors.blue
                    : Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: isMe
                      ? const Radius.circular(12)
                      : const Radius.circular(0),
                  topRight: isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                  bottomLeft: const Radius.circular(12),
                  bottomRight: const Radius.circular(12),
                ),
              ),
              width: 180,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        userName,
                        style: style(context),
                      ),
                      Text(
                        date,
                        style: style(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    message,
                    style: TextStyle(
                      color: isMe
                          ? Colors.white
                          : Theme.of(context).textTheme.titleSmall!.color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
            top: 2,
            left: isMe ? null : 5,
            right: isMe ? 5 : null,
            child: CircleAvatar(
              backgroundImage: NetworkImage(userImage),
            ))
      ],
    );
  }

  TextStyle style(BuildContext context) {
    return TextStyle(
        fontWeight: FontWeight.bold,
        color: isMe
            ? Colors.white
            : Theme.of(context).textTheme.titleSmall!.color);
  }
}
