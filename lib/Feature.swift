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
    case mainFeedSideScrolling
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
            case .mainFeedSideScrolling: return "\(base).mainFeedSideScrolling"
        }
    }

    var defaultValue: Bool {
        switch self {
            case .mainFeedSideScrolling: return true
            default: return false
        }
    }

    var value: Bool {
        guard let obj = UserDefaults.standard.object(forKey: userDefaultsKey) as? NSNumber else {
            return defaultValue
        }
        return obj.boolValue
    }

    func set(_ value: Bool) {
        UserDefaults.standard.set(value, forKey: userDefaultsKey)
    }
}