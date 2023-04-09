import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CompanyDetail extends StatelessWidget {
  final DocumentSnapshot document;

  CompanyDetail({required this.document});

  @override
  Widget build(BuildContext context) {
    List<String> names = document['name'].split(" ");
    String initials = "";
    for (int i = 0; i < names.length; i++) {
      initials += names[i][0].toUpperCase();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(document['name']),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: CircleAvatar(
                radius: 50,
                child: Text(
                  initials,
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      document['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Adresse : ${document['address']}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Email : ${document['email']}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Secteur d"activité : ${document['secteurActivite']}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Description : ${document['description']}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
