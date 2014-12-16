//
//  KoreanBasic600WordsAppDelegate.m
//  KoreanBasic600Words
//
//  Created by 이선동 on 11. 8. 30..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "KoreanBasic600WordsAppDelegate.h"
#import "Home.h"

@implementation KoreanBasic600WordsAppDelegate

@synthesize window=_window;
@synthesize viewController=_viewController;
@synthesize CAT_ENG, CAT_KOR, CAT_CHA, CAT_JPN, CAT_KOR_PRO, CAT_CHA_PRO, CAT_JPN_PRO, CAT_JPN_HIRA;
@synthesize mode, lang;

@synthesize CAT_PIC;

//SystemSoundID soundID;
//
//CFURLRef baseURL;

AVAudioPlayer *av;
NSString *sndPath;


- (void) soundPlay:(NSString *)audioName{
//    if (&soundID != nil) {
//        AudioServicesDisposeSystemSoundID(soundID); //이전 소리를 먼저 중지시킨다.
//    }
//    
//	NSString *sndPath = [[NSBundle mainBundle] pathForResource:audioName ofType:nil];
//    
//    NSLog(@"sndPath=%@",sndPath);
//    
//	baseURL = (CFURLRef)[[NSURL alloc] initFileURLWithPath:sndPath];
//	AudioServicesCreateSystemSoundID(baseURL, &soundID);
//	AudioServicesPlaySystemSound(soundID);
    

    if (av.playing) {
        [av stop];
//        [sndPath release]; //LSD : 사용하면 에러남..(소리가 끝나기 전에 다른 소리가 나면..)
        [av release];
    } else {
        [av release];
    }
    
	sndPath = [[NSBundle mainBundle] pathForResource:audioName ofType:nil];
//    NSLog(@"sndPath = %@",sndPath);
	NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:sndPath];
    av = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:NULL];
    
    [fileURL release];
    [av play];
    
    

    
    
}




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.

    lang=@"ENG";

    CAT_ENG = [[NSMutableArray alloc] init];
    CAT_KOR = [[NSMutableArray alloc] init];
    CAT_CHA = [[NSMutableArray alloc] init];
    CAT_JPN = [[NSMutableArray alloc] init];
    CAT_KOR_PRO = [[NSMutableArray alloc] init];
    CAT_CHA_PRO = [[NSMutableArray alloc] init];
    CAT_JPN_PRO = [[NSMutableArray alloc] init];
    CAT_JPN_HIRA = [[NSMutableArray alloc] init];
    
    [self getCatFromDB];
    
    CAT_PIC = [[NSArray alloc] initWithObjects:@"red", @"one", @"zebra", @"ladybug", @"grapes", @"corn", @"sandwich", @"juice", @"winter", @"January", @"father", @"T-shirt", @"hair", @"full", @"play", @"happy", @"sun", @"lightning", @"sofa", @"kettle", @"shop", @"north", @"roof", @"toilet paper", @"train", @"scissors", @"dice", @"model", nil];

    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [CAT_ENG release];
    [CAT_KOR release];
    [CAT_CHA release];
    [CAT_JPN release];
    [CAT_KOR_PRO release];
    [CAT_CHA_PRO release];
    [CAT_JPN_PRO release];
    [CAT_JPN_HIRA release];

    [mode release];
    [lang release];
    
    [CAT_PIC release];
    
    [_window release];
    [_viewController release];
    [super dealloc];
}

NSFileManager *fileManager;
NSString *theDBPath;
sqlite3_stmt *statement;

- (void) getCatFromDB {
    NSString * sql_cat = @"SELECT CAT_ENG, CAT_KOR, CAT_CHA, CAT_JPN, CAT_KOR_PRO, CAT_CHA_PRO, CAT_JPN_PRO, CAT_JPN_HIRA FROM CATEGORY";
    
    @synchronized(self) {
        @try {
            fileManager = [NSFileManager defaultManager];
            theDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"BasicWord.sqlite"];
            
            BOOL success = [fileManager fileExistsAtPath:theDBPath];
            if (!success) {
                NSLog(@"Failed to find database file '%@'.",theDBPath);    
            }
            if (!(sqlite3_open([theDBPath UTF8String], &database) == SQLITE_OK)) {
                NSLog(@"An error opening database, normally handle error here.");
            }
            
            if (sqlite3_prepare_v2(database, [sql_cat cStringUsingEncoding:NSUTF8StringEncoding], -1, &statement, NULL) != SQLITE_OK) {
                NSLog(@"Error, failed to prepare statement, normally handle error here.");
            }

            while (sqlite3_step(statement) == SQLITE_ROW) {
                [CAT_ENG addObject:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 0)]];
                [CAT_KOR addObject:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 1)]];
                [CAT_CHA addObject:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 2)]];
                [CAT_JPN addObject:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 3)]];
                [CAT_KOR_PRO addObject:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 4)]];
                [CAT_CHA_PRO addObject:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 5)]];
                [CAT_JPN_PRO addObject:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 6)]];
                [CAT_JPN_HIRA addObject:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 7)]];
            }
            
            if (sqlite3_finalize(statement) != SQLITE_OK) {
                NSLog(@"1Failed to finalize data statement, normally error handling here.");
            }
            
            if (sqlite3_close(database) != SQLITE_OK) {
                NSLog(@"Failed to close database, normally error handling here.");
            }
        }
        
        @catch (NSException *exception) {
            NSLog(@"An exception occurred: %@", [exception reason]);
        }
        
        @finally {
            
        }
    }
}





@end
