
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

import '../globale.dart';

class MyUser {
  late String id;
  late String mail;
  late String nom;
  late String prenom;
  String? pseudo;
  DateTime? birthday;
  String? avatar;
  Gender genre = Gender.indefini;
  List? favoris;
  GeoPoint? location;

  MyUser.empty() {
    id = "";
    mail = "";
    nom = "";
    prenom = "";
  }

  MyUser(DocumentSnapshot snapshot) {
    id = snapshot.id;
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    mail = map["EMAIL"];
    nom = map["NOM"];
    prenom = map["PRENOM"];
    String? provisoirePseudo = map["PSEUDO"];
    if(provisoirePseudo == null) {
      pseudo = "";
    } else {
      pseudo = provisoirePseudo;
    }

    Timestamp? birthdayProvisoire = map["BIRTHDAY"];
    if(birthdayProvisoire == null) {
      birthday = DateTime.now();
    } else {
      birthday = birthdayProvisoire.toDate();
    }

    avatar = map["AVATAR"] ?? defaultImage;
    favoris = map["FAVORIS"] ?? [];

    location = map["POSITION"];
  }

  String get fullname {
    return "$prenom $nom";
  }
}