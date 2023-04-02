/* import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projetdemo/Model/Companies.dart';
import 'package:projetdemo/Model/FirebaseHelper.dart';

class ProfileController extends StatefulWidget {
  String? id;

  ProfileController(String id) {
    this.id = id;
  }

  @override
  State<ProfileController> createState() => _ProfileControllerState();
}

class _ProfileControllerState extends State<ProfileController> {
  Companies? user;
  String? firstname;
  String? name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return (user == null)
        ? const Center(
            child: Text('Chargement...'),
          )
        : SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  //image
                  TextField(
                    decoration: InputDecoration(hintText: user?.firstname),
                    onChanged: (String) {
                      setState(() {
                        firstname = String;
                      });
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: user?.name),
                    onChanged: (String) {
                      setState(() {
                        name = String;
                      });
                    },
                  ),
                  ElevatedButton(
                    onPressed: _saveChanges, 
                    child: Text('Save chages')
                  ),
                  TextButton(
                    onPressed: _Logout, 
                    child: Text('Disconnected'),
                  )
                ],
              ),
            ),
          );
  }

  _saveChanges(){

  }

  Future<void> _Logout() async {

  }

  _getUser() {
    FirebaseHelper().getUser(widget.id!).then((user) {
      setState(() {
        this.user = user;
      });
    });
  }
}
 */