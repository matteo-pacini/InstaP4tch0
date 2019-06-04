
#import "Headers.h"

#import <instap4tch0-Swift.h>

@interface FLEXManager: NSObject 
+ (id)sharedManager;
- (void)showExplorer;
@end

@interface IGFeedItem (Utils)

- (NSURL *)highestResolutionPhotoURL;
- (NSURL *)highestResolutionVideoURL;

@end
