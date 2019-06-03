import Foundation

@objc(IPPostType)
public enum PostType: Int {
    case photo
    case page
    case video
}

extension PostType {

    var doubleTapString: String {
        switch self {
            case .photo: return L("alert.double_tap_guard.type.photo")
            case .page: return L("alert.double_tap_guard.type.page")
            case .video: return L("alert.double_tap_guard.type.video")
        }
    }

}
