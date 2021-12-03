import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hafsa/services/firebase_auth.dart';
import 'package:hafsa/ui/authentication/signUp_donor.dart';
import 'package:hafsa/ui/authentication/signUp_seeker.dart';

class SingInScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                //  child: FlutterLogo(size: 300,),
                child: Image(
                  image: AssetImage(
                    'assets/images/logo.png',
                  ),
                  height: 280.0,
                  width: 280.0,
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailTextController,
                        keyboardType: TextInputType.emailAddress,
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
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: passwordTextController,
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'Password is required.'),
                          MinLengthValidator(6,
                              errorText:
                                  'Password must be at least 8 digits long.'),
                        ]),
                        decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      )
                    ],
                  ),
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
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      FirebaseAuthService()
                          .signInWithEmailAndPass(
                              email: emailTextController.text.toString(),
                              password: passwordTextController.text.toString())
                          .then((String value) {
                        print("hehe");
                        print(value);
                        if (value.toString().toLowerCase() ==
                            "success".toLowerCase()) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.green,
                              content: Container(
                                child: Text("Successfully Logged In"),
                              )));
                        } else if (value.toString().toLowerCase() ==
                            "Wrong Password".toLowerCase()) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.redAccent,
                              content: Container(
                                child: Text("Wrong Password."),
                              )));
                        } else if (value.toString().toLowerCase() ==
                            "Email not Registered".toLowerCase()) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.redAccent,
                              content: Container(
                                child: Text("Email not Registered."),
                              )));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.redAccent,
                              content: Container(
                                child: Text("Unexpected Error."),
                              )));
                        }
                      });
                    }
                  },
                  child: Text(
                    "   Login   ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                          text: 'Don\'t have an account?',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                          children: <TextSpan>[
                            TextSpan(
                                text: '  Register.',
                                style: TextStyle(
                                    color: Colors.blueAccent, fontSize: 18),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            showDialogBox(context));
                                  })
                          ]),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  showDialogBox(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)), //this right here
      child: Container(
        height: 250.0,
        width: 300.0,
        padding: EdgeInsets.all(10),
        color: Colors.black12,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => DonorSignUp()));
                  },
                  child: Text(
                    'Register as a Donor.',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  )),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text("or"),
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SeekerSignUp()));
                  },
                  child: Text(
                    'Register as a Seeker.',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
