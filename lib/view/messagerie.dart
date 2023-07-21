import 'package:flutter/material.dart';
import 'package:geo_chat/controller/chat_bubble.dart';
import 'package:geo_chat/controller/firestore_helper.dart';

import '../globale.dart';
import '../model/my_user.dart';

class MyMessagerie extends StatefulWidget {
  final MyUser user;
  const MyMessagerie({super.key, required this.user});

  @override
  State<MyMessagerie> createState() => _MyMessagerieState();
}

class _MyMessagerieState extends State<MyMessagerie> {
  TextEditingController message = TextEditingController();
  FirestoreHelper firestoreHelper = FirestoreHelper();
  List<Map<dynamic, dynamic>> messages = [];

  @override
  void initState() {
    me.messagerie!.forEach((message) {
      if(message["destinataire"] == widget.user.id) {
        messages.add(message);
      }
    });

    widget.user.messagerie!.forEach((message) {
      if(message["destinataire"] == me.id) {
        messages.add(message);
      }
    });

    messages.sort((a, b) {
      return a["date"].compareTo(b["date"]);
    });

    print(messages);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.user.fullname),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return ChatBubble(messages[index]);
        },
      ),

    );
  }
}
