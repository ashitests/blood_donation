import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomWebView extends StatefulWidget {
  /// we need these variables from the very start
  /// when you tap on a link in instagram these variables are passes in the inApp webBrowser

  final url;
  final title;
  CustomWebView({Key key, @required this.url, @required this.title})
      : super(key: key);
  @override
  _CustomWebViewState createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {
  /// initializing WebView Controller
  Completer<WebViewController> _controller = Completer<WebViewController>();

  /// initializing variale to control progress indicator
  double lineProgress = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,

        /// providing cross icon instead of default back icon to give instagram like effect
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.clear),
        ),

        /// instagram like title Style
        title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              textScaleFactor: 1.0,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
            ),
            SizedBox(height: 5),
            Text(
              widget.url,
              textScaleFactor: 0.6,
              style:
                  TextStyle(color: Colors.white54, fontWeight: FontWeight.w300),
            )
          ],
        ),

        /// Menu Button (3 dots)
        actions: [Menu(_controller.future)],

        /// instagram like Progress Indicator
        bottom: PreferredSize(
          child: _progressBar(lineProgress, context),
          preferredSize: Size.fromHeight(3.0),
        ),
      ),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,

        /// once WebView is creates we have to notify its controller
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },

        /// using on Progress Method implicitly provided to us by WebView
        onProgress: (val) {
          setState(() {
            lineProgress = val / 100;
            print(lineProgress);
          });
        },
      ),
    );
  }
}

/// Menu Widget Extracted
class Menu extends StatelessWidget {
  Menu(this._webViewControllerFuture);
  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> controller) {
        if (!controller.hasData) return Container();
        return PopupMenuButton<String>(
          color: Colors.black.withOpacity(0.95),
          onSelected: (String value) async {
            switch (value) {
              case "Report Website":
                {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      "Website Reported.",
                      style: TextStyle(color: Colors.black),
                    ),
                    backgroundColor: Colors.red.shade500,
                    duration: Duration(seconds: 2),
                  ));
                }
                break;
              case "Refresh":
                {
                  _webViewControllerFuture.then((value) => value.reload());
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      "Refreshing.",
                      style: TextStyle(color: Colors.black),
                    ),
                    backgroundColor: Colors.yellow.shade600,
                    duration: Duration(seconds: 1),
                  ));
                }
                break;
              case "Open In Chrome":
                {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("use url_launcher plugin."),
                    backgroundColor: Colors.blue.shade300,
                    duration: Duration(seconds: 2),
                  ));
                }
                break;
              case "Copy Link":
                {
                  _webViewControllerFuture
                      .then((value) => print(value.currentUrl().toString()));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        "printed in console\nuser copy plugin, to copy to clipboard"),
                    backgroundColor: Colors.yellow.shade300,
                    duration: Duration(seconds: 2),
                  ));
                }
                break;
              case "Share via...":
                {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("use url_launcher plugin."),
                    backgroundColor: Colors.blue.shade300,
                    duration: Duration(seconds: 2),
                  ));
                }
                break;

              default:
                {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Menu Button Tapped."),
                    duration: Duration(seconds: 2),
                  ));
                }
                break;
            }
          },

          /// Menu Items
          itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
            const PopupMenuItem<String>(
              value: 'Report Website',
              child:
                  Text('Report Website', style: TextStyle(color: Colors.red)),
            ),
            const PopupMenuItem<String>(
              value: 'Refresh',
              child: Text('Refresh', style: TextStyle(color: Colors.white)),
            ),
            const PopupMenuItem<String>(
              value: 'Open In Chrome',
              child:
                  Text('Open In Chrome', style: TextStyle(color: Colors.white)),
            ),
            const PopupMenuItem<String>(
              value: 'Copy Link',
              child: Text('Copy Link', style: TextStyle(color: Colors.white)),
            ),
            const PopupMenuItem<String>(
              value: 'Share via...',
              child:
                  Text('Share via...', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}

/// reusable Progress Indicator
_progressBar(double progress, BuildContext context) {
  return LinearProgressIndicator(
    backgroundColor: Colors.white70.withOpacity(0),
    value: progress == 1.0 ? 0 : progress,
    valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
  );
}
