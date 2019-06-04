import UIKit

extension UIAlertController {

    @objc
    public func show() {
        let rootVC = UIApplication.shared.keyWindow?.rootViewController
        rootVC?.present(self, animated: true, completion: nil)
    }

    @objc(showOnViewController:)
    public func show(on viewController: UIViewController) {
        viewController.present(self, animated: true, completion: nil)
    }

    @objc(errorAlertForError:)
    public static func errorAlert(for error: Error?) -> UIAlertController {
        let message = error?.localizedDescription ?? L("alert.error.default_message")
        let alert = UIAlertController(title: L("generic.error"),
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertController.Actions.dismiss())
        return alert
    }

    @objc(localizedAlertWithTitle:message:)
    public static func localizedAlert(withTitle title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: L(title),
                                      message: L(message),
                                      preferredStyle: .alert)
        alert.addAction(UIAlertController.Actions.dismiss())
        return alert
    }

    @objc(debugAlertWithItem:)
    public static func debugAlert(with item: AnyObject) -> UIAlertController {
         let alert = UIAlertController(title: "Debug",
                                      message: item.debugDescription,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertController.Actions.dismiss())
        return alert
    }
}