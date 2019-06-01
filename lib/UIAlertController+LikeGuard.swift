import UIKit

extension UIAlertController {

    @objc(likeAlertWithPostType:success:)
    public static func likeAlert(with postType: PostType, success: @escaping (() -> Void)) -> UIAlertController {

        let message = String(format: Bundle.L("alert.double_tap_guard.message"), postType.doubleTapString)
        let alert = UIAlertController(title: Bundle.L("generic.warning"),
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertController.Actions.yes(success))
        alert.addAction(UIAlertController.Actions.no())
        return alert

    }

}