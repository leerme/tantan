//
//  ViewController.m
//  tantan
//
//  Created by jjs on 2018/3/24.
//  Copyright © 2018年 iOS-LeiYu. All rights reserved.
//

#import "ViewController.h"
#import "LYClickTextView.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *inputTextView;
@property (strong, nonatomic) LYClickTextView *clickTextView;

@property (copy, nonatomic) NSString *html5String;
@property (copy, nonatomic) NSString *controllerString;
@property (copy, nonatomic) NSString *resultString;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.inputTextView.layer.borderWidth = 1;
    self.inputTextView.layer.borderColor = [[UIColor grayColor] CGColor];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.clickTextView removeFromSuperview];
}


- (IBAction)confimButtonClicked:(UIButton *)sender {
    
    NSString *input = self.inputTextView.text;
    NSString *pattern = @"<a.*>(\\d+|\\D+)</a>";
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray<NSTextCheckingResult *> *result = [regex matchesInString:input options:0 range:NSMakeRange(0, input.length)];
    if (result) {
        for (int i=0; i<result.count; i++) {
            NSTextCheckingResult *res = result[i];
            self.html5String = [input substringWithRange:res.range];
            NSArray *array=[self.html5String componentsSeparatedByCharactersInSet:
                            [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
            self.controllerString = array[1];
            self.resultString = array[2];
        }
    }
    

    NSString *content = [self.inputTextView.text stringByReplacingOccurrencesOfString:self.html5String withString:self.resultString];
    self.clickTextView.text = content;
    [self.view addSubview:self.clickTextView];
    
    NSRange range = [content rangeOfString:self.resultString];
    __weak typeof(self) weakSelf = self;
    [self.clickTextView setUnderlineTextWithRange:range withUnderlineColor:[UIColor blueColor] withClickCoverColor:[UIColor greenColor] withBlock:^(NSString *clickText) {
        [weakSelf.navigationController pushViewController:[weakSelf getPushController:weakSelf.controllerString] animated:YES];
    }];
}

- (UIViewController *)getPushController:(NSString *)string{
    NSRange range = [string rangeOfString:@"tantanapp://"];
    NSString *str = [[string substringWithRange:NSMakeRange(range.location+range.length, string.length-range.location-range.length-1)] capitalizedString];
    return (UIViewController *)[[NSClassFromString([NSString stringWithFormat:@"TT%@ViewController",str]) alloc] init];
}

- (LYClickTextView *)clickTextView{
    if (!_clickTextView) {
        _clickTextView = [[LYClickTextView alloc] initWithFrame:CGRectMake(15, 300, 300, 300)];
        _clickTextView.font = [UIFont systemFontOfSize:14];
    }
    return _clickTextView;
}

@end
