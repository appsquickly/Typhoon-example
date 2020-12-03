////////////////////////////////////////////////////////////////////////////////
//
//  TYPHOON FRAMEWORK
//  Copyright 2013, Typhoon Framework Contributors
//  All Rights Reserved.
//
//  NOTICE: The authors permit you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////



#import <ICLoader/ICLoader.h>
#import "PFAppDelegate.h"
#import "PFCityDao.h"
#import "UIFont+ApplicationFonts.h"
#import "PFRootViewController.h"

@implementation PFAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = self.rootViewController;

    [ICLoader setImageName:@"cloud_icon.png"];
    [ICLoader setLabelFontName:[UIFont applicationFontOfSize:10].fontName];

    [[UINavigationBar appearance] setTitleTextAttributes:@{
        NSFontAttributeName            : [UIFont applicationFontOfSize:20],
        NSForegroundColorAttributeName : [UIColor whiteColor],
    }];

    NSString *selectedCity = [_cityDao loadSelectedCity];
    if (!selectedCity)
    {
        [_rootViewController showCitiesListController];
    }

    [self.window makeKeyAndVisible];

    return YES;
}

@end
