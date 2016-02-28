//
//  AppDelegate.h
//  Everpobre
//
//  Created by Akixe on 28/2/16.
//  Copyright © 2016 AOA. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AGTSimpleCoreDataStack;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) AGTSimpleCoreDataStack *model;
@end

