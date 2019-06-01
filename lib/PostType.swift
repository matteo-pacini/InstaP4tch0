import Foundation

@objc
public enum PostType: Int {
    case photo
    case page
    case video
}

extension PostType {

    var doubleTapString: String {
        switch self {
            case .photo: return Bundle.L("alert.double_tap_guard.type.photo")
            case .page: return Bundle.L("alert.double_tap_guard.type.page")
            case .video: return Bundle.L("alert.double_tap_guard.type.video")
        }
    }

}
