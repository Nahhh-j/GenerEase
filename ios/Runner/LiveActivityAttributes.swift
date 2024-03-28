import Foundation
import ActivityKit

class LiveActivityAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var helperName: String
        var connectingState: String
    }
}
