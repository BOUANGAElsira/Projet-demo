import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projetdemo/Model/FirebaseHelper.dart';

import 'SearchController.dart';

class MainAppController extends StatefulWidget {
  const MainAppController({super.key});

  @override
  State<MainAppController> createState() => _MainAppControllerState();
}

class _MainAppControllerState extends State<MainAppController> {
  @override
  Widget build(BuildContext context) {
    Text title = Text('Compagnies Register');

    return FutureBuilder(
      future: FirebaseHelper().auth.currentUser(),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
              title: title,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search)
                )
              ],
            ),
            body: TabBarView(
              children: controller(),
            ),
          );
        } else {
          //Retourne un widget chargement
          return Scaffold(
            appBar: AppBar(
              title: title,
            ),
            body: Center(
              child: Text(
                'Chargement...',
                style: TextStyle(
                  fontSize: 25.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.purple,
                ),
              ) 
            ),
          );
        };
      }
    );
  }

  List<Widget> controller() {
    return [
      SearchController(),
    ];
  }

}
