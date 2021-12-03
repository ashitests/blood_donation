import 'package:flutter/material.dart';
import 'package:hafsa/services/firebase_auth.dart';
import 'package:hafsa/ui/authentication/signIn.dart';
import 'package:hafsa/ui/homepage/about_us/about_us_page.dart';
import 'package:hafsa/ui/homepage/profile/my_profile_page.dart';

import 'blood_banks/blood_banks_page.dart';
import 'find_donors/search_donors/search_donor_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blood Donation App"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
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
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  HomePageBox(
                    title: "My Profile",
                    iconData: Icons.person,
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MyProfile())),
                  ),
                  HomePageBox(
                    title: "Find Donors",
                    iconData: Icons.search,
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SearchDonorPage())),
                  ),
                  HomePageBox(
                    title: "Blood Banks",
                    iconData: Icons.home_outlined,
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => BloodBanks())),
                  ),
                  HomePageBox(
                    title: "Log Out\n",
                    iconData: Icons.exit_to_app,
                    onTap: () {
                      FirebaseAuthService().signOut();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => SingInScreen()),
                          (Route<dynamic> route) => false);
                    },
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AboutUsScreen()));
                      },
                      child: Center(
                        child: Text(
                          "About us",
                          textScaleFactor: 1.5,
                          style: TextStyle(
                              color: Colors.white, fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePageBox extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Function onTap;

  HomePageBox({this.iconData, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.35,
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.redAccent.shade100,
            borderRadius: BorderRadius.all(Radius.circular(3)),
            border: Border.all(color: Colors.black38)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: Colors.white,
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
