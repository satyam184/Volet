package com.example.wallet

import android.app.Activity
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class UpiNativeBridge(private val activity: Activity?) {
    private var pendingResult: MethodChannel.Result? = null
    private val UPI_REQUEST_CODE = 2025

    fun handleMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "startTransaction" -> {
                if (pendingResult != null) {
                    result.error("PENDING", "Another transaction is still in progress", null)
                    return
                }

                val upiId = call.argument<String>("upiId")
                val name = call.argument<String>("name") ?: ""
                val note = call.argument<String>("note") ?: ""
                val amount = call.argument<String>("amount") ?: ""

                if (upiId.isNullOrEmpty() || amount.isEmpty()) {
                    result.error("INVALID_ARGS", "upiId and amount required", null)
                    return
                }

                startUpiPayment(upiId, name, note, amount, result)
            }
            else -> result.notImplemented()
        }
    }

    private fun startUpiPayment(
        upiId: String,
        name: String,
        note: String,
        amount: String,
        result: MethodChannel.Result
    ) {
        if (activity == null) {
            result.error("NO_ACTIVITY", "Activity is null", null)
            return
        }

        val uri = Uri.parse("upi://pay").buildUpon()
            .appendQueryParameter("pa", upiId)
            .appendQueryParameter("pn", name)
            .appendQueryParameter("tn", note)
            .appendQueryParameter("am", amount)
            .appendQueryParameter("cu", "INR")
            .build()

        val intent = Intent(Intent.ACTION_VIEW, uri)
        val chooser = Intent.createChooser(intent, "Pay with UPI")

        val pm: PackageManager = activity.packageManager
        val apps = pm.queryIntentActivities(intent, 0)
        if (apps.isEmpty()) {
            result.error("NO_UPI_APP", "No UPI app found", null)
            return
        }

        pendingResult = result
        activity.startActivityForResult(chooser, UPI_REQUEST_CODE)
    }

    fun handleActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (requestCode != UPI_REQUEST_CODE) return

        val response = data?.getStringExtra("response")
        val map = parseUpiResponse(response)

        pendingResult?.success(map)
        pendingResult = null
    }

    private fun parseUpiResponse(response: String?): Map<String, String?> {
        if (response == null) {
            return mapOf("status" to "FAILED", "message" to "Cancelled or no response")
        }

        val pairs = response.split("&").mapNotNull {
            val parts = it.split("=")
            if (parts.size == 2) parts[0] to parts[1] else null
        }.toMap()

        val status = pairs["Status"]?.uppercase() ?: "FAILED"
        val approvalRef = pairs["ApprovalRefNo"] ?: pairs["txnRef"]

        return mapOf(
            "status" to status,
            "txnId" to pairs["txnId"],
            "txnRef" to pairs["txnRef"],
            "approvalRef" to approvalRef,
            "responseCode" to pairs["responseCode"],
            "message" to when (status) {
                "SUCCESS" -> "Transaction successful"
                "FAILURE" -> "Transaction failed"
                "SUBMITTED" -> "Transaction pending"
                else -> "Unknown status"
            }
        )
    }
}

