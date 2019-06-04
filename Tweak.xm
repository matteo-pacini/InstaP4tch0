
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <MBProgressHUD/MBProgressHUD.h>

#import <instap4tch0-Swift.h>
#define HAS_FEATURE(X) [IPFeatureManager isFeatureEnabled:IPFeature##X]

#import "Categories.h"

%hook IGAppDelegate

- (void)registerForPushWithUserSession:(id)arg1 { }

%end

%hook UIApplication

- (void)registerForRemoteNotifications { }

%end

%hook IGMainFeedItemConfiguration

- (BOOL)shouldHideFeedItem:(id)feedItem {
	if (HAS_FEATURE(HideSponsoredContent)) {
		return %orig || [feedItem valueForKey:@"_sponsoredPostInfo"] != nil;
	}
	return %orig;
}

%end

%hook IGListAdapter

- (void)collectionView:(id)collectionView 
        willDisplayCell:(id)cell
		forItemAtIndexPath:(id)indexPath {

	if ([cell isKindOfClass:%c(IGHiddenReasonListCell)] && HAS_FEATURE(HideSponsoredContent)) {
			UITableView *tableView = [cell valueForKey:@"_tableView"];
			// Tap "Not relevant" on tombstone cell
			NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
			[tableView.delegate tableView:tableView
			                    didSelectRowAtIndexPath:indexPath];
	} else {
		%orig;
	}
}

%end 

%hook IGStoryViewerViewController

-(BOOL)_canFetchAd {
	return %orig && !HAS_FEATURE(HideSponsoredContent);
}

%end

%hook UIImage

+ (UIImage *)imageNamed:(NSString *)name {
	if ([name isEqualToString:@"logotype-feed"]) {
		return [[UIImage alloc] initWithResource: IPImageResourceLogo];
	}
	return %orig;
}

%end

%hook IGFeedItemPhotoCell

- (void)feedPhotoDidDoubleTapToLike:(id)tap locationInfo:(id)locationInfo {
	if (!HAS_FEATURE(DoubleTapGuardPhoto)) { %orig; return; }
	[[UIAlertController likeAlertWithPostType:IPPostTypePhoto success: ^{
		%orig;
	}] show];
}

- (void)didMoveToWindow {
	id photoView = [self valueForKey:@"_photoView"];
	BOOL hasLongPressGR = NO;
	for (UIGestureRecognizer *gr in [photoView gestureRecognizers]) {
		if ([gr isKindOfClass:%c(UILongPressGestureRecognizer)]) {
			hasLongPressGR = YES;
			break;
		}
	}
	if (!hasLongPressGR) {
		UILongPressGestureRecognizer *longGestureRecognizer = 
		[[UILongPressGestureRecognizer alloc] initWithTarget: self 
		                                      action: @selector(didLongPressOnPhoto:)];
		[photoView addGestureRecognizer: longGestureRecognizer];
	}
}

%new
- (void)didLongPressOnPhoto:(id)sender {
	static BOOL guard = NO;
	if (!HAS_FEATURE(DownloadPhoto)) { return; }
	if (guard) { return; }
	guard = YES;
	[sender setEnabled: NO];
	IGFeedItem *feedItem = [self valueForKey:@"_post"];
	NSURL *url = [feedItem highestResolutionPhotoURL];
	if (url) {
		[[IPDownloader sharedInstance] downloadPost:IPPostTypePhoto
		                 withURL:url 
									   completion: ^(NSError *error){
			if (error) {
				[[UIAlertController errorAlertForError:error] show];
			} else {
				[[UIAlertController localizedAlertWithTitle:@"generic.success"
				                                    message: @"alert.success.photo_downloaded"] show];
			}
			dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC);
			dispatch_after(delay, dispatch_get_main_queue(), ^{
				guard = NO;
				[sender setEnabled: YES];
			});
		}];
	}
}

%end

%hook IGFeedItemPageCell

- (void)pageMediaViewDidDoubleTap:(id)tap {
	if (!HAS_FEATURE(DoubleTapGuardPage)) { %orig; return; }
	[[UIAlertController likeAlertWithPostType:IPPostTypePage success: ^{
		%orig;
	}] show];
}

%end

%hook IGFeedItemVideoCell

- (void)didDoubleTapFeedItemVideoView:(id)tap {
	if (!HAS_FEATURE(DoubleTapGuardVideo)) { %orig; return; }
	[[UIAlertController likeAlertWithPostType:IPPostTypeVideo success: ^{
		%orig;
	}] show];
}

- (void)didMoveToWindow {
	id videoView = [self valueForKey:@"_videoView"];
	BOOL hasLongPressGR = NO;
	for (UIGestureRecognizer *gr in [videoView gestureRecognizers]) {
		if ([gr isKindOfClass:[UILongPressGestureRecognizer class]]) {
			hasLongPressGR = YES;
			break;
		}
	}
	if (!hasLongPressGR) {
		UILongPressGestureRecognizer *longGestureRecognizer = 
		[[UILongPressGestureRecognizer alloc] initWithTarget: self 
		                                      action: @selector(didLongPressOnVideo:)];
		[videoView addGestureRecognizer: longGestureRecognizer];
	}
}

%new
- (void)didLongPressOnVideo:(id)sender {
	static BOOL guard = NO;
	if (!HAS_FEATURE(DownloadVideo)) { return; }
	if (guard) { return; }
	guard = YES;
	[sender setEnabled: NO];
	IGFeedItem *feedItem = [self valueForKey:@"_post"];
	NSURL *url = [feedItem highestResolutionVideoURL];
	if (url) {
		[[IPDownloader sharedInstance] downloadPost:IPPostTypeVideo
		                 withURL:url 
									   completion: ^(NSError *error){
			if (error) {
				[[UIAlertController errorAlertForError:error] show];
			} else {
				[[UIAlertController localizedAlertWithTitle:@"generic.success"
				                                    message: @"alert.success.video_downloaded"] show];
			}
			dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC);
			dispatch_after(delay, dispatch_get_main_queue(), ^{
				guard = NO;
				[sender setEnabled: YES];
			});
		}];
	}
}

%end

%hook IGMainAppHeaderView 

- (void)didMoveToWindow {
	%orig;
	static dispatch_once_t once;
    dispatch_once(&once, ^{
		id logoButton = [self valueForKey:@"_logoButton"];
      	UILongPressGestureRecognizer *longGestureRecognizer = 
		[[UILongPressGestureRecognizer alloc] initWithTarget: self 
		                                      action: @selector(didLongPressLogoButton:)];			
		[logoButton addGestureRecognizer: longGestureRecognizer];
    });
}

%new
- (void)didLongPressLogoButton:(id)sender {
	IPSettingsViewController *settingsVC = 
		[[IPSettingsViewController alloc] initWithNibName: nil bundle: nil];
	UINavigationController *navigationController = 
		[[UINavigationController alloc] initWithRootViewController: settingsVC];
	UIViewController *rootVC = 
		[[[UIApplication sharedApplication] keyWindow] rootViewController];
	[rootVC presentViewController: navigationController animated: YES completion: nil];
}

%end
