//
//  AOANoteViewController.h
//  Everpobre
//
//  Created by Akixe on 5/3/16.
//  Copyright © 2016 AOA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AOADetailViewController.h"
@class AOANotebook;
@interface AOANoteViewController : UIViewController <AOADetailViewController>
@property (weak, nonatomic) IBOutlet UILabel *modificationDateView;
@property (weak, nonatomic) IBOutlet UITextField *nameView;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITextView *textView;


-(id) initForNewNoteInNotebook:(AOANotebook *) notebook;
@end
