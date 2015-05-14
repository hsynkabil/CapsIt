//
//  MainViewController.h
//  CapsIt
//
//  Created by Hüseyin Kabil on 02/03/14.
//  Copyright (c) 2014 Hüseyin Kabil. All rights reserved.
//

#import <UIKit/UIKit.h> 
#import <Social/Social.h>
#import <Accounts/Accounts.h>


//UINavigationControllerDelegate bu camera ile ilgili view'lara gidip gelme yaptigi icin lazim
@interface MainViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITableViewDataSource, UITableViewDelegate> {
    
    NSString *caps;
    NSArray *listArray;
    __weak IBOutlet UIImageView *imageCaps;
    __weak IBOutlet UITableView *tableList;
}


@property NSString *caps;
@property NSArray *listArray;

-(IBAction)shareMenu: (id)sender;
-(IBAction)openCamera:(id)sender;
-(IBAction)openPhotos:(id)sender;
-(IBAction)openTextField:(id)sender;

@end
