import Foundation
import UIKit
import Alamofire
import MBProgressHUD

@objc(IPDownloader)
public class Downloader: NSObject {

    override private init() { }

    @objc(sharedInstance)
    public static let instance = Downloader() 

    @objc(downloadPost:withURL:completion:)
    public func download(post: PostType, with url: URL, completion: @escaping (Error?) -> Void) {
        guard let window = UIApplication.shared.keyWindow else { return }
        let progressHUD = MBProgressHUD.showAdded(to: window, animated: true)
        progressHUD.label.text = post.downloadMessage
        let destination = DownloadRequest.suggestedDownloadDestination(for: .cachesDirectory, options: [.removePreviousFile])
        AF.download(url, to: destination)
        .response { [weak self] response in
            guard let self = self else { return }
            progressHUD.hide(animated: true)
            guard let destinationURL = response.fileURL else {
                return completion(response.error)
            }
            self.save(post: post, with: destinationURL) { error in
                guard error != nil else {
                    return completion(error)
                }
                completion(nil)
            }
        }
    }

}

private extension PostType {

    var downloadMessage: String {
        switch self {
            case .photo: return L("downloading.photo")
            case .video: return L("downloading.video")
            default: return ""
        }
    }

}