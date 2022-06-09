import UIKit
import Flutter
import FlutterPluginRegistrant

@UIApplicationMain
class AppDelegate: FlutterAppDelegate {
    lazy var flutterEngine = FlutterEngine(name: "my flutter engine")
    var flutterViewController: FlutterViewController?
    
    var onGetArgsValue: (() -> Bool)?
    var onSetArgsValue: ((Bool) -> Void)?

    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        flutterEngine.run();
        
        flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        flutterViewController!.modalPresentationStyle = .fullScreen
        
        attachMethodChannel()
        
        GeneratedPluginRegistrant.register(with: self.flutterEngine);
        return super.application(application, didFinishLaunchingWithOptions: launchOptions);
    }
    
    private func attachMethodChannel() {
        let channel = FlutterMethodChannel(name: "samples.flutter.dev/args",
                                           binaryMessenger: flutterViewController!.binaryMessenger)
        channel.setMethodCallHandler({
          [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
            
            if (call.method == "getArgsValue") {
                if let onGetArgsValue = self?.onGetArgsValue {
                    return result(onGetArgsValue())
                }
            } else if (call.method == "setArgsValue") {
                let val = (call.arguments as! Dictionary<String, Any>)["args"] as? Bool
                
                if let onSetArgsValue = self?.onSetArgsValue, let val = val {
                    onSetArgsValue(val)
                }
                
                return result(true)
            }

            result(FlutterMethodNotImplemented)
        })
    }
}
