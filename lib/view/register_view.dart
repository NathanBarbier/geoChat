import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geo_chat/controller/animation_controller.dart';
import 'package:geo_chat/controller/firestore_helper.dart';
import 'package:geo_chat/view/dashboard_view.dart';

import '../globale.dart';
import 'my_background.dart';

class MyRegisterView extends StatefulWidget {
  const MyRegisterView({super.key});

  @override
  State<MyRegisterView> createState() => _MyRegisterViewState();
}

class _MyRegisterViewState extends State<MyRegisterView> {
  //variable
  TextEditingController mail = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController nom = TextEditingController();
  TextEditingController prenom = TextEditingController();

  // Fonctions
  myPopError() {
    showDialog(
      context: context,
      builder: (context) {
        if(Platform.isIOS){
          return CupertinoAlertDialog(
            title: const Text("Erreur de connexion"),
            content: const Text("Votre Email/Mot de passe sont érronés"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK")
              )
            ],
          );
        } else {
          return AlertDialog(
            title: const Text("Erreur de connexion"),
            content: const Text("Votre Email/Mot de passe sont érronés"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("OK")
              )
            ],
          );
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Ma première application"),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle : true
        ),
        extendBodyBehindAppBar: true,
        body:  Stack(
          children: [
            MyBackground(),
            SafeArea(
              child: SingleChildScrollView(
                  child : Padding(
                      padding : const EdgeInsets.all(10),
                      child : Center(
                          child : Column(
                              mainAxisAlignment : MainAxisAlignment.center,
                              children : [
                                // image
                                Container(
                                    height : 250,
                                    width : 350,
                                    decoration : BoxDecoration(
                                        borderRadius : BorderRadius.circular(15),
                                        image : const DecorationImage(
                                            image : AssetImage("assets/mainAnimation.json"),
                                            fit : BoxFit.fill
                                        )
                                    )
                                ),
                                // const SizedBox(height : 200),
                                //prenom
                                // MyAnimationController(
                                //     delay: 0,
                                //     child:
                                      TextField(
                                        controller: prenom,
                                        decoration : InputDecoration(
                                            hintText: "Prénom",
                                            prefixIcon : const Icon(Icons.person),
                                            border : OutlineInputBorder(
                                              borderRadius : BorderRadius.circular(15),
                                            )
                                        )
                                      ),
                                // ),
                                const SizedBox(height : 15),
                                //nom
                                // MyAnimationController(
                                //     delay: 0,
                                //     child:
                                      TextField(
                                        controller: nom,
                                        decoration : InputDecoration(
                                            hintText: "Nom",
                                            prefixIcon : const Icon(Icons.person),
                                            border : OutlineInputBorder(
                                              borderRadius : BorderRadius.circular(15),
                                            )
                                        )
                                    ),
                                // ),
                                // const SizedBox(height : 15),
                                //adresse mail
                                const SizedBox(height : 15),
                                // MyAnimationController(
                                //     delay: 0,
                                //     child:
                                    TextField(
                                        controller: mail,
                                        decoration : InputDecoration(
                                            hintText: "Entrer votre adresse mail",
                                            prefixIcon : const Icon(Icons.person),
                                            border : OutlineInputBorder(
                                              borderRadius : BorderRadius.circular(15),
                                            )
                                        )
                                    ),
                                // ),
                                //mot de passe
                                const SizedBox(height : 15),
                                // MyAnimationController(
                                //     delay: 0,
                                //     child:
                                    TextField(
                                      controller : password,
                                      obscureText : true,
                                      decoration : InputDecoration(
                                          hintText: "Entrer votre mot de passe",
                                          prefixIcon : const Icon(Icons.lock),
                                          border : OutlineInputBorder(
                                            borderRadius : BorderRadius.circular(15),
                                          )
                                      ),
                                    ),
                                // ),
                                const SizedBox(height : 15),
                                // MyAnimationController(
                                //     delay: 0,
                                //     child:
                                    ElevatedButton(
                                        style : ElevatedButton.styleFrom(
                                            backgroundColor : Colors.purple,
                                            shape : const StadiumBorder()
                                        ),
                                        onPressed : (){
                                          FirestoreHelper().connect(mail.text, password.text).then((value){
                                            setState(() {
                                              me = value;
                                            });
                                            Navigator.push(context,MaterialPageRoute(
                                                builder : (context){
                                                  return const MyDashBoardView();
                                                }
                                            ));
                                          }).catchError((onError) {
                                            myPopError();
                                          });
                                        },
                                        child : const Text("Connexion")
                                    ),
                                // ),

                                const SizedBox(height : 15),
                                // MyAnimationController(
                                //     delay: 0,
                                //     child:
                                    TextButton(
                                      onPressed: () {
                                        FirestoreHelper().register(mail.text, password.text, prenom.text, nom.text).then((value){
                                          setState(() {
                                            me = value;
                                          });
                                          // Navigator.push(context,MaterialPageRoute(
                                          //     builder : (context){
                                          //       return const MyDashBoardView();
                                          //     }
                                          // ));
                                        }).catchError((onError) {
                                          myPopError();
                                        });
                                      },
                                      child: const Text('Inscription')
                                    ),
                                // ),
                                //bouton
                              ]
                          )
                      )
                  )
              ),
            ),
          ],
        )
    );
  }
}
