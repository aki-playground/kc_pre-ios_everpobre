//
//  AOANotesViewController.h
//  Everpobre
//
//  Created by Akixe on 3/3/16.
//  Copyright © 2016 AOA. All rights reserved.
//

#import "AGTCoreDataCollectionViewController.h"
@class AOANotebook;
@interface AOANotesViewController : AGTCoreDataCollectionViewController
@property (strong, nonatomic) AOANotebook *notebook;
@end
