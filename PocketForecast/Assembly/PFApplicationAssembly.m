////////////////////////////////////////////////////////////////////////////////
//
//  TYPHOON FRAMEWORK
//  Copyright 2015, Typhoon Framework Contributors
//  All Rights Reserved.
//
//  NOTICE: The authors permit you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

#import "PFApplicationAssembly.h"
#import "PFCoreComponents.h"
#import "PFAddCityViewController.h"
#import "PFRootViewController.h"
#import "PFCitiesListViewController.h"
#import "PFThemeAssembly.h"
#import "PFWeatherReportViewController.h"
#import "PFAppDelegate.h"


@implementation PFApplicationAssembly

//-------------------------------------------------------------------------------------------
#pragma mark - Bootstrapping
//-------------------------------------------------------------------------------------------

- (PFAppDelegate *)appDelegate
{
    return [TyphoonDefinition withClass:[PFAppDelegate class] configuration:^(TyphoonDefinition *definition)
    {
        [definition injectProperty:@selector(cityDao) with:[self.coreComponents cityDao]];
        [definition injectProperty:@selector(rootViewController) with:[self rootViewController]];
    }];
}

//-------------------------------------------------------------------------------------------

- (PFRootViewController *)rootViewController
{
    return [TyphoonDefinition withClass:[PFRootViewController class] configuration:^(TyphoonDefinition *definition)
    {
        [definition useInitializer:@selector(initWithMainContentViewController:assembly:) parameters:^(TyphoonMethod *initializer)
        {
            [initializer injectParameterWith:[self weatherReportController]];
            [initializer injectParameterWith:self];
        }];
        definition.scope = TyphoonScopeSingleton;
    }];
}


- (PFCitiesListViewController *)citiesListController
{
    return [TyphoonDefinition withClass:[PFCitiesListViewController class] configuration:^(TyphoonDefinition *definition)
    {
        [definition useInitializer:@selector(initWithCityDao:theme:) parameters:^(TyphoonMethod *initializer)
        {
            [initializer injectParameterWith:[self.coreComponents cityDao]];
            [initializer injectParameterWith:[self.themeProvider currentTheme]];
        }];
        [definition injectProperty:@selector(assembly)];
    }];
}

- (PFWeatherReportViewController *)weatherReportController
{
    return [TyphoonDefinition withClass:[PFWeatherReportViewController class] configuration:^(TyphoonDefinition *definition)
    {
        [definition useInitializer:@selector(initWithView:weatherClient:weatherReportDao:cityDao:assembly:)
            parameters:^(TyphoonMethod *initializer)
            {
                [initializer injectParameterWith:[self weatherReportView]];
                [initializer injectParameterWith:[self.coreComponents weatherClient]];
                [initializer injectParameterWith:[self.coreComponents weatherReportDao]];
                [initializer injectParameterWith:[self.coreComponents cityDao]];
                [initializer injectParameterWith:self];
            }];
    }];
}

- (PFWeatherReportView *)weatherReportView
{
    return [TyphoonDefinition withClass:[PFWeatherReportView class] configuration:^(TyphoonDefinition *definition)
    {
        [definition injectProperty:@selector(theme) with:[self.themeProvider currentTheme]];
    }];
}

- (PFAddCityViewController *)addCityViewController
{
    return [TyphoonDefinition withClass:[PFAddCityViewController class] configuration:^(TyphoonDefinition *definition)
    {
        [definition useInitializer:@selector(initWithNibName:bundle:) parameters:^(TyphoonMethod *initializer)
        {
            [initializer injectParameterWith:@"AddCity"];
            [initializer injectParameterWith:[NSBundle mainBundle]];
        }];

        [definition injectProperty:@selector(cityDao) with:[self.coreComponents cityDao]];
        [definition injectProperty:@selector(weatherClient) with:[self.coreComponents weatherClient]];
        [definition injectProperty:@selector(theme) with:[self.themeProvider currentTheme]];
        [definition injectProperty:@selector(rootViewController) with:[self rootViewController]];
    }];
}

@end
