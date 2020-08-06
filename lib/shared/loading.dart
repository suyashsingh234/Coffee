import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
          child: LoadingBouncingGrid.circle(
            borderColor: Colors.brown,
            borderSize: 3.0,
            size: 150.0,
            backgroundColor: Colors.brown,
            duration: Duration(milliseconds: 2000),
          ),
      ),
    );
  }
}
