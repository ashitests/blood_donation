import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hafsa/models/donor_model.dart';
import 'package:hafsa/services/firebase_auth.dart';
import 'package:hafsa/utils/hard_data.dart';

class DonorSignUp extends StatefulWidget {
  @override
  _DonorSignUpState createState() => _DonorSignUpState();
}

class _DonorSignUpState extends State<DonorSignUp> {
  final _donorRegistrationFormKey = GlobalKey<FormState>();

  // important info controllers
  TextEditingController firstNameTextController = TextEditingController();
  TextEditingController lastNameTextController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();
  TextEditingController addressTextController = TextEditingController();

  // stuff info controllers
  TextEditingController genderTextController = TextEditingController();
  TextEditingController bloodTypeTextController = TextEditingController();
  TextEditingController cityTextController = TextEditingController();

  // auth data controllers
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedCity = null;
      selectedProfession = null;
      selectedGender = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        title: Text("Blood Donor Registration"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _donorRegistrationFormKey,
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
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 12),
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 12),
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    //email
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                      child: TextFormField(
                        controller: emailTextController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'Email is required.'),
                          EmailValidator(errorText: "Enter a valid Email.")
                        ]),
                        decoration: InputDecoration(
                          fillColor: Colors.redAccent,
                          focusColor: Colors.redAccent,
                          labelText: "Email",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                    ),

                    /// civil ID no more required therefore commented
                    // Container(
                    //   ///  what is civil ID and does it have any minimum or maximum characters
                    //   margin:
                    //       EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                    //   child: TextFormField(
                    //     validator: MultiValidator([
                    //       RequiredValidator(errorText: 'Civi Id is required.'),
                    //       MinLengthValidator(3,
                    //           errorText: "Enter a valid Civl ID.")
                    //     ]),
                    //     decoration: InputDecoration(
                    //       fillColor: Colors.redAccent,
                    //       focusColor: Colors.redAccent,
                    //       labelText: "Civl Id",
                    //       border: OutlineInputBorder(
                    //           borderSide: BorderSide(width: 2),
                    //           borderRadius:
                    //               BorderRadius.all(Radius.circular(10))),
                    //     ),
                    //   ),
                    // ),

                    //...
                    // address
                    // Container(
                    //   margin:
                    //       EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                    //   child: TextFormField(
                    //     controller: addressTextController,
                    //     textInputAction: TextInputAction.next,
                    //     validator: MultiValidator([
                    //       RequiredValidator(errorText: 'Address is required.'),
                    //       MinLengthValidator(9,
                    //           errorText: "Address too short."),
                    //       MaxLengthValidator(50, errorText: "Address too Long")
                    //     ]),
                    //     decoration: InputDecoration(
                    //       fillColor: Colors.redAccent,
                    //       focusColor: Colors.redAccent,
                    //       labelText: "Address",
                    //       border: OutlineInputBorder(
                    //           borderSide: BorderSide(width: 2),
                    //           borderRadius:
                    //               BorderRadius.all(Radius.circular(10))),
                    //     ),
                    //   ),
                    // ),
                    // phone number
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                      child: TextFormField(
                        controller: phoneTextController,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.phone,
                        maxLength: 8,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: 'Phone number is required.'),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                    ),
                    DropDownWidgetsOfDonorRegistrationPage(),
                    // pass field
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                      child: TextFormField(
                        controller: passwordTextController,
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'Password is required.'),
                          MinLengthValidator(8,
                              errorText:
                                  'Password must be at least 8 digits long.'),
                        ]),
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Create a Password",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                    color: Colors.redAccent,
                    border: Border.all(color: Colors.black45),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextButton(
                  onPressed: () async {
                    if (_donorRegistrationFormKey.currentState.validate() &&
                        selectedGender != null &&
                        selectedBloodType != null &&
                        selectedCity != null &&
                        selectedProfession != null) {
                      await FirebaseAuthService().signUpDonor(
                          email: emailTextController.text,
                          password: passwordTextController.text,
                          donor: DonorModel(
                              name: firstNameTextController.text,
                              lastname: lastNameTextController.text,
                              email: emailTextController.text,
                              // address: "random address 12345",
                              phone: "+968" + phoneTextController.text,
                              gender: selectedGender,
                              bloodType: selectedBloodType,
                              city: selectedCity,
                              profession: selectedProfession));
                      selectedProfession = null;
                      selectedCity = null;
                      selectedGender = null;
                      selectedBloodType = null;
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Container(
                          child: Text("Recheck all fields !"),
                        ),
                        backgroundColor: Colors.redAccent,
                      ));
                    }
                  },
                  child: Text(
                    "        Register as a Donor.        ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class DropDownWidgetsOfDonorRegistrationPage extends StatefulWidget {
  @override
  _DropDownWidgetsOfDonorRegistrationPageState createState() =>
      _DropDownWidgetsOfDonorRegistrationPageState();
}

class _DropDownWidgetsOfDonorRegistrationPageState
    extends State<DropDownWidgetsOfDonorRegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // gender , blood type and city
          Container(
            // width: MediaQuery.of(context).size.width * 0.9,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: Row(
              children: [
                SizedBox(width: 10),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.only(right: 20),
                    child: DropdownButton(
                      isExpanded: true,
                      hint: selectedGender == null
                          ? Text("Gender",
                              style: TextStyle(fontWeight: FontWeight.w300))
                          : Text(selectedGender,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400)),
                      items: genders.map(
                        (val) {
                          return DropdownMenuItem<String>(
                              value: val, child: Text(val));
                        },
                      ).toList(),
                      onChanged: (value) {
                        setState(() {
                          setState(() {
                            selectedGender = value;
                            print(selectedGender);
                          });
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.001),
                Flexible(
                  child: Container(
                    child: DropdownButton(
                      isExpanded: true,
                      hint: selectedBloodType == null
                          ? Text("Blood Type",
                              maxLines: 1,
                              style: TextStyle(fontWeight: FontWeight.w300))
                          : Text(selectedBloodType,
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.w400)),
                      items: bloodGroups.map(
                        (val) {
                          return DropdownMenuItem<String>(
                              value: val, child: Text(val));
                        },
                      ).toList(),
                      onChanged: (value) {
                        setState(() {
                          setState(() {
                            selectedBloodType = value;
                            print(selectedBloodType);
                          });
                        });
                      },
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
                          ? Text("City",
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
                SizedBox(width: 10),
              ],
            ),
          ),
          // profession
          Container(
            padding: EdgeInsets.only(left: 5),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: DropdownButton(
              isExpanded: true,
              hint: selectedProfession == null
                  ? Text("Profession",
                      style: TextStyle(fontWeight: FontWeight.w300))
                  : Text(selectedProfession,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w400)),
              items: professions.map(
                (val) {
                  return DropdownMenuItem<String>(value: val, child: Text(val));
                },
              ).toList(),
              onChanged: (value) {
                setState(() {
                  setState(() {
                    selectedProfession = value;
                  });
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
