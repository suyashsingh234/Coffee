import 'package:coffee/models/User.dart';
import 'package:coffee/models/UserData.dart';
import 'package:coffee/screens/home/settings_form.dart';
import 'package:coffee/services/auth_service.dart';
import 'package:coffee/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'PreferenceList.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  void showSettings(){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context){
        return SettingsForm();
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<UserData>>.value(value: DatabaseService().preferences,),
        StreamProvider<User>.value(value: AuthService().user,),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          backgroundColor: Colors.brown[800],
          actions: <Widget>[
            FlatButton(
              onPressed: (){
                showSettings();
              },
              child: Row(
                children: <Widget>[
                  Icon(Icons.settings, color: Colors.white,),
                  Text('Settings', style: TextStyle(color: Colors.white),)
                ],
              ),
            ),
            FlatButton(
              onPressed: () async{
                await AuthService().signOut();
              },
              child: Row(
                children: <Widget>[
                  Icon(Icons.person, color: Colors.white,),
                  Text('Logout', style: TextStyle(color: Colors.white),)
                ],
              ),
            )
          ],
        ),
        body: PreferenceList(),
        ),
    );
  }
}
