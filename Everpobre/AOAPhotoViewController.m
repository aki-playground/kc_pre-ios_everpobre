//
//  AOAPhotoViewController.m
//  Everpobre
//
//  Created by Akixe on 5/3/16.
//  Copyright © 2016 AOA. All rights reserved.
//

#import "AOAPhotoViewController.h"
#import "AOAPhoto.h"
@import CoreImage;

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
- (IBAction)applyVintageImage:(id)sender
{

    //Crear contexto
    CIContext *context = [CIContext contextWithOptions:nil];
    
    //Crear CIImage de entrada
    CIImage *image = [CIImage imageWithCGImage:self.model.image.CGImage];
    
    //Crear Filtro Foto Antigua
    CIFilter *filterOld = [CIFilter filterWithName:@"CIFalseColor"];
    [filterOld setDefaults];
    [filterOld setValue:image forKey:kCIInputImageKey];
    
    //CRear filtro Vignette
    CIFilter *filterVignette = [CIFilter filterWithName:@"CIVignette"];
    [filterVignette setDefaults];
    [filterVignette setValue:@12 forKey:kCIInputIntensityKey];
    
    //Encadenar Filtros
    [filterVignette setValue:filterOld.outputImage forKey:kCIInputImageKey];
    
    //Crear imagen de salida
    CIImage *output = filterVignette.outputImage;
    
    //Aplicar el filtro
    [self.activityView startAnimating];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        CGImageRef res = [context createCGImage: output
                                       fromRect:[output extent]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.activityView stopAnimating];
            //Guardar nueva imagen
            UIImage *img = [UIImage imageWithCGImage:res];
            self.photoView.image = img;
            
            CGImageRelease(res);
        });
        
    });
    
   
}
@end
