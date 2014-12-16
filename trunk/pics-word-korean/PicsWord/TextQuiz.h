//
//  Quiz.h
//  ABC English
//
//  Created by 이선동 on 11. 4. 3..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@class AppDelegate;

@interface TextQuiz : UIViewController {
    sqlite3 * database;
    NSInteger section_index;
    NSString *section_name;
    
    NSMutableArray * WORD_ENG;
    NSMutableArray * WORD_CHA;
    NSMutableArray * WORD_CHA_PRO;
    NSMutableArray * WORD_JPN;
    NSMutableArray * WORD_JPN_PRO;
    NSMutableArray * WORD_JPN_HIRA;
    NSMutableArray * WORD_KOR;
    NSMutableArray * WORD_KOR_PRO;
    
    
    
    
    
    
    
    NSMutableArray *textArray_ENG;
    NSMutableArray *textArray_KOR;
    NSMutableArray *textArray_Phonetic;
    
    UIButton *button1;
    UIButton *button2;
    UIButton *button3;
    UIButton *button4;

    int dabNo;
    
    int countO;
    int countX;
    
    UIButton *oxButton1;
    UIButton *oxButton2;
    UIButton *oxButton3;
    UIButton *oxButton4;
    
    NSString *oxImageName1;
	NSString *oxImageName2;
	NSString *oxImageName3;
	NSString *oxImageName4;
    
    NSString *audioName_ENG;
    
    bool isConsonant;
    IBOutlet UILabel *label_phonetic;

    IBOutlet UIImageView *Oman;
    IBOutlet UIImageView *Xman;
    IBOutlet UIImageView *finalFlag;
    
    CGPoint OmanPoint;
    CGPoint XmanPoint;
    CGPoint flagPoint;
    float gradation;
    
    IBOutlet UILabel *currentNumber;
}

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

- (void) getWordFromDB;






- (AppDelegate *)appDelegate;

@property (nonatomic) bool isConsonant;

@property (nonatomic, retain) IBOutlet UIButton *button1;
@property (nonatomic, retain) IBOutlet UIButton *button2;
@property (nonatomic, retain) IBOutlet UIButton *button3;
@property (nonatomic, retain) IBOutlet UIButton *button4;

- (IBAction)button1Clicked:(id)sender;
- (IBAction)button2Clicked:(id)sender;
- (IBAction)button3Clicked:(id)sender;
- (IBAction)button4Clicked:(id)sender;

@property (nonatomic, retain) IBOutlet UIButton *oxButton1;
@property (nonatomic, retain) IBOutlet UIButton *oxButton2;
@property (nonatomic, retain) IBOutlet UIButton *oxButton3;
@property (nonatomic, retain) IBOutlet UIButton *oxButton4;


@property (nonatomic) CGPoint OmanPoint;
@property (nonatomic) CGPoint XmanPoint;
@property (nonatomic) CGPoint flagPoint;
@property (nonatomic) float gradation;

- (IBAction)goHome:(id)sender;
- (IBAction)soundClicked:(id)sender;

@property (nonatomic, retain) NSMutableArray *textArray_ENG;
@property (nonatomic, retain) NSMutableArray *textArray_KOR;
@property (nonatomic, retain) NSMutableArray *textArray_Phonetic;

- (IBAction)test:(id)sender;

@end
