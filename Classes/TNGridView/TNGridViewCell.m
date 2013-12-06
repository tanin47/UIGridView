//
//  TNGridViewCell.m
//  foodling2
//
//  Created by Tanin Na Nakorn on 3/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "TNGridViewCell.h"


@implementation TNGridViewCell

@synthesize rowIndex;
@synthesize colIndex;
@synthesize view;

- (void) addSubview:(UIView *)v
{
	[super addSubview:v];
	v.exclusiveTouch = NO;
	v.userInteractionEnabled = NO;
}


@end
