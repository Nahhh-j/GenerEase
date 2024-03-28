import WidgetKit
import SwiftUI

struct LiveActivityWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveActivityAttributes.self) { context in
            VStack {
                HStack {
                    Image(systemName: "heart.fill")
                    Spacer()
                    Text(context.state.connectingState)
                        .font(.system(size: 10))
                }
                Text("도우미와 연결중입니다...")
                    .font(.system(size: 14))
                ProgressView(value: 43, total: 100).cornerRadius(3.0).tint(.blue).background(.white)
            }.padding()
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.center) {
                    EmptyView()
                }
                DynamicIslandExpandedRegion(.bottom) {
                    EmptyView()
                }
            } compactLeading: {
                EmptyView()
            } compactTrailing: {
                EmptyView()
            } minimal: {
                EmptyView()
            }
        }
    }
}
