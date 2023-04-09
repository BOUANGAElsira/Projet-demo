import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'Companies.dart';

class FirebaseHelper {
  //Authentification
  final auth = FirebaseAuth.instance;

  Future<User> handleSignIn(String mail, String password) async {
    UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: mail, password: password);
    User user = userCredential.user!;
    return user;
  }

  Future<User> handleCreate(
    String mail, String password, String name, String address, String description, String secteurActivite) async {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: mail, password: password);
      User user = userCredential.user!;
      String uid = user.uid;
      Map<String, String> map = {
        "uid": uid,
        "name": name,
        "address": address,
        "mail": mail,
        "description": description,
        "secteurActivite": secteurActivite
      };

      addCompanies(uid, map);
      return user;
  }

  Future<Stream<User?>> myId() async {
    Stream<User?> user = await auth.authStateChanges();
    return user;
  }

  //Database
  static final base = FirebaseDatabase.instance.reference();
  final base_companies = base.child('companies');

  addCompanies(String uid, Map map) {
    base_companies.child(uid).set(map);
  }

/*   Future<Companie> getUser(String id) async {
    DataSnapshot snapshot = (await base_companies.child(id).once()).snapshot;
    return Companie(snapshot);
  }
 */}
