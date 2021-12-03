import 'package:flutter/material.dart';
import 'package:hafsa/services/firebase_auth.dart';
import 'package:hafsa/ui/authentication/signIn.dart';
import 'package:hafsa/ui/homepage/homepage.dart';
import 'package:provider/provider.dart';

class AuthStreamScreen extends StatefulWidget {
  @override
  _AuthStreamScreenState createState() => _AuthStreamScreenState();
}

class _AuthStreamScreenState extends State<AuthStreamScreen> {
  @override
  Widget build(BuildContext context) {
    /// is same as
    /// Provider.of<User>(context  ,listen: true);
    return StreamBuilder(
        stream: Provider.of<FirebaseAuthService>(context).authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return Container(
              child: Center(
                child: Text("Error! Check Internet Connection."),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data == null) {
              return SingInScreen();
            } else if (snapshot.hasError) {
              return Container(
                child: Center(
                  child: Text("Error"),
                ),
              );
            }
            return HomePage();
          } else
            // else return a splash for a specific time - if things get right then okay else show a screen with retry
            return Center(child: CircularProgressIndicator());
        });
  }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: StreamBuilder(
//             stream: Provider.of<FirebaseAuthService>(context).authStateChanges,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.active) {
//                 if(snapshot.hasData){
//                   return HomePage();
// //                  Navigator.of(context).push(MaterialPageRoute(builder: (context){return HomePage();}));
//                 } else if(snapshot.data == null){
//                   return SingInScreen();
// //                  Navigator.of(context).push(MaterialPageRoute(builder: (context){return SingInScreen();}));
//                 }
//                 return Center(child: CircularProgressIndicator());
//               } else
//                 return Center(child: Center(child: Text("No Internet Connection :("),));
//             }),
//       ),
//     );
//   }
}
