
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:openflutterecommerce/presentation/widgets/independent/scaffold.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
class RoyalPagesScreen extends StatefulWidget {
  final RoyalPagesScreenParameters parameters;
  const RoyalPagesScreen({Key key, this.parameters}) : super(key: key);
  @override
  _RoyalPagesScreenState createState() => _RoyalPagesScreenState();
}
class RoyalPagesScreenParameters {
  final String pageurl;
  final String title;
  RoyalPagesScreenParameters(this.title, this.pageurl);
}
class _RoyalPagesScreenState extends State<RoyalPagesScreen> {
  InAppWebViewController webView;
  String url = "";
  double progress = 0;

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: OpenFlutterScaffold(
          background: null,
          title: widget.parameters.title,
          body:  Container(
        child: Column(children: <Widget>[
        Expanded(
        child: Stack(
        children: <Widget>[
        Align(
        alignment: Alignment.center,
        child:InAppWebView(
            initialUrl: "https://royalautopartsmarket.com" + widget.parameters.pageurl,
            initialHeaders: {},
            initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  debuggingEnabled: false,
                )
            ),
            onWebViewCreated: (InAppWebViewController controller) async {
              webView = controller;

            },
            onLoadStart: (InAppWebViewController controller, String url) async {

              setState(() {
                this.url = url;
              });
            },
            onLoadStop: (InAppWebViewController controller, String url) async {
              int result1 = await controller.evaluateJavascript(source: "var element = document.getElementsByClassName('site__mobile-header');if (element.length > 0) { element[0].style.display = 'none';}");


              setState(() {
                this.url = url;
              });
            },
            onProgressChanged: (InAppWebViewController controller, int progress) async{
              setState(() {
                this.progress = progress / 100;
                bool nothide = true;
                if( nothide && this.progress>0.2)
                  {
                      controller.evaluateJavascript(source: "var element = document.getElementsByClassName('site__mobile-header');if (element.length > 0) { element[0].style.display = 'none';}");
                    nothide = false;

                  }
              });
            },
          )),
          Align(
              alignment: Alignment.center,
              child: _buildProgressBar()
          ),
          ],
        ))
        ])),
          bottomMenuIndex: 2,
        ));
  }
  Widget _buildProgressBar() {
    if (progress != 1.0) {
      return CircularProgressIndicator();
// You can use LinearProgressIndicator also
//      return LinearProgressIndicator(
//        value: progress,
//        valueColor: new AlwaysStoppedAnimation<Color>(Colors.orange),
//        backgroundColor: Colors.blue,
//      );
    }
    return Container();
  }
}
