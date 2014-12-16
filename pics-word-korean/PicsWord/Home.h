//
//  KoreanBasic600WordsViewController.h
//  KoreanBasic600Words
//
//  Created by 이선동 on 11. 8. 30..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate;

@interface Home : UIViewController {
    IBOutlet UINavigationController *flashcardNavController;
    IBOutlet UISegmentedControl *langSegment;
}

- (AppDelegate *)appDelegate;

- (IBAction)goAutoPlay:(id)sender;
- (IBAction)goFlashcard:(id)sender;
- (IBAction)goQuiz:(id)sender;
- (IBAction)goHome:(id)sender;
- (IBAction)langSegmentChanged:(id)sender;
- (IBAction)goOtherApps:(id)sender;

@end
