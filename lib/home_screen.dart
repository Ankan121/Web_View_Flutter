import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';


class Web_View extends StatefulWidget {
  const Web_View({super.key});

  @override
  State<Web_View> createState() => _Web_ViewState();
}

class _Web_ViewState extends State<Web_View> {
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                SystemNavigator.pop();
              },
            ),

            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  final controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setNavigationDelegate(
  NavigationDelegate(
  onProgress: (int progress) {
  // Update loading bar.
  },
  onPageStarted: (String url) {},
  onPageFinished: (String url) {},
  onHttpError: (HttpResponseError error) {},
  onWebResourceError: (WebResourceError error) {},
  onNavigationRequest: (NavigationRequest request) {
  if (request.url.startsWith('https://www.youtube.com/')) {
  return NavigationDecision.prevent;
  }
  return NavigationDecision.navigate;
  },
  ),
  )
  ..loadRequest(Uri.parse('https://flutter.dev'));
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (e)async{
        await _showMyDialog();
      },
      child: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          elevation: 10,
          backgroundColor: Colors.blue,
          title: const Text('Web View'),
          centerTitle: true,
        ),
        body: Container(
          child: WebViewWidget(controller: controller),
        ),
      ),
    );
  }
}
