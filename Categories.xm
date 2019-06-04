
#import "Categories.h"

%hook IGFeedItem

%new
- (NSURL *)highestResolutionPhotoURL {
    IGPostItem *post = [[self items] firstObject];
    if (post.mediaType == 1) {
        IGPhoto *photo = post.photo;
        IGImageURL *imageURL = [[photo ascendingSizeImageURLs] lastObject];
        return imageURL.url;
    }
    return nil;
}

%new
- (NSURL *)highestResolutionVideoURL {
    IGPostItem *post = [[self items] firstObject];
    if (post.mediaType == 2) {
        IGVideo *video = post.video;
        double winnerResolution = 0;
        NSURL *winner = nil;
        for (NSDictionary *dict in video.videoVersions) {
            double width = [dict[@"width"] doubleValue];
            double height = [dict[@"height"] doubleValue];
            double resolution = width * height;
            if (resolution > winnerResolution) {
                winnerResolution = resolution;
                winner = [NSURL URLWithString:dict[@"url"]];
            }
        }
        return winner;
    }
    return nil;
}

%end

%hook IPSettingsViewController

- (void)viewDidLoad {
    %orig;
    if (%c(FLEXManager) != nil) {
        UIBarButtonItem *flexBarButtonItem =
        [[UIBarButtonItem alloc] initWithTitle: @"FLEX"
                                  style: UIBarButtonItemStylePlain
                                  target: self
                                  action:@selector(showFLEX)];
        self.navigationItem.leftBarButtonItem = flexBarButtonItem;
    }
}

%new
- (void)showFLEX {
    [[%c(FLEXManager) sharedManager] showExplorer];
}

%end