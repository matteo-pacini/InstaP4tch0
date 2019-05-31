#import <UIKit/UIKit.h>

@interface UIAlertController (Utils)

- (void)show;

+ (UIAlertController *)likeAlertWithType:(NSString *)type 
                            successBlock:(void (^)(void))successBlock;

@end