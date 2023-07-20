import 'package:flutter/material.dart';
import 'package:geo_chat/view/my_drawer.dart';

import '../controller/all_utilisateurs.dart';
import '../controller/mes_favoris.dart';
import 'map_view.dart';

class MyDashBoardView extends StatefulWidget {
  const MyDashBoardView({super.key});

  @override
  State<MyDashBoardView> createState() => _MyDashBoardViewState();
}

class _MyDashBoardViewState extends State<MyDashBoardView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
        width : MediaQuery.of(context).size.width * 0.75,
        height: MediaQuery.of(context).size.height,
        color: Colors.blue,
        child: const MyDrawer(),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: bodyPage(),
      backgroundColor: const Color.fromRGBO(198, 237, 255, 1),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label : "Utilisateur"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label : "Mes amis"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label : "Carte"
          ),
        ],
      ),
    );
  }

  Widget bodyPage(){
    switch (currentIndex) {
      case 0: return const AllUser();
      case 1: return const MyFavorites();
      case 2: return const MyMapView();
      default: return const Text("Problème d'affichage");
    }
  }
}
