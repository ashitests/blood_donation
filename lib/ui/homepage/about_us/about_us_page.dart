import 'package:flutter/material.dart';
import 'package:hafsa/utils/hard_data.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us :) "),
        centerTitle: false,
      ),
      body: Center(
          child: Container(
        child: Text(
          aboutUs + "\n\n\n\n\n\n",
          textScaleFactor: 2.0,
          style: TextStyle(),
          textAlign: TextAlign.center,
        ),
      )),
    );
  }
}
