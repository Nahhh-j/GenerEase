import Foundation
import ActivityKit

@available(iOS 16.1, *)
class LiveActivityManager {
    @discardableResult // 함수가 반환하는 값을 사용하지 않을 때 경고 무시
    static func startActivity(helperName: String, connectingState: String) throws -> String {
        var activity: Activity<LiveActivityAttributes>?
        let initialState = LiveActivityAttributes.ContentState(helperName: helperName, connectingState: connectingState)
        
        do {
            activity = try Activity.request(attributes: LiveActivityAttributes(), contentState: initialState, pushType: nil)
            guard let id = activity?.id else { throw
                LiveActivityErrorType.failedToGetId
            }
            return id
        } catch {
            throw error
        }
    }
    
    static func endAllActivities() async {
        for activity in Activity<LiveActivityAttributes>.activities {
            await activity.end(dismissalPolicy: .immediate)
        }
    }
    
    static func endActivity(_ id: String) async {
        await Activity<LiveActivityAttributes>.activities.first(where: {
            $0.id == id
        })?.end(dismissalPolicy: .immediate)
    }
    
    static func updateActivity(id: String, helperName: String, connectingState: String) async {
        let updateContentState = LiveActivityAttributes.ContentState(helperName: helperName, connectingState: connectingState)
        let activity = Activity<LiveActivityAttributes>.activities.first(where: {
            $0.id == id
        })
        
        await activity?.update(using: updateContentState)
    }
}

enum LiveActivityErrorType: Error {
    case failedToGetId
}
