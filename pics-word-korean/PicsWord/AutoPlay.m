//
//  Watch.m
//  ABC ENGLISH
//
//  Created by 이선동 on 11. 4. 5..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AutoPlay.h"
#import "AppDelegate.h"

@implementation AutoPlay

@synthesize section_index, section_name;
@synthesize WORD_ENG,WORD_CHA,WORD_CHA_PRO,WORD_JPN,WORD_JPN_PRO,WORD_JPN_HIRA,WORD_KOR,WORD_KOR_PRO;



@synthesize currentNumber;
@synthesize pictureButton;



bool pairFlag;

- (AppDelegate *)appDelegate {
	return [[UIApplication sharedApplication] delegate];	
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{

    
    
    [WORD_ENG release];
    [WORD_CHA release];
    [WORD_CHA_PRO release];
    [WORD_JPN release];
    [WORD_JPN_PRO release];
    [WORD_JPN_HIRA release];
    [WORD_KOR release];
    [WORD_KOR_PRO release];
    
    [section_name release];
    
    
    
    
    
    
    
    
    if (myTimer != nil) {
        [myTimer invalidate];
        [myTimer release];
        myTimer = nil;
    }

    [pictureButton release];
    [currentNumber release];
    [labelCaption release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self appDelegate] soundPlay:@"AutoInter.mp3"];
    
    //NSLog(@"section_index=%d", section_index);
    
    //NSLog(@"lang=%@", [self appDelegate].lang);
    
    self.navigationItem.title = section_name;
    
    WORD_ENG = [[NSMutableArray alloc] init];
    WORD_CHA = [[NSMutableArray alloc] init];
    WORD_CHA_PRO = [[NSMutableArray alloc] init];
    WORD_JPN = [[NSMutableArray alloc] init];
    WORD_JPN_PRO = [[NSMutableArray alloc] init];
    WORD_JPN_HIRA = [[NSMutableArray alloc] init];
    WORD_KOR = [[NSMutableArray alloc] init];
    WORD_KOR_PRO = [[NSMutableArray alloc] init];
    
    [self getWordFromDB];
//    [self testPrint];
    

    
    
    
    
    
    
    

    isPlay = true;
    ordinal=0;
    
    //그림 설정
//    NSString * imageName;
//    UIImage* image;
    
//    imageName = [@"SNAP_" stringByAppendingString:[[[self appDelegate].EnglishArray objectAtIndex:ordinal] stringByAppendingString:@".png"]];
//    imageName = [[WORD_ENG objectAtIndex:ordinal] stringByAppendingString:@".png"];
//    image = [UIImage imageNamed:imageName];
//    [pictureButton setImage:image forState:UIControlStateNormal];

    NSString *resourcePath = [[[NSBundle mainBundle] resourcePath] retain];
    
    NSString *pathForImageFile = [resourcePath stringByAppendingPathComponent:[[WORD_ENG objectAtIndex:ordinal] stringByAppendingString:@".png"]];
    NSData *imageData = [[NSData alloc] initWithContentsOfFile:pathForImageFile];
    
    UIImage *image = [[UIImage alloc] initWithData:imageData];
    [imageData release];
    
    [pictureButton setImage:image forState:UIControlStateNormal];
    
    [image release];
    
    [resourcePath release];
    
    
    
    
    
    
    
    
    
	labelCaption.text = [WORD_ENG objectAtIndex:0];
    
    myTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextButtonClicked) userInfo:nil repeats:YES];
    //LSD 테스트를 위해 3을 0.5로 수정함.
    

    
//    if ([[self appDelegate].lang isEqualToString:@"ENG"]) {
//        segment_flag.selectedSegmentIndex = 0;
//    } else if ([[self appDelegate].lang isEqualToString:@"CHA"]) {
//        segment_flag.selectedSegmentIndex = 1;
//    } else if ([[self appDelegate].lang isEqualToString:@"JPN"]) {
//        segment_flag.selectedSegmentIndex = 2; 
//    } else if ([[self appDelegate].lang isEqualToString:@"KOR"]) {
//        segment_flag.selectedSegmentIndex = 3; 
//    } else {
//        NSLog(@"Unknown lang..");
//    }
}

- (void)viewDidUnload
{
    [self setPictureButton:nil];
    [self setCurrentNumber:nil];
    [labelCaption release];
    labelCaption = nil;
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    pairFlag = true;
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    
    [self setPictureButton:nil];
    [self setCurrentNumber:nil];
    [labelCaption release];
    labelCaption = nil;
    
    isPlay = false;
    
    if (myTimer != nil) {
        [myTimer invalidate];
        myTimer = nil;
    }
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)goHome:(id)sender {
    isPlay = false;
    [self dismissModalViewControllerAnimated:YES];
}

