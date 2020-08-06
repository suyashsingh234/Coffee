import 'package:coffee/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/User.dart';
import 'screens/wrapper.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
          StreamProvider<User>.value(value:AuthService().user),
      ],
      child: MaterialApp(
        home:SafeArea(
          child:Wrapper(),
        )
      ),
    );
  }
}
