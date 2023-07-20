import 'package:flutter/material.dart';

import '../model/my_user.dart';

class MyMessagerie extends StatefulWidget {
  final MyUser user;
  const MyMessagerie({super.key, required this.user});

  @override
  State<MyMessagerie> createState() => _MyMessagerieState();
}

class _MyMessagerieState extends State<MyMessagerie> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.user.fullname),
        elevation: 0,
      ),
      body: Text("salut"),
    );
  }
}
