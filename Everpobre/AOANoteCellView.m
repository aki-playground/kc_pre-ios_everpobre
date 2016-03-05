//
//  AOANoteCellView.m
//  Everpobre
//
//  Created by Akixe on 3/3/16.
//  Copyright © 2016 AOA. All rights reserved.
//

#import "AOANoteCellView.h"
#import "AOANote.h"
#import "AOAPhoto.h"
@interface AOANoteCellView ()
@property (strong, nonatomic) AOANote *note;
@end

@implementation AOANoteCellView

+(NSArray *) keys
{
    return @[@"name", @"modificationDate", @"photo.image"];
}



-(void) observeNote: (AOANote *) note
{
    self.note = note;
    
    for (NSString *key in [AOANoteCellView keys]) {
        [self.note addObserver: self
                    forKeyPath: key
                       options: NSKeyValueObservingOptionNew
                       context: NULL];
    }
    
    [self syncWithNote];
}

- (void) syncWithNote
{
    //configurar la celca
    self.titleView.text = self.note.name;
    UIImage *img;
    if(self.note.photo.image == nil){
        img = [UIImage imageNamed:@"noImage.png"];
    } else {
        self.photoView.image = self.note.photo.image;
    }
    
    NSDateFormatter *fmt = [NSDateFormatter new];
    fmt.dateStyle = NSDateFormatterMediumStyle;
    
    self.modificationDateView.text = [fmt stringFromDate: self.note.modificationDate];

}

-(void) observeValueForKeyPath: (NSString *)keyPath
                      ofObject: (id)object
                        change: (NSDictionary<NSString *,id> *)change
                       context: (void *)context
{
    [self syncWithNote];
}


-(void) prepareForReuse
{
    
    for (NSString *key in [AOANoteCellView keys]) {
        [self.note removeObserver:self forKeyPath:key];
        
    }
    self.note = nil;
    [self syncWithNote];
}
@end
