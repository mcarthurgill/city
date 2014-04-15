//
//  CTLoginViewController.h
//  city
//
//  Created by Joseph McArthur Gill on 2/11/14.
//  Copyright (c) 2014 Joseph McArthur Gill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTLoginViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *phoneField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)loginButtonAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

@end
