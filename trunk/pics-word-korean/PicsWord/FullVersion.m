//
//  FullVersion.m
//  TapEnglish
//
//  Created by 이선동 on 11. 6. 29..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FullVersion.h"

@implementation FullVersion

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
    [scrollView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [scrollView setContentSize:CGSizeMake(320, 1300)];
}

- (void)viewDidUnload
{
    [scrollView release];
    scrollView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)closeAction:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}



- (IBAction)getOXword:(id)sender {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=452664313&mt=8"]];
    //452664313
    //452664313
}

- (IBAction)getKoreanFlashcard:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=423541431&mt=8"]];
}

- (IBAction)getKoreanAlphabet:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=435334356&mt=8"]];
}

- (IBAction)getKoreanAlphabetSyllable:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=452003911&mt=8"]];
    
}

- (IBAction)getMultiLingual:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=433871009&mt=8"]];
}

- (IBAction)getABCalphabet:(id)sender {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=431457298&mt=8"]];
}

- (IBAction)getEnglishFlashcard:(id)sender {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=426875463&mt=8"]];
}

- (IBAction)getSoundScan:(id)sender {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=446633635&mt=8"]];
}

- (IBAction)getSpeedMap:(id)sender {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=443851835&mt=8"]];
}

- (IBAction)getTouchChinese:(id)sender {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=432769286&mt=8"]];
}

- (IBAction)getTouchEnglish:(id)sender {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=432328969&mt=8"]];
}

- (IBAction)getTouchJapanese:(id)sender {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=432970412&mt=8"]];
}

- (IBAction)getVegeRestaurant:(id)sender {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=442906956&mt=8"]];
}

- (IBAction)getVeganRestaurant:(id)sender {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=443095537&mt=8"]];
}

- (IBAction)getJapaneseAlphabet:(id)sender {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=435002352&mt=8"]];
}

- (IBAction)getLocalSearch:(id)sender {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=443612097&mt=8"]];
}

@end
