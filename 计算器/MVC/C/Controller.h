//
//  Controller.h
//  计算器
//
//  Created by 差不多先生 on 2021/10/6.
//

#import <UIKit/UIKit.h>
#import "View.h"
NS_ASSUME_NONNULL_BEGIN

@interface Controller : UIViewController<viewDelegate>
@property (nonatomic, strong) NSMutableArray* changeArray;
@end

NS_ASSUME_NONNULL_END
