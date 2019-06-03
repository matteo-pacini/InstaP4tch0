import Foundation

extension Bundle {

    @objc
    public static func L(_ localizedKey: String) -> String {
        return Bundle.instap4tch0.localizedString(forKey: "\(localizedKey)", 
                                                  value: "**\(localizedKey)**", 
                                                  table: nil)
    }   

}