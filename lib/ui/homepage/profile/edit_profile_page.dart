import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hafsa/models/donor_model.dart';
import 'package:hafsa/models/seeker_model.dart';
import 'package:hafsa/services/firebase_user.dart';
import 'package:hafsa/ui/homepage/homepage.dart';
import 'package:hafsa/utils/hard_data.dart';

class ModifyProfileScreen extends StatefulWidget {
  final userData;
  final String uid;
  ModifyProfileScreen({this.userData, this.uid});

  @override
  _ModifyProfileScreenState createState() =>
      _ModifyProfileScreenState(userData, uid);
}

class _ModifyProfileScreenState extends State<ModifyProfileScreen> {
  final userData;
  final String uid;
  _ModifyProfileScreenState(this.userData, this.uid);

  final modifyFormKey = GlobalKey<FormState>();

  final TextEditingController firstNameTextController = TextEditingController();

  final TextEditingController lastNameTextController = TextEditingController();

  final TextEditingController phoneTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedCity = null;
      selectedProfession = null;
      selectedGender = null;
    });
    firstNameTextController.text = userData["details"]["name"];
    lastNameTextController.text = userData["details"]["lastname"];
    phoneTextController.text =
        userData["details"]["phone"].toString().replaceRange(0, 4, "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modify Profile"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 30),
            //name and last name
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.99,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                      child: TextFormField(
                        controller: firstNameTextController,
                        autofocus: true,
                        textInputAction: TextInputAction.next,
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: 'First Name is required.'),
                          MinLengthValidator(3,
                              errorText: "Enter a valid Name.")
                        ]),
                        decoration: InputDecoration(
                          fillColor: Colors.redAccent,
                          focusColor: Colors.redAccent,
                          labelText: "First name",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                      child: TextFormField(
                        controller: lastNameTextController,
                        autofocus: true,
                        textInputAction: TextInputAction.next,
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: 'Last name is required.'),
                          MinLengthValidator(3,
                              errorText: "Enter a valid Name.")
                        ]),
                        decoration: InputDecoration(
                          fillColor: Colors.redAccent,
                          focusColor: Colors.redAccent,
                          labelText: "Last name",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            // phone number
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: TextFormField(
                controller: phoneTextController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.phone,
                maxLength: 8,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                validator: MultiValidator([
                  RequiredValidator(errorText: 'Phone number is required.'),
                  MinLengthValidator(8,
                      errorText: "Enter a valid phone number.")
                ]),
                decoration: InputDecoration(
                  fillColor: Colors.redAccent,
                  focusColor: Colors.redAccent,
                  prefixIcon: Icon(Icons.phone),
                  prefixText: "+968 ",
                  labelText: "Phone Number",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
            Flexible(
              child: Container(
                padding: EdgeInsets.only(left: 20),
                child: DropdownButton(
                  isExpanded: true,
                  hint: selectedCity == null
                      ? Text(userData["details"]["city"],
                          style: TextStyle(fontWeight: FontWeight.w300))
                      : Text(selectedCity,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400)),
                  items: cities.map(
                    (val) {
                      return DropdownMenuItem<String>(
                          value: val, child: Text(val));
                    },
                  ).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCity = value;
                      print(selectedGender);
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Flexible(
              child: Container(
                padding: EdgeInsets.only(left: 20),
                child: DropdownButton(
                  isExpanded: true,
                  hint: selectedProfession == null
                      ? Text(userData["details"]["profession"],
                          style: TextStyle(fontWeight: FontWeight.w300))
                      : Text(selectedProfession,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400)),
                  items: professions.map(
                    (val) {
                      return DropdownMenuItem<String>(
                          value: val, child: Text(val));
                    },
                  ).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedProfession = value;
                      print(selectedGender);
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 20),
              width: MediaQuery.of(context).size.width * 0.9,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.redAccent.shade200),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextButton(
                  onPressed: () async {
                    print("now checkthing if its a donor");
                    if (userData["type"].toString().toLowerCase() == "donor") {
                      print("yes");
                      print("updating the donor at " + uid.toString());
                      print(phoneTextController.text.toString() + "\n\n\n");
                      await UserServices().updateDonor(
                          DonorModel(
                              name: firstNameTextController.text.toString(),
                              lastname: lastNameTextController.text.toString(),
                              phone:
                                  "+968" + phoneTextController.text.toString(),
                              city: selectedCity != null
                                  ? selectedCity.toString()
                                  : userData["details"]["city"].toString(),
                              profession: selectedProfession != null
                                  ? selectedProfession.toString()
                                  : userData["details"]["profession"]
                                      .toString(),
                              email: userData["details"]["email"].toString(),
                              gender: userData["details"]["gender"].toString(),
                              bloodType:
                                  userData["details"]["bloodType"].toString()),
                          uid);
                      Navigator.pushAndRemoveUntil<void>(
                          context,
                          MaterialPageRoute(builder: (_) => HomePage()),
                          (_) => false);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.greenAccent.shade200,
                          content: Container(
                            alignment: Alignment.bottomCenter,
                            height: 20,
                            margin: EdgeInsets.all(10),
                            child: Center(
                                child: Text("Profile Updated Successfully")),
                          )));
                    } else {
                      print("updating the seeker at " + uid.toString());
                      print(phoneTextController.text.toString() + "\n\n\n");
                      await UserServices().updateSeeker(
                          SeekerModel(
                            name: firstNameTextController.text.toString(),
                            lastname: lastNameTextController.text.toString(),
                            phone: "+968" + phoneTextController.text.toString(),
                            city: selectedCity != null
                                ? selectedCity.toString()
                                : userData["details"]["city"].toString(),
                            profession: selectedProfession != null
                                ? selectedProfession.toString()
                                : userData["details"]["profession"].toString(),
                            email: userData["details"]["email"].toString(),
                            gender: userData["details"]["gender"].toString(),
                          ),
                          uid);
                      Navigator.pushAndRemoveUntil<void>(
                          context,
                          MaterialPageRoute(builder: (_) => HomePage()),
                          (_) => false);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.greenAccent.shade200,
                          content: Container(
                            alignment: Alignment.bottomCenter,
                            height: 20,
                            margin: EdgeInsets.all(10),
                            child: Center(
                                child: Text("Profile Updated Successfully")),
                          )));
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Update          ",
                        textScaleFactor: 1.3,
                        style: TextStyle(color: Colors.redAccent.shade200),
                      ),
                      Icon(
                        Icons.edit_outlined,
                        color: Colors.redAccent.shade200,
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
