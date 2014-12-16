//
//  Study.m
//  ABC English
//
//  Created by 이선동 on 11. 4. 3..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Flashcard.h"
#import "AppDelegate.h"

@implementation Flashcard

@synthesize section_index, section_name;
@synthesize WORD_ENG,WORD_CHA,WORD_CHA_PRO,WORD_JPN,WORD_JPN_PRO,WORD_JPN_HIRA,WORD_KOR,WORD_KOR_PRO;

@synthesize currentNumber;
@synthesize nextButton;
@synthesize previousButton;
@synthesize pictureButton;
@synthesize isConsonant;

@synthesize WHITE, YELLOW;

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
    [WHITE release];
    [YELLOW release];
    
    [WORD_ENG release];
    [WORD_CHA release];
    [WORD_CHA_PRO release];
    [WORD_JPN release];
    [WORD_JPN_PRO release];
    [WORD_JPN_HIRA release];
    [WORD_KOR release];
    [WORD_KOR_PRO release];
        
    [section_name release];
    
    [pictureButton release];
    [currentNumber release];
    [nextButton release];
    [previousButton release];
    [label_KOR_PRO release];
    [label_KOR release];
    [label_ENG release];
    [label_CHA release];
    [label_JPN release];
    [label_CHA_PRO release];
    [label_JPN_PRO release];
    [label_JPN_HIRA release];
    [segment_flag release];
    [progress_word release];
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
    
    WHITE = [UIColor whiteColor];
    YELLOW = [UIColor yellowColor];
    
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

    ordinal=0;
    
    [self showCard];
    
    if ([[self appDelegate].lang isEqualToString:@"ENG"]) {
        segment_flag.selectedSegmentIndex = 0;
    } else if ([[self appDelegate].lang isEqualToString:@"CHA"]) {
        segment_flag.selectedSegmentIndex = 1;
    } else if ([[self appDelegate].lang isEqualToString:@"JPN"]) {
        segment_flag.selectedSegmentIndex = 2; 
    } else if ([[self appDelegate].lang isEqualToString:@"KOR"]) {
        segment_flag.selectedSegmentIndex = 3; 
    } else {
        NSLog(@"Unknown lang..");
    }
}

- (void)viewDidUnload
{
    [self setPictureButton:nil];
    [self setCurrentNumber:nil];
    [self setNextButton:nil];
    [self setPreviousButton:nil];
    [label_KOR_PRO release];
    label_KOR_PRO = nil;
    [label_KOR release];
    label_KOR = nil;
    [label_ENG release];
    label_ENG = nil;
    [label_CHA release];
    label_CHA = nil;
    [label_JPN release];
    label_JPN = nil;
    [label_CHA_PRO release];
    label_CHA_PRO = nil;
    [label_JPN_PRO release];
    label_JPN_PRO = nil;
    [label_JPN_HIRA release];
    label_JPN_HIRA = nil;
    [segment_flag release];
    segment_flag = nil;
    [progress_word release];
    progress_word = nil;
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    [previousButton setAlpha:0.0];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self setPictureButton:nil];
    [self setCurrentNumber:nil];
    [self setNextButton:nil];
    [self setPreviousButton:nil];
    [label_KOR_PRO release];
    label_KOR_PRO = nil;
    [label_KOR release];
    label_KOR = nil;
    [label_ENG release];
    label_ENG = nil;
    [label_CHA release];
    label_CHA = nil;
    [label_JPN release];
    label_JPN = nil;
    [label_CHA_PRO release];
    label_CHA_PRO = nil;
    [label_JPN_PRO release];
    label_JPN_PRO = nil;
    [label_JPN_HIRA release];
    label_JPN_HIRA = nil;
    [segment_flag release];
    segment_flag = nil;
    [progress_word release];
    progress_word = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)goHome:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}


