import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_chat/widgets/chat/message_avatar.dart';

class AllMessages extends StatelessWidget {
  const AllMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.black),
          );
        }
        final chatDocs = chatSnapshot.data!.docs;
        final curUser = FirebaseAuth.instance.currentUser!;
        return ListView.builder(
          itemBuilder: (context, index) => MessageAvatar(
            chatDocs[index]['text'],
            chatDocs[index]['createdAt'].toString(),
            chatDocs[index]['username'],
            chatDocs[index]['userImage'],
            curUser.uid == chatDocs[index]['userId'],
            key: ValueKey(chatDocs[index].id),
          ),
          itemCount: chatDocs.length,
          reverse: true,
        );
      },
    );
  }
}
