import 'package:flutter/services.dart';

class UpiNativeBridge {
  static const _channel = MethodChannel("com.example.wallet/channel");

  static Future<String> getHelloMessage() async {
    try {
      final result = await _channel.invokeMethod<String>("getHelloMessage");
      return result ?? "No message from native side";
    } on PlatformException catch (e) {
      return "Failed: ${e.message}";
    }
  }
}
