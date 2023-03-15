# InstaP4tch0 📸

A modded Instagram app for non-jailbroken iDevices.

Minimum iOS version: `10.0` 📱

Compiled using iOS `12.2` SDK.

Supported architectures: `armv7 arm64` 🏗️

Powered by `theos-jailed` and `CydiaSubstrate`.

![feed screenshot](screenshots/feed.jpeg)

![settings screenshot](screenshots/settings.png)

## Implemented Features ✅

- In-app settings to enable/disable features (long press on InstaP4tch0 logo) ⚙️
- Localized in: 🇬🇧, 🇮🇹.
- Hide sponsored content (main feed/stories) 🚫
- Double-tap guard when liking a photo, pages, or a video 🔒
- Long press on a photo/video/story to download it 📥
- Don't mark stories as seen 👀
- Don't mark direct messages as seen 💌
- No more prompts to rate the app 🌟
- Toggle side-scrolling for the main feed ↔️

## Coming Soon 🚧

- Long press on pages to download all the media 📚

## Not Working (and Probably Will Never Work) ❌

- Push notifications 🔔
- CloudKit related functionality ☁️
- PassKit related functionality 💳

## Development Tools 🛠️

- Theos (https://github.com/theos/theos)
- Theos Jailed Module (https://github.com/kabiroberai/theos-jailed)
    - ~~Needs a patch for linking against Swift frameworks: https://github.com/kabiroberai/theos-jailed/issues/58#issuecomment-497927651~~ Patch is now integrated into the Makefile
- iOS 12.2 Theos-ready SDK (https://github.com/DavidSkrundz/sdks)
- Instagram universal IPA (iMazing to ensure it's universal -> jailbroken device -> decrypt)

## Swift Runtime 🏃‍♂️

Added Swift 5 thinned runtime (`armv7` / `arm64`) in `Resources/Frameworks` to make the IPA work on devices running older versions of iOS (from 10.x.x to 12.1.x)

## Sideloading 🚀

Tested utilities:
- `Cydia Impactor`
- `ios-deploy`

## Instagram IPA Version 🗂️

![feed screenshot](screenshots/app_version.png)

## Project Status: Archived ⏳

Please note that I have stopped working on this project due to a lack of available time. I appreciate your understanding and interest in InstaP4tch0. Thank you for your support, and I hope you enjoyed using the modded app. Feel free to explore the repository and learn from the work that has been done.
