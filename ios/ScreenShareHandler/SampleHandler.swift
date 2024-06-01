//
//  SampleHandler.swift
//  ScreenShareHandler
//
//  Created by 이지원 on 2024/05/21.
//

import ReplayKit
import BroadcastWriter
import Photos

class SampleHandler: RPBroadcastSampleHandler {
    
    private var writer: BroadcastWriter?
    private let fileManager: FileManager = .default
    private let nodeURL: URL
    private let videoOutputFullFileName = "\\(Date().timeIntervalSince1970)"
    
    override init() {
        print("🧩 Broadcast Sample Handler Created")
        nodeURL = fileManager.temporaryDirectory
            .appendingPathComponent(UUID().uuidString)
            .appendingPathExtension(for: .mpeg4Movie)
                
        fileManager.removeFileIfExists(url: nodeURL)
                
        super.init()
    }

    override func broadcastStarted(withSetupInfo setupInfo: [String : NSObject]?) {
        // User has requested to start the broadcast. Setup info from the UI extension can be supplied but optional.
        
        let screen: UIScreen = .main
        
        do {
            writer = try .init(
                outputURL: nodeURL,
                screenSize: screen.bounds.size,
                screenScale: screen.scale
            )
        } catch {
            assertionFailure(error.localizedDescription)
            finishBroadcastWithError(error)
            return
        }
        
        do {
            try writer?.start()
        } catch {
            finishBroadcastWithError(error)
        }
    }
    
    override func broadcastPaused() {
        // User has requested to pause the broadcast. Samples will stop being delivered.
        
        debugPrint("=== paused")
        writer?.pause()
    }
    
    override func broadcastResumed() {
        // User has requested to resume the broadcast. Samples delivery will resume.
        
        debugPrint("=== resumed")
        writer?.resume()
    }
    
    override func broadcastFinished() {
        // User has requested to finish the broadcast.
        
        guard let writer = writer else {
            return
        }
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        
        let outputURL: URL
        
        do {
            outputURL = try writer.finish()
        } catch {
            debugPrint("writer failure", error)
            dispatchGroup.leave()
            return
        }
        
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: outputURL)
        }) { completed, error in
            if completed {
                print("🎥 Video \\(self.videoOutputFullFileName) has been moved to camera roll")
            }
            
            if error != nil {
                print ("🧨 Cannot move the video \\(self.videoOutputFullFileName) to camera roll, error: \\(error!.localizedDescription)")
            }
            
            dispatchGroup.leave()
        }
        
        dispatchGroup.wait()
    }
    
    override func processSampleBuffer(_ sampleBuffer: CMSampleBuffer, with sampleBufferType: RPSampleBufferType) {
//        switch sampleBufferType {
//        case RPSampleBufferType.video:
//            // Handle video sample buffer
//            break
//        case RPSampleBufferType.audioApp:
//            // Handle audio sample buffer for app audio
//            break
//        case RPSampleBufferType.audioMic:
//            // Handle audio sample buffer for mic audio
//            break
//        @unknown default:
//            // Handle other sample buffer types
//            fatalError("Unknown type of sample buffer")
//        }
        
        guard let writer = writer else {
            debugPrint("processSampleBuffer: Writer is nil")
            return
        }
                
        do {
            let captured = try writer.processSampleBuffer(sampleBuffer, with: sampleBufferType)
            debugPrint("processSampleBuffer captured", captured)
        } catch {
            debugPrint("processSampleBuffer error:", error.localizedDescription)
        }
    }
}

extension FileManager {
    func removeFileIfExists(url: URL) {
        guard fileExists(atPath: url.path) else { return }
        do {
            try removeItem(at: url)
        } catch {
            print("error removing item \\(url)", error)
        }
    }
}
