import 'package:flutter/material.dart';

void snackBar(
  BuildContext context, {
  required String message,
  Color backgroundColor = Colors.blueAccent,
  IconData? icon,
  Duration duration = const Duration(milliseconds: 1000),
  bool floating = true,
  bool autoDismiss = true,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: floating ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
      duration: autoDismiss ? duration : const Duration(days: 1),
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white),
              SizedBox(width: 10),
            ],
            Expanded(
              child: Text(
                message,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
