import UIKit

extension UIAlertController {

    @objc
    public func show() {
        let rootVC = UIApplication.shared.keyWindow?.rootViewController
        rootVC?.present(self, animated: true, completion: nil)
    }

}