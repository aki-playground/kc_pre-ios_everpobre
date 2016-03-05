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
- (IBAction)takePhoto:(id)sender;
- (IBAction)deletePhoto:(id)sender;
@end
