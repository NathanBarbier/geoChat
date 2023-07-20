import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../globale.dart';
import '../model/my_user.dart';

class ProfileView extends StatefulWidget {
  final MyUser currentUser;
  const ProfileView({required this.currentUser, super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late MyUser user;

  @override
  void initState() {
     user = widget.currentUser;
     super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Text(user.fullname);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Column(
          children : [
            CircleAvatar(
              radius: 150,
              backgroundImage: NetworkImage(widget.currentUser.avatar ?? defaultImage),
            ),
            const SizedBox(height : 30),
            Row(
              mainAxisAlignment : MainAxisAlignment.center,
              children: [
                const Icon(Icons.email, color: Colors.blueGrey),
                const SizedBox(width : 15),
                Text(user.mail, style: const TextStyle(fontSize: 20))
              ],
            ),
            const SizedBox(height : 30),
            Row(
              mainAxisAlignment : MainAxisAlignment.center,
              children: [
                const Icon(Icons.person, color: Colors.blueGrey),
                const SizedBox(width : 15),
                Text(user.fullname, style: const TextStyle(fontSize: 20))
              ],
            ),
            const SizedBox(height : 30),
            Row(
              mainAxisAlignment : MainAxisAlignment.center,
              children: [
                const Icon(Icons.assignment_ind, color: Colors.blueGrey),
                const SizedBox(width : 15),
                Text((user.pseudo != "") ? user.pseudo! : "Pas de pseudonyme", style: const TextStyle(fontSize: 20))
              ],
            ),
            const SizedBox(height : 30),
            Row(
              mainAxisAlignment : MainAxisAlignment.center,
              children: [
                const Icon(Icons.date_range, color: Colors.blueGrey),
                const SizedBox(width : 15),
                Text(DateFormat('dd/MM/yyyy').format(user.birthday!), style: const TextStyle(fontSize: 20))
              ],
            ),
            const SizedBox(height : 30),
            Row(
              mainAxisAlignment : MainAxisAlignment.center,
              children: [
                const Icon(Icons.male, color: Colors.blueGrey),
                const SizedBox(width : 15),
                Text(user.genre.name, style: const TextStyle(fontSize: 20))
              ],
            ),
          ]
        ),
      )
    );
  }
}
