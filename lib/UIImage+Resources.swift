import UIKit

@objc(IPImageResource)
public enum ImageResource: Int {
    case logo
}

extension ImageResource {

    var imageName: String {
        switch self {
            case .logo: return "logo"
        }
    }

}

extension UIImage {

    @objc
    public convenience init?(resource: ImageResource) {
        self.init(named: resource.imageName, in: Bundle.instap4tch0, compatibleWith: nil)
    }

}
