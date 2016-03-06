//
//  AOANoteViewController.m
//  Everpobre
//
//  Created by Akixe on 5/3/16.
//  Copyright © 2016 AOA. All rights reserved.
//

#import "AOANoteViewController.h"
#import "AOANote.h"
#import "AOANotebook.h"
#import "AOAPhoto.h"
#import "AOAPhotoViewController.h"
#import "AOALocation.h"
#import "AOAMapSnapshot.h"
@interface AOANoteViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) AOANote *model;
@property (nonatomic) BOOL new;
@property (nonatomic) BOOL deleteCurrentNote;
@end

@implementation AOANoteViewController

#pragma mark - Init
-(id) initWithModel: (id) model
{
    if(self = [super initWithNibName:nil bundle:nil]){
        _model = model;
    }
    return self;
}

-(id) initForNewNoteInNotebook:(AOANotebook *) notebook
{
    AOANote *newNote= [AOANote noteWithName: @""
                           notebook: notebook
                            context: notebook.managedObjectContext];
    self.new = YES;
    return [self initWithModel:newNote];
}

#pragma mark - View Lifecycle
-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSDateFormatter *fmt = [NSDateFormatter new];
    fmt.dateStyle = NSDateFormatterLongStyle;
    
    self.modificationDateView.text = [fmt stringFromDate:self.model.modificationDate];
    self.nameView.text = self.model.name;
    self.textView.text = self.model.text;
    
    //Image
    UIImage *img = self.model.photo.image;
    if(!img){
        img = [UIImage imageNamed:@"noImage.png"];
    }
    
    self.photoView.image = img;
    
    
    
    //Snapshot
    img = self.model.location.mapSnapshot.image;
    if(!img){
        img = [UIImage imageNamed:@"noSnapshot.png"];
    }
    self.mapSnapshotView.image = img;
    
    [self startObservingSnapshot];
    
    [self startObservingKeyboard];
    
    [self setupInputAccesoryView];
    
    if(self.new){
        UIBarButtonItem *cancel = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                   target:self
                                   action:@selector(cancel:)];
        
        self.navigationItem.rightBarButtonItem = cancel;
    }
    self.nameView.delegate = self;
    
    
    //Abrir detalle de imagen
    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openImageDetail:)];
    [self.photoView addGestureRecognizer:tap];
    
    
    //Abrir detalle de mapa
    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openMapDetail:)];
    [self.mapSnapshotView addGestureRecognizer:tap];
    
    UIBarButtonItem *share = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(displayShareController:)];
    self.navigationItem.rightBarButtonItem = share;

}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if(self.deleteCurrentNote){
        [self.model.managedObjectContext deleteObject:self.model];
    } else {
        self.model.text = self.textView.text;
        self.model.photo.image = self.photoView.image;
        self.model.name = self.nameView.text;
    }
    
    [self stopObservingKeyboard];
    [self stopObservingSnapshot];
}

#pragma mark - Keyboard
-(void) startObservingKeyboard
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver: self
           selector: @selector(notifyThatKeyboardWillAppear:)
               name: UIKeyboardWillShowNotification object:nil];
    
    [nc addObserver: self
           selector: @selector(notifyThatKeyboardWillDissappear:)
               name: UIKeyboardWillHideNotification object:nil];
}

-(void) stopObservingKeyboard
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
    
}

-(void) notifyThatKeyboardWillAppear: (NSNotification *) notification
{
    if([self.textView isFirstResponder]){
        NSDictionary *dict = notification.userInfo;
        double duration = [[dict objectForKey:UIKeyboardAnimationCurveUserInfoKey] doubleValue];
        
        [UIView animateWithDuration: duration
                              delay: 0
                            options: 0
                         animations:^{
                             self.textView.frame =
                             CGRectMake(self.modificationDateView.frame.origin.x,
                                        self.modificationDateView.frame.origin.y,
                                        self.textView.frame.size.width,
                                        self.textView.frame.size.height);
                         } completion:nil];
        [UIView animateWithDuration:duration
                         animations:^{
                             self.textView.alpha = 0.95;
                         }];
    }
}


-(void) notifyThatKeyboardWillDissappear: (NSNotification *) notification
{
    if([self.textView isFirstResponder]){
        NSDictionary *dict = notification.userInfo;
        double duration = [[dict objectForKey:UIKeyboardAnimationCurveUserInfoKey] doubleValue];
        
        [UIView animateWithDuration: duration
                              delay: 0
                            options: 0
                         animations:^{
                             self.textView.frame =
                             CGRectMake(0,
                                        345,
                                        self.textView.frame.size.width,
                                        self.textView.frame.size.height);
                         } completion:nil];
        [UIView animateWithDuration:duration
                         animations:^{
                             self.textView.alpha = 1;
                         }];
    }
}

-(void) setupInputAccesoryView
{
    UIToolbar *textBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    //UIToolbar *nameBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemDone
                                                                          target: self
                                                                          action: @selector(dismissKeyboard:)];
    UIBarButtonItem *sep= [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace
                                                                          target: nil
                                                                          action: nil];
    UIBarButtonItem *smile= [[UIBarButtonItem alloc] initWithTitle:@";-P"
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(insertTitle:)];
    [textBar setItems:@[smile, sep, done]];
    //[nameBar setItems:@[sep, done]];
    
    self.textView.inputAccessoryView = textBar;
    //self.nameView.inputAccessoryView = nameBar;
}


-(void) insertTitle:(UIBarButtonItem *) sender
{
    [self.textView insertText:sender.title];
}

-(void) dismissKeyboard:(id) sender
{
    [self.view endEditing:YES];
}

#pragma mark - Utils
-(void) cancel:(id) sender
{
    self.deleteCurrentNote = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextFieldDelegate
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Actions

-(void) openImageDetail:(id) sender
{
    if(self.model.photo == nil){
        self.model.photo = [AOAPhoto photoWithImage:nil context:self.model.managedObjectContext];
    }
    AOAPhotoViewController *pVC = [[AOAPhotoViewController alloc]
                                   initWithModel:self.model.photo];
    
    [self.navigationController pushViewController:pVC animated:YES];
}

-(void) openMapDetail:(id)self
{
    
}

-(void) displayShareController:(id)sender
{
    //Crear un UIActivityController
    UIActivityViewController *aVC = [[UIActivityViewController alloc] initWithActivityItems:[self arrayOfItems] applicationActivities:nil];
    
    [self presentViewController:aVC animated:YES completion:nil];
}

-(NSArray *) arrayOfItems
{
    NSMutableArray *items = [NSMutableArray array];
    if(self.model.name){
        [items addObject:self.model.name];
    }
    
    if(self.model.text){
        [items addObject:self.model.text];
    }
    
    if(self.model.photo.image){
        [items addObject:self.model.photo.image];
    }
    
    return items;
}

#pragma mark - KVO

-(void) startObservingSnapshot
{
    [self.model addObserver:self
           forKeyPath:@"location.mapSnapshot.snapshotData"
              options:NSKeyValueObservingOptionNew
              context:NULL];
}

-(void) stopObservingSnapshot
{
    [self.model removeObserver:self
              forKeyPath:@"location.mapSnapshot.snapshotData"];
}

-(void) observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context
{
    UIImage *img = self.model.location.mapSnapshot.image;
    if(!img){
        img = [UIImage imageNamed:@"noSnapshot.png"];
    }
    self.mapSnapshotView.image = img;
}
@end
