import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hafsa/services/firebase_auth.dart';
import 'package:hafsa/ui/homepage/find_donors/search_donors/search_donor_controller.dart';
import 'package:hafsa/ui/welcome/user_onboarding.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized();
  await Firebase
      .initializeApp();
  runApp(MyApp());
}

function() {
  print('fuck');
}

class MyApp
    extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(
      BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<
            FirebaseAuthService>(
          create: (_) =>
              FirebaseAuthService(),
        ),
        ChangeNotifierProvider<
                SearchDonorController>(
            create: (context) =>
                SearchDonorController())
      ],
      child: MaterialApp(
        theme: ThemeData().copyWith(
            accentColor: Colors
                .redAccent,
            primaryColor: Colors
                .redAccent),
        debugShowCheckedModeBanner:
            false,
        title:
            'Blood Donation App',
        home: OnBoarding(),
      ),
    );
  }
}
