//
//  Controller.m
//  计算器
//
//  Created by 差不多先生 on 2021/10/6.
//

#import "Controller.h"
#import "View.h"
#import "Model.h"
@interface Controller ()
@property (nonatomic, strong) View* firstView;
@property (nonatomic, strong) Model* firstModel;
@end

@implementation Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _firstView = [[View alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_firstView];
    _firstView.delegate = self;
//    [_firstView.normalButton addTarget:self action:@selector(pressChange:) forControlEvents:UIControlEventTouchUpInside];
//    [_firstView.zeroButton addTarget:self action:@selector(pressChange:) forControlEvents:UIControlEventTouchUpInside];
    _changeArray = [[NSMutableArray alloc] init];
    _firstModel = [[Model alloc] init];

}
// 记录小数点状态
int flag = 0;
// 防止连续输入符号
int secondFlag = 0;
// 记录等于号状态
int thirdFlag = 0;
// 防止连续输入zero
int zeroFlag = 0;
- (void) pressChange: (UIButton*) cButton {
    if (cButton.tag == 101) {
        [_changeArray removeAllObjects];
        NSString *ansString = @"0";
        _firstView.topLabel.text = ansString;
        flag = 0;
        secondFlag = 0;
        thirdFlag = 0;
    } else if (cButton.tag == 120) {
        if (thirdFlag == 1) {
            ;
        } else {
            [_changeArray addObject:@"#"];
            NSString *ansString = [_changeArray componentsJoinedByString:@""];
//            NSLog(@"%@", ansString);
            [_firstModel operation:ansString];
            _firstView.topLabel.text = [_firstModel operation:ansString];;
            [_changeArray removeAllObjects];
            thirdFlag = 1;
        }
        
    } else if (cButton.tag == 119) {    //控制小数点输入合理
        if (flag == 0) {
            flag = 1;
            [_changeArray addObject:cButton.titleLabel.text];
            NSString *ansString = [_changeArray componentsJoinedByString:@""];
            _firstView.topLabel.text = ansString;
        } else {
            ;
        }
    }
    else {
        if (cButton.tag == 104 || cButton.tag == 108 || cButton.tag == 112 || cButton.tag == 116 ) {
            flag = 0;
            if (secondFlag == 0) {
                return;
            } else {
                secondFlag = 0;
            }
        } else if (cButton.tag != 102){ // 左括号后不能按符号
            secondFlag = 1;
        }
        [_changeArray addObject:cButton.titleLabel.text];
        NSString *ansString = [_changeArray componentsJoinedByString:@""];
        _firstView.topLabel.text = ansString;
        thirdFlag = 0;
        
    }
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
