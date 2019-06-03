import UIKit 

extension UIAlertController {

    enum Actions {

        static func yes(_ then: (() -> Void)? = nil) -> UIAlertAction {
            return UIAlertAction(title: L("generic.yes"), style: .default) { _ in
                then?()
            }
        }
    
        static func no() -> UIAlertAction {
            return UIAlertAction(title: L("generic.no"), style: .default, handler: nil)
        }

        static func dismiss() -> UIAlertAction {
            return UIAlertAction(title: L("generic.dismiss"), style: .default, handler: nil)
        }
    
    }

}