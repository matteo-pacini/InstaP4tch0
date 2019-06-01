import UIKit

@objc
public enum ImageResource: Int {
    case logo
}

extension ImageResource {

    var imageName: String {
        switch self {
            case .logo: return "instap4tch0_logo"
        }
    }

}

extension UIImage {

    @objc
    public convenience init?(resource: ImageResource) {
        self.init(named: resource.imageName)
    }

}
