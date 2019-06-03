import Foundation
import UIKit
import Alamofire
import MBProgressHUD

@objc(IPDownloader)
public class Downloader: NSObject {

    override private init() { }

    @objc(sharedInstance)
    public static let instance = Downloader() 

    @objc(downloadAndSavePhotoFromURL:completion:)
    public func downloadAndSavePhoto(from url: URL, completion: @escaping (Error?) -> Void) {
        guard let window = UIApplication.shared.keyWindow else { return }
        let progressHUD = MBProgressHUD.showAdded(to: window, animated: true)
        progressHUD.label.text = L("downloading.photo")
        AF.request(url)
        .responseData { [weak self] response in
            guard let self = self else { return }
            progressHUD.hide(animated: true)
            guard let data = response.data,
                  let image = UIImage(data: data) else { 
                return completion(response.error)
            }
            self.save(image: image) { error in
                guard error != nil else {
                    return completion(error)
                }
                completion(nil)
            }
        }
    }

}