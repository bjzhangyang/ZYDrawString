//
//  ZYMainViewController.m
//  ZYDrawString
//
//  Created by soufun on 15-1-9.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import "ZYMainViewController.h"
#import "ZYAnimationLayer.h"
#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight  [UIScreen mainScreen].bounds.size.height
@interface ZYMainViewController ()<UITextFieldDelegate>
@property (nonatomic,strong)UIView * bgView;
@property (nonatomic,strong)UITextField * myTextField;
@property (nonatomic,strong)UIButton * sendButton;
@property (nonatomic)CGRect oraginFrame;
@end

@implementation ZYMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}
#pragma -mark 主要方法，点击“开始画线”执行的方法
-(void)startDraw:(UIButton*)sender
{
    [_myTextField resignFirstResponder];
    for (id layer in self.view.layer.sublayers) {
        if([layer isKindOfClass:[ZYAnimationLayer class]])
        {
            [layer removeFromSuperlayer];
        }
    }
    [ZYAnimationLayer createAnimationLayerWithString:_myTextField.text andRect: CGRectMake(20.0f, -100.0f,
                                                                                           CGRectGetWidth(self.view.layer.bounds) - 40.0f,
                                                                                           CGRectGetHeight(self.view.layer.bounds) - 84.0f) andView:self.view andFont:[UIFont boldSystemFontOfSize:40] andStrokeColor:[UIColor colorWithRed:0 green:0.0 blue:0.0 alpha:1]];
}
#pragma -mark 自定义方法
-(void)createUI
{
    self.title = @"DrawString";
    [self addKeyboardObserve];
    [self createTextFieldAndButton];
}
-(void)addKeyboardObserve{
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
-(void)createTextFieldAndButton
{
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(10, kHeight- 64 - 10, kWidth - 20, 44)];
    _myTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, kWidth - 100, 44)];
    _myTextField.layer.borderColor = [UIColor grayColor].CGColor;
    _myTextField.layer.borderWidth = .5;
    _myTextField.layer.cornerRadius = 10.0;
    _myTextField.layer.masksToBounds = YES;
    _myTextField.delegate = self;
    _myTextField.userInteractionEnabled = YES;
    _myTextField.placeholder = @"请输入要画的文字";
    _myTextField.textAlignment = NSTextAlignmentCenter;
    
    _sendButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _sendButton.frame = CGRectMake(kWidth - 90, 0, 80, 44);
    [_sendButton setTitle:@"开始画线" forState:UIControlStateNormal];
    _sendButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_sendButton addTarget:self action:@selector(startDraw:) forControlEvents:UIControlEventTouchUpInside];
    
    [_bgView addSubview:_myTextField];
    [_bgView addSubview:_sendButton];
    [self.view addSubview:_bgView];
    _oraginFrame = _bgView.frame;
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_myTextField resignFirstResponder];
}


#pragma -mark 键盘监听
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    _bgView.frame = CGRectMake(_oraginFrame.origin.x, _oraginFrame.origin.y - height, _oraginFrame.size.width, _oraginFrame.size.height);
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    _bgView.frame = _oraginFrame;
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
