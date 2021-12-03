import 'package:flutter/material.dart';
import 'package:hafsa/services/firebase_auth.dart';
import 'package:hafsa/services/firebase_user.dart';
import 'package:hafsa/ui/authentication/signIn.dart';

import 'edit_profile_page.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  bool loading = true;
  var userData;

  fetchTheUser() async {
    String uid = FirebaseAuthService().getUser().uid;
    userData = await UserServices().fetchUser(uid: uid);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchTheUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  CustomDisplayTile(
                    title: "First Name",
                    value: userData["details"]["name"].toString(),
                  ),
                  CustomDisplayTile(
                    title: "Last Name",
                    value: userData["details"]["lastname"].toString(),
                  ),
                  CustomDisplayTile(
                    title: "Email",
                    value: userData["details"]["email"].toString(),
                  ),
                  CustomDisplayTile(
                    title: "Phone",
                    value: userData["details"]["phone"].toString(),
                  ),
                  CustomDisplayTile(
                    title: "City",
                    value: userData["details"]["city"].toString(),
                  ),
                  CustomDisplayTile(
                    title: "Gender",
                    value: userData["details"]["gender"].toString(),
                  ),
                  CustomDisplayTile(
                    title: "Profession",
                    value: userData["details"]["profession"].toString(),
                  ),
                  userData["details"]["bloodType"] == null
                      ? SizedBox()
                      : CustomDisplayTile(
                          title: "Blood Type",
                          value: userData["details"]["bloodType"].toString(),
                        ),
                  Container(
                    margin: EdgeInsets.only(top: 30, bottom: 20),
                    width: MediaQuery.of(context).size.width * 0.9,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.redAccent.shade200),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            print("\n\n\n" +
                                FirebaseAuthService().getUser().uid +
                                "\n\n\n");
                            return ModifyProfileScreen(
                              userData: userData,
                              uid: FirebaseAuthService().getUser().uid,
                            );
                          }));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Modify          ",
                              textScaleFactor: 1.3,
                              style:
                                  TextStyle(color: Colors.redAccent.shade200),
                            ),
                            Icon(
                              Icons.edit_outlined,
                              color: Colors.redAccent.shade200,
                            ),
                          ],
                        )),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: EdgeInsets.only(bottom: 30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.redAccent.shade200,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: TextButton(
                        onPressed: () async {
                          await FirebaseAuthService().deleteAccount();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => SingInScreen()),
                              (Route<dynamic> route) => false);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Delete          ",
                              textScaleFactor: 1.3,
                              style: TextStyle(color: Colors.black),
                            ),
                            Icon(
                              Icons.delete,
                              color: Colors.black,
                            ),
                          ],
                        )),
                  )
                ],
              ),
            ),
    );
  }
}

class CustomDisplayTile extends StatelessWidget {
  final String title, value;

  const CustomDisplayTile({this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      color: Colors.redAccent.shade100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(3))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  textScaleFactor: 1.3,
                ),
                Text(
                  ":",
                  textScaleFactor: 1.2,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Spacer(),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              value,
              textScaleFactor: 1.3,
              style: TextStyle(color: Colors.white),
            ),
          ),
          Spacer()
        ],
      ),
    );
  }
}
