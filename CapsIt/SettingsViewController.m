//
//  SettingsViewController.m
//  CapsIt
//
//  Created by Hüseyin Kabil on 09/07/14.
//  Copyright (c) 2014 Hüseyin Kabil. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _yaziBoyutu.maximumValue=24;
    _yaziBoyutu.minimumValue=17;
    
    NSString *ln=[[NSUserDefaults standardUserDefaults] objectForKey:@"language"];
    if([ln isEqualToString:@"tr"])
        _btnLng.selectedSegmentIndex=0;
    else
        _btnLng.selectedSegmentIndex=1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)setLanguage:(id)sender
{
    NSString *lng = @"";
    
    switch (((UISegmentedControl *)sender).selectedSegmentIndex) {
        case 0:
            lng = @"tr";
            break;
            
        case 1:
            lng = @"en";
            break;
            
        default:
            lng = @"tr";
            break;
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject: lng
                     forKey: @"language"];
    [userDefaults synchronize];
    
}

- (IBAction)changeValueOfStepper:(id)sender {
    
    NSLog(@"alınan değer: %.f", _yaziBoyutu.value);
    [_yaziBoyutuLabel setFont:[UIFont systemFontOfSize:_yaziBoyutu.value]];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
