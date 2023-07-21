import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geo_chat/model/message.dart';

import '../globale.dart';
import 'my_user.dart';

class MyMessagerie {
  late String id;
  late String idUser;
  List<MyMessage>? messages;

  MyMessagerie.new(MyUser destinataire) {
    id = "";
    idUser = me.id;
    destinataire = destinataire;
  }

  MyMessagerie.get(DocumentSnapshot snapshot) {
    id = snapshot.id;
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    idUser = map["IDUSER"];
    messages = map["MESSAGES"] ?? [];
  }
}