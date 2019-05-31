#import "UIAlertController+Utils.h"

#import "NSBundle+Localisation.h"

@implementation UIAlertController (Utils)

- (void)show {
    UIViewController *vc = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    [vc presentViewController:self animated:YES completion:nil];
}

+ (UIAlertController *)likeAlertWithType:(NSString *)type 
                            successBlock:(void (^)(void))successBlock {
    NSString *message = [NSString stringWithFormat:L(@"instap4tch0.alert.double_tap_guard.message"), type];
    UIAlertController* alert = 
    [UIAlertController alertControllerWithTitle:L(@"instap4tch0.generic.warning")
                                        message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction: [self _yesActionWithSuccessBlock:successBlock]];
    [alert addAction: [self _noAction]];
    return alert;
}

+ (UIAlertAction*)_yesActionWithSuccessBlock:(void (^)(void))successBlock {
    return
    [UIAlertAction actionWithTitle:L(@"instap4tch0.generic.yes")
                             style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction *action){
        successBlock();
    }];
}

+ (UIAlertAction*)_noAction {
    return
    [UIAlertAction actionWithTitle:L(@"instap4tch0.generic.no")
                             style:UIAlertActionStyleDefault
                            handler:nil];
}

@end