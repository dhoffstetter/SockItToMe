//
//  MainViewController.m
//  SockItToMe
//
//  Created by Diane Hoffstetter on 6/28/19.
//  Copyright © 2019 Dumb Blonde Software. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property UIView * mainView;

@property UILabel * titleLabel;
@property UILabel * stitchGaugeLabel;
@property UILabel * rowGaugeLabel;
@property UILabel * footLengthLabel;
@property UILabel * footCircumferenceLabel;
@property UILabel * legLengthLabel;

@property UITextField * stitchGaugeTextField;
@property UITextField * rowGaugeTextField;

@property float stitchGauge;
@property float rowGauge;
@property Pattern * pattern;
@property Foot * foot;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  [self setDefaultFootMeasurementAndGauge];
  [self setUpTitleAndInputFields];
}

- (void)setUpTitleAndInputFields{
  
  CGSize windowSize = [[UIScreen mainScreen]bounds].size;
  NSLog(@"H: %f W: %f", windowSize.height, windowSize.width);
  
  self.mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, windowSize.width, windowSize.height)];
  
  [self.mainView setFrame:CGRectMake(0, 0, windowSize.width, windowSize.height)];
  [self.view addSubview: self.mainView];
  
  float center = windowSize.width / 2.0f;
  
  float titleLabelYpos = 50.0f;
  
  float inputLabelHeight = 30.0f;
  float inputLablelWidth = 200.0f;
  float inputLabelXpos = 20.0f;
  float inputLabelVerticalSpace = 10.0f;
  float inputTextFieldXpos = 250.0f;
  float inputTextFieldWidth = 100.0f;
  
  // Title Label
  float titleLabelWidth = 200.0f;
  self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((center-titleLabelWidth/2), titleLabelYpos, titleLabelWidth, inputLabelHeight)];
  self.titleLabel.text = @"Sock It To Me!";
  self.titleLabel.textAlignment = NSTextAlignmentCenter;
  [self.mainView addSubview:self.titleLabel];

  // Stitch Gauge Label
  float stitchGaugeLabelYpos = titleLabelYpos + inputLabelHeight + inputLabelVerticalSpace;
  self.stitchGaugeLabel =[[UILabel alloc]initWithFrame:CGRectMake(inputLabelXpos, stitchGaugeLabelYpos, inputLablelWidth, inputLabelHeight)];
  self.stitchGaugeLabel.text = @"Stitch Gauge st/in";
  [self.mainView addSubview:self.stitchGaugeLabel];

  // Stitch Gauge Text Field
  self.stitchGaugeTextField = [[UITextField alloc]initWithFrame:CGRectMake(inputTextFieldXpos, stitchGaugeLabelYpos, inputTextFieldWidth, inputLabelHeight)];
  self.stitchGaugeTextField.delegate = self;
  self.stitchGaugeTextField.borderStyle = UITextBorderStyleRoundedRect;
  self.stitchGaugeTextField.text = [@(_stitchGauge) stringValue];
  self.stitchGaugeTextField.textAlignment = NSTextAlignmentRight;
  [self.stitchGaugeTextField setKeyboardType:UIKeyboardTypeDecimalPad];
  
  UIToolbar* toolbar = [UIToolbar new];
  UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissKeyboard)];
  id space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];
  toolbar.items = @[space, doneButton];
  
  [toolbar sizeToFit];
  self.stitchGaugeTextField.inputAccessoryView = toolbar;
  
  [self.mainView addSubview:self.stitchGaugeTextField];
  
  // Row Gauge Label
  float rowGaugeLabelYpos = stitchGaugeLabelYpos + inputLabelHeight + inputLabelVerticalSpace;
  self.rowGaugeLabel =[[UILabel alloc]initWithFrame:CGRectMake(inputLabelXpos, rowGaugeLabelYpos, inputLablelWidth, inputLabelHeight)];
  self.rowGaugeLabel.text = @"Row Gauge row/in";
  [self.mainView addSubview:self.rowGaugeLabel];
  
  // Row Gauge Text Field
  self.rowGaugeTextField = [[UITextField alloc]initWithFrame:CGRectMake(inputTextFieldXpos, rowGaugeLabelYpos, inputTextFieldWidth, inputLabelHeight)];
  self.rowGaugeTextField.delegate = self;
  self.rowGaugeTextField.borderStyle = UITextBorderStyleRoundedRect;
  self.rowGaugeTextField.text = [@(_rowGauge) stringValue];
  self.rowGaugeTextField.textAlignment = NSTextAlignmentRight;
  [self.rowGaugeTextField setKeyboardType:UIKeyboardTypeDecimalPad];
  
  self.rowGaugeTextField.inputAccessoryView = toolbar;
  
  [self.mainView addSubview:self.rowGaugeTextField];

  // Foot Length Label
  float footLengthLabelYpos = rowGaugeLabelYpos + inputLabelHeight + inputLabelVerticalSpace;
  self.footLengthLabel =[[UILabel alloc]initWithFrame:CGRectMake(inputLabelXpos, footLengthLabelYpos, inputLablelWidth, inputLabelHeight)];
  self.footLengthLabel.text = @"Foot Length in";
  [self.mainView addSubview:self.footLengthLabel];
  
  // Foot Circumference Label
  float footCircLabelYpos = footLengthLabelYpos + inputLabelHeight + inputLabelVerticalSpace;
  self.footCircumferenceLabel =[[UILabel alloc]initWithFrame:CGRectMake(inputLabelXpos, footCircLabelYpos, inputLablelWidth, inputLabelHeight)];
  self.footCircumferenceLabel.text = @"Foot Circumfernce in";
  [self.mainView addSubview:self.footCircumferenceLabel];

  // Leg Length Label
  float legLengthLabelYpos = footCircLabelYpos + inputLabelHeight + inputLabelVerticalSpace;
  self.legLengthLabel =[[UILabel alloc]initWithFrame:CGRectMake(inputLabelXpos, legLengthLabelYpos, inputLablelWidth, inputLabelHeight)];
  self.legLengthLabel.text = @"Leg Length in";
  [self.mainView addSubview:self.legLengthLabel];

}
- (void)setDefaultFootMeasurementAndGauge{
  
  _pattern = [[Pattern alloc]init];
  _foot = [[Foot alloc]init];
  
  _stitchGauge = 24.0;
  _rowGauge = 20.0;
  
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
  [textField resignFirstResponder];
  return YES;
}

-(BOOL) dismissKeyboard {
  
  UIView *firstResponder;
  for (UIView *view in self.mainView.subviews) //: caused error
  {
    if (view.isFirstResponder)
    {
      firstResponder = view;
      NSLog(@"%@",firstResponder);
      [firstResponder resignFirstResponder];
      break;
    }
  }
//  [self.stitchGaugeTextField resignFirstResponder];
  return YES;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
