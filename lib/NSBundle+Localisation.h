#import <Foundation/Foundation.h>

#define L(KEY) [[NSBundle mainBundle] localizedStringForKey:KEY             \
                                                      value:@"**" KEY "**"  \
                                                      table:nil]
