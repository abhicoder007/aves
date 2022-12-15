import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
class wikiPedia extends StatefulWidget {
  final String link;
  const wikiPedia(this.link, {Key? key}) : super(key: key);

  @override
  State<wikiPedia> createState() => _wikiPediaState();
}

class _wikiPediaState extends State<wikiPedia> {
  String initial_link="";
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      initial_link = widget.link;
    });
    super.initState();
  }
  late WebViewController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: widget.link,
        backgroundColor: Colors.cyan[200],
        zoomEnabled: true,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (webViewController){
          _controller=webViewController;
        },
        onPageStarted: (String url){
          Future.delayed(Duration(microseconds: 500), (){
            _controller.runJavascript("document.getElementByTagName('header')[0].style.display='node'");
            _controller.runJavascript("document.getElementByTagName('footer')[0].style.display='node'");
          });
        },
        navigationDelegate: (NavigationRequest request){
          if(request.url.startsWith(initial_link)){
            print('blocking navigation to $request');
          }
          print('allowing navigation to $request');
          return NavigationDecision.prevent;
        },
      ),
    );
  }
}

