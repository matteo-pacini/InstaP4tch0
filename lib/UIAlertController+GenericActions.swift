import UIKit 

extension UIAlertController {

    struct Actions {

        static func yes(_ then: (() -> Void)? = nil) -> UIAlertAction {
            return UIAlertAction(title: Bundle.L("generic.yes"), style: .default) { _ in
                then?()
            }
        }
    
        static func no() -> UIAlertAction {
            return UIAlertAction(title: Bundle.L("generic.no"), style: .default, handler: nil)
        }
    
    }

}