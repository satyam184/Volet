import 'package:flutter/material.dart';
import 'package:wallet/utils/screen_util.dart';

class PayScreen extends StatefulWidget {
  const PayScreen({super.key});

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  final TextEditingController amount = TextEditingController();

  @override
  void dispose() {
    amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
        title: Text('cab'),
        leadingWidth: ScreenUtil.width(6),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: ScreenUtil.height(5)),
              child: CircleAvatar(radius: ScreenUtil.width(15)),
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenUtil.height(7)),
              width: ScreenUtil.width(20),
              child: TextField(
                controller: amount,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
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
            onPressed: () {},
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
