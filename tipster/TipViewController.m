//
//  TipViewController.m
//  tipster
//
//  Created by Kanwarpreet Randhawa on 9/9/14.
//  Copyright (c) 2014 Kanwarpreet Randhawa. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

@property (weak, nonatomic) IBOutlet UILabel *tipPercentLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipPercentNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *splitAmountLabel;
- (IBAction)onTap:(id)sender;
- (IBAction)billAmountChange:(id)sender;
- (IBAction)tipSliderChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UISlider *tipSlider;
- (IBAction)tipSliderValueChange:(id)sender;
- (IBAction)stepperValueChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *splitLabel;
@property (weak, nonatomic) IBOutlet UIStepper *splitStepper;

@end

@implementation TipViewController

- (void)viewWillAppear:(BOOL)animated {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    float bill = [defaults floatForKey:@"bill"];
    float tipVal = [defaults floatForKey:@"tipPercent"];
    int splitVal = @([defaults integerForKey:@"splits"]).intValue;
    if (tipVal == 0) {
        tipVal = 10;
    }
    if (splitVal == 0) {
        splitVal = 1;
    }
    [self initTipSlider];
    self.billTextField.text = [NSString stringWithFormat:@"%.2f", bill];
    self.tipPercentLabel.text = [NSString stringWithFormat:@"%.2f", tipVal];
    self.tipSlider.value = tipVal/100;
    self.splitLabel.text = [NSString stringWithFormat:@"%d", splitVal];
    self.splitStepper.value = splitVal;
    [self updateValues];
}

- (void)viewWillDisappear:(BOOL)animated {
    float bill = [self.billTextField.text floatValue];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:bill forKey:@"bill"];
    [defaults synchronize];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Tip Calculator";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initTipSlider];
    [self updateValues];
    [self initSettingsButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initTipSlider
{
    self.tipSlider.minimumValue = 0;
    self.tipSlider.maximumValue = 1;
    self.tipSlider.value = 0.1;
    // Dispose of any resources that can be recreated.
}

- (void)initSplitStepper
{
    self.splitStepper.minimumValue = 1;
    self.splitStepper.maximumValue = 10;
    self.splitStepper.stepValue = 1;
    self.splitStepper.value = 1;
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (IBAction)billAmountChange:(id)sender {
    [self updateValues];
}

- (IBAction)tipSliderChanged:(id)sender {
    [self updateValues];
}


- (void) initSettingsButton {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
}
- (void) updateValues {
    float billAmount = [self.billTextField.text floatValue];
    float tipPercent = self.tipSlider.value;
    self.tipPercentLabel.text = [NSString stringWithFormat:@"%.2f", tipPercent*100];
    float totalAmount = tipAmount + billAmount;
    self.tipLabel.text = [NSString stringWithFormat:@"$%.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%.2f", totalAmount];
    int splitVal = @(self.splitStepper.value).intValue;
    if (splitVal < 1) {
        splitVal = 1;
        self.splitStepper.value = splitVal;
    }
    if (splitVal > 10) {
        splitVal = 10;
        self.splitStepper.value = splitVal;
    }
    self.splitLabel.text = [NSString stringWithFormat:@"%.d", splitVal];
    self.splitAmountLabel.text = [NSString stringWithFormat:@"$%.2f", totalAmount/splitVal];
    if (billAmount == 0) {
        self.billTextField.text = @"";
    }
}

- (void) onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}


- (IBAction)tipSliderValueChange:(id)sender {
    [self updateValues];
}

- (IBAction)stepperValueChanged:(id)sender {
    [self updateValues];
}
@end
