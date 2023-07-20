import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geo_chat/controller/firestore_helper.dart';
import 'package:geo_chat/model/my_user.dart';

import '../globale.dart';

class AllUser extends StatefulWidget {
  const AllUser({super.key});

  @override
  State<AllUser> createState() => _AllUserState();
}

class _AllUserState extends State<AllUser> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirestoreHelper().cloudUsers.snapshots(),
      builder: (context,snap) {
        List document = snap.data?.docs ?? [];
        if(document == []){
          return const Center(
            child: Text("Pas de donnée")
          );
        } else {
          return ListView.builder(
            itemCount: document.length,
            itemBuilder: (context,index){
              MyUser autreUtilisateurs = MyUser(document[index]);
              if(me.id == autreUtilisateurs.id){
                return Container();
              } else {
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  color: Colors.lightBlueAccent,
                  child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        height: 75,
                        width: 75,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 7,
                                blurRadius: 10,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          image: DecorationImage(
                            image: NetworkImage(autreUtilisateurs.avatar ?? defaultImage),
                          )
                        ),
                      ),
                    ),
                    title: Text(autreUtilisateurs.fullname),
                    subtitle: Text(autreUtilisateurs.mail),
                    trailing: IconButton(
                      icon: Icon(Icons.favorite, color: (me.favoris!.contains(autreUtilisateurs.id)) ? Colors.red : Colors.grey),
                      onPressed: () {
                        setState(() {
                          if(me.favoris!.contains(autreUtilisateurs.id)) {
                            me.favoris!.remove(autreUtilisateurs.id);
                          } else {
                            me.favoris!.add(autreUtilisateurs.id);
                          }
                          Map<String, dynamic> map = {
                            "FAVORIS":me.favoris
                          };
                          FirestoreHelper().updateUser(me.id, map);
                        });
                      },
                    ),
                  )
                );
              }
            },
          );
        }
      },
    );
  }
}
