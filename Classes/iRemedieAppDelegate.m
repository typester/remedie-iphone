//
//  iRemedieAppDelegate.m
//  iRemedie
//
//  Created by Daisuke Murase on 09/07/15.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "iRemedieAppDelegate.h"

@implementation iRemedieAppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    

    // Override point for customization after application launch
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
