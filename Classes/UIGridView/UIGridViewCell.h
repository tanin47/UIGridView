//
//  UIGridViewCell.h
//  foodling2
//
//  Created by Tanin Na Nakorn on 3/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIIndexedButton.h"


@interface UIGridViewCell : UIView {

}

@property int rowIndex;
@property int colIndex;
@property int sectionIndex;
@property (nonatomic, retain) IBOutlet UIView *view;
@property (nonatomic, assign) BOOL isEditing;
@property (readonly) BOOL editable;
@property (nonatomic, retain) UIIndexedButton *deleteButton;
@property (nonatomic, retain) UIView *container;

@end
