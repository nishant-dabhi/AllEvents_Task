import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// shows webView in app via event_url provided
class EventWebView extends StatelessWidget {
  final String eventUrl;

  const EventWebView({Key? key, required this.eventUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(eventUrl));
    return Scaffold(
        appBar: AppBar(
          title: Text('Event Detail'),
        ),
        body: WebViewWidget(
          controller: webViewController,
        ));
  }
}
