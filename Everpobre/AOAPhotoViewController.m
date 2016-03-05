//
//  AOAPhotoViewController.m
//  Everpobre
//
//  Created by Akixe on 5/3/16.
//  Copyright © 2016 AOA. All rights reserved.
//

#import "AOAPhotoViewController.h"
#import "AOAPhoto.h"
@interface AOAPhotoViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) AOAPhoto *model;
@end

@implementation AOAPhotoViewController

-(id) initWithModel: (id) model
{
    if(self = [super initWithNibName:nil bundle:nil]){
        _model = model;
    }
    return self;
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.photoView.image = self.model.image;
}

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    self.model.image = self.photoView.image;
}
- (IBAction)takePhoto:(id)sender
{
    //crear imagepicker
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    //configurar
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    //asignar delgado
    picker.delegate = self;
    
    picker.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;


    //mostrarlo
    [self presentViewController:picker
                       animated:YES
                     completion:^{
                         
                     }];
}


-(void)     imagePickerController:(UIImagePickerController *)picker
    didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.model.image = img;
    [self dismissViewControllerAnimated:YES
                             completion:^{
                             }];
}
- (IBAction)deletePhoto:(id)sender
{
    CGRect oldBounds = self.photoView.bounds;

    [UIView animateWithDuration:0.6
                          delay:0
                        options:0
                     animations:^{
                         self.photoView.bounds = CGRectZero;
                         self.photoView.alpha = 0;
                         self.photoView.transform = CGAffineTransformMakeRotation(M_2_PI);
                     } completion:^(BOOL finished) {
                         self.photoView.image = nil;
                         self.photoView.alpha = 1;
                         self.photoView.bounds = oldBounds;
                         self.photoView.transform = CGAffineTransformIdentity;
                     }];
    
    self.model.image = nil;
}
@end
