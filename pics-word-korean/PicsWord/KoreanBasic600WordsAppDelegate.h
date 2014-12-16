//
//  KoreanBasic600WordsAppDelegate.h
//  KoreanBasic600Words
//
//  Created by 이선동 on 11. 8. 30..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@class Home;

@interface KoreanBasic600WordsAppDelegate : NSObject <UIApplicationDelegate> {
    NSMutableArray * CAT_ENG;
    NSMutableArray * CAT_KOR;
    NSMutableArray * CAT_CHA;
    NSMutableArray * CAT_JPN;
    NSMutableArray * CAT_KOR_PRO;
    NSMutableArray * CAT_CHA_PRO;
    NSMutableArray * CAT_JPN_PRO;
    NSMutableArray * CAT_JPN_HIRA;

    sqlite3 * database;
    
    NSString * mode;
    NSString * lang;
    
    NSArray * CAT_PIC;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet Home *viewController;

@property (nonatomic, retain) NSMutableArray * CAT_ENG;
@property (nonatomic, retain) NSMutableArray * CAT_KOR;
@property (nonatomic, retain) NSMutableArray * CAT_CHA;
@property (nonatomic, retain) NSMutableArray * CAT_JPN;
@property (nonatomic, retain) NSMutableArray * CAT_KOR_PRO;
@property (nonatomic, retain) NSMutableArray * CAT_CHA_PRO;
@property (nonatomic, retain) NSMutableArray * CAT_JPN_PRO;
@property (nonatomic, retain) NSMutableArray * CAT_JPN_HIRA;

@property (nonatomic, retain) NSString * mode;
@property (nonatomic, retain) NSString * lang;

- (void) getCatFromDB;

- (void) soundPlay:(NSString *)audioName;

@property (nonatomic, retain) NSArray * CAT_PIC;

@end
