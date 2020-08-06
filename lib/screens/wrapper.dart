import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee/models/User.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authentication/authentication.dart';
import 'home/home.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user=Provider.of<User>(context);
    if(user==null){
      return Authentication();
    }else{
      return Home();
    }
  }
}
