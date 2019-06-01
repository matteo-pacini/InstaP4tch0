import UIKit
import QuickTableViewController

@objc(IPSettingsViewController)
public class SettingsViewController: QuickTableViewController {

    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "InstaP4tch0"
        tableContents = [
            Section(title: "Sponsored Content", rows: [
                row(named: "Hide", for: .hideSponsoredContent)
            ]),
            Section(title: "Double Tap Guard", rows: [
                row(named: "Photo", for: .doubleTapGuardPhoto),
                row(named: "Pages", for: .doubleTapGuardPage),
                row(named: "Video", for: .doubleTapGuardVideo)
            ]),
            Section(title: "Actions", rows: [
                TapActionRow(text: "Dismiss", action: { [weak self] _ in
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
