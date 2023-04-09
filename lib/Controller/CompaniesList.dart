import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'CompanyDetails.dart';

class CompaniesList extends StatefulWidget {
  const CompaniesList({super.key});

  @override
  State<CompaniesList> createState() => _CompaniesListState();
}

Widget _buildInitialsAvatar(String name) {
  List<String> names = name.split(' ');
  String initials = '';
  for (String name in names) {
    initials += name[0].toUpperCase();
  }
  return CircleAvatar(
    backgroundColor: Colors.blueAccent,
    child: Text(
      initials,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

class _CompaniesListState extends State<CompaniesList> {
  final CollectionReference _companies =
      FirebaseFirestore.instance.collection('companies');
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Company list'),
        actions: [
          SizedBox(
            width: 200,
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search',
              ),
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _companies.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            final List<DocumentSnapshot> filteredCompanies = streamSnapshot
                .data!.docs
                .where((document) =>
                    document['name']
                        .toLowerCase()
                        .contains(_searchText.toLowerCase()))
                .toList();

            return ListView.builder(
              itemCount: filteredCompanies.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    filteredCompanies[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: _buildInitialsAvatar(documentSnapshot['name']),
                    title: Text(documentSnapshot['name']),
                    subtitle: Text(documentSnapshot['address']),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_forward),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CompanyDetail(
                                      document: documentSnapshot),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _buildInitialsAvatar(String name) {
    final initials = name.split(' ').map((word) => word.substring(0, 1));
    return CircleAvatar(
      child: Text(initials.join()),
    );
  }
}
