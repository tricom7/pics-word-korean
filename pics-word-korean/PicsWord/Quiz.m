//
//  Quiz.m
//  ABC English
//
//  Created by 이선동 on 11. 4. 3..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Quiz.h"
#import "AppDelegate.h"

@implementation Quiz

@synthesize section_index, section_name;
@synthesize WORD_ENG,WORD_CHA,WORD_CHA_PRO,WORD_JPN,WORD_JPN_PRO,WORD_JPN_HIRA,WORD_KOR,WORD_KOR_PRO;



@synthesize textArray_ENG, textArray_Phonetic;

@synthesize oxButton1;
@synthesize oxButton2;
@synthesize oxButton3;
@synthesize oxButton4;

@synthesize button1;
@synthesize button2;
@synthesize button3;
@synthesize button4;
@synthesize isConsonant;


@synthesize OmanPoint, XmanPoint, flagPoint, gradation;

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
    
    
    
    
    
    [textArray_ENG release];
    [textArray_Phonetic release];
    
    [button1 release];
    [button2 release];
    [button3 release];
    [button4 release];

    [oxButton1 release];
    [oxButton2 release];
    [oxButton3 release];
    [oxButton4 release];
    [label_phonetic release];
    [Oman release];
    [Xman release];
    [finalFlag release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

int ordinal;
bool isEnd;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    
    
    
    
    
    isEnd=false;
    ordinal=-1;
 
    textArray_ENG = [[NSMutableArray alloc] init];
    textArray_Phonetic = [[NSMutableArray alloc] init];
    
    NSMutableSet *selectedNumber = [[NSMutableSet alloc] init];
    
    int randomNum;
    
    
    
    for (int i=0; i<[WORD_ENG count]; i++) {
        
        do {
            randomNum = ((random() % [WORD_ENG count]));
        } while ([selectedNumber containsObject:[NSNumber numberWithInt:randomNum]]);

        [selectedNumber addObject:[NSNumber numberWithInt:randomNum]];
        NSString *quizChar = [WORD_ENG objectAtIndex:randomNum]; //1~quizCount 중에서 문제 결정
//        NSString *quizPhonetic = [WORD_KOR_PRO objectAtIndex:randomNum];
        //발음글자 대신 해당 단어에 해당하는 글자 표시.
        NSString *quizPhonetic = [WORD_ENG objectAtIndex:randomNum];
        if ([[self appDelegate].lang isEqualToString:@"ENG"]) {
            quizPhonetic = [WORD_ENG objectAtIndex:randomNum];
        } else if ([[self appDelegate].lang isEqualToString:@"CHA"]) {
            quizPhonetic = [WORD_CHA objectAtIndex:randomNum];
        } else if ([[self appDelegate].lang isEqualToString:@"JPN"]) {
            quizPhonetic = [WORD_JPN objectAtIndex:randomNum];
        } else if ([[self appDelegate].lang isEqualToString:@"KOR"]) {
            quizPhonetic = [WORD_KOR objectAtIndex:randomNum];
        } else {
            NSLog(@"Unknown lang..");
        }

        
        
        

        [textArray_ENG addObject:quizChar];
        [textArray_Phonetic addObject:quizPhonetic];
    }
    
    [selectedNumber release];

	srandom(time(0)); // seed random number generator
	
	[oxButton1 setAlpha:0.0];
	[oxButton2 setAlpha:0.0];
	[oxButton3 setAlpha:0.0];
	[oxButton4 setAlpha:0.0];

    [self performSelector:@selector(nextQuiz) withObject:nil afterDelay:0];
    
    countO = 0;
    countX = 0;

    //사람의 진행 간격(눈금) 길이 계산하기
    OmanPoint = Oman.center;
    XmanPoint = Xman.center;
    flagPoint = finalFlag.center;
//    gradation = (flagPoint.x - OmanPoint.x)/[self appDelegate].globalQuizCount+1;
    gradation = ((flagPoint.x-finalFlag.frame.size.width/2) - (OmanPoint.x+Oman.frame.size.width/2))/[WORD_ENG count];
    
//    NSLog(@"Oman.x=%f,Flag.x=%f,gradation=%f",OmanPoint.x,flagPoint.x,gradation);
    
    //발음 기호를 설정 상태에 따로 보이거나 보이지 않게..
//    if ([self appDelegate].isPhoneticSymbolOnQuiz==0) {
//        [label_phonetic setAlpha:0.0];
//    } else {
//        [label_phonetic setAlpha:1.0];
//    }

}

