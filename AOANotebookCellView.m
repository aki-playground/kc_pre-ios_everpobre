//
//  AOANotebookCellView.m
//  Everpobre
//
//  Created by Akixe on 1/3/16.
//  Copyright © 2016 AOA. All rights reserved.
//

#import "AOANotebookCellView.h"

@implementation AOANotebookCellView

+(NSString *) cellId{
    return NSStringFromClass(self);
}
+(CGFloat) cellHeight{
    return 60.0f;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
