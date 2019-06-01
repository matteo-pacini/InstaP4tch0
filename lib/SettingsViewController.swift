import UIKit
import QuickTableViewController

@objc(IPSettingsViewController)
public class SettingsViewController: QuickTableViewController {

    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "InstaP4tch0"
        tableContents = [
            Section(title: Bundle.L("settings.sponsored_content"), rows: [
                row(named: Bundle.L("settings.sponsored_content.hide"), for: .hideSponsoredContent)
            ]),
            Section(title: Bundle.L("settings.double_tap_guard"), rows: [
                row(named: Bundle.L("settings.double_tap_guard.photo"), for: .doubleTapGuardPhoto),
                row(named: Bundle.L("settings.double_tap_guard.page"), for: .doubleTapGuardPage),
                row(named: Bundle.L("settings.double_tap_guard.video"), for: .doubleTapGuardVideo)
            ]),
            Section(title: Bundle.L("settings.actions"), rows: [
                TapActionRow(text: Bundle.L("generic.dismiss"), action: { [weak self] _ in
                    guard let self = self else { return }
                    self.dismiss(animated: true, completion: nil)
                })
            ])
        ]
    }

    private func row(named: String, for feature: Feature) -> Row & RowStyle {
        return SwitchRow(text: named, switchValue: feature.value, action: { row in
            guard let row = row as? SwitchRow else { return }
            feature.set(row.switchValue)
        })
    }

}