- (void)nextButtonClicked {
    if (isPlay) { 
//        NSString * imageName;
//        UIImage* image;
        
        if (ordinal == [WORD_ENG count]) {
            ordinal = 0; //배열의 끝에 도달하면 다시 배열의 처음으로 가도록...    
            NSLog(@"go to first!");
        }

        //현재 순서
        currentNumber.text = [NSString stringWithFormat:@"# %d / %d",ordinal+1,[WORD_ENG count]];
        //---------------------
        if (pairFlag) { //영어
            //그림 설정
//            imageName = [[WORD_ENG objectAtIndex:ordinal] stringByAppendingString:@".png"];
//            image = [UIImage imageNamed:imageName];
//            [pictureButton setImage:image forState:UIControlStateNormal];

            
            NSString *resourcePath = [[[NSBundle mainBundle] resourcePath] retain];

                NSString *pathForImageFile = [resourcePath stringByAppendingPathComponent:[[WORD_ENG objectAtIndex:ordinal] stringByAppendingString:@".png"]];
                NSData *imageData = [[NSData alloc] initWithContentsOfFile:pathForImageFile];
                
                UIImage *image = [[UIImage alloc] initWithData:imageData];
                [imageData release];
                
                [pictureButton setImage:image forState:UIControlStateNormal];
                
                [image release];

            [resourcePath release];
            
            
            
            
            //캡션 설정
            labelCaption.text = [WORD_ENG objectAtIndex:ordinal];
            
            //영어 발음 내기
            audioName = [NSString stringWithFormat:@"ENG_%@.mp3", [WORD_ENG objectAtIndex:ordinal]];
            [[self appDelegate] soundPlay:audioName];
            
            pairFlag=false;
            
        } else { //다국어(영어, 중국어, 일본어, 한글) 
            //발음
            if ([[self appDelegate].lang isEqualToString:@"ENG"]) {
                audioName = [NSString stringWithFormat:@"ENG_%@.mp3", [WORD_ENG objectAtIndex:ordinal]]; 
                labelCaption.text = [WORD_ENG objectAtIndex:ordinal];
            } else if ([[self appDelegate].lang isEqualToString:@"CHA"]) {
                audioName = [NSString stringWithFormat:@"CHA_%@.mp3", [WORD_ENG objectAtIndex:ordinal]]; 
                labelCaption.text = [WORD_CHA objectAtIndex:ordinal];
            } else if ([[self appDelegate].lang isEqualToString:@"JPN"]) {
                audioName = [NSString stringWithFormat:@"JPN_%@.mp3", [WORD_ENG objectAtIndex:ordinal]]; 
                labelCaption.text = [WORD_JPN objectAtIndex:ordinal];
            } else if ([[self appDelegate].lang isEqualToString:@"KOR"]) {
                audioName = [NSString stringWithFormat:@"KOR_%@.mp3", [WORD_ENG objectAtIndex:ordinal]]; 
                labelCaption.text = [WORD_KOR objectAtIndex:ordinal];
            } else {
                NSLog(@"Unknown lang..");
            }
            
            [[self appDelegate] soundPlay:audioName];
            ordinal = ordinal+1; //다음 배열(즉, 다음 그림)로 이동시켜 둠.              
            pairFlag=true;
        }
        
    } else {
        
    }
}

- (IBAction)playButtonClicked:(id)sender {
    if ([sender selectedSegmentIndex] == 0) {
        isPlay = true;
        
        [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
//        myTimer = [NSTimer scheduledTimerWithTimeInterval:[self appDelegate].timerInterval target:self selector:@selector(nextButtonClicked) userInfo:nil repeats:YES];
        myTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextButtonClicked) userInfo:nil repeats:YES];
    } else {
        isPlay = false;
        
        [[UIApplication sharedApplication] setIdleTimerDisabled:NO];

        if (myTimer != nil) {
            [myTimer invalidate];
            myTimer = nil;
        }
    }
}









NSFileManager *fileManager;
NSString *theDBPath;
sqlite3_stmt *statement;

- (void) getWordFromDB {
    NSString * sql_word = [NSString stringWithFormat:@"SELECT WORD_ENG, WORD_CHA, WORD_CHA_PRO, WORD_JPN, WORD_JPN_PRO, WORD_JPN_HIRA, WORD_KOR, WORD_KOR_PRO FROM WORD where cat_id=%d",section_index ];
    
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
            
            if (sqlite3_prepare_v2(database, [sql_word cStringUsingEncoding:NSUTF8StringEncoding], -1, &statement, NULL) != SQLITE_OK) {
                NSLog(@"Error, failed to prepare statement, normally handle error here.");
            }
            
            //NSLog(@"sql_word=%@",sql_word);
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                [WORD_ENG addObject:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 0)]];
                [WORD_CHA addObject:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 1)]];
                [WORD_CHA_PRO addObject:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 2)]];
                [WORD_JPN addObject:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 3)]];
                [WORD_JPN_PRO addObject:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 4)]];
                [WORD_JPN_HIRA addObject:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 5)]];
                [WORD_KOR addObject:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 6)]];
                [WORD_KOR_PRO addObject:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 7)]];
                
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

- (void) testPrint {
    NSLog(@"test print ... (%d)",[WORD_ENG count]);
    
    for (NSString * test in WORD_ENG) {
        NSLog(@"%@",test);
    }
}

@end
