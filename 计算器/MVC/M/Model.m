//
//  Model.m
//  计算器
//
//  Created by 差不多先生 on 2021/10/6.
//

#import "Model.h"

@implementation Model

- (void) ModelInit {
    _ansArray = [[NSMutableArray alloc] init];
    _tempArray = [[NSMutableArray alloc] init];
    _returnString = @"0";
}
// 设置符号优先级
int compareReturn(char str1) {
    if (str1 == '#') {
        return 0;
    } else if (str1 == '+' || str1 == '-') {
        return 1;
    } else if (str1 == '*' || str1 == '/') {
        return 2;
    } else if (str1 == '(' || str1 == ')') {
        return 0;
    }
    else {
        // 此时为数字
        return -1;
    }
}
// 判断括号是否有效以及最后一位是否为符号
int tureKH (const char* str) {
    int top = 0;
    for (int i = 0; i < strlen(str); i++) {
        if (str[i] == '(') {
            top++;
        } else if (str[i] == ')') {
            if (top == 0) {
                return 0;
            } else {
                top--;
            }
        } else {
            ;
        }
    }
    if (top == 0) {
        return 1;
    } else {
        return 0;
    }
}
// 判断是否是符号
- (BOOL) isSymbol:(NSString*) string {
    if ([string isEqual:@"*"] || [string isEqual:@"+"] || [string isEqual:@"-"] || [string isEqual:@"/"] || [string isEqual:@"("] || [string isEqual:@")"] || [string isEqual:@"#"]) {
        return YES;
    } else {
        return NO;
    }
}
// 优先级表
- (int) firstSymbol:(NSString*) string {
    if ([string isEqual:@"-"] || [string isEqual:@"+"]) {
        return 2;
    } else if ([string isEqual:@"*"] || [string isEqual:@"/"]) {
        return 3;
    } else if ([string isEqual:@"#"]) {
        return 1;
    } else {
        return 0;
    }
}
// 中缀转后缀

- (NSMutableArray*)switchString :(const char *) outString {
    // 设置存字符串标识
    int flag = 0;
    // 结果栈
    self.ansArray = [[NSMutableArray alloc] init];
    // 临时符号栈
    self.tempArray = [[NSMutableArray alloc] init];
    NSMutableArray *textArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < strlen(outString); i++) {
//        printf("%c", outString[i]);
        NSString *str1 = [NSString stringWithFormat:@"%c", outString[i]];
        [textArray addObject:str1];
    }
//    NSLog(@"%@", textArray);
    NSMutableString* numberString = [[NSMutableString alloc] init];
    for (int i = 0; i < textArray.count;) {
        if ([self isSymbol:textArray[i]] == NO) {
            [numberString appendString:textArray[i++]];
            flag = 0;
        } else {
            if (flag == 0) {
                NSMutableString* temp = [[NSMutableString alloc] init];
                temp = [numberString copy];
                [self.ansArray addObject:temp];
                flag = 1;
                [numberString deleteCharactersInRange:NSMakeRange(0, numberString.length)];
                NSLog(@"%@", self.ansArray);
            }
            if ([textArray[i] isEqual:@"("]) {
//                [symbolString appendString:textArray[i++]];
                [self.tempArray addObject:textArray[i++]];
            } else if ([textArray[i] isEqual:@")"]) {
                while (![self.tempArray[self.tempArray.count - 1] isEqual:@"("]) {
                    [self.ansArray addObject:self.tempArray[self.tempArray.count - 1]];
                    [self.tempArray removeLastObject];
                }
                [self.tempArray removeLastObject];
                i++;
            } else {
                if (self.tempArray.count == 0) {
                    [self.tempArray addObject:textArray[i++]];
                    continue;
                }
                if (self.tempArray.count != 0 && [self firstSymbol:textArray[i]] > [self firstSymbol:self.tempArray[self.tempArray.count - 1]]) {
                    [self.tempArray addObject:textArray[i++]];
                } else {
                    [self.ansArray addObject:self.tempArray[self.tempArray.count - 1]];
                    [self.tempArray removeLastObject];
                }
            }
        }
    }
//    NSLog(@"%lu", self.ansArray.count);
    NSLog(@"%@", self.ansArray);
    return self.ansArray;
}
// 符号计算方法
- (double)symbolOperation:(NSString*)symbol andx:(double)y andy:(double)x {
    double ans = 0;
    if ([symbol isEqual:@"+"]) {
        ans = x + y;
    } else if ([symbol isEqual:@"-"]) {
        ans = x - y;
    } else if ([symbol isEqual:@"*"]) {
        ans = x * y;
    } else if ([symbol isEqual:@"/"]) {
        ans = x / y;
    }
    return ans;
}
// 除去sum后多余的0
-(NSString*)removeZero:(NSString*)string {
    NSString * testNumber = string;
    NSString * ansNumber = [NSString stringWithFormat:@"%@",@(testNumber.doubleValue)];
    return ansNumber;
}
// 计算后缀表达式
- (NSString*)lastOperation:(NSMutableArray*) tempArray {
    NSString *ansString = [[NSString alloc] init];
    double sum = 0;
    double x = 0;
    double y = 0;
    // 设置补*标记
    int flag = 0;
    if (tempArray.count == 1) {
        sum = [tempArray[0] doubleValue];
    } else {
        for (int i = 0; i < tempArray.count; i++) {
            if ([self isSymbol:tempArray[i]]) {
                if (i - 2 == 0) {
                    flag = 1;
                }
                x = [tempArray[i - 1] doubleValue];
                y = [tempArray[i - 2] doubleValue];
                sum = [self symbolOperation:tempArray[i] andx:x andy:y];
                NSString* tempString = [NSString stringWithFormat:@"%lf", sum];
                tempArray[i] = tempString;
                sum = 0;
            } else {
                ;
            }
        }
        sum = [tempArray[tempArray.count - 1] doubleValue];
        if (flag == 0) {
            sum *= [tempArray[0] doubleValue] ;
        }
    }
    
    ansString = [NSString stringWithFormat:@"%lf",sum];
    return ansString;
}
- (NSString*)operation:(NSString *)string {
    const char *textString = NULL;
    NSString* ans = @"qq";
    if ([string canBeConvertedToEncoding:NSUTF8StringEncoding]) {
        textString = [string cStringUsingEncoding:NSUTF8StringEncoding];
    }
    printf("%s", textString);
    if (tureKH(textString) == 0) {
        ans = @"输入有误";
        return ans;
    }
    NSMutableArray* ansArray = [self switchString:textString];
//    ans = [ansArray componentsJoinedByString:@""];
    ans = [self lastOperation:ansArray];
    ans = [self removeZero:ans];
    return ans;
}

@end
