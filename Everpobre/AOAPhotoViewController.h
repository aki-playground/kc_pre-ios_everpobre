//
//  AOAPhotoViewController.h
//  Everpobre
//
//  Created by Akixe on 5/3/16.
//  Copyright © 2016 AOA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AOADetailViewController.h"
@interface AOAPhotoViewController : UIViewController<AOADetailViewController>
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
- (IBAction)takePhoto:(id)sender;
- (IBAction)deletePhoto:(id)sender;
- (IBAction)applyVintageImage:(id)sender;
@end
