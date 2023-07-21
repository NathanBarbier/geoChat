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
  TextEditingController messageSend = TextEditingController();
  FirestoreHelper firestoreHelper = FirestoreHelper();
  List<Map<dynamic, dynamic>> messages = [];

  @override
  void initState() {
    me.messagerie!.forEach((message) {
      if(message["DESTINATAIRE"] == widget.user.id) {
        messages.add(message);
      }
    });

    widget.user.messagerie!.forEach((message) {
      if(message["DESTINATAIRE"] == me.id) {
        messages.add(message);
      }
    });

    messages.sort((a, b) {
      return a["DATE"].compareTo(b["DATE"]);
    });

    print(messages);

    super.initState();
  }

  onSendMessage(messageTexte) {
    setState(() {
      Map<String, dynamic> message = {
        "MESSAGE": messageTexte,
        "DATE": DateTime.now(),
        "DESTINATAIRE": widget.user.id,
      };

      me.messagerie!.add(message);
      messages.add(message);

      Map<String, dynamic> map = {
        "MESSAGERIE": me.messagerie
      };

      FirestoreHelper().updateUser(me.id, map);
    });
  }

  void simulateReceiveMessage() {
    setState(() {
      Map<String, dynamic> newMessage = {
        "MESSAGE": "Nouveau message reçu",
        "DATE": DateTime.now(),
        "DESTINATAIRE": me.id, // Mettez l'ID du destinataire ici
      };

      receiveMessage(newMessage);
    });
  }

  void receiveMessage(Map<String, dynamic> message) {
    setState(() {
      messages.add(message);
      messages.sort((a, b) {
        return a["DATE"].compareTo(b["DATE"]);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.user.fullname),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(messages[index]);
              },
            ),
          ),
          TextField(
            controller: messageSend,
            decoration: InputDecoration(
              hintText: 'Saisir un message...',
              border: OutlineInputBorder(),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (messageSend.text.trim().isNotEmpty) {
                onSendMessage(messageSend.text);
                messageSend.clear();
              }
            },
            child: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }

}
