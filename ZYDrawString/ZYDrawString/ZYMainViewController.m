//
//  ZYMainViewController.m
//  ZYDrawString
//
//  Created by soufun on 15-1-9.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import "ZYMainViewController.h"
#import "ZYAnimationLayer.h"
@interface ZYMainViewController ()<UITextFieldDelegate>
@property (nonatomic,strong)UIImageView * bgImageView;
@property (nonatomic,strong)UITextField * myTextField;
@property (nonatomic,strong)UIButton * sendButton;
@end

@implementation ZYMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}
-(void)createUI
{
    self.title = @"DrawString";
    [self createBgimageView];
    [self createTextField];
    [self createButton];
}
-(void)createBgimageView
{
    self.bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64)];
    self.bgImageView.image = [UIImage imageNamed:@"23.jpg"];
    self.bgImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.bgImageView addGestureRecognizer:tap];
    [self.view addSubview:self.bgImageView];
}
-(void)createTextField
{
    self.myTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, self.view.bounds.size.height-64-44 - 10, self.view.bounds.size.width - 20, 44)];
    self.myTextField.backgroundColor = [UIColor lightGrayColor];
    self.myTextField.delegate = self;
    self.myTextField.userInteractionEnabled = YES;
//    self.myTextField.text = @"开始画线";
    self.myTextField.placeholder = @"请输入要画的文字";
    self.myTextField.textAlignment = NSTextAlignmentCenter;
    [self.bgImageView addSubview:self.myTextField];
    
}
-(void)createButton
{
    self.sendButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.sendButton.frame = CGRectMake((self.view.bounds.size.width-100)/2, self.view.bounds.size.width/2+80, 100, 30);
    [self.sendButton setTitle:@"开始画线" forState:UIControlStateNormal];
    [self.sendButton setFont:[UIFont systemFontOfSize:20]];
    [self.sendButton addTarget:self action:@selector(startDraw:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgImageView addSubview:self.sendButton];
}
-(void)tap:(UITapGestureRecognizer*)sender
{
    [self.myTextField resignFirstResponder];
}
-(void)startDraw:(UIButton*)sender
{
    for (id layer in self.view.layer.sublayers) {
        if([layer isKindOfClass:[ZYAnimationLayer class]])
        {
            [layer removeFromSuperlayer];
        }
    }
    [ZYAnimationLayer createAnimationLayerWithString:self.myTextField.text andRect: CGRectMake(20.0f, -100.0f,
                                                                                              CGRectGetWidth(self.view.layer.bounds) - 40.0f,
                                                                                               CGRectGetHeight(self.view.layer.bounds) - 84.0f) andView:self.view andFont:CTFontCreateWithName(CFSTR("Helvetica-Bold"), 40.0f, NULL) andStrokeColor:[UIColor colorWithRed:0 green:0.0 blue:0.0 alpha:1]];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.myTextField.frame = CGRectMake(self.myTextField.frame.origin.x, self.myTextField.frame.origin.y - 252, self.myTextField.frame.size.width, self.myTextField.frame.size.height);
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.myTextField.frame = CGRectMake(self.myTextField.frame.origin.x, self.myTextField.frame.origin.y + 252, self.myTextField.frame.size.width, self.myTextField.frame.size.height);
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

@end
