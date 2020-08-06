import 'package:flutter/material.dart';
import '../../../services/auth_service.dart';
import '../../../shared/loading.dart';

class SignInForm extends StatefulWidget {

  final Function toggleForm;
  SignInForm({this.toggleForm});

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {

  String _email;
  String _password;
  String error='';
  bool showLoading=false;


  final _formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return showLoading ? Loading() : Scaffold(

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
                  Text('Register', style: TextStyle(color: Colors.white),),
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
                validator: (val){
                  if(val.isEmpty){
                    return 'Please enter email';
                  }
                  return null;
                },
                onChanged: (val){
                  setState(() {
                    _email=val;
                  });
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
                validator: (val){
                  if(val.length<6){
                    return 'Enter password of length greater than 6';
                  }
                  return null;
                },
                onChanged: (val){
                  setState(() {
                    _password=val;
                  });
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
                    dynamic result=await AuthService().signInWithEmailAndPassword(_email, _password);
                    setState(() {
                      showLoading=false;
                      error=result;
                    });
                  }
                },
                child: Text('Sign In'),
                textColor: Colors.white,
                color: Colors.brown[500],
              ),

              Container(
                child: Text(error,style: TextStyle(fontSize:15, color: Colors.red),),
              ),

            ],
          ),
        ),
      ),
    );
  }
}


