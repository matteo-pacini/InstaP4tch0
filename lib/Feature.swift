import Foundation

@objc(IPFeature)
public enum Feature: Int {
    case hideSponsoredContent
    case doubleTapGuardPhoto
    case doubleTapGuardPage
    case doubleTapGuardVideo
    case downloadPhoto
    case downloadVideo
    case seeStoriesAsJohnCena
    case seeDirectMessagesAsJohnCena
}

@objc(IPFeatureManager)
public class FeatureManager: NSObject {
    override private init() { }
    @objc public class func isFeatureEnabled(_ feature: Feature) -> Bool {
        return feature.value
    }
}

extension Feature {

    var userDefaultsKey: String {
        let base = "feature"
        switch self {
            case .hideSponsoredContent: return "\(base).hideSponsoredContent"
            case .doubleTapGuardPhoto: return "\(base).doubleTapGuardPhoto"
            case .doubleTapGuardPage: return "\(base).doubleTapGuardPage"
            case .doubleTapGuardVideo: return "\(base).doubleTapGuardVideo"
            case .downloadPhoto: return "\(base).downloadPhoto"
            case .downloadVideo: return "\(base).downloadVideo"
            case .seeStoriesAsJohnCena: return "\(base).seeStoriesAsJohnCena"
            case .seeDirectMessagesAsJohnCena: return "\(base).seeDirectMessagesAsJohnCena"
        }
    }

    var value: Bool {
        return UserDefaults.standard.bool(forKey: userDefaultsKey)
    }

    func set(_ value: Bool) {
        UserDefaults.standard.set(value, forKey: userDefaultsKey)
    }
}