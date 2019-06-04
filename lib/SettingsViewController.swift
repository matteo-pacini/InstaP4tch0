import UIKit
import QuickTableViewController
import Photos

@objc(IPSettingsViewController)
public class SettingsViewController: QuickTableViewController {

    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "InstaP4tch0"
        let doneBarButtonItem =
            UIBarButtonItem(barButtonSystemItem: .done, 
                            target: self,
                            action: #selector(dismissMe))
        self.navigationItem.rightBarButtonItem = doneBarButtonItem
        tableContents = [
            Section(title: L("settings.sponsored_content"), rows: [
                row(named: L("settings.sponsored_content.hide"), for: .hideSponsoredContent)
            ]),
            Section(title: L("settings.double_tap_guard"), rows: [
                row(named: L("settings.double_tap_guard.photo"), for: .doubleTapGuardPhoto),
                row(named: L("settings.double_tap_guard.page"), for: .doubleTapGuardPage),
                row(named: L("settings.double_tap_guard.video"), for: .doubleTapGuardVideo)
            ]),
            Section(title: L("settings.download"), rows: [
                row(named: L("settings.download.photo"), for: .downloadPhoto) { value in
                    if value && PHPhotoLibrary.authorizationStatus() != .authorized {
                        PHPhotoLibrary.requestAuthorization { _ in }
                    }
                },
                row(named: L("settings.download.video"), for: .downloadVideo) { value in
                    if value && PHPhotoLibrary.authorizationStatus() != .authorized {
                        PHPhotoLibrary.requestAuthorization { _ in }
                    }
                }
            ], footer: L("settings.download.footer")),
            Section(title: L("settings.stories"), rows: [
                row(named: L("settings.stories.as_john_cena"), for: .seeStoriesAsJohnCena)
            ]),
            Section(title: L("settings.direct_messages"), rows: [
                row(named: L("settings.direct_messages.as_john_cena"), for: .seeDirectMessagesAsJohnCena)
            ]),
            Section(title: L("settings.main_feed"), rows: [
                row(named: L("settings.main_feed.side_scrolling"), for: .mainFeedSideScrolling)
            ]),
            Section(title: L("settings.open_source"), rows: [
                NavigationRow(text: "Alamofire", detailText: .value1(Bundle.alamofire.shortVersionString)),
                NavigationRow(text: "MBProgressHUD", detailText: .value1(Bundle.mbProgressHud.shortVersionString)),
                NavigationRow(text: "QuickTableViewController", detailText: .value1(Bundle.quickTableViewController.shortVersionString)),
            ], footer: L("settings.open_source.footer"))
        ]
    }

    private func row(named: String, for feature: Feature, then: ((Bool) -> Void)? = nil) -> Row & RowStyle {
        return SwitchRow(text: named, switchValue: feature.value, action: { row in
            guard let row = row as? SwitchRow else { return }
            feature.set(row.switchValue)
            then?(row.switchValue)
        })
    }

    @objc
    private func dismissMe() {
        self.dismiss(animated: true, completion: nil)
    }

}
