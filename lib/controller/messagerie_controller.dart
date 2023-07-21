import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:geo_chat/controller/firestore_helper.dart';
import 'package:geo_chat/model/my_messagerie.dart';

import '../globale.dart';
import '../model/my_user.dart';

class MyMessagerieController extends StatefulWidget {
  final MyUser user;
  const MyMessagerieController({super.key, required this.user});

  @override
  State<MyMessagerieController> createState() => _MyMessagerieControllerState();
}

class _MyMessagerieControllerState extends State<MyMessagerieController> {
  TextEditingController message = TextEditingController();
  FirestoreHelper firestoreHelper = FirestoreHelper();
  MyMessagerie Messagerie=  MyMessagerie();
  List MaListe = [];
  List AutreListe=[];

  @override
  void initState() {
    if (me.messagerie == null || me.messagerie!.isEmpty)  {
      setState(() {
       me.messagerie = firestoreHelper.createMessagerie(me.id);

       Map<String,dynamic> map = {
         "MESSAGERIE": me.messagerie,
       };

       FirestoreHelper().updateUser(me.id, map);
      });
    }
    GetListsMessageries();
    super.initState();
  }
 GetListsMessageries(){
    FirestoreHelper().getMessagerie(me.messagerie!).then((value) => {
      Messagerie  = value
    }
    );

    Messagerie[widget.user.messagerie]
    // List OtherList = FirestoreHelper().getMessagerie(otheruser.messagerie);


 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.user.fullname),
        elevation: 0,
      ),
      body: Container(),
    );
  }
}
//
// class ChatBubble extends StatelessWidget {
//   final Message message;
//
//   ChatBubble(this.message);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       alignment: message.idespediteur == me.id ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         padding: EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: message.idespediteur == me.id ? Colors.blue : Colors.grey[300],
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Text(
//           message.content,
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//     );
//   }
// }