#import "iRemedieAppDelegate.h"

@implementation iRemedieAppDelegate

@synthesize window, bonjourbrowser;

-(void)applicationDidFinishLaunching:(UIApplication *)application {
    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    bonjourbrowser = [[BonjourBrowser alloc] initWithNibName:nil bundle:nil];
    [window addSubview:bonjourbrowser.view];

    [window makeKeyAndVisible];
}

-(void)dealloc {
    [window release];
    [bonjourbrowser release];
    [super dealloc];
}

@end
