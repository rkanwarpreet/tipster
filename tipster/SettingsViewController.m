//
//  SettingsViewController.m
//  tipster
//
//  Created by Kanwarpreet Randhawa on 9/10/14.
//  Copyright (c) 2014 Kanwarpreet Randhawa. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UITextField *tipTextField;
- (IBAction)tipValueChange:(id)sender;
- (IBAction)onTap:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *splitTextField;
- (IBAction)splitValueChanged:(id)sender;

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

- (void)viewWillDisappear:(BOOL)animated {
    float tipVal = [self.tipTextField.text floatValue];
    int splitVal = [self.splitTextField.text intValue];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:tipVal forKey:@"tipPercent"];
    [defaults setInteger:splitVal forKey:@"splits"];
    [defaults synchronize];
}

- (void)viewWillAppear:(BOOL)animated {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    float tipVal = [defaults floatForKey:@"tipPercent"];
    int splitVal = @([defaults integerForKey:@"splits"]).intValue;
    if (splitVal == 0) {
        splitVal = 1;
    }
    self.tipTextField.text = [NSString stringWithFormat:@"%.2f", tipVal];
    self.splitTextField.text = [NSString stringWithFormat:@"%d", splitVal];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) updateValue
{
    float tipVal = [self.tipTextField.text floatValue];
    if (tipVal > 100) {
        tipVal = 100;
    }
    if (tipVal == 0) {
        self.tipTextField.text = @"";
    }
    else {
        self.tipTextField.text = [NSString stringWithFormat:@"%.2f", tipVal];
    }
    int splitVal = [self.splitTextField.text intValue];
    if (splitVal > 10) {
        splitVal = 10;
    }
    if (splitVal < 1) {
        splitVal = 1;
    }
    self.splitTextField.text = [NSString stringWithFormat:@"%d", splitVal];
    
}

- (IBAction)tipValueChange:(id)sender {
    
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValue];
}
- (IBAction)splitValueChanged:(id)sender {
    
}
@end
