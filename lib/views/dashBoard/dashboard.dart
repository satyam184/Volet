import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wallet/components/snack_bar.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            snackBar(
              context,
              message: "Data saved successfully!",
              icon: Icons.check_circle,
              backgroundColor: Colors.green,
            );
          },
          child: Text("Show Snackbar"),
        ),
      ),
    );
  }
}
