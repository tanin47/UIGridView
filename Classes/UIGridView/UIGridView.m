//
//  UIGridViewView.m
//  foodling2
//
//  Created by Tanin Na Nakorn on 3/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "UIGridView.h"
#import "UIGridViewDelegate.h"
#import "UIGridViewCell.h"
#import "UIGridViewRow.h"

#import "ECGridCatalogueCell.h"

@implementation UIGridView


@synthesize uiGridViewDelegate;


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		[self setUp];
    }
    return self;
}


- (id) initWithCoder:(NSCoder *)aDecoder
{
	
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
		self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}


- (void) setUp
{
	self.delegate = self;
	self.dataSource = self;
}

- (UIGridViewCell *) dequeueReusableCell
{
	UIGridViewCell* temp = tempCell;
	tempCell = nil;
	return temp;
}


// UITableViewController specifics
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 0.0;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [uiGridViewDelegate numberOfSectionInGridView:self];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	int residue =  ([uiGridViewDelegate numberOfCellsOfGridView:self ForSection:section] % [uiGridViewDelegate numberOfColumnsOfGridView:self ForSection:section]);
	
	if (residue > 0) residue = 1;
	
	return ([uiGridViewDelegate numberOfCellsOfGridView:self ForSection:section] / [uiGridViewDelegate numberOfColumnsOfGridView:self ForSection:section]) + residue;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [uiGridViewDelegate gridView:self heightForRowAt:indexPath.row Section:indexPath.section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UIGridViewRow";
	
    UIGridViewRow *row = nil;//(UIGridViewRow *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (row == nil) {
        row = [[UIGridViewRow alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
	
	int numCols = [uiGridViewDelegate numberOfColumnsOfGridView:self ForSection:indexPath.section];
	int count = [uiGridViewDelegate numberOfCellsOfGridView:self ForSection:indexPath.section];
	
	CGFloat x = 0.0;
	CGFloat height = [uiGridViewDelegate gridView:self heightForRowAt:indexPath.row Section:indexPath.section];
	
	for (int i=0;i<numCols;i++) {
		
		if ((i + indexPath.row * numCols) >= count) {
			
			if ([row.contentView.subviews count] > i) {
				((UIGridViewCell *)[row.contentView.subviews objectAtIndex:i]).hidden = YES;
			}
			
			continue;
		}
		
		if ([row.contentView.subviews count] > i) {
			tempCell = [row.contentView.subviews objectAtIndex:i];
		} else {
			tempCell = nil;
		}
		
		UIGridViewCell *cell = [uiGridViewDelegate gridView:self 
												cellForRowAt:indexPath.row 
												 AndColumnAt:i
                                                     Section:indexPath.section];
		
		if (cell.superview != row.contentView) {
			[cell removeFromSuperview];
			[row.contentView addSubview:cell];
			
            UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cellPressed:)];
            [tapGR setDelegate:self];
            [cell addGestureRecognizer:tapGR];
			
            if (cell.editable) {
                UISwipeGestureRecognizer *swipeGR = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(cellSwiped:)];
                [swipeGR setDirection:UISwipeGestureRecognizerDirectionLeft];
                [cell addGestureRecognizer:swipeGR];
                
                UISwipeGestureRecognizer *swipeRightGR = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(cellSwiped:)];
                [swipeRightGR setDirection:UISwipeGestureRecognizerDirectionRight];
                [cell addGestureRecognizer:swipeRightGR];
                
                cell.container = [[UIView alloc]initWithFrame:CGRectMake(cell.bounds.size.width-10, (cell.bounds.size.height/2)-15 , 0, 30)];
                [cell.deleteButton setFrame:CGRectMake(-60, 0 , 60, 30)];
                [cell.deleteButton setBackgroundImage:[[UIImage imageNamed:@"Button_Delete"]resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forState:UIControlStateNormal];
                [cell.deleteButton setTitle:NSLocalizedString(@"DELETE", nil) forState:UIControlStateNormal];
                [cell.deleteButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
                [cell.deleteButton setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin];
                [cell.deleteButton addTarget:self action:@selector(deleteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [cell.container setClipsToBounds:YES];
                [cell.deleteButton setButtonRow:indexPath.row];
                [cell.deleteButton setButtonColumn:i];
                [cell.container addSubview:cell.deleteButton];
                [cell.view addSubview:cell.container];
                cell.isEditing = NO;
                [cell.view bringSubviewToFront:cell.deleteButton];
            }
		}
		
		cell.hidden = NO;
		cell.rowIndex = indexPath.row;
		cell.colIndex = i;
        cell.sectionIndex = indexPath.section;
		
		CGFloat thisWidth = [uiGridViewDelegate gridView:self widthForColumnAt:i Section:indexPath.section];
		cell.frame = CGRectMake(x, 0, thisWidth, height);
		x += thisWidth;
	}
	
	row.frame = CGRectMake(row.frame.origin.x,
							row.frame.origin.y,
							x,
							height);
	
    return row;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    [uiGridViewDelegate gridView:self willDisplayRowAtIndexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    [uiGridViewDelegate gridView:self didEndDisplayingRowAtIndexPath:indexPath];
}

- (IBAction) cellPressed:(UITapGestureRecognizer *) sender
{
	UIGridViewCell *cell = (UIGridViewCell *) sender.view;
    
    if (cell.isEditing) {
        CGRect frame = cell.deleteButton.frame;
        CGPoint point = [sender locationInView:cell.deleteButton];
        if (CGRectContainsPoint(frame, point)) {
            [self deleteButtonPressed:cell.deleteButton];
        }
        
        [UIView beginAnimations:@"button" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView setAnimationDuration:0.1];
        [cell.container setFrame:CGRectMake(cell.bounds.size.width-10, (cell.bounds.size.height/2)-15 , 0, cell.deleteButton.frame.size.height)];
        [UIView commitAnimations];
        cell.isEditing = NO;
    }
    else{
        [uiGridViewDelegate gridView:self didSelectRowAt:cell.rowIndex AndColumnAt:cell.colIndex Section:cell.sectionIndex];
    }
}

- (void) cellSwiped:(UISwipeGestureRecognizer *)sender{
    UIGridViewCell *cell = (UIGridViewCell *) sender.view;
    
    if (!cell.isEditing) {
        
        [cell.container setFrame:CGRectMake(cell.bounds.size.width-10, (cell.bounds.size.height/2)-15 , 0, cell.deleteButton.frame.size.height)];
        [UIView beginAnimations:@"button" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView setAnimationDuration:0.1];
        [cell.container setFrame:CGRectMake(cell.bounds.size.width-70, (cell.bounds.size.height/2)-15 , cell.deleteButton.frame.size.width, cell.deleteButton.frame.size.height)];
        cell.isEditing = YES;
        [UIView commitAnimations];
    }
    else{
        [cell.container setFrame:CGRectMake(cell.bounds.size.width-70, (cell.bounds.size.height/2)-15 , cell.deleteButton.frame.size.width, cell.deleteButton.frame.size.height)];
        [UIView beginAnimations:@"button" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView setAnimationDuration:0.1];
        [cell.container setFrame:CGRectMake(cell.bounds.size.width-10, (cell.bounds.size.height/2)-15 , 0, cell.deleteButton.frame.size.height)];
        [UIView commitAnimations];
        cell.isEditing = NO;
    }
}

-(void)deleteButtonPressed:(UIIndexedButton *)sender{
    [uiGridViewDelegate gridView:self didEditRowAt:sender.buttonRow AndColumnAt:sender.buttonColumn InSection:sender.buttonSection];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    UIGridViewCell *cell = (UIGridViewCell *) gestureRecognizer.view;
    
    if (cell.isEditing) {
        CGRect frame = cell.deleteButton.frame;
        CGPoint point = [touch locationInView:cell.deleteButton];
        if (CGRectContainsPoint(frame, point)) {
            return NO;
        }
    }
    return YES;
}

@end
