//
//  DKAVAudioTool+DKAudioPlayer.h
//  AVFoundationDemos
//
//  Created by 丁侃 on 2020/2/1.
//  Copyright © 2020 丁侃. All rights reserved.
//

#import "DKAVAudioTool.h"

NS_ASSUME_NONNULL_BEGIN

@interface DKAVAudioTool (DKAudioPlayer)

+(AVAudioPlayer *)playerWithFile:(NSString *)file extension:(NSString *)extension;

/**
 file: 本地文件名
 loops：循环次数
 rate：速率
 pan：声道
 volume: 音量
 */
+(AVAudioPlayer *)playerWithFile:(NSString *)file loops:(NSInteger)loops rate:(float)rate pan:(float)pan volume:(float)volume;

+(void)setPlayer:(AVAudioPlayer *)player rate:(float)rate;

+(void)setPlayer:(AVAudioPlayer *)player pan:(float)pan;

+(void)setPlayer:(AVAudioPlayer *)player volume:(float)volume;

@end

NS_ASSUME_NONNULL_END
