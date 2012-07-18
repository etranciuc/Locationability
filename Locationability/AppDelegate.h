//
//  AppDelegate.h
//  Locationability
//
//  Created by Liam Beeton on 2012/07/17.
//  Copyright (c) 2012 Codebase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {

@private
    UINavigationController *_navigationController;
    LocationViewController *_locationViewController;

}

@property (strong, nonatomic) UIWindow *window;

@end
