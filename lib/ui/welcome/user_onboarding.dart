import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hafsa/ui/authentication/splash.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
          color: isActive ? Colors.red : Colors.white10,
          borderRadius: BorderRadius.all(Radius.circular(12)),
          border: Border.all(color: Colors.red)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              // stops: [0.05, 0.2, 0.7, 0.9],
              colors: [Colors.white, Colors.white],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: 550.0,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              //  child: FlutterLogo(size: 300,),
                              child: Image(
                                image: AssetImage(
                                  'assets/images/logo.png',
                                ),
                                height: 300.0,
                                width: 300.0,
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'Welcome To\nBlood Donation App',
                              style: kTitleStyle,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 7.0),
                            Text(
                              '100% Free app for finding Blood Donors.',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                height: 1.2,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              // child: FlutterLogo(size: 300),
                              child: Image(
                                image: AssetImage(
                                  'assets/images/onboarding_image2.jpeg',
                                ),
                                height: 300.0,
                                width: 300.0,
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Text(
                              'Just 1 Donation Can\nSave Up To 3 Lives.',
                              style: kSubtitleStyle,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Center(
//                              child: FlutterLogo(size: 300),
                              child: Image(
                                image: AssetImage(
                                  'assets/images/logo.png',
                                ),
                                height: 300.0,
                                width: 300.0,
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Text(
                              'More Than 38,000\nBlood Donations Are\nNeeded Every Day.',
                              textAlign: TextAlign.center,
                              style: kSubtitleStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _currentPage == _numPages - 1
                        ? Text(" ")
                        : TextButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  border: Border.all(color: Colors.black45),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              padding: EdgeInsets.all(4),
                              child: Text(
                                ' Next ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                ),
                              ),
                            ),
                          ),
                    SizedBox(height: 15),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return AuthStreamScreen();
                        }));
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black45),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Text(
                          'Go To Login',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// styles for fonts
final kTitleStyle = TextStyle(
  color: Colors.black,
  fontFamily: 'CM Sans Serif',
  fontSize: 26.0,
  height: 1.5,
);

final kSubtitleStyle = TextStyle(
  color: Colors.black,
  fontSize: 26.0,
  height: 1.5,
);
