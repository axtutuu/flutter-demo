import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:nfc_manager/nfc_manager.dart';

class NFCViewPage extends StatefulWidget {
  const NFCViewPage({Key? key}) : super(key: key);
  
  @override
  State<NFCViewPage> createState() => _NFCViewPageState();
}

class _NFCViewPageState extends State<NFCViewPage> {
  var currentTag = "";

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: 'http://10.0.2.2:8080/nfc',
      // initialUrl: 'http://localhost:8080/nfc',
      javascriptMode: JavascriptMode.unrestricted,
      javascriptChannels: {
        JavascriptChannel(
          name: "flutterApp",
          onMessageReceived: (JavascriptMessage result) async {
            debugPrint(result.message);
            final check = await NfcManager.instance.isAvailable();
            if (!check) {
              showDialog(context: context, builder: (_) {
                return AlertDialog(
                  title: const Text("NFC未対応"),
                  actions: [
                    TextButton(
                      child: const Text("OK"),
                      onPressed: () => Navigator.pop(context),
                    )
                  ]
                );
              });
              return;
            }
            
            if (result.message == 'write') {
              NfcManager.instance.startSession(
                onDiscovered: (NfcTag tag) async {
                  var ndef = Ndef.from(tag);
                  if (ndef == null || !ndef.isWritable) {
                    NfcManager.instance.stopSession(errorMessage: "not permitted");
                    return;
                  }
                  NdefMessage message = NdefMessage([
                    NdefRecord.createText('Hello World!'),
                  ]);
                  try {
                    await ndef.write(message);
                    NfcManager.instance.stopSession();
                  } catch (e) {
                    NfcManager.instance.stopSession(errorMessage: "faliled!");
                  }
                  currentTag = tag.data.toString();
              });
            }
            
            if (result.message == 'read') {
              NfcManager.instance.startSession(
                onDiscovered: (NfcTag tag) async {
                  debugPrint(tag.data.toString());
                  currentTag = tag.data.toString();
                  showDialog(context: context, builder: (_) {
                    return AlertDialog(
                      title: Text(currentTag),
                      actions: [
                        TextButton(
                          child: const Text("OK"),
                          onPressed: () => Navigator.pop(context),
                        )
                      ]
                    );
                  });
                  NfcManager.instance.stopSession();
              });
            }
          }
        )
      },
    );
  }
}