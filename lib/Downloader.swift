import Foundation
import UIKit
import Alamofire
import MBProgressHUD

@objc(IPDownloader)
public class Downloader: NSObject {

    override private init() { }

    @objc(sharedInstance)
    public static let instance = Downloader() 

    @objc(downloadPhotoFromURL:withGestureRecognizer:)
    public func downloadPhoto(from url: URL, gestureRecognizer: UIGestureRecognizer) {
        guard let window = UIApplication.shared.keyWindow else { return }
        gestureRecognizer.isEnabled = false
        let progressHUD = MBProgressHUD.showAdded(to: window, animated: true)
        progressHUD.label.text = "Downloading photo..."
        AF.request(url)
        .responseData { response in
            progressHUD.hide(animated: true)
            guard let data = response.data,
                  let image = UIImage(data: data) else { return }
            let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            window.rootViewController?.present(activityVC, animated: true) {
                gestureRecognizer.isEnabled = true
            }
        }
    }

}