- (void)viewDidUnload
{
    [self setButton1:nil];
    [self setButton2:nil];
    [self setButton3:nil];
    [self setButton4:nil];

    [self setOxButton1:nil];
    [self setOxButton2:nil];
    [self setOxButton3:nil];
    [self setOxButton4:nil];
    [label_phonetic release];
    label_phonetic = nil;
    [Oman release];
    Oman = nil;
    [Xman release];
    Xman = nil;
    [finalFlag release];
    finalFlag = nil;
    [currentNumber release];
    currentNumber = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {

}


- (void)viewWillDisappear:(BOOL)animated {
    [self setButton1:nil];
    [self setButton2:nil];
    [self setButton3:nil];
    [self setButton4:nil];
    
    [self setOxButton1:nil];
    [self setOxButton2:nil];
    [self setOxButton3:nil];
    [self setOxButton4:nil];
    [label_phonetic release];
    label_phonetic = nil;
    [Oman release];
    Oman = nil;
    [Xman release];
    Xman = nil;
    [finalFlag release];
    finalFlag = nil;
    [currentNumber release];
    currentNumber = nil;
    
    
    
//    [self dealloc];
    
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}




- (void) quizEnd {
    ordinal = 0; //배열의 끝에 도달하면 다시 배열의 처음으로 가도록...   
    
    float correctPercent = ([[NSNumber numberWithInt:countO] floatValue]/[[NSNumber numberWithInt:(countO+countX)] floatValue])*100;
    float incorrectPercent = ([[NSNumber numberWithInt:countX] floatValue]/[[NSNumber numberWithInt:(countO+countX)] floatValue])*100;
    
    UIAlertView *alert = [[UIAlertView alloc] init];
    
    if (countX > countO) {
        [alert setTitle:@"X win!"];
        [[self appDelegate] soundPlay:@"end6_laugh.mp3"];
    } else {
        [alert setTitle:@"O win!"];
        if (correctPercent >= 90) {
            [[self appDelegate] soundPlay:@"end1_cheer.mp3"];
        } else if (correctPercent >= 80) {
            [[self appDelegate] soundPlay:@"end3_kids_cheer.mp3"];
        } else if (correctPercent >= 70) {
            [[self appDelegate] soundPlay:@"end2_applause.mp3"];
        } else if (correctPercent >= 60) {
            [[self appDelegate] soundPlay:@"end4_clap.mp3"];
        } else if (correctPercent >= 50) {
            [[self appDelegate] soundPlay:@"end5_aah.mp3"];
        }
    }
    
    
    [alert setMessage:[NSString stringWithFormat:@" O: %d (%.2f%%) \nX: %d (%.2f%%)",countO,correctPercent,countX,incorrectPercent]];
    [alert setDelegate:self];
    [alert addButtonWithTitle:@"OK"];
    [alert show];
    [alert release];
    isEnd=true;
}

- (IBAction) button1Clicked:(id)sender {
	[oxButton1 setAlpha:1.0];
	if (ordinal==-1) {
		[self performSelector:@selector(nextQuiz) withObject:nil afterDelay:0];
	} else {
		if (dabNo == 1) {
            countO = countO + 1;

            Oman.center = CGPointMake(OmanPoint.x+gradation, OmanPoint.y);
            OmanPoint = Oman.center;

			[[self appDelegate] soundPlay:@"O.mp3"];
            
            button2.enabled = false;
            button3.enabled = false;
            button4.enabled = false;
            
			[self performSelector:@selector(nextQuiz) withObject:nil afterDelay:1];
		} else {
            countX = countX + 1;

            Xman.center = CGPointMake(XmanPoint.x+gradation, XmanPoint.y);
            XmanPoint = Xman.center;
            
			[[self appDelegate] soundPlay:@"X.mp3"];
            
            if (countX >= [textArray_ENG count]) {
                [self quizEnd];
            }
		}
        button1.enabled = false;
	}
}

- (IBAction) button2Clicked:(id)sender {
	[oxButton2 setAlpha:1.0];
	if (ordinal==-1) {
		[self performSelector:@selector(nextQuiz) withObject:nil afterDelay:0];
	} else {
		if (dabNo == 2) {
            countO = countO + 1;

            Oman.center = CGPointMake(OmanPoint.x+gradation, OmanPoint.y);
            OmanPoint = Oman.center;
            
			[[self appDelegate] soundPlay:@"O.mp3"];
            
            button1.enabled = false;
            button3.enabled = false;
            button4.enabled = false;

			[self performSelector:@selector(nextQuiz) withObject:nil afterDelay:1];
		} else {
            countX = countX + 1;

            Xman.center = CGPointMake(XmanPoint.x+gradation, XmanPoint.y);
            XmanPoint = Xman.center;
            
			[[self appDelegate] soundPlay:@"X.mp3"];  
            
            if (countX >= [textArray_ENG count]) {
                [self quizEnd];
            }
		}
        button2.enabled = false;
	}
}

- (IBAction) button3Clicked:(id)sender {
	[oxButton3 setAlpha:1.0];
	if (ordinal==-1) {
		[self performSelector:@selector(nextQuiz) withObject:nil afterDelay:0];
	} else {
		if (dabNo == 3) {
            countO = countO + 1;

            Oman.center = CGPointMake(OmanPoint.x+gradation, OmanPoint.y);
            OmanPoint = Oman.center;
            
			[[self appDelegate] soundPlay:@"O.mp3"];
            
            button1.enabled = false;
            button2.enabled = false;
            button4.enabled = false;
            
			[self performSelector:@selector(nextQuiz) withObject:nil afterDelay:1];
		} else {
            countX = countX + 1;

            Xman.center = CGPointMake(XmanPoint.x+gradation, XmanPoint.y);
            XmanPoint = Xman.center;
            
			[[self appDelegate] soundPlay:@"X.mp3"];
            
            if (countX >= [textArray_ENG count]) {
                [self quizEnd];
            }
		}
        button3.enabled = false;
	}
}

- (IBAction) button4Clicked:(id)sender {
	[oxButton4 setAlpha:1.0];
	if (ordinal==-1) {
		[self performSelector:@selector(nextQuiz) withObject:nil afterDelay:0];
	} else {
		if (dabNo == 4) {
            countO = countO + 1;

            Oman.center = CGPointMake(OmanPoint.x+gradation, OmanPoint.y);
            OmanPoint = Oman.center;
            
			[[self appDelegate] soundPlay:@"O.mp3"];
            
            button1.enabled = false;
            button2.enabled = false;
            button3.enabled = false;
            
			[self performSelector:@selector(nextQuiz) withObject:nil afterDelay:1];
		} else {
            countX = countX + 1;

            Xman.center = CGPointMake(XmanPoint.x+gradation, XmanPoint.y);
            XmanPoint = Xman.center;
            
			[[self appDelegate] soundPlay:@"X.mp3"];
            
            if (countX >= [textArray_ENG count]) {
                [self quizEnd];
            }
            
		}
        button4.enabled = false;
	}
}

- (IBAction)goHome:(id)sender {
    ordinal = 0;
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)soundClicked:(id)sender {
    //발음
    if ([[self appDelegate].lang isEqualToString:@"ENG"]) {
        audioName_ENG = [NSString stringWithFormat:@"ENG_%@.mp3", [textArray_ENG objectAtIndex:ordinal]]; 
        
    } else if ([[self appDelegate].lang isEqualToString:@"CHA"]) {
        audioName_ENG = [NSString stringWithFormat:@"CHA_%@.mp3", [textArray_ENG objectAtIndex:ordinal]]; 
        
    } else if ([[self appDelegate].lang isEqualToString:@"JPN"]) {
        audioName_ENG = [NSString stringWithFormat:@"JPN_%@.mp3", [textArray_ENG objectAtIndex:ordinal]]; 
        
    } else if ([[self appDelegate].lang isEqualToString:@"KOR"]) {
        audioName_ENG = [NSString stringWithFormat:@"KOR_%@.mp3", [textArray_ENG objectAtIndex:ordinal]]; 
        
    } else {
        NSLog(@"Unknown lang..");
    }
    
//    NSLog(@"audioName_ENG=%@",audioName_ENG);
    
    [[self appDelegate] soundPlay:audioName_ENG];
    

}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 0)
	{
		[self goHome:self];
	}
}



