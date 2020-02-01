//
//  DKAVAudioTool+DKAudioSession.h
//  AVFoundationDemos
//
//  Created by 丁侃 on 2020/2/1.
//  Copyright © 2020 丁侃. All rights reserved.
//

#import "DKAVAudioTool.h"

NS_ASSUME_NONNULL_BEGIN

@interface DKAVAudioTool (DKAudioSession)

/**
AVAudioSession Error
 AVAudioSessionErrorCodeNone
 操作成功。
 AVAudioSessionErrorCodeMediaServicesFailed
 尝试在媒体服务失败期间或之后使用音频会话。
 AVAudioSessionErrorCodeIsBusy
 尝试将其音频会话设置为非活动状态，但仍在播放和/或录制。
 AVAudioSessionErrorCodeIncompatibleCategory
 试图执行当前类别中不允许的操作。
 AVAudioSessionErrorCodeCannotInterruptOthers
 尝试在应用程序处于后台时使不可混音的音频会话处于活动状态。
 AVAudioSessionErrorCodeMissingEntitlement
 试图执行应用程序没有所需权利的操作。
 AVAudioSessionErrorCodeSiriIsRecording
 Siri正在录制时尝试执行不允许的操作。
 AVAudioSessionErrorCodeCannotStartPlaying
 试图开始音频播放，但不允许播放。
 AVAudioSessionErrorCodeCannotStartRecording
 试图开始录音，但失败了。
 AVAudioSessionErrorCodeBadParam
 试图将属性设置为非法值。
 AVAudioSessionErrorInsufficientPriority
 该应用程序不允许设置音频类别，因为它正在被另一个应用程序使用。
 AVAudioSessionErrorCodeResourceNotAvailable
 由于设备没有足够的硬件资源来完成操作而失败的操作。
 AVAudioSessionErrorCodeUnspecified
 没有更多的错误信息可用。当音频系统处于不一致状态时，通常会产生这种错误类型。
 */

/**
 配置音频回话
 AVAudioSessionCategoryAmbient    允许混音    屏幕锁定和Silent开关【静音开关】会使其静音  音频输出
 AVAudioSessionCategorySoloAmbient (默认) 音频输出
 AVAudioSessionCategoryPlayback   可选混音  音频输出 （默认情况下，使用此类别意味着，应用的音频不可混合，激活音频会话将中断其它不可混合的音频会话。如要使用混音，则使用 AVAudioSessionCategoryOptionMixWithOthers）
 AVAudioSessionCategoryRecord   音频输入（会使系统上的所有输出停止）
 AVAudioSessionCategoryPlayAndRecord 可选混音  音频输出 音频输入
 AVAudioSessionCategoryMultiRoute  音频输出 音频输入 （使用AVAudioSessionCategoryMultiRoute类别时，必须注册以观察AVAudioSessionRouteChangeNotification通知并根据需要更新配置。）
 */
+(NSError *)setUpAudioSessionWithCategory:(AVAudioSessionCategory)category;

/**
配置音频模式
 AVAudioSessionModeDefault 默认
 AVAudioSessionModeVoiceChat: 执行双向语音通信（只能与AVAudioSessionCategoryPlayAndRecord同时使用，此模式同事会启用AVAudioSessionCategoryOptionAllowBluetooth 类别选线支持蓝牙耳机。）
 AVAudioSessionModeVideoChat: 在线视频会议（只能与AVAudioSessionCategoryPlayAndRecord /  AVAudioSessionCategoryRecord同时使用，此模式同事会启用AVAudioSessionCategoryOptionAllowBluetooth 类别选线支持蓝牙耳机。）
 AVAudioSessionModeGameChat
 AVAudioSessionModeVideoRecording： 适用于视频录制情景（只适用于AVAudioSessionCategoryPlayAndRecord / AVAudioSessionCategoryRecord）
 AVAudioSessionModeMeasurement:  此模式适用于需要将输入和输出信号的系统提供的信号处理量将至最低的应用程序（只用于AVAudioSessionCategoryPlayback、AVAudioSessionCategoryRecord、AVAudioSessionCategoryPlayAndRecord）
 AVAudioSessionModeMoviePlayback： 适用于正在播放电影内容（将采用信号处理来增强某些音频路由（如内置扬声器或耳机）的电影播放,只用于AVAudioSessionCategoryPlayback）
 AVAudioSessionModeSpokenAudio： 当想要在另一个应用播放短语音频时暂停当前音频时，用于持续说话音频的模式
 */
+(NSError *)setUpAudioSessionWithMode:(AVAudioSessionMode)mode;


/**
配置音频
AVAudioSessionCategoryOptionMixWithOthers       确定来自此会话的音频是否与来自其他音频应用中活动会话的音频混合
AVAudioSessionCategoryOptionDuckOthers           当来自此会话的音频播放时，会导致来自其他会话的音频被降低（音量降低）
AVAudioSessionCategoryOptionAllowBluetooth    确定蓝牙免提设备是否显示为可用输入路由(需要设置此选项才能将音频输入和输出路由到配对的蓝牙免提模式（HFP）设备。 如果清除此选项，则配对的蓝牙HFP不会显示为可用的音频输入路由。)
AVAudioSessionCategoryOptionDefaultToSpeaker 确定会话中的音频是否默认为内置扬声器而不是接收器
AVAudioSessionCategoryOptionInterruptSpokenAudioAndMixWithOthers  确定播放此应用的音频内容时，是否暂停了来自其他应用的连续语音内容
AVAudioSessionCategoryOptionAllowBluetoothA2DP 确定来自此会话的音频是否可以流式传输到支持高级音频分发配置文件（A2DP）的蓝牙设备。
AVAudioSessionCategoryOptionAllowAirPlay  确定此会话中的音频是否可以传输到AirPlay设备。
 */
+(NSError *)setUpAudioSessionWithCategory:(AVAudioSessionCategory)category mode:(AVAudioSessionMode)mode Options:(AVAudioSessionCategoryOptions)options;

#pragma ---------------------------             AVAudioSessionInterruptionNotification
/**
 添加中断通知
 */
-(void)addInterruptionNotification;


#pragma ---------------------------             AVAudioSessionInterruptionNotification
//线路改变通知
-(void)handleRouteChange:(NSNotification *)notification;


/**
移除通知
*/
-(void)removeNotification;

@end

NS_ASSUME_NONNULL_END
