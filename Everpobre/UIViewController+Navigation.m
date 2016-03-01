//
//  UIViewController+Navigation.m
//  Everpobre
//
//  Created by Akixe on 1/3/16.
//  Copyright © 2016 AOA. All rights reserved.
//

#import "UIViewController+Navigation.h"

@implementation UIViewController (Navigation)


-(UINavigationController *) wreappedInNavigation{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self];
    return nav;
}
@end
