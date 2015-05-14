//
//  SettingsViewController.h
//  CapsIt
//
//  Created by Hüseyin Kabil on 09/07/14.
//  Copyright (c) 2014 Hüseyin Kabil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *btnLng;
@property (weak, nonatomic) IBOutlet UILabel *yaziBoyutuLabel;
@property (weak, nonatomic) IBOutlet UIStepper *yaziBoyutu;

-(IBAction)back: (id)sender;
-(IBAction)setLanguage: (id)sender;
-(IBAction)changeValueOfStepper: (id)sender;

@end
