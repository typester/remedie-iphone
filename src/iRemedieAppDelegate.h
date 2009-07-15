#import <UIKit/UIKit.h>
#import "BonjourBrowser.h"

@interface iRemedieAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    BonjourBrowser *bonjourbrowser;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) BonjourBrowser *bonjourbrowser;

@end
