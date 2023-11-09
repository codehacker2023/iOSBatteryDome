//
//  ViewController.m
//  battery
//
//  Created by liuyihua on 2023/11/6.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSourceSoundData];
}

//sound 模拟数据
- (void)addSourceSoundData {
//    NSString *source = [[NSBundle mainBundle] pathForResource:@"Analytics-2023-11-06-080042.ips.ca" ofType:@"synced"];
//    NSData *data = [NSData dataWithContentsOfFile:source];
//    NSDictionary * temp = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//    NSString * str = [NSString stringWithFormat:@"%@",temp[@"sound"]];
//    NSArray * soundData = [str componentsSeparatedByString:@","];
//    self.soundOrginArr = [NSMutableArray arrayWithArray:soundData];
    
    // 获取文件路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Analytics-2023-11-06-080042.ips.ca.synced" ofType:@""];

    // 读取文件内容
    NSError *error;
    NSString *content = [NSString stringWithContentsOfFile:filePath
                                                  encoding:NSUTF8StringEncoding
                                                     error:&error];

    if (content) {
        
     
        NSString * str = extractTextSegment(content);
        NSLog(@"%@",str);
        
        NSError *error = nil;
        NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
        
        if (jsonDict) {
            NSLog(@"JSON Dictionary: %@", jsonDict);
        } else {
            NSLog(@"Error parsing JSON: %@", error.localizedDescription);
        }
        
    }
        
//        NSLog(@"%@", content);
//
//        NSString *replacementString = [content stringByReplacingOccurrencesOfString:@"}\n" withString:@"@"];
//        NSLog(@"Replaced String: %@", replacementString);
        
//        // 使用正则表达式匹配
//        NSError *error = nil;
////        PackVoltage
//        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@".*PackVoltage.*" options:0 error:&error];
//
////        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@".*Capacity.*" options:0 error:&error];
//
//        if (!error) {
//            NSArray<NSTextCheckingResult *> *matches = [regex matchesInString:content options:0 range:NSMakeRange(0, content.length)];
//
//            for (NSTextCheckingResult *match in matches) {
//                NSRange range = [match range];
//                NSString *matchedText = [content substringWithRange:range];
//                NSLog(@"匹配到的文本: %@", matchedText);
//            }
//        } else {
//            NSLog(@"正则表达式编译错误: %@", [error localizedDescription]);
//        }
//
//        
//        
//    } else {
//        NSLog(@"无法读取文件内容：%@", [error localizedDescription]);
//    }

    
}

NSString *extractTextSegment(NSString *input) {
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\{\"Count\":.*?\"last_value_xFlags\":.*?\\}" options:0
                                                                             error:&error];

    if (error) {
        NSLog(@"Error creating regular expression: %@", error);
        return nil;
    }
    
    NSRange range = NSMakeRange(0, input.length);
    NSTextCheckingResult *match = [regex firstMatchInString:input options:0 range:range];
    if (match) {
        NSRange matchedRange = [match range];
        NSString *extractedText = [input substringWithRange:matchedRange];
        return extractedText;
    }
    
    return nil;
}


@end
