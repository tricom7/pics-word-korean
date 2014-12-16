//
//  Flashcard.m
//  KoreanBasic600Words
//
//  Created by 이선동 on 11. 8. 30..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WordList.h"
#import "AppDelegate.h"
#import "AutoPlay.h"
#import "Flashcard.h"
#import "Quiz.h"

@implementation WordList

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
    [wordTableView release];
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
}

- (void)viewDidUnload
{
    [wordTableView release];
    wordTableView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {

//    NSLog(@"mode=%@",[self appDelegate].mode);
    
    if ([[self appDelegate].mode isEqualToString:@"AutoPlay"]) {
        [[self appDelegate] soundPlay:@"AutoPlay.mp3"];
    } else if ([[self appDelegate].mode isEqualToString:@"Flashcard"]) {
        [[self appDelegate] soundPlay:@"Flashcard.aiff"];
    } else if ([[self appDelegate].mode isEqualToString:@"Quiz"]) {
        [[self appDelegate] soundPlay:@"Quiz.aiff"];
    }
    
    self.navigationItem.title = [self appDelegate].mode;
//    UIImage *image = [UIImage imageNamed: @"ICO_speaker.png"];
//    UIImageView *imageView = [[UIImageView alloc] initWithImage: image];
//    self.navigationItem.titleView = imageView;
//    [imageView release];
    [wordTableView reloadData];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)goHome:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}


// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self appDelegate].CAT_ENG count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
//        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    

    // Configure the cell.
    if ([[self appDelegate].lang isEqualToString:@"ENG"]) {
        cell.textLabel.text = [[self appDelegate].CAT_ENG objectAtIndex:[indexPath row]];
        cell.detailTextLabel.text = @"";
    } else if ([[self appDelegate].lang isEqualToString:@"CHA"]) {
        cell.textLabel.text = [[self appDelegate].CAT_CHA objectAtIndex:[indexPath row]];
        cell.detailTextLabel.text = [[self appDelegate].CAT_ENG objectAtIndex:[indexPath row]];
    } else if ([[self appDelegate].lang isEqualToString:@"JPN"]) {
        cell.textLabel.text = [[self appDelegate].CAT_JPN objectAtIndex:[indexPath row]];
        cell.detailTextLabel.text = [[self appDelegate].CAT_ENG objectAtIndex:[indexPath row]];
    } else if ([[self appDelegate].lang isEqualToString:@"KOR"]) {
        cell.textLabel.text = [[self appDelegate].CAT_KOR objectAtIndex:[indexPath row]];
        cell.detailTextLabel.text = [[self appDelegate].CAT_ENG objectAtIndex:[indexPath row]];
    } else {
        NSLog(@"unknow language !");
    }

    UIImage *thumbnail = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [[self appDelegate].CAT_PIC objectAtIndex:[indexPath row]]]];
    
    cell.imageView.image = thumbnail;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if ([[self appDelegate].mode isEqualToString:@"AutoPlay"]) {
        AutoPlay *detailViewController = [[AutoPlay alloc] initWithNibName:@"AutoPlay" bundle:nil];
        
        detailViewController.section_index = indexPath.row+1; //row는 0부터 시작하고 DB의 CAT_ID는 1부터 시작하므로 +1을 함.
        if ([[self appDelegate].lang isEqualToString:@"ENG"]) {
            detailViewController.section_name = [[self appDelegate].CAT_ENG objectAtIndex:[indexPath row]];
        } else if ([[self appDelegate].lang isEqualToString:@"CHA"]) {
            detailViewController.section_name = [[self appDelegate].CAT_CHA objectAtIndex:[indexPath row]];
        } else if ([[self appDelegate].lang isEqualToString:@"JPN"]) {
            detailViewController.section_name = [[self appDelegate].CAT_JPN objectAtIndex:[indexPath row]];
        } else if ([[self appDelegate].lang isEqualToString:@"KOR"]) {
            detailViewController.section_name = [[self appDelegate].CAT_KOR objectAtIndex:[indexPath row]];
        } else {
            NSLog(@"unknow language .. !");
        }
        [self.navigationController pushViewController:detailViewController animated:YES];
        [detailViewController release];
    } else if ([[self appDelegate].mode isEqualToString:@"Flashcard"]) {
        Flashcard *detailViewController = [[Flashcard alloc] initWithNibName:@"Flashcard" bundle:nil];
        
        detailViewController.section_index = indexPath.row+1; //row는 0부터 시작하고 DB의 CAT_ID는 1부터 시작하므로 +1을 함.
        if ([[self appDelegate].lang isEqualToString:@"ENG"]) {
            detailViewController.section_name = [[self appDelegate].CAT_ENG objectAtIndex:[indexPath row]];
        } else if ([[self appDelegate].lang isEqualToString:@"CHA"]) {
            detailViewController.section_name = [[self appDelegate].CAT_CHA objectAtIndex:[indexPath row]];
        } else if ([[self appDelegate].lang isEqualToString:@"JPN"]) {
            detailViewController.section_name = [[self appDelegate].CAT_JPN objectAtIndex:[indexPath row]];
        } else if ([[self appDelegate].lang isEqualToString:@"KOR"]) {
            detailViewController.section_name = [[self appDelegate].CAT_KOR objectAtIndex:[indexPath row]];
        } else {
            NSLog(@"unknow language .. !");
        }
        [self.navigationController pushViewController:detailViewController animated:YES];
        [detailViewController release];
    } else if ([[self appDelegate].mode isEqualToString:@"Quiz"]) {
        Quiz *detailViewController = [[Quiz alloc] initWithNibName:@"Quiz" bundle:nil];
        
        detailViewController.section_index = indexPath.row+1; //row는 0부터 시작하고 DB의 CAT_ID는 1부터 시작하므로 +1을 함.
        if ([[self appDelegate].lang isEqualToString:@"ENG"]) {
            detailViewController.section_name = [[self appDelegate].CAT_ENG objectAtIndex:[indexPath row]];
        } else if ([[self appDelegate].lang isEqualToString:@"CHA"]) {
            detailViewController.section_name = [[self appDelegate].CAT_CHA objectAtIndex:[indexPath row]];
        } else if ([[self appDelegate].lang isEqualToString:@"JPN"]) {
            detailViewController.section_name = [[self appDelegate].CAT_JPN objectAtIndex:[indexPath row]];
        } else if ([[self appDelegate].lang isEqualToString:@"KOR"]) {
            detailViewController.section_name = [[self appDelegate].CAT_KOR objectAtIndex:[indexPath row]];
        } else {
            NSLog(@"unknow language .. !");
        }
        [self.navigationController pushViewController:detailViewController animated:YES];
        [detailViewController release];
    } else {
        NSLog(@"Unknown mode!");
    }

}


@end
