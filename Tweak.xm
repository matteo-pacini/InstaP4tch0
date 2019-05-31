
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <lib/UIAlertController+Utils.h>
#import <lib/NSBundle+Localisation.h>
#import <lib/UIImage+Resources.h>

@interface IGMainAppHeaderView: UIView
@end

%hook IGMainFeedItemConfiguration

- (BOOL)shouldHideFeedItem:(id)feedItem {
	return [feedItem valueForKey:@"_sponsoredPostInfo"] != nil;
}

%end

%hook IGListAdapter

- (void)collectionView:(id)collectionView 
        willDisplayCell:(id)cell
		forItemAtIndexPath:(id)indexPath {
	if ([cell isKindOfClass:NSClassFromString(@"IGHiddenReasonListCell")]) {
			UITableView *tableView = [cell valueForKey:@"_tableView"];
			// Tap "Not relevant" on tombstone cell
			id indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
			[tableView.delegate tableView:tableView
			                    didSelectRowAtIndexPath:indexPath];
	} else {
		%orig;
	}
}

%end 

%hook UIImage

+ (UIImage *)imageNamed:(NSString *)name {
	if ([name isEqualToString:@"logotype-feed"]) {
		return IMG_LOGO;
	}
	return %orig;
}

%end

%hook IGFeedItemPhotoCell

- (void)feedPhotoDidDoubleTapToLike:(id)tap locationInfo:(id)locationInfo {
	[[UIAlertController likeAlertWithType:L(@"instap4tch0.alert.double_tap_guard.type.photo") successBlock: ^{
		%orig;
	}] show];
}

%end

%hook IGFeedItemPageCell

- (void)pageMediaViewDidDoubleTap:(id)tap {
	[[UIAlertController likeAlertWithType:L(@"instap4tch0.alert.double_tap_guard.type.photos") successBlock: ^{
		%orig;
	}] show];
}

%end

%hook IGFeedItemVideoCell

- (void)didDoubleTapFeedItemVideoView:(id)tap {
	[[UIAlertController likeAlertWithType:L(@"instap4tch0.alert.double_tap_guard.type.video") successBlock: ^{
		%orig;
	}] show];
}

%end
