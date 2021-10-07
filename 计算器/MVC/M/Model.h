//
//  Model.h
//  计算器
//
//  Created by 差不多先生 on 2021/10/6.
//

#import <Foundation/Foundation.h>
#import "View.h"
NS_ASSUME_NONNULL_BEGIN

@interface Model : NSObject
@property (nonatomic, strong) NSMutableArray* ansArray;
@property (nonatomic, strong) NSMutableArray* tempArray;
@property (nonatomic, strong) NSString* returnString;
- (NSString*) operation:(NSString*) string;

@end

NS_ASSUME_NONNULL_END
