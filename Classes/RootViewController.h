//
//  RootViewController.h
//  naivegrid
//
//  Created by Apirom Na Nakorn on 3/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIGridView.h"
#import "UIGridViewDelegate.h"

@interface RootViewController : UIViewController<UIGridViewDelegate> {

}

@property (nonatomic, retain) IBOutlet UIGridView *table;

@end