- (void) nextQuiz {
    NSString * imageName;
    UIImage* image;
    
    button1.enabled = true;
    button2.enabled = true;
    button3.enabled = true;
    button4.enabled = true;
    
	[oxButton1 setAlpha:0.0];
	[oxButton2 setAlpha:0.0];
	[oxButton3 setAlpha:0.0];
	[oxButton4 setAlpha:0.0];

	ordinal = ordinal+1; //다음 배열(즉, 다음 그림)로 이동시켜 둠.

	if (ordinal == [textArray_ENG count]) {
        [self quizEnd];
    }
	
	dabNo = (random() % 4) + 1; //1~4 중에서 답이 될 버튼 결정
	
//    NSLog(@"ordinal = %d",ordinal);
//    NSLog(@"[textArray_ENG count] = %d",[textArray_ENG count]);
    
	//답이 아닌 버튼들에 나올 그림(인덱스)을 랜덤하게 불러오기(중복되지 않도록 while문 3개 사용)
	int noDab1 = (random() % [textArray_ENG count]); //0~113
	while (ordinal == noDab1) {
		noDab1 = (random() % [textArray_ENG count]);
	}
	
	int noDab2 = (random() % [textArray_ENG count]);
	while (ordinal == noDab2 || noDab1 == noDab2) {
		noDab2 = (random() % [textArray_ENG count]);
	}
	
	int noDab3 = (random() % [textArray_ENG count]);
	while (ordinal == noDab3 || noDab1 == noDab3 || noDab2 == noDab3) {
		noDab3 = (random() % [textArray_ENG count]);
	}
	
	switch (dabNo) { //답이된 버튼에 따른 처리
		case 1:
//            [button1 setTitle:[textArray_ENG objectAtIndex:ordinal] forState:UIControlStateNormal];
//            [button2 setTitle:[textArray_ENG objectAtIndex:noDab1] forState:UIControlStateNormal];
//            [button3 setTitle:[textArray_ENG objectAtIndex:noDab2] forState:UIControlStateNormal];
//            [button4 setTitle:[textArray_ENG objectAtIndex:noDab3] forState:UIControlStateNormal];
            

            imageName = [[textArray_ENG objectAtIndex:ordinal] stringByAppendingString:@".png"];
            image = [UIImage imageNamed:imageName];
            [button1 setImage:image forState:UIControlStateNormal];
            
            imageName = [[textArray_ENG objectAtIndex:noDab1] stringByAppendingString:@".png"];
            image = [UIImage imageNamed:imageName];
            [button2 setImage:image forState:UIControlStateNormal];
            
            imageName = [[textArray_ENG objectAtIndex:noDab2] stringByAppendingString:@".png"];
            image = [UIImage imageNamed:imageName];
            [button3 setImage:image forState:UIControlStateNormal];
            
            imageName = [[textArray_ENG objectAtIndex:noDab3] stringByAppendingString:@".png"];
            image = [UIImage imageNamed:imageName];
            [button4 setImage:image forState:UIControlStateNormal];
            
			
			oxImageName1 = @"O.png";
			oxImageName2 = @"X.png";
			oxImageName3 = @"X.png";
			oxImageName4 = @"X.png";
			
			break;
		case 2:
//            [button1 setTitle:[textArray_ENG objectAtIndex:noDab1] forState:UIControlStateNormal];
//            [button2 setTitle:[textArray_ENG objectAtIndex:ordinal] forState:UIControlStateNormal];
//            [button3 setTitle:[textArray_ENG objectAtIndex:noDab2] forState:UIControlStateNormal];
//            [button4 setTitle:[textArray_ENG objectAtIndex:noDab3] forState:UIControlStateNormal];
            
            imageName = [[textArray_ENG objectAtIndex:noDab1] stringByAppendingString:@".png"];
            image = [UIImage imageNamed:imageName];
            [button1 setImage:image forState:UIControlStateNormal];
            
            imageName = [[textArray_ENG objectAtIndex:ordinal] stringByAppendingString:@".png"];
            image = [UIImage imageNamed:imageName];
            [button2 setImage:image forState:UIControlStateNormal];
            
            imageName = [[textArray_ENG objectAtIndex:noDab2] stringByAppendingString:@".png"];
            image = [UIImage imageNamed:imageName];
            [button3 setImage:image forState:UIControlStateNormal];
            
            imageName = [[textArray_ENG objectAtIndex:noDab3] stringByAppendingString:@".png"];
            image = [UIImage imageNamed:imageName];
            [button4 setImage:image forState:UIControlStateNormal];
            
			oxImageName1 = @"X.png";
			oxImageName2 = @"O.png";
			oxImageName3 = @"X.png";
			oxImageName4 = @"X.png";
			
			break;
		case 3:
//            [button1 setTitle:[textArray_ENG objectAtIndex:noDab1] forState:UIControlStateNormal];
//            [button2 setTitle:[textArray_ENG objectAtIndex:noDab2] forState:UIControlStateNormal];
//            [button3 setTitle:[textArray_ENG objectAtIndex:ordinal] forState:UIControlStateNormal];
//            [button4 setTitle:[textArray_ENG objectAtIndex:noDab3] forState:UIControlStateNormal];
            
            imageName = [[textArray_ENG objectAtIndex:noDab1] stringByAppendingString:@".png"];
            image = [UIImage imageNamed:imageName];
            [button1 setImage:image forState:UIControlStateNormal];
            
            imageName = [[textArray_ENG objectAtIndex:noDab2] stringByAppendingString:@".png"];
            image = [UIImage imageNamed:imageName];
            [button2 setImage:image forState:UIControlStateNormal];
            
            imageName = [[textArray_ENG objectAtIndex:ordinal] stringByAppendingString:@".png"];
            image = [UIImage imageNamed:imageName];
            [button3 setImage:image forState:UIControlStateNormal];
            
            imageName = [[textArray_ENG objectAtIndex:noDab3] stringByAppendingString:@".png"];
            image = [UIImage imageNamed:imageName];
            [button4 setImage:image forState:UIControlStateNormal];
            
			oxImageName1 = @"X.png";
			oxImageName2 = @"X.png";
			oxImageName3 = @"O.png";
			oxImageName4 = @"X.png";
			
			break;
		case 4:
//            [button1 setTitle:[textArray_ENG objectAtIndex:noDab1] forState:UIControlStateNormal];
//            [button2 setTitle:[textArray_ENG objectAtIndex:noDab2] forState:UIControlStateNormal];
//            [button3 setTitle:[textArray_ENG objectAtIndex:noDab3] forState:UIControlStateNormal];
//            [button4 setTitle:[textArray_ENG objectAtIndex:ordinal] forState:UIControlStateNormal];
            
            imageName = [[textArray_ENG objectAtIndex:noDab1] stringByAppendingString:@".png"];
            image = [UIImage imageNamed:imageName];
            [button1 setImage:image forState:UIControlStateNormal];
            
            imageName = [[textArray_ENG objectAtIndex:noDab2] stringByAppendingString:@".png"];
            image = [UIImage imageNamed:imageName];
            [button2 setImage:image forState:UIControlStateNormal];
            
            imageName = [[textArray_ENG objectAtIndex:noDab3] stringByAppendingString:@".png"];
            image = [UIImage imageNamed:imageName];
            [button3 setImage:image forState:UIControlStateNormal];
            
            imageName = [[textArray_ENG objectAtIndex:ordinal] stringByAppendingString:@".png"];
            image = [UIImage imageNamed:imageName];
            [button4 setImage:image forState:UIControlStateNormal];
            
			oxImageName1 = @"X.png";
			oxImageName2 = @"X.png";
			oxImageName3 = @"X.png";
			oxImageName4 = @"O.png";
			
			break;
		default:
			break;
	}
    
	UIImage* oxImage1 = [UIImage imageNamed:oxImageName1];
	UIImage* oxImage2 = [UIImage imageNamed:oxImageName2];
	UIImage* oxImage3 = [UIImage imageNamed:oxImageName3];
	UIImage* oxImage4 = [UIImage imageNamed:oxImageName4];
	
	[oxButton1 setImage:oxImage1 forState:UIControlStateNormal];
	[oxButton2 setImage:oxImage2 forState:UIControlStateNormal];
	[oxButton3 setImage:oxImage3 forState:UIControlStateNormal];
	[oxButton4 setImage:oxImage4 forState:UIControlStateNormal];
	

    
    
    
    
    currentNumber.text = [NSString stringWithFormat:@"#%d/%d",ordinal+1,[textArray_ENG count]];
    
    //    audioName_ENG = [NSString stringWithFormat:@"%@.mp3", [textArray_ENG objectAtIndex:ordinal]];    
    
    //발음
    if ([[self appDelegate].lang isEqualToString:@"ENG"]) {
        audioName_ENG = [NSString stringWithFormat:@"ENG_%@.mp3", [textArray_ENG objectAtIndex:ordinal]]; 
    } else if ([[self appDelegate].lang isEqualToString:@"CHA"]) {
        audioName_ENG = [NSString stringWithFormat:@"CHA_%@.mp3", [textArray_ENG objectAtIndex:ordinal]]; 
    } else if ([[self appDelegate].lang isEqualToString:@"JPN"]) {
        audioName_ENG = [NSString stringWithFormat:@"JPN_%@.mp3", [textArray_ENG objectAtIndex:ordinal]]; 
    } else if ([[self appDelegate].lang isEqualToString:@"KOR"]) {
        audioName_ENG = [NSString stringWithFormat:@"KOR_%@.mp3", [textArray_ENG objectAtIndex:ordinal]]; 
    } else {
        NSLog(@"Unknown lang..");
    }
    
    
    if (!isEnd) {
        //NSLog(@"audioName_ENG=%@",audioName_ENG);
        [[self appDelegate] soundPlay:audioName_ENG];
        label_phonetic.text = [textArray_Phonetic objectAtIndex:ordinal];
    }
}

- (IBAction)test:(id)sender {
    for (int i=0; i<[WORD_ENG count]; i++) {
        Oman.center = CGPointMake(OmanPoint.x+gradation, OmanPoint.y);
        OmanPoint = Oman.center;
        
        Xman.center = CGPointMake(XmanPoint.x+gradation, XmanPoint.y);
        XmanPoint = Xman.center;
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



@end
