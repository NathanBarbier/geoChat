import 'package:flutter/material.dart';

import '../globale.dart';

class ChatBubble extends StatelessWidget {
  final Map<dynamic, dynamic> message;

  ChatBubble(this.message);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      alignment: message["DESTINATAIRE"] == me.id ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: message["DESTINATAIRE"] == me.id ? Colors.grey[300] : Colors.blue,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          message["MESSAGE"],
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}