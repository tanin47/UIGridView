//
//  RootViewController.h
//  naivegrid
//
//  Created by Apirom Na Nakorn on 3/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TNGridView.h"
#import "TNGridViewDelegate.h"

@interface RootViewController : UIViewController<TNGridViewDelegate> {

}

@property (nonatomic, retain) IBOutlet TNGridView *table;

@end
