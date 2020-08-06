import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee/models/User.dart';
import 'package:coffee/models/UserData.dart';

class DatabaseService{

  final databaseReference=Firestore.instance;

  Future<String> updatePreferences(String uid, String username, int strength, int sugar) async{
    try{
      await databaseReference.collection('Preferences').document(uid).setData({
       'username':username,
        'strength':strength,
        'sugar':sugar,
      });
    }catch(error){
      return error.message;
    }
  }

  Future<UserData> getPreferences(String uid) async{
    return await databaseReference.collection('Preferences').document(uid).get().then((doc){
      return UserData(
        username: doc.data['username'],
        strength: doc.data['strength'],
        sugar: doc.data['sugar'],
      );
    });
  }

  List<UserData> _getUserDataListFromSnapshot(QuerySnapshot snap){
    return snap.documents.map((doc){
      return UserData(
        username: doc.data['username'],
        strength: doc.data['strength'],
        sugar: doc.data['sugar'],
      );
    }).toList();
  }

  Stream<List<UserData>> get preferences{
    return databaseReference.collection('Preferences').snapshots().map(
        (QuerySnapshot snap)=>  _getUserDataListFromSnapshot(snap)
    );
  }




}