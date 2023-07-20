import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:geo_chat/controller/profile_view.dart';

import '../globale.dart';
import '../model/my_user.dart';
import 'firestore_helper.dart';

class MyFavorites extends StatefulWidget {
  const MyFavorites({super.key});

  @override
  State<MyFavorites> createState() => _MyFavoritesState();
}

class _MyFavoritesState extends State<MyFavorites> {
  List<MyUser> maListeAmis = [];

  @override
  void initState() {
    for(String uid in me.favoris!) {
      FirestoreHelper().getUser(uid).then((value){
        setState(() {
          maListeAmis.add(value);
        });
      });
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: maListeAmis.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3, crossAxisSpacing: 5, mainAxisSpacing: 5),
      itemBuilder: (context, index) {
      MyUser otherUser = maListeAmis[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.push(context,MaterialPageRoute(
                builder : (context) {
                  return ProfileView(currentUser: otherUser);
                }
              ));
            },
            child : Container(
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 7,
                    blurRadius: 10,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        height: 75,
                        width: 75,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(otherUser.avatar ?? defaultImage),
                        ),
                      ),
                      const SizedBox(height : 8),
                      Text(otherUser.fullname),
                    ],
                  ),
                ),
              )
            ),
          ),
        );
      }
    );
  }
}
