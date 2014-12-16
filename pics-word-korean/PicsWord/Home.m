//
//  KoreanBasic600WordsViewController.m
//  KoreanBasic600Words
//
//  Created by 이선동 on 11. 8. 30..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Home.h"
#import "AppDelegate.h"
#import "WordList.h"
#import "FullVersion.h"

@implementation Home

- (AppDelegate *)appDelegate {
	return [[UIApplication sharedApplication] delegate];	
}

- (void)dealloc
{
    [flashcardNavController release];
    [langSegment release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [flashcardNavController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    
    [self appDelegate].lang = @"KOR";
}


- (void)viewDidUnload
{
    [flashcardNavController release];
    flashcardNavController = nil;
    [langSegment release];
    langSegment = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [[self appDelegate] soundPlay:@"DungDing.mp3"];
    
    if ([[self appDelegate].lang isEqualToString:@"ENG"]) {
        langSegment.selectedSegmentIndex = 0;
    } else if ([[self appDelegate].lang isEqualToString:@"CHA"]) {
        langSegment.selectedSegmentIndex = 1;
    } else if ([[self appDelegate].lang isEqualToString:@"JPN"]) {
        langSegment.selectedSegmentIndex = 2; 
    } else if ([[self appDelegate].lang isEqualToString:@"KOR"]) {
        langSegment.selectedSegmentIndex = 3; 
    } else {
        NSLog(@"Unknown lang..");
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)goAutoPlay:(id)sender {
    [self appDelegate].mode = @"AutoPlay";
    [self presentModalViewController:flashcardNavController animated:YES];
}

- (IBAction)goFlashcard:(id)sender {
    [self appDelegate].mode = @"Flashcard";
    [self presentModalViewController:flashcardNavController animated:YES];
    
}

- (IBAction)goQuiz:(id)sender {
    [self appDelegate].mode = @"Quiz";
    [self presentModalViewController:flashcardNavController animated:YES];
}

- (IBAction)goHome:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)langSegmentChanged:(id)sender {
    switch (langSegment.selectedSegmentIndex) {
        case 0:
            [self appDelegate].lang = @"ENG";
            [[self appDelegate] soundPlay:@"English.mp3"];
            break;
        case 1:
            [self appDelegate].lang = @"CHA";
            [[self appDelegate] soundPlay:@"Chinese.mp3"];
            break;
        case 2:
            [self appDelegate].lang = @"JPN";
            [[self appDelegate] soundPlay:@"Japanese.mp3"];
            break;
        case 3:
            [self appDelegate].lang = @"KOR";
            [[self appDelegate] soundPlay:@"Korean.mp3"];
            break;
        default:
            break;
    }
}

- (IBAction)goOtherApps:(id)sender {
    FullVersion *fullVersion = [[FullVersion alloc] initWithNibName:@"FullVersion" bundle:nil];
    fullVersion.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:fullVersion animated:YES];
    [fullVersion release];
}

@end
