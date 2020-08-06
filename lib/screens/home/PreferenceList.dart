import 'package:coffee/models/UserData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PreferenceListTile extends StatelessWidget{
  final UserData userdata;
  PreferenceListTile({this.userdata});

  @override
  Widget build(BuildContext context) {
      return Card(
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.brown[userdata.strength*100+100],
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(userdata.username, style: TextStyle(fontSize: 25, color: Colors.brown),),
                Text('strength: '+userdata.strength.toString(), style: TextStyle(fontSize: 25, color: Colors.brown),),
                Text('sugar: '+userdata.sugar.toString(), style: TextStyle(fontSize: 25, color: Colors.brown),),
              ],
            )
          ],
        ),
      );
    }
}

class PreferenceList extends StatefulWidget {
  @override
  _PreferenceListState createState() => _PreferenceListState();
}

class _PreferenceListState extends State<PreferenceList> {
  @override
  Widget build(BuildContext context) {
    List<UserData> userdata = Provider.of<List<UserData>>(context) ?? [];
    return ListView.builder(
        itemCount: userdata.length,
        itemBuilder: (BuildContext ctxt, int index){
          return PreferenceListTile(userdata: userdata[index]);
        },
    );
  }
}
