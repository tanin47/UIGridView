//
//  TNGridView.h
//  foodling2
//
//  Created by Tanin Na Nakorn on 3/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TNGridViewDelegate;
@class TNGridViewCell;

@interface TNGridView : UITableView<UITableViewDelegate, UITableViewDataSource> {
	TNGridViewCell *tempCell;
}

@property (nonatomic, retain) IBOutlet id<TNGridViewDelegate> tnGridViewDelegate;

- (void) setUp;
- (TNGridViewCell *) dequeueReusableCell;

- (IBAction) cellPressed:(id) sender;

@end
