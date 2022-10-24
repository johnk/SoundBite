//
//  SBAppDelegate.m
//  SoundBite
//
//  Created by John Keyes on 12/23/12.
//  Copyright (c) 2012 John Keyes. All rights reserved.
//

#import "SBAppDelegate.h"

@implementation SBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Register for push notifications
    //[application registerForRemoteNotificationTypes:
    // UIRemoteNotificationTypeBadge |
     //UIRemoteNotificationTypeAlert |
     //UIRemoteNotificationTypeSound];
    
    //(void) [[KCSClient sharedClient] initializeKinveyServiceForAppKey:@"kid_ePkPqHNUxJ"
    //                                                    withAppSecret:@"7d152d447b7645bd851028a4810f42e3"
    //                                                     usingOptions:nil];
    
    // TODO: take this out for production
    //[KCSPing pingKinveyWithBlock:^(KCSPingResult *result) {
    //    if (result.pingWasSuccessful == YES){
    //        NSLog(@"Kinvey Ping Success");
    //    } else {
    //        NSLog(@"Kinvey Ping Failed");
    //    }
    //}];
    
    //NSDictionary* pushOptions = @{
    //                              KCS_PUSH_IS_ENABLED_KEY : @"YES",
    //                              KCS_PUSH_KEY_KEY : @"xxxxx",
    //                              KCS_PUSH_SECRET_KEY : @"xxxxx",
    //                              KCS_PUSH_MODE_KEY : KCS_PUSH_DEVELOPMENT //or KCS_PUSH_PRODUCTION for production push
    //
    //                          };
    
    //NSError *error = nil;
    //BOOL setUp = [[KCSPush sharedPush] onLoadHelper:pushOptions error:&error];
    //if (setUp == NO) {
    //    NSAssert(error == nil, @"Push not set up correctly: %@", error);
    //    //otherwise some other set-up issue
    //}
    
    // This may not be necessary, since it should get created earlier in awakeFromNib.
    if (!self.users) {
        self.users = [[Users alloc] init];
        [self.users load];
    }

    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
        UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
        splitViewController.delegate = (id)navigationController.topViewController;
    }
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    //[[KCSPush sharedPush] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
    // Additional registration goes here (if needed)
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    //[[KCSPush sharedPush] application:application didReceiveRemoteNotification:userInfo];
    // Additional push notification handling code should be performed here
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    //[[KCSPush sharedPush] onUnloadHelper];
    [self.users save];
}

@end
