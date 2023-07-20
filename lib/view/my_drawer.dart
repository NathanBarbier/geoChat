import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geo_chat/controller/firestore_helper.dart';

import '../globale.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool isScript = false;
  TextEditingController pseudo = TextEditingController();
  String? nameImage;
  Uint8List? bytesImages;

  popImage() {
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text("Souhaitez-vous enregistrer cette image"),
            content: Image.memory(bytesImages!),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Annulation")
              ),
              TextButton(
                onPressed: () {
                  FirestoreHelper().stockageImage("images", me.id, nameImage!, bytesImages!).then((value) => {
                    setState(() {
                      me.avatar = value;

                      Map<String,dynamic> map = {
                        "AVATAR": me.avatar
                      };

                      FirestoreHelper().updateUser(me.id, map);
                    })
                  });

                  Navigator.pop(context);
                },
                child: const Text("Enregistrement")
              ),
            ],
          );
        }
    );
  }

  accessPhoto() async {
    FilePickerResult? resultat = await FilePicker.platform.pickFiles(
      type: FileType.image,
        withData: true
    );
    if(resultat != null) {
      nameImage = resultat.files.first.name;
      bytesImages = resultat.files.first.bytes;
      popImage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
            child: Column(
              children : [
                InkWell(
                  onTap: () {
                    print("aze");
                    accessPhoto();
                  },
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(me.avatar ?? defaultImage),
                  ),
                ),
                const Divider(
                  thickness: 3,
                ),
                ListTile(
                  leading: const Icon(Icons.mail, color: Colors.blueGrey),
                  title: Text(me.mail, style: const TextStyle(fontSize: 20))
                ),
                ListTile(
                  leading: const Icon(Icons.person, color: Colors.blueGrey),
                  title: Text(me.fullname, style: const TextStyle(fontSize: 20))
                ),
                ListTile(
                  leading: const Icon(Icons.person, color: Colors.blueGrey),
                  title: (isScript)
                      ? TextField(
                        controller: pseudo,
                        decoration: InputDecoration(
                          hintText: me.pseudo ?? "",
                        ),
                      )
                      : Text(me.pseudo ?? "", style: const TextStyle(fontSize: 20)),
                  trailing: IconButton(
                    icon: Icon((isScript) ? Icons.fiber_manual_record : Icons.update),
                    onPressed: () {
                      if (isScript) {
                        if (pseudo != null && pseudo.text != "") {
                          Map<String, dynamic> map = {
                            "PSEUDO": pseudo.text
                          };
                          setState(() {
                            me.pseudo = pseudo.text;
                          });
                          FirestoreHelper().updateUser(me.id, map);
                        }
                      }
                      setState(() {
                        isScript = !isScript;
                      });
                    }
                  ),
                ),
              ]
            )
        )
    );

  }
}
