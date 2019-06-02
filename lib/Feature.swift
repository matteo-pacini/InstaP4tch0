import Foundation

@objc
public enum Feature: Int {
    case hideSponsoredContent
    case doubleTapGuardPhoto
    case doubleTapGuardPage
    case doubleTapGuardVideo
    case downloadPhoto
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
        let base = "instap4tch0.feature"
        switch self {
            case .hideSponsoredContent: return "\(base).hideSponsoredContent"
            case .doubleTapGuardPhoto: return "\(base).doubleTapGuardPhoto"
            case .doubleTapGuardPage: return "\(base).doubleTapGuardPage"
            case .doubleTapGuardVideo: return "\(base).doubleTapGuardVideo"
            case .downloadPhoto: return "\(base).downloadPhoto"
        }
    }

    var value: Bool {
        return UserDefaults.standard.bool(forKey: userDefaultsKey)
    }

    func set(_ value: Bool) {
        UserDefaults.standard.set(value, forKey: userDefaultsKey)
    }
}