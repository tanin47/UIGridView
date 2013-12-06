//
//  Cell.h
//  naivegrid
//
//  Created by Apirom Na Nakorn on 3/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TNGridViewCell.h"

@interface Cell : TNGridViewCell {

}

@property (nonatomic, retain) IBOutlet UIImageView *thumbnail;
@property (nonatomic, retain) IBOutlet UILabel *label;

@end
