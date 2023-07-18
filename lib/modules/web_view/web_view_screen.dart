// ignore_for_file: prefer_const_literals_to_create_immutables, sized_box_for_whitespace, must_be_immutable, unnecessary_string_interpolations, use_key_in_widget_constructors, prefer_const_constructors, avoid_print, unused_local_variable, prefer_typing_uninitialized_variables, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {

  late final String url;
  late final String text;
  WebViewScreen(this.text,this.url);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {

  final WebViewController _controller = WebViewController();
  @override
  void initState()
  {
    super.initState();
    print(widget.url);
    _controller.loadRequest(
      Uri.parse(widget.url),
    );

  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.text
        ),
      ),
      body: WebViewWidget(
        controller: _controller,
      )
    );
  }
}

