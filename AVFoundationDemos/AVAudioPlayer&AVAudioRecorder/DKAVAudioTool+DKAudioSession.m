//
//  DKAVAudioTool+DKAudioSession.m
//  AVFoundationDemos
//
//  Created by 丁侃 on 2020/2/1.
//  Copyright © 2020 丁侃. All rights reserved.
//

#import "DKAVAudioTool+DKAudioSession.h"


@implementation DKAVAudioTool (DKAudioSession)

//配置音频回话
+(NSError *)setUpAudioSessionWithCategory:(AVAudioSessionCategory)category{
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    NSError *error;
    
    /*
     其中一些分类可以通过options 和 modes方法自定义开发
     */
    if (![session setCategory:category error:&error]) {
        NSLog(@"Category Error: %@",[error localizedDescription]);
        return error;
    }
    
    if (![session setActive:YES error:&error]) {
        NSLog(@"Activation Error: %@",[error localizedDescription]);
        return error;
    }
    return nil;
}


/**
配置音频模式
 */
+(NSError *)setUpAudioSessionWithMode:(AVAudioSessionMode)mode{
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *error;
    
    if (![session setMode:mode error:&error]) {
        NSLog(@"Mode Error: %@",[error localizedDescription]);
        return error;
    }
    
    return nil;
}


/**
配置音频选项
 */
+(NSError *)setUpAudioSessionWithCategory:(AVAudioSessionCategory)category mode:(AVAudioSessionMode)mode Options:(AVAudioSessionCategoryOptions)options{
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *error;
    
    if (![session setCategory:category mode:mode options:options error:&error]) {
        NSLog(@"Options Error: %@",[error localizedDescription]);
        return error;
    }
    
    return nil;
}

//中断
-(void)addInterruptionNotification{
    //注册中断通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleInterruption:) name:AVAudioSessionInterruptionNotification object:[AVAudioSession sharedInstance]];
}

//线路改变
-(void)addRouteChangeNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleRouteChange:) name:AVAudioSessionRouteChangeNotification object:[AVAudioSession sharedInstance]];
}

-(void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//中断通知处理事件
-(void)handleInterruption:(NSNotification *)notification{
    NSDictionary *info = notification.userInfo;
    AVAudioSessionInterruptionType type = [info[AVAudioSessionInterruptionTypeKey] unsignedIntegerValue];
    
    if (type == AVAudioSessionInterruptionTypeBegan) {
        if ([self.delegate respondsToSelector:@selector(interruptionBegan)]) {
            [self.delegate interruptionBegan];
        }
    }else if (type == AVAudioSessionInterruptionTypeEnded){
        
        //如果type类型是Ended类型，info中有一个AVAudioSessionInterruptionOptions值，来表明音频回话是否已经重新激活以及是否可以再次播放
        AVAudioSessionInterruptionOptions option = [info[AVAudioSessionInterruptionOptionKey] unsignedIntegerValue];
        if (option == AVAudioSessionInterruptionOptionShouldResume) {
            if ([self.delegate respondsToSelector:@selector(interruptionShouldResume)]) {
                [self.delegate interruptionShouldResume];
            }
        }
        
    }
}

//线路改变通知
-(void)handleRouteChange:(NSNotification *)notification{
    NSDictionary *info = notification.userInfo;
    
    AVAudioSessionRouteChangeReason reason = [info[AVAudioSessionRouteChangeReasonKey] unsignedIntegerValue];
    
    switch (reason) {
        case AVAudioSessionRouteChangeReasonUnknown:
            if ([self.delegate respondsToSelector:@selector(routeChangeReasonUnknown)]) {
                [self.delegate routeChangeReasonUnknown];
            }
            break;
        case AVAudioSessionRouteChangeReasonNewDeviceAvailable:
            //新设备出现（耳机已连接）
            [self routeChangeReasonOldDeviceUnavailableWithInfo:info isInput:YES];
            break;
        case AVAudioSessionRouteChangeReasonOldDeviceUnavailable:
            //旧设备无法使用（耳机为插拨）
            [self routeChangeReasonOldDeviceUnavailableWithInfo:info isInput:NO];
            break;
        case AVAudioSessionRouteChangeReasonCategoryChange:
            //音频类别已更改(例如AVAudioSessionCategoryPlayback已更改为AVAudioSessionCategoryPlayAndRecord)。一般由[[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:newOption error:nil];触发
            if ([self.delegate respondsToSelector:@selector(routeChangeReasonCategoryChange)]) {
                [self.delegate routeChangeReasonCategoryChange];
            }
            break;
        case AVAudioSessionRouteChangeReasonOverride:
            //路由已被覆盖(例如，category是AVAudioSessionCategoryPlayAndRecord和输出已从默认的接收方更改为扬声器)。一般由[[AVAudioSession sharedInstance] overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:nil];触发
            if ([self.delegate respondsToSelector:@selector(routeChangeReasonOverride)]) {
                [self.delegate routeChangeReasonOverride];
            }
            break;
        case AVAudioSessionRouteChangeReasonWakeFromSleep:
            if ([self.delegate respondsToSelector:@selector(routeChangeReasonWakeFromSleep)]) {
                [self.delegate routeChangeReasonWakeFromSleep];
            }
            break;
        case AVAudioSessionRouteChangeReasonNoSuitableRouteForCategory:
            //当当前类别没有路由是返回（例如，该类别是AVAudioSessionCategoryRecord但是没有输入设备可用）
            if ([self.delegate respondsToSelector:@selector(routeChangeReasonNoSuitableRouteForCategory)]) {
                     [self.delegate routeChangeReasonNoSuitableRouteForCategory];
            }
            break;
        case AVAudioSessionRouteChangeReasonRouteConfigurationChange:
            //表示输入和/或输出端口的集合没有改变，只是改变了它们的某些方面配置发生了变化。例如，端口选择的数据源发生了更改。
            if ([self.delegate respondsToSelector:@selector(routeChangeReasonRouteConfigurationChange)]) {
                     [self.delegate routeChangeReasonRouteConfigurationChange];
            }
            break;
        default:
            break;
    }
}

-(void)routeChangeReasonOldDeviceUnavailableWithInfo:(NSDictionary *)info isInput:(BOOL)isInput{
    //获取用于描述前一个线路
    AVAudioSessionRouteDescription *previousRoute = info[AVAudioSessionRouteChangePreviousRouteKey];
    //线路的描述信息整合在一个输入和输入的array中
    AVAudioSessionPortDescription *previousOutput = isInput ? previousRoute.inputs.firstObject : previousRoute.outputs.firstObject;
    
    AVAudioSessionPort portType = previousOutput.portType;
    
    if ([self.delegate respondsToSelector:@selector(routeChange:)]) {
        [self.delegate routeChange:portType];
    }    
}

@end
