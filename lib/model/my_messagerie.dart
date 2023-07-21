import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geo_chat/model/message.dart';

import '../globale.dart';
import 'my_user.dart';

class MyMessagerie {
  late String id;
  Map<String, dynamic>? messagerie;

  MyMessagerie.new() {
    id = "";
  }

  MyMessagerie.get(DocumentSnapshot snapshot) {
    id = snapshot.id;
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    messagerie = map["MESSAGERIE"] ?? [];
  }
}