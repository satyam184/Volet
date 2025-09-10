import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet/utils/screen_util.dart';
import 'package:wallet/views/pay_screen/upi_native_bridge/upi_native_bridge.dart';

class PayScreen extends StatefulWidget {
  const PayScreen({super.key});

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  final TextEditingController amount = TextEditingController();
  String _status = "";

  Future<void> _startPayment() async {
    try {
      if (amount.text.isEmpty) {
        setState(() => _status = "Please enter an amount");
        return;
      }
      final result = await UpiNativeBridge.startPayment(
        upiId: "test@upi",
        name: "Auto Driver",
        note: "Ride payment",
        amount: amount.text,
      );
      setState(() {
        _status =
            "Payment status: ${result['status']}\nRaw: ${result['rawResponse']}";
      });
    } on PlatformException catch (e) {
      setState(() => _status = "Error: ${e.message}");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text('cab'),
        leadingWidth: ScreenUtil.width(6),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
      ),
      body: Center(
        child: Column(
          children: [
            CircleAvatar(radius: ScreenUtil.width(15)),
            Text('status: $_status'),
            Container(
              margin: EdgeInsets.only(top: ScreenUtil.height(7)),
              width: ScreenUtil.width(20),
              child: TextField(
                controller: amount,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  hintText: '₹',
                  hintStyle: TextStyle(
                    color: Colors.grey.withValues(alpha: 0.5),
                    fontSize: 20.0,
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 5),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        spacing: 6,
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
            onPressed: () {},
            label: Text(
              'Add Manually',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: Color(0xFF5e78a2),
            enableFeedback: true,
            isExtended: true,
            extendedPadding: EdgeInsets.symmetric(
              horizontal: ScreenUtil.width(30),
            ),
          ),
          FloatingActionButton.extended(
            onPressed: () {
              _startPayment();
            },
            label: Text(
              'Pay',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: Color(0xFF5e78a2),
            enableFeedback: true,
            isExtended: true,
            extendedPadding: EdgeInsets.symmetric(
              horizontal: ScreenUtil.width(40),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
