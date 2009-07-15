#import "iRemedieAppDelegate.h"

@implementation iRemedieAppDelegate

@synthesize window;

-(void)applicationDidFinishLaunching:(UIApplication *)application {
    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [window makeKeyAndVisible];
}

-(void)dealloc {
    [window release];
    [super dealloc];
}

@end
