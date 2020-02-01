//
//  DKAVAudioTool+DKAudioPlayer.m
//  AVFoundationDemos
//
//  Created by 丁侃 on 2020/2/1.
//  Copyright © 2020 丁侃. All rights reserved.
//

#import "DKAVAudioTool+DKAudioPlayer.h"
@implementation DKAVAudioTool (DKAudioPlayer)

+(AVAudioPlayer *)playerWithFile:(NSString *)file extension:(NSString *)extension{
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:file withExtension:extension];
    
    NSError *error;
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&error];
    
    return player;
}

/**
 file: 本地文件名
 loops：循环次数
 rate：速率   0.5  /  1.0  /  2.0
 pan：声道  -1.0  /   0  /  1.0
 volume: 音量   0 -1
 */
+(AVAudioPlayer *)playerWithFile:(NSString *)file loops:(NSInteger)loops rate:(float)rate pan:(float)pan volume:(float)volume{
    AVAudioPlayer *player = [self playerWithFile:file extension:@"caf"];
    if (player) {
        player.numberOfLoops = loops;
        player.enableRate = YES;
        player.rate = rate;
        player.pan = pan;
        player.volume = volume;
        player.currentTime = 0.0f;
    }
    
    return player;
}

+(void)setPlayer:(AVAudioPlayer *)player rate:(float)rate{
    if (player) {
        player.enableRate = YES;
        player.rate = rate;
    }
}

+(void)setPlayer:(AVAudioPlayer *)player pan:(float)pan{
    if (player) {
        player.pan = pan;
    }
}

+(void)setPlayer:(AVAudioPlayer *)player volume:(float)volume{
    if (player) {
        player.volume = volume;
    }
}


@end
