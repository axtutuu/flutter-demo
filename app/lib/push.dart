import 'package:flutter/material.dart';

import 'package:fcm_config/fcm_config.dart';

class PushView extends StatelessWidget {
  var currentToken = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () async {
                  final token = await FCMConfig.instance.messaging.getToken();
                  currentToken = token.toString();
                  print(token);
                },
                child: const Text('TOKEN')
              ),
              Text(currentToken)
          ],)
        )
    );
  }
}