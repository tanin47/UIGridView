//
//  TNGridViewView.m
//  foodling2
//
//  Created by Tanin Na Nakorn on 3/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "TNGridView.h"
#import "TNGridViewDelegate.h"
#import "TNGridViewCell.h"
#import "TNGridViewRow.h"

@implementation TNGridView


@synthesize tnGridViewDelegate;


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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
	self.delegate = nil;
	self.dataSource = nil;
	self.tnGridViewDelegate = nil;
}

- (TNGridViewCell *) dequeueReusableCell
{
	TNGridViewCell* temp = tempCell;
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
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	int residue =  ([tnGridViewDelegate numberOfCellsOfGridView:self] % [tnGridViewDelegate numberOfColumnsOfGridView:self]);
	
	if (residue > 0) residue = 1;
	
	return ([tnGridViewDelegate numberOfCellsOfGridView:self] / [tnGridViewDelegate numberOfColumnsOfGridView:self]) + residue;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tnGridViewDelegate gridView:self heightForRowAt:indexPath.row];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TNGridViewRow";
	
    TNGridViewRow *row = (TNGridViewRow *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (row == nil) {
        row = [[TNGridViewRow alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
	
	int numCols = [tnGridViewDelegate numberOfColumnsOfGridView:self];
	int count = [tnGridViewDelegate numberOfCellsOfGridView:self];
	
	CGFloat x = 0.0;
	CGFloat height = [tnGridViewDelegate gridView:self heightForRowAt:indexPath.row];
	
	for (int i=0;i<numCols;i++) {
		
		if ((i + indexPath.row * numCols) >= count) {
			
			if ([row.contentView.subviews count] > i) {
				((TNGridViewCell *)[row.contentView.subviews objectAtIndex:i]).hidden = YES;
			}
			
			continue;
		}
		
		if ([row.contentView.subviews count] > i) {
			tempCell = [row.contentView.subviews objectAtIndex:i];
		} else {
			tempCell = nil;
		}
		
		TNGridViewCell *cell = [tnGridViewDelegate gridView:self 
												cellForRowAt:indexPath.row 
												 AndColumnAt:i];
		
		if (cell.superview != row.contentView) {
			[cell removeFromSuperview];
			[row.contentView addSubview:cell];
			
			[cell addTarget:self action:@selector(cellPressed:) forControlEvents:UIControlEventTouchUpInside];
		}
		
		cell.hidden = NO;
		cell.rowIndex = indexPath.row;
		cell.colIndex = i;
		
		CGFloat thisWidth = [tnGridViewDelegate gridView:self widthForColumnAt:i];
		cell.frame = CGRectMake(x, 0, thisWidth, height);
		x += thisWidth;
	}
	
	row.frame = CGRectMake(row.frame.origin.x,
							row.frame.origin.y,
							x,
							height);
	
    return row;
}


- (IBAction) cellPressed:(id) sender
{
	TNGridViewCell *cell = (TNGridViewCell *) sender;
	[tnGridViewDelegate gridView:self didSelectRowAt:cell.rowIndex AndColumnAt:cell.colIndex];
}


@end
