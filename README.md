# InstaP4tch0

Modded Instagram for non-jailbroken iDevices.

Min iOS version: `10.0`.

Compiled using iOS `12.2` SDK.

Supported architectures: `armv7 arm64`.

Made possibile by `theos-jailed` and `CydiaSubstrate`.

![feed screenshot](screenshots/feed.jpeg)

# Implemented Features

- In app settings to enable/disable features (long press on InstaP4tch0 logo).
- Localised in: 🇬🇧, 🇮🇹.
- Hide sponsored content
- Double tap guard when liking a photo, pages or a video.

# Coming Soon

- More...

# Not working

- Push notifications
- CloudKit related functionality
- PassKit related functionality

# Development Tools

- Theos (https://github.com/theos/theos)
- Theos Jailed Module (https://github.com/kabiroberai/theos-jailed)
    - Needs a patch for linking against Swift frameworks: https://github.com/kabiroberai/theos-jailed/issues/58#issuecomment-497927651
- iOS 12.2 Theos-ready SDK (https://github.com/DavidSkrundz/sdks)
- Instagram universal IPA (iMazing to make sure it's universal -> jailbroken device -> decrypt)

# Sideloading

- Sideloaded successfully via Cydia Impactor and ios-deploy

# Instagram IPA version

![feed screenshot](screenshots/app_version.png)