import Foundation

extension Bundle {

    static let instap4tch0: Bundle = {
        let bundlePath = Bundle.main.path(forResource: "instap4tch0", ofType: "bundle")!
        return Bundle(path: bundlePath)!
    }()

}