import 'package:flutter/services.dart';

class UpiNativeBridge {
  static const _channel = MethodChannel("com.example.wallet/channel");

  static Future<Map<String, dynamic>> startPayment({
    required String upiId,
    required String name,
    required String note,
    required String amount,
  }) async {
    try {
      final result = await _channel.invokeMethod<Map<dynamic, dynamic>>(
        "startTransaction",
        {"upiId": upiId, "name": name, "note": note, "amount": amount},
      );
      return Map<String, dynamic>.from(result ?? {});
    } on PlatformException catch (e) {
      return {"status": "ERROR", "message": e.message};
    }
  }
}
