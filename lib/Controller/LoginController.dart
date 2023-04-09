import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projetdemo/Model/FirebaseHelper.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends StatefulWidget {
  const LoginController({super.key});

  @override
  State<LoginController> createState() => _LoginControllerState();
}

class _LoginControllerState extends State<LoginController> {
  bool _log = true;
  String? _name;
  String? _address;
  String? _mail;
  String? _password;
  String? _description;
  String? _secteurActivite;
  //
  final CollectionReference _companies =
      FirebaseFirestore.instance.collection('companies');
  //

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        title: new Text('Authentification'),
      ),
      body: new SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20.0),
              width: MediaQuery.of(context).size.width - 40,
              height: MediaQuery.of(context).size.height / 2,
              child: new Card(
                color: Colors.white,
                elevation: 8.5,
                child: Container(
                  margin: EdgeInsets.only(left: 7.0, right: 5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: cardElements(),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: _handleLog,
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.purple),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                padding:
                    MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(16)),
              ),
              child: new Text((_log == true) ? 'Sign in' : 'Sign up'),
            )
          ],
        ),
      ),
    );
  }

  _handleLog() {
    if (_mail != null) {
      if (_password != null) {
        if (_log == true) {
          //Se connecter
          FirebaseHelper().handleSignIn(_mail!, _password!).then((User user) {
            print('New user');
          }).catchError((error) {
            alerte(error.toString());
          });
        } else {
          if (_address != null) {
            if (_name != null) {
              print('valeur de _description : $_description');
              if (_description != null) {
                if (_secteurActivite != null) {
                  //Créer un compte
                  FirebaseHelper()
                      .handleCreate(_mail!, _password!, _name!, _address!,
                          _description!, _secteurActivite!)
                      .then((User user) {
                    _create(_name!, _address!, _mail!, _description!,
                        _secteurActivite!);
                    print('New user ceated');
                  }).catchError((error) {
                    alerte(error.toString());
                  });
                } else {
                  //Alerte de secteur d'activité
                  alerte('No activity sector, try to write a activity sector to continue');
                }
              } else {
                //Alerte, pas de description
                alerte('No description, try to write a description to continue');
              }
            } else {
              //Alerte, pas de nom
              alerte('No address, try to write a name to continue');
            }
          } else {
            //Alerte, pas de adresse
            alerte('No name, try to write a address to continue');
          }
        }
      } else {
        //Alerte, pas de mot de passe
        alerte('Error your password  is obligatory to continue');
      }
    } else {
      //ALerte, pas de mail
      alerte('Error your mail  is obligatory to continue');
    }
  }

  Future<void> _create(String name, String address, String email,
      String description, String secteurActivite) async {
    await _companies.add({
      "address": address,
      "name": name,
      "email": email,
      "description": description,
      "secteurActivite": secteurActivite
    });
  }

  Future<void> alerte(String error) async {
    Text title = new Text('There is an error');
    Text subTitle = new Text(error);
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            title: title,
            content: subTitle,
            actions: <Widget>[okButton(buildContext)],
          );
        });
  }

  OutlinedButton okButton(BuildContext context) {
    return new OutlinedButton(
      onPressed: () => Navigator.of(context).pop(),
      child: new Text('Ok'),
    );
  }

  List<Widget> cardElements() {
    List<Widget> widgets = [];

    //Remplir le chmap de l'adresse mail
    widgets.add(new TextField(
      decoration: InputDecoration(hintText: 'Enter your email'),
      onChanged: (String) {
        setState(() {
          _mail = String;
        });
      },
    ));

    //Remplir le chmap du mot de passe
    widgets.add(new TextField(
      obscureText: true, //Cacher l mot de passe
      decoration: InputDecoration(hintText: 'Enter your password'),
      onChanged: (String) {
        setState(() {
          _password = String;
        });
      },
    ));

    if (_log == false) {
      widgets.add(new TextField(
        decoration: InputDecoration(hintText: 'Enter your name'),
        onChanged: (String) {
          setState(() {
            _name = String;
          });
        },
      ));

      widgets.add(new TextField(
        decoration: InputDecoration(hintText: 'Enter your address'),
        onChanged: (String) {
          setState(() {
            _address = String;
          });
        },
      ));

      widgets.add(new TextField(
        decoration: InputDecoration(hintText: 'Enter your activity sector'),
        onChanged: (String) {
          setState(() {
            _secteurActivite = String;
          });
        },
      ));

      widgets.add(new TextField(
        decoration: InputDecoration(hintText: 'Enter your description'),
        onChanged: (String) {
          setState(() {
            _description = String;
          });
        },
      ));
    }

    widgets.add(new ElevatedButton(
      onPressed: () {
        setState(() {
          _log = !_log;
        });
      },
      child: new Text((_log == true)
          ? 'Press this button to create an account'
          : 'Already have an account ? Press here to sign up'),
    ));
    return widgets;
  }
}
