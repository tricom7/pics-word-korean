//
//  Study.h
//  ABC English
//
//  Created by 이선동 on 11. 4. 3..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@class AppDelegate;

@interface Flashcard : UIViewController {
    sqlite3 * database;
    NSInteger section_index;
    NSString *section_name;
    
    IBOutlet UIProgressView *progress_word;

    NSMutableArray * WORD_ENG;
    NSMutableArray * WORD_CHA;
    NSMutableArray * WORD_CHA_PRO;
    NSMutableArray * WORD_JPN;
    NSMutableArray * WORD_JPN_PRO;
    NSMutableArray * WORD_JPN_HIRA;
    NSMutableArray * WORD_KOR;
    NSMutableArray * WORD_KOR_PRO;
    
    UIButton *pictureButton;
    NSString *audioName;
    int ordinal;
    UILabel *currentNumber;
    UIButton *nextButton;
    UIButton *previousButton;
    bool isConsonant;
    
    IBOutlet UILabel *label_ENG;
    IBOutlet UILabel *label_CHA;
    IBOutlet UILabel *label_CHA_PRO;
    IBOutlet UILabel *label_JPN;
    IBOutlet UILabel *label_JPN_PRO;
    IBOutlet UILabel *label_JPN_HIRA;
    IBOutlet UILabel *label_KOR;
    IBOutlet UILabel *label_KOR_PRO;
    IBOutlet UISegmentedControl *segment_flag;
    
    UIColor *WHITE;
    UIColor *YELLOW;
    
}

@property (nonatomic, retain) UIColor *WHITE;
@property (nonatomic, retain) UIColor *YELLOW;

- (AppDelegate *)appDelegate;
- (void) getWordFromDB;
- (void) testPrint;
- (void) showCard;

@property (nonatomic, assign) NSInteger section_index;
@property (nonatomic, retain) NSString *section_name;

@property (nonatomic, retain) NSMutableArray * WORD_ENG;
@property (nonatomic, retain) NSMutableArray * WORD_CHA;
@property (nonatomic, retain) NSMutableArray * WORD_CHA_PRO;
@property (nonatomic, retain) NSMutableArray * WORD_JPN;
@property (nonatomic, retain) NSMutableArray * WORD_JPN_PRO;
@property (nonatomic, retain) NSMutableArray * WORD_JPN_HIRA;
@property (nonatomic, retain) NSMutableArray * WORD_KOR;
@property (nonatomic, retain) NSMutableArray * WORD_KOR_PRO;

@property (nonatomic) bool isConsonant;
@property (nonatomic, retain) IBOutlet UIButton *pictureButton;

- (IBAction)goHome:(id)sender;
- (IBAction)previousButtonClicked:(id)sender;
- (IBAction)nextButtonClicked:(id)sender;
- (IBAction)soundClicked:(id)sender;
- (IBAction)pictureButtonClicked:(id)sender;

@property (nonatomic, retain) IBOutlet UILabel *currentNumber;

@property (nonatomic, retain) IBOutlet UIButton *nextButton;
@property (nonatomic, retain) IBOutlet UIButton *previousButton;
- (IBAction)segment_flag_changed:(id)sender;
    
@end
