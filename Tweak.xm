
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <instap4tch0-Swift.h>

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
		return [[UIImage alloc] initWithResource: ImageResourceLogo];
	}
	return %orig;
}

%end

%hook IGFeedItemPhotoCell

- (void)feedPhotoDidDoubleTapToLike:(id)tap locationInfo:(id)locationInfo {
	[[UIAlertController likeAlertWithPostType:PostTypePhoto success: ^{
		%orig;
	}] show];
}

%end

%hook IGFeedItemPageCell

- (void)pageMediaViewDidDoubleTap:(id)tap {
	[[UIAlertController likeAlertWithPostType:PostTypePage success: ^{
		%orig;
	}] show];
}

%end

%hook IGFeedItemVideoCell

- (void)didDoubleTapFeedItemVideoView:(id)tap {
	[[UIAlertController likeAlertWithPostType:PostTypeVideo success: ^{
		%orig;
	}] show];
}

%end
