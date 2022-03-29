import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewCookie extends StatefulWidget {
  const WebviewCookie({Key? key}) : super(key: key);

  @override
  State<WebviewCookie> createState() => _WebviewCookieState();
}

class _WebviewCookieState extends State<WebviewCookie> {
  final cookieManager = WebviewCookieManager();

  // final String _url = 'http://localhost:8080/nfc';
  final String _url = 'http://10.0.2.2:8080/cookie';

  @override
  void initState() {
    super.initState();
    cookieManager.clearCookies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: _url,
        javascriptMode: JavascriptMode.unrestricted,
        javascriptChannels: {
          JavascriptChannel(
            name: "flutterApp",
            onMessageReceived: (JavascriptMessage result) {
              debugPrint(result.message);
            }
          )
        },
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        curve: Curves.bounceIn,
        animatedIconTheme: const IconThemeData(size: 22.0),
        children: [
          SpeedDialChild(
            label: "get cookie",
            onTap: () async {
              debugPrint('----------get cookie');
              final cookies = await cookieManager.getCookies(_url);
              for (var item in cookies) {
                debugPrint(item.name);
                debugPrint(item.value);
              }
            }),
          SpeedDialChild(
            // child: const Icon(Icons.person_add),
            label: "set cookie",
            onTap: () async {
              debugPrint('-----------set cookie');
              await cookieManager.setCookies([
                Cookie('sample', 'hogehoge')
                  ..domain = '10.0.2.2'
                  ..expires = DateTime.now().add(const Duration(days: 10))
                  ..httpOnly = false
              ]);
            })
        ],
      )
    );
  }
}