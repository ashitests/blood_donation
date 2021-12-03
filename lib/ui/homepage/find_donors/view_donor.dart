import 'package:flutter/material.dart';
import 'package:hafsa/models/donor_model.dart';

class ViewDonor extends StatelessWidget {
  final DonorModel donor;

  ViewDonor({this.donor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Donor Details"),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
