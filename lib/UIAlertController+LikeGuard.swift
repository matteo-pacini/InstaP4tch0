import UIKit

extension UIAlertController {

    @objc(likeAlertWithPostType:success:)
    public static func likeAlert(with postType: PostType, success: @escaping (() -> Void)) -> UIAlertController {

        let message = String(format: L("alert.double_tap_guard.message"), postType.doubleTapString)
        let alert = UIAlertController(title: L("generic.warning"),
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertController.Actions.yes(success))
        alert.addAction(UIAlertController.Actions.no())
        return alert

    }

}

private extension PostType {

    var doubleTapString: String {
        switch self {
            case .photo: return L("alert.double_tap_guard.type.photo")
            case .page: return L("alert.double_tap_guard.type.page")
            case .video: return L("alert.double_tap_guard.type.video")
        }
    }

}