//
//  MainViewController.m
//  CapsIt
//
//  Created by Hüseyin Kabil on 02/03/14.
//  Copyright (c) 2014 Hüseyin Kabil. All rights reserved.
//

#import "settings.h"
#import "MainViewController.h"
#import "AppManager.h"

@interface MainViewController ()

@end

@implementation MainViewController
{
    NSString *lng;
    
}

@synthesize caps, listArray;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        caps=@"";
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{
    caps =[[AppManager sharedManager] translate:@"Caps metni buraya"];
  
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    lng=[[NSUserDefaults standardUserDefaults] objectForKey:@"language"];
    [AppManager sharedManager].lng=lng; //uygulama yüklenir yüklenmez diskten dil ayarini okuyup sessiona yaz
    
   NSLog(@"hebeee %@",caps );
    imageCaps.image = [self addText: caps toImage: imageCaps.image];
    
    self.listArray = [NSArray arrayWithObjects: @"HABERİM YOKMUŞ GİBİ ÇEK PANPA",
                      @"ANLAYAMAZSINIZ",
                      @"BEN GÜLÜYOM MU LAN",
                      @"GÜLMEDİM",
                      @"İNŞ CANIM YA",
                      @"SINAVDAN ÇIKINCA BEN",
                      @"SINAV SONUCU AÇIKLANINCA BEN",
                      @"ÇOK CAHİLSİN KEŞKE ÖLSEN",
                      @"ÇAKTIRMA PANPA", nil];
    
    tableList.delegate = self; //delegate fonksiyonlarını bu class tan almak için
    tableList.dataSource = self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(UIImage*) addText:(NSString*) text toImage:
                    (UIImage*) image
{
    
    caps=text;
    
    int fontSize = kminFontSize;
    
    if([text length] <= kMinLength){
        fontSize = kminFontSize;
    }
    else if([text length] <= kMidLength){
        fontSize = kmidFontSize;
    }
    else if([text length] <= kMaxLength){
        fontSize = kmaxFontSize;
    }
    else{
        fontSize = kmaxFontSize;
    }
    
    UIFont *font = [UIFont fontWithName:@"Helvetica" size: fontSize];
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect: CGRectMake(0,0,image.size.width,image.size.height)];
    
    //kirmizi alan
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0, 540, image.size.width, 100)];
    [[UIColor redColor] setFill];
    [rectanglePath fill];
    
    //textin oturacagi dortgen
    CGRect rect = CGRectMake(5, 575, image.size.width-10, image.size.height);
    
    //textin ozellikleri
    NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    textStyle.lineBreakMode = NSLineBreakByWordWrapping;
    textStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attr = [NSDictionary dictionaryWithObjectsAndKeys: font, NSFontAttributeName, [UIColor whiteColor],NSForegroundColorAttributeName, textStyle, NSParagraphStyleAttributeName, nil];
    
    //texti resim olarak yapiyor
    [text drawInRect: CGRectIntegral(rect) withAttributes: attr];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
-(IBAction)shareMenu: (id)sender{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Paylaş"
                          message:nil
                          delegate:self
                          cancelButtonTitle:@"Vazgeç"
                          otherButtonTitles:@"Twitter",
                          @"Facebook",
                          @"Kaydet", nil];
    alert.tag=1;
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger) buttonIndex{
    
    
    if(alertView.tag==0)    //text yazma
    {
        UITextField *textField = [alertView textFieldAtIndex: 0];
        
        NSLog(@"yazdım. %@",  textField.text);

        imageCaps.image =[self addText:textField.text toImage: imageCaps.image];
    }
    else{
        if (buttonIndex == 1) //Twitter
        {
            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
                
                SLComposeViewController *mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
                
                [mySLComposerSheet setInitialText:@"#CapsIt "];
                
                [mySLComposerSheet addImage:imageCaps.image];
                
                //[mySLComposerSheet addURL:[NSURL URLWithString:@""]];
                
                [mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
                    
                    switch (result) {
                        case SLComposeViewControllerResultCancelled:
                            NSLog(@"Tweet Canceled");
                            break;
                        case SLComposeViewControllerResultDone:
                            NSLog(@"Tweet Sucessful");
                            break;
                            
                        default:
                            break;
                    }
                }];
                
                [self presentViewController:mySLComposerSheet animated:YES completion:nil];
            }
        }
        else if(buttonIndex == 2) //Facebook
        {
            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
                
                SLComposeViewController *mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
                
                [mySLComposerSheet setInitialText:@"#CapsIt "];
                
                [mySLComposerSheet addImage:imageCaps.image];
                
                //[mySLComposerSheet addURL:[NSURL URLWithString:@""]];
                
                [mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
                    
                    switch (result) {
                        case SLComposeViewControllerResultCancelled:
                            NSLog(@"Post Canceled");
                            break;
                        case SLComposeViewControllerResultDone:
                            NSLog(@"Post Sucessful");
                            break;
                            
                        default:
                            break;
                    }
                }];
                
                [self presentViewController:mySLComposerSheet animated:YES completion:nil];
            }
        }
        else if(buttonIndex == 3) //Kaydet
        {
            UIImageWriteToSavedPhotosAlbum(imageCaps.image, nil, nil, nil);
        }
    }
}
-(IBAction)openCamera:(id)sender{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.allowsEditing=YES;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(IBAction)openPhotos:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES; 
    picker.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController: picker animated:YES completion:nil];
  
}

//imagepicker delegate fonksiyonlari
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

    NSLog(@"select");
    //her halukarda editedImage kullanilacak
    UIImage * image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    imageCaps.image=[self addText:caps toImage:image];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    NSLog(@"cancel");
    [self dismissViewControllerAnimated:YES completion:nil];
 
}

- (IBAction)openTextField:(id)sender{
    UIAlertView *dialog = [[UIAlertView alloc] init];
    [dialog setDelegate:self];
    [dialog setTitle:@"Yaz hacı!"];
    [dialog setMessage: @"Caps için komik birşeyler yaz."];
    [dialog addButtonWithTitle:@"Vazgeç"];
    [dialog addButtonWithTitle:@"Tamam"];
    dialog.tag = 0;
    dialog.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *textField = [dialog textFieldAtIndex: 0];
    textField.text = caps;
    textField.clearButtonMode = UITextFieldViewModeAlways;
    [dialog show];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [listArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [listArray objectAtIndex: indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize: 12];
    
    NSLog(@"metin %@", [listArray objectAtIndex: indexPath.row]);
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"seçilen: %li", (long)indexPath.row);
    

    imageCaps.image =[self addText:[listArray objectAtIndex:indexPath.row] toImage: imageCaps.image];

    
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
