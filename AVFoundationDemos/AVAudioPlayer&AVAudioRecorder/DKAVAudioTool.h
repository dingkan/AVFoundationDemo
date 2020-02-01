//
//  DKAVAudioTool.h
//  AVFoundationDemos
//
//  Created by 丁侃 on 2020/2/1.
//  Copyright © 2020 丁侃. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVKit/AVKit.h>

@protocol DKAVAudioToolDelegate <NSObject>

@optional
#pragma  ------------   中断通知代理
//后台播放停止
-(void)interruptionBegan;
//后台播放允许回复
-(void)interruptionShouldResume;

#pragma  ------------   线路改变通知代理
-(void)routeChangeReasonUnknown;

/**
 AVAudioSessionPortBuiltInMic ：内置麦克风
 AVAudioSessionPortHeadsetMic ：耳机线中的麦克风
 
 AVAudioSessionPortLineOut
 AVAudioSessionPortHeadphones ：耳机或者耳机式输出设备
 AVAudioSessionPortBuiltInReceiver ：帖耳朵时候内置扬声器（打电话的时候的听筒）
 AVAudioSessionPortBuiltInSpeaker ：iOS设备的扬声器
 AVAudioSessionPortBluetoothA2DP ：A2DP协议式的蓝牙设备
 AVAudioSessionPortHDMI ：高保真多媒体接口设备
 AVAudioSessionPortAirPlay ：远程AirPlay设备
 AVAudioSessionPortBluetoothLE ：蓝牙低电量输出设备
 
 AVAudioSessionPortUSBAudio
 AVAudioSessionPortCarAudio
 */
-(void)routeChange:(AVAudioSessionPort _Nullable )port;

-(void)routeChangeReasonCategoryChange;

-(void)routeChangeReasonOverride;

-(void)routeChangeReasonWakeFromSleep;

-(void)routeChangeReasonNoSuitableRouteForCategory;

-(void)routeChangeReasonRouteConfigurationChange;
@end

NS_ASSUME_NONNULL_BEGIN

@interface DKAVAudioTool : NSObject

@property (nonatomic, weak) id<DKAVAudioToolDelegate> delegate;

+(instancetype)sharenInsatnce;


@end

NS_ASSUME_NONNULL_END
