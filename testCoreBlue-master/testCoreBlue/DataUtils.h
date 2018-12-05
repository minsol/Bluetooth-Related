//
//  DataUtils.h
//  testCoreBlue
//
//  Created by minsol on 2018/1/16.
//  Copyright © 2018年 极目. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataUtils : NSObject

+(instancetype) shareInstance;

///将字符串表示的16进制字符串根据位置转换为String数组
+ (NSArray <NSString *>*)tranHexStrToStrArray:(NSString *)hexStr withRange:(NSArray<NSNumber *> *  )range;

/******************************解析*****************************************/

///Data转成十六进制字符串
+ (NSString*)DataToHexStr:(NSData*)data;
///十六进制字符串转成Data
+ (NSData*)HexStrToData:(NSString*)strHex;

///int转四字节
+(NSData *)intValueToByteArray:(int32_t)value;
///十六进制字符转化为十进制
+(int)hexStringToAlgorism:(NSString *)strHex;
///十六进制字符转换成NSString
+ (NSString *)convertHexStrToString:(NSString *)str;


//中英文字符串转16进制字符串
+ (NSString *)utf8ToUnicode:(NSString *)string;


@end
