import Foundation

extension Bundle {

    @objc
    public static func L(_ localizedKey: String) -> String {
        return Bundle.main.localizedString(forKey: "instap4tch0.\(localizedKey)", 
                                           value: "**instap4tch0.\(localizedKey)**", 
                                           table: nil)
    }   

}