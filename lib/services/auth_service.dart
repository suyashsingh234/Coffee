import 'package:firebase_auth/firebase_auth.dart';
import '../models/User.dart';
import 'database_service.dart';

class AuthService{

  final FirebaseAuth _auth=FirebaseAuth.instance;
  
  User _getUserFromFirebaseUser(FirebaseUser user){
    return user==null ? null : User(user:user);
  }
  

  Future<String> signUpWithEmailAndPassword(String _username, String _email, String _password) async{
    try{
      final FirebaseUser result= (await _auth.createUserWithEmailAndPassword(
          email: _email,
          password: _password
      )).user;
      if(result.uid!=null){
        DatabaseService().updatePreferences(result.uid, _username, 1, 0);
      }
      return result.uid;
    }catch(error){
      return await error.message;
    }
  }

  Future<String> signInWithEmailAndPassword(String _email, String _password) async{
    try{
      await _auth.signInWithEmailAndPassword(email: _email, password: _password);
    }catch(error){
      return error.message;
    }
  }

  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(error){
      print(error);
    }
  }
  
  Stream<User> get user{
    return _auth.onAuthStateChanged.map((FirebaseUser user) => _getUserFromFirebaseUser(user));
  }
  
}