- (IBAction)previousButtonClicked:(id)sender {
    ordinal = ordinal-1; //이전 배열(즉, 이전 그림)로 이동시켜 둠.
    if (ordinal == -1) ordinal = [WORD_ENG count]-1; //배열의 처음에 도달하면 다시 배열의 끝으로 가도록...

    if (ordinal == 0) {
        [previousButton setAlpha:0.0];
    } else {
        [nextButton setAlpha:1];
    }
    
    [self showCard];
}

- (IBAction)nextButtonClicked:(id)sender {
    ordinal = ordinal+1; //다음 배열(즉, 다음 그림)로 이동시켜 둠.

    if (ordinal == [WORD_ENG count] - 1) {
        [nextButton setAlpha:0.0];
    } else {
        [previousButton setAlpha:1];
    }

    [self showCard];
}





- (IBAction)soundClicked:(id)sender {
    
    label_ENG.textColor = WHITE; 
    label_CHA.textColor = WHITE; 
    label_JPN.textColor = WHITE; 
    label_KOR.textColor = WHITE; 
    
    //발음
    if ([[self appDelegate].lang isEqualToString:@"ENG"]) {
        audioName = [NSString stringWithFormat:@"ENG_%@.mp3", [WORD_ENG objectAtIndex:ordinal]]; 
        label_ENG.textColor = YELLOW;
    } else if ([[self appDelegate].lang isEqualToString:@"CHA"]) {
        audioName = [NSString stringWithFormat:@"CHA_%@.mp3", [WORD_ENG objectAtIndex:ordinal]]; 
        label_CHA.textColor = YELLOW;
    } else if ([[self appDelegate].lang isEqualToString:@"JPN"]) {
        audioName = [NSString stringWithFormat:@"JPN_%@.mp3", [WORD_ENG objectAtIndex:ordinal]]; 
        label_JPN.textColor = YELLOW;
    } else if ([[self appDelegate].lang isEqualToString:@"KOR"]) {
        audioName = [NSString stringWithFormat:@"KOR_%@.mp3", [WORD_ENG objectAtIndex:ordinal]]; 
        label_KOR.textColor = YELLOW;
    } else {
        NSLog(@"Unknown lang..");
    }
    
    [[self appDelegate] soundPlay:audioName];
}

- (IBAction)pictureButtonClicked:(id)sender {
    [self soundClicked:sender];
}

- (void) showCard {

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
    
    
    
    
    
    
    
    //레이블 글자 설정
    label_ENG.text = [WORD_ENG objectAtIndex:ordinal];
    label_CHA.text = [WORD_CHA objectAtIndex:ordinal];
    label_CHA_PRO.text = [WORD_CHA_PRO objectAtIndex:ordinal];
    label_JPN.text = [WORD_JPN objectAtIndex:ordinal];
    label_JPN_PRO.text = [WORD_JPN_PRO objectAtIndex:ordinal];
    label_JPN_HIRA.text = [WORD_JPN_HIRA objectAtIndex:ordinal];
    label_KOR.text = [WORD_KOR objectAtIndex:ordinal];
    label_KOR_PRO.text = [WORD_KOR_PRO objectAtIndex:ordinal];
    
    currentNumber.text = [NSString stringWithFormat:@"# %d / %d",ordinal+1,[WORD_ENG count]];
    float progressRate = (float)(ordinal+1)/[WORD_ENG count];
//    NSLog(@"progressRate=%f",progressRate);
    progress_word.progress = progressRate;
    
    
    [self soundClicked:self];

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


- (IBAction)segment_flag_changed:(id)sender {
    switch (segment_flag.selectedSegmentIndex) {
        case 0:
            [self appDelegate].lang = @"ENG";
            break;
        case 1:
            [self appDelegate].lang = @"CHA";
            break;
        case 2:
            [self appDelegate].lang = @"JPN";
            break;
        case 3:
            [self appDelegate].lang = @"KOR";
            break;
        default:
            break;
    }
    
    [self soundClicked:self];
}
@end
