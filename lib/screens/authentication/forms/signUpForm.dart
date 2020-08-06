import 'package:coffee/shared/loading.dart';
import 'package:flutter/material.dart';
import '../../../services/auth_service.dart';

class SignUpForm extends StatefulWidget {

  final Function toggleForm;
  SignUpForm({this.toggleForm});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {

  String _username;
  String _email;
  String _password;
  final _formKey=GlobalKey<FormState>();

  bool showLoading=false;
  String error='';

  @override
  Widget build(BuildContext context) {
    return showLoading ? Loading() :Scaffold(

      appBar: AppBar(
        title: Text('Coffee'),
        backgroundColor: Colors.brown[700],
        actions: <Widget>[
          FlatButton(
            onPressed: (){
              widget.toggleForm();
            },
            child:Row(
              children: <Widget>[
                Icon(Icons.person,color:Colors.white,),
                Text('Log In', style: TextStyle(color: Colors.white),),
              ],
            )
          )
        ],
      ),

      body: Container(
        margin: EdgeInsets.all(10),
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[

                TextFormField(
                  onChanged: (val){
                    setState(() {
                      _username=val;
                    });
                  },
                  validator: (val){
                    if(val.isEmpty){
                      return 'Please enter username';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.person, color: Colors.brown[600],),
                    hintText: 'Username',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.brown[600],
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.brown[600],
                      ),
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.brown[600],
                    fontSize: 20,
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                TextFormField(
                  onChanged: (val){
                    setState(() {
                      _email=val;
                    });
                  },
                  validator: (val){
                    if(val.isEmpty){
                      return 'Please enter email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.mail, color: Colors.brown[600],),
                    hintText: 'Email',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.brown[600],
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.brown[600],
                      ),
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.brown[600],
                    fontSize: 20,
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                TextFormField(
                  onChanged: (val){
                    setState(() {
                      _password=val;
                    });
                  },
                  validator: (val){
                    if(val.length<6){
                      return 'Enter password of length greater than 6';
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock, color: Colors.brown[600],),
                    hintText: 'Password',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.brown[600],
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.brown[600],
                      ),
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.brown[600],
                    fontSize: 20,
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                RaisedButton(
                  onPressed: () async{
                    if(_formKey.currentState.validate()){
                      setState(() {
                        showLoading=true;
                      });
                      dynamic result = await AuthService().signUpWithEmailAndPassword(_username,_email,_password);
                      setState(() {
                        error=result;
                        showLoading=false;
                      });
                    }
                  },
                  child: Text('Sign Up'),
                  textColor: Colors.white,
                  color: Colors.brown[500],
                ),

                Container(
                  child: Text(error,style: TextStyle(fontSize: 15, color: Colors.red),),
                )

              ],
            ),
          ),
      ),
    );
  }
}


