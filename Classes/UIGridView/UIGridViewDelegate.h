//
//  UIGridViewDelegate.h
//  foodling2
//
//  Created by Tanin Na Nakorn on 3/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIGridView.h"

@protocol UIGridViewDelegate

@optional
- (void) gridView:(UIGridView *)grid didSelectRowAt:(int)rowIndex AndColumnAt:(int)columnIndex Section:(int)section;
- (void)gridView:(UIGridView *)grid willDisplayRowAtIndexPath:(NSIndexPath *)indexPath;
-(void)gridView:(UIGridView *)grid didEndDisplayingRowAtIndexPath:(NSIndexPath *)indexPath;
-(void)gridView:(UIGridView *)grid didEditRowAt:(int)row AndColumnAt:(int)column InSection:(int)section;


@required
- (int) numberOfSectionInGridView:(UIGridView *)grid ;
- (CGFloat) gridView:(UIGridView *)grid widthForColumnAt:(int)columnIndex Section:(int)section;
- (CGFloat) gridView:(UIGridView *)grid heightForRowAt:(int)rowIndex Section:(int)section;

- (NSInteger) numberOfColumnsOfGridView:(UIGridView *) grid ForSection:(int)section;
- (NSInteger) numberOfCellsOfGridView:(UIGridView *) grid ForSection:(int)section;

- (UIGridViewCell *) gridView:(UIGridView *)grid cellForRowAt:(int)rowIndex AndColumnAt:(int)columnIndex Section:(int)section;

@end

