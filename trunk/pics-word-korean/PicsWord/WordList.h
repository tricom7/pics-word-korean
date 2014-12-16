//
//  Flashcard.h
//  KoreanBasic600Words
//
//  Created by 이선동 on 11. 8. 30..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate;

@interface WordList : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UITableView *wordTableView;
}

- (AppDelegate *)appDelegate;

- (IBAction)goHome:(id)sender;

@end
