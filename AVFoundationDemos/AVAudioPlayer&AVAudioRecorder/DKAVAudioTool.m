//
//  DKAVAudioTool.m
//  AVFoundationDemos
//
//  Created by 丁侃 on 2020/2/1.
//  Copyright © 2020 丁侃. All rights reserved.
//

#import "DKAVAudioTool.h"

@implementation DKAVAudioTool

static DKAVAudioTool *instance;

+(instancetype)sharenInsatnce{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DKAVAudioTool alloc]init];
    });
    return instance;
}




@end
