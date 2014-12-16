//
//  FullVersion.h
//  TapEnglish
//
//  Created by 이선동 on 11. 6. 29..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FullVersion : UIViewController {
    
    IBOutlet UIScrollView *scrollView;
}

- (IBAction)closeAction:(id)sender;

- (IBAction)getOXword:(id)sender;
- (IBAction)getKoreanAlphabet:(id)sender;
- (IBAction)getKoreanAlphabetSyllable:(id)sender;
- (IBAction)getMultiLingual:(id)sender;
- (IBAction)getABCalphabet:(id)sender;
- (IBAction)getEnglishFlashcard:(id)sender;
- (IBAction)getSoundScan:(id)sender;
- (IBAction)getSpeedMap:(id)sender;
- (IBAction)getKoreanFlashcard:(id)sender;
- (IBAction)getTouchChinese:(id)sender;
- (IBAction)getTouchEnglish:(id)sender;
- (IBAction)getTouchJapanese:(id)sender;
- (IBAction)getVegeRestaurant:(id)sender;
- (IBAction)getVeganRestaurant:(id)sender;
- (IBAction)getJapaneseAlphabet:(id)sender;
- (IBAction)getLocalSearch:(id)sender;

@end
