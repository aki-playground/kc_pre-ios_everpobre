//
//  AOANotebookCellView.h
//  Everpobre
//
//  Created by Akixe on 1/3/16.
//  Copyright © 2016 AOA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AOANotebookCellView : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *nameView;
@property (strong, nonatomic) IBOutlet UILabel *numberOfNotesView;


+(NSString *) cellId;
+(CGFloat) cellHeight;
@end
