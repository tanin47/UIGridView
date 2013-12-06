//
//  Cell.m
//  naivegrid
//
//  Created by Apirom Na Nakorn on 3/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Cell.h"
#import <QuartzCore/QuartzCore.h> 

@implementation Cell


@synthesize thumbnail;
@synthesize label;


- (id)init {
	
    if (self = [super init]) {
		
        self.frame = CGRectMake(0, 0, 80, 80);
		
		[[NSBundle mainBundle] loadNibNamed:@"Cell" owner:self options:nil];
		
        [self addSubview:self.view];
		
		self.thumbnail.layer.cornerRadius = 4.0;
		self.thumbnail.layer.masksToBounds = YES;
		self.thumbnail.layer.borderColor = [UIColor lightGrayColor].CGColor;
		self.thumbnail.layer.borderWidth = 1.0;
	}
	
    return self;
	
}


@end
