//
//  ViewController.m
//  tantan
//
//  Created by jjs on 2018/3/24.
//  Copyright © 2018年 iOS-LeiYu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *inputTextView;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.inputTextView.layer.borderWidth = 1;
    self.inputTextView.layer.borderColor = [[UIColor grayColor] CGColor];
}


- (IBAction)confimButtonClicked:(UIButton *)sender {
    
    UIViewController * controller = [[NSClassFromString(@"TTFeedbackViewController") alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}


@end
