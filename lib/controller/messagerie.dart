import 'package:flutter/material.dart';
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
      body: Container(),
    );
  }
}
