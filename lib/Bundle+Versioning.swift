import Foundation

extension Bundle {

    static let alamofire: Bundle = {
        let aClass: AnyClass = NSClassFromString("_TtC9Alamofire15SessionDelegate")!
        return Bundle(for: aClass)
    }()

    static let mbProgressHud: Bundle = {
        let aClass: AnyClass = NSClassFromString("MBProgressHUD")!
        return Bundle(for: aClass)
    }()

    static let quickTableViewController: Bundle = {
        let aClass: AnyClass = NSClassFromString("_TtC24QuickTableViewController24QuickTableViewController")!
        return Bundle(for: aClass)
    }()

}

extension Bundle { 

    var shortVersionString: String {
        return infoDictionary?["CFBundleShortVersionString"] as? String ?? "???"
    }
}
