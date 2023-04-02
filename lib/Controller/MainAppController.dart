import 'package:firebase_database/firebase_database.dart';
import '../Model/Companies.dart';

class MainAppController {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference();

  Future<List<Companies>> getCompanies() async {
    // Récupérer une référence à la collection "companies"
    final snapshot = await _databaseReference.child('companies').once();
    
    // Créer une liste vide pour stocker les entreprises récupérées
    final companies = <Companies>[];
    
    // Parcourir chaque élément de la collection "companies"
    final data = (snapshot as DataSnapshot).value as Map<String, dynamic>;
    data.forEach((key, values) {
      // Récupérer les informations de chaque entreprise et créer un objet "Companies"
      final company = Companies(
        id: key,
        name: values['name'],
        address: values['address'],
      );
      
      // Ajouter l'objet "Companies" à la liste des entreprises
      companies.add(company);
    });
    
    // Retourner la liste des entreprises
    return companies;
  }
}
