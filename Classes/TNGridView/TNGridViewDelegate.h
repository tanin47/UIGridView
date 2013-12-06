//
//  TNGridViewDelegate.h
//  foodling2
//
//  Created by Tanin Na Nakorn on 3/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TNGridViewDelegate


@optional
- (void) gridView:(TNGridView *)grid didSelectRowAt:(int)rowIndex AndColumnAt:(int)columnIndex;


@required
- (CGFloat) gridView:(TNGridView *)grid widthForColumnAt:(int)columnIndex;
- (CGFloat) gridView:(TNGridView *)grid heightForRowAt:(int)rowIndex;

- (NSInteger) numberOfColumnsOfGridView:(TNGridView *) grid;
- (NSInteger) numberOfCellsOfGridView:(TNGridView *) grid;

- (TNGridViewCell *) gridView:(TNGridView *)grid cellForRowAt:(int)rowIndex AndColumnAt:(int)columnIndex;

@end

