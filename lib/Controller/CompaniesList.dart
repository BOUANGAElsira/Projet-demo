import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';

import '../Model/Companies.dart';
import 'MainAppController.dart';

class CompaniesList extends StatefulWidget {
  const CompaniesList({super.key});

  @override
  State<CompaniesList> createState() => _CompaniesListState();
}

class _CompaniesListState extends State<CompaniesList> {
final MainAppController controller = MainAppController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des entreprises'),
      ),
      body: FutureBuilder<List<Companies>>(
        future: controller.getCompanies(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final companies = snapshot.data;
            return ListView.builder(
              itemCount: companies!.length,
              itemBuilder: (context, index) {
                final company = companies[index];
                return ListTile(
                  title: Text(company.name),
                  subtitle: Text(company.address),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur de chargement des entreprises.'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }}