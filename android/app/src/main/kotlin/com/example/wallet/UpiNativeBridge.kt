import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel


class UpiNativeBridge {
    fun handleMethodCall(call: MethodCall, result: MethodChannel.Result){
        when(call.method){
            "getHelloMessage" -> {
                val message = "Hello kotlin"
                result.success(message)
            }else -> result.notImplemented()
        }
    }
}
