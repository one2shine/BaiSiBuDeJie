//
//  BSLoginController.m
//  百思不得姐
//
//  Created by mac on 16/3/11.
//  Copyright © 2016年 one2shine. All rights reserved.
//

#import "BSLoginController.h"

@interface BSLoginController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginLeft;

- (IBAction)loginOrRegister:(UIButton *)sender;
- (IBAction)cancel:(id)sender;

@end

@implementation BSLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginOrRegister:(UIButton *)sender {
    [self.view endEditing:YES];
    if (self.loginLeft.constant == 0) {
        sender.selected = YES;
        self.loginLeft.constant = - self.view.width;
    } else {
        sender.selected = NO;
        self.loginLeft.constant = 0;
    }
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
