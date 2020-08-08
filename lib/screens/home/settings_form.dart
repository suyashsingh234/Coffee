import 'package:coffee/models/User.dart';
import 'package:coffee/models/UserData.dart';
import 'package:coffee/services/database_service.dart';
import 'package:coffee/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  double strength;
  double sugar;

  @override
  Widget build(BuildContext context) {
    User user=Provider.of<User>(context);
    return StreamBuilder<List<UserData>>(
      stream: DatabaseService().preferences,
      builder: (context, snapshot){
        if(snapshot.hasData){
          UserData userdata=snapshot.data.where((element) => element.uid==user.user.uid).toList()[0];
          strength=strength ?? userdata.strength.roundToDouble();
          sugar=sugar ?? userdata.sugar.roundToDouble();
          return Form(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text('Strength: '+ strength.toString()),
                    Slider(
                      value: strength ,
                      min: 1,
                      max: 5,
                      divisions: 4,
                      onChanged: (value){
                        setState(() {
                          strength=value;
                        });
                      },
                      activeColor: Colors.brown[strength.round()*100+100],
                      inactiveColor: Colors.brown[strength.round()*100+100],
                    ),
                    Text('Sugar'),
                    DropdownButton<double>(
                      value: sugar,
                      icon: Icon(Icons.arrow_drop_down),
                      onChanged: (double value){
                        setState(() {
                          sugar=value;
                        });
                      },
                      items: <double>[0,1,2,3]
                        .map<DropdownMenuItem<double>>((double value){
                          return DropdownMenuItem<double>(
                            value: value,
                            child: Text(value.toString()),
                          );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      onPressed: (){
                        DatabaseService().updatePreferences(user.user.uid, userdata.username, strength.round(), sugar.round());
                        Navigator.pop(context);
                      },
                      color: Colors.amber,
                      child: Text('Save', style: TextStyle(fontSize: 15, color: Colors.white),),
                    )
                  ],
                ),
              ),
            ),
          );
        }else{
          return Loading();
        }
      }
    ) ?? Loading();
  }
}
