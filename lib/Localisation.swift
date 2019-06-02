import Foundation

extension Bundle {

    static let instap4tch0: Bundle = {
        let bundlePath = Bundle.main.path(forResource: "instap4tch0", ofType: "bundle")!
        return Bundle(path: bundlePath)!
    }()

    @objc
    public static func L(_ localizedKey: String) -> String {
        return Bundle.instap4tch0.localizedString(forKey: "\(localizedKey)", 
                                                  value: "**\(localizedKey)**", 
                                                  table: nil)
    }   

}