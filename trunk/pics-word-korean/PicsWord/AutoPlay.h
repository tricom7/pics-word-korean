//
//  Watch.h
//  ABC ENGLISH
//
//  Created by 이선동 on 11. 4. 5..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@class AppDelegate;

@interface AutoPlay : UIViewController {
    
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
    
    
    
    
    
    NSString *audioName;
    int ordinal;
    UIButton *pictureButton;
    UILabel *currentNumber;
    bool isPlay;

    IBOutlet UILabel *labelCaption;
    
    NSTimer *myTimer;
    
    
    
    
    
    
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






- (AppDelegate *)appDelegate;
- (void) getWordFromDB;
- (void) testPrint;

@property (nonatomic, retain) IBOutlet UILabel *currentNumber;

@property (nonatomic, retain) IBOutlet UIButton *pictureButton;

- (IBAction)goHome:(id)sender;

- (void)nextButtonClicked;

- (IBAction)playButtonClicked:(id)sender;

///////////////////////////////////////////



@end
