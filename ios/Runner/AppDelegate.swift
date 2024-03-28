import UIKit
import ActivityKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      let controller = window?.rootViewController as! FlutterViewController
      let channel = FlutterMethodChannel(
        name: "generease", binaryMessenger: controller.binaryMessenger
      )
      
      channel.setMethodCallHandler{[weak self] (call, result) in
          if call.method == "showLiveActivity" {
              print("in showLiveActivity")
//              self?.showLiveActivity()
              
              let args = call.arguments as? [String]
              let helperName = args?[0]
              let connectingState = args?[1]
              
              print(helperName ?? "")
              print(connectingState ?? "")
              
              do {
                  self?.deleteAllActivities()
                  
                  if #available(iOS 16.1, *) {
                      let id = try LiveActivityManager.startActivity(helperName: helperName ?? "", connectingState: connectingState ?? "")
                      print("Live Activity ID : \(id)")
                  } else {
                      // Fallback on earlier versions
                      print("iOS 16.1 이상이 아님")
                  }
              } catch {
                  print(error.localizedDescription)
              }
          }
      }
      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
//    private func showLiveActivity() {
//        if #available(iOS 16.2, *) {
//            if ActivityAuthorizationInfo().areActivitiesEnabled {
//                let liveWidgetAttributes = LiveWidgetAttributes(name: "테스트")
//                let contentState = LiveWidgetAttributes.ContentState(emoji: "🐈‍⬛")
//                
//                do {
//                    let activity = try Activity.request(
//                        attributes: liveWidgetAttributes, contentState: contentState
//                    )
//                    print(activity)
//                } catch {
//                    print(error)
//                }
//            }
//        }
//    }
    
    private func deleteAllActivities() {
        print("in deleteAllActivities")
    }
}
