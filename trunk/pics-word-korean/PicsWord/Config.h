//
//  Config.h
//  KOREANBASIC600WORDS
//
//  Created by 이선동 on 11. 9. 8..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Config : UIViewController {
    
    IBOutlet UISegmentedControl *segment_quiz_voice;
    IBOutlet UISegmentedControl *segment_quiz_text;
}

- (IBAction)segment_quiz_voice_changed:(id)sender;
- (IBAction)segment_quiz_text_changed:(id)sender;

@end
