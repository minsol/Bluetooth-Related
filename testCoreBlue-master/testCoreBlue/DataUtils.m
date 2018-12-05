//
//  DataUtils.m
//  testCoreBlue
//
//  Created by minsol on 2018/1/16.
//  Copyright © 2018年 极目. All rights reserved.
//


#import "DataUtils.h"

@implementation DataUtils


/**
 *  单例
 */
static DataUtils * shareUtil = nil;
+(instancetype) shareInstance {
    // 保证程序的运行中 只执行一次
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        shareUtil = [[self alloc] init] ;
    }) ;
    return shareUtil ;
}

///Data转成十六进制字符串
+ (NSString*)DataToHexStr:(NSData*)data {
    Byte *bytes = (Byte *)[data bytes];
    NSString *hexStr=@"";
    for(int i=0;i<[data length];i++) {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff]; ///16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];        
    }
    return hexStr;
}

///十六进制字符串转成Data
+ (NSData*)HexStrToData:(NSString*)strHex {
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= strHex.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [strHex substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}



//将字符串表示的16进制字符串根据位置转换为String数组
+ (NSArray <NSString *>*)tranHexStrToStrArray:(NSString *)hexStr withRange:(NSArray<NSNumber *> *  )range{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:range.count];
    int startLocation = 0;
    for (int i = 0; i < range.count; i++) {
        int endLocation = [range[i] intValue] * 2;
        int len = endLocation - startLocation;
//        NSLog(@"%d::::%d:::%d",startLocation,endLocation,len);
        NSString *subStr = [hexStr substringWithRange:NSMakeRange(startLocation, len)];
        [array addObject:subStr];
        startLocation = endLocation;
    }
    return [array copy];
}

//十六进制字符转十进制
+(int )hexStringToAlgorism:(NSString *)strHex {
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= strHex.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [strHex substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    
    Byte *bytes = (Byte *)[data bytes];
    int intValue = 0;
    for (int i = 0; i < [data length]; i++){
        intValue += (bytes[i] & 0xFF) << (8 * (i));
    }
//    NSLog(@"%d",intValue);
    return intValue;
}


/**
 int32_t转4字节data

 @param value
 @return
 */
+(NSData *)intValueToByteArray:(int32_t)value{
    Byte bytes[4];
    for (int i = 0; i < 4; i++) {
        bytes[i] = (Byte) ((value >> INT32_C(8 * i)) & 0xFF);
        NSLog(@"%hhu",bytes[i]);
    }
    NSData *data = [NSData dataWithBytes:bytes length:4];
    return data;
}




///将十六进制的字符串转换成NSString则可使用如下方式:
+ (NSString *)convertHexStrToString:(NSString *)str {
    if (!str || [str length] == 0) {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    NSString *string = [[NSString alloc]initWithData:hexData encoding:NSUTF8StringEncoding];
    return string;
}


//中英文字符串转16进制字符串
+ (NSString *)utf8ToUnicode:(NSString *)string {
    
    NSUInteger length = [string length];
    
    NSMutableString *s = [NSMutableString stringWithCapacity:0];
    
    for (int i = 0;i < length; i++) {
        unichar _char = [string characterAtIndex:i];
        [s appendFormat:@"%04x",_char];
        NSLog(@"%c",_char);
    }
    return s;
    
}

@end

