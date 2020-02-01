//
//  DKAVFBaseViewController.m
//  AVFoundationDemos
//
//  Created by 丁侃 on 2020/1/22.
//  Copyright © 2020 丁侃. All rights reserved.
//

#import "DKAVFBaseViewController.h"
#import <AVKit/AVKit.h>

@interface DKAVFBaseViewController ()
@property (nonatomic, strong) UIButton *btn;

@property (nonatomic, strong) AVSpeechSynthesizer *synthesizer;

@property (nonatomic, strong) NSArray *voices;

@property (nonatomic, strong) NSArray *speechStrings;
@end

@implementation DKAVFBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.btn];
    
    _synthesizer = [[AVSpeechSynthesizer alloc]init];
    
    _voices = @[
        [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"],
        [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"]
    ];
    
}

-(void)didClick:(UIButton *)btn{
//    AVSpeechSynthesizer *syn = [[AVSpeechSynthesizer alloc]init];
//    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:@"hello world"];
//    [syn speakUtterance:utterance];
    [self beginConversation];
}


-(void)beginConversation{
    NSInteger count = self.speechStrings.count;
    for (NSInteger i = 0; i < count; i ++) {
        AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:self.speechStrings[i]];
        //语言
        utterance.voice = self.voices[i % 2];
        //播放速率
        utterance.rate = 0.5;
        //音调
        utterance.pitchMultiplier = 0.8;
        //播放下一句之前的暂停
        utterance.postUtteranceDelay = 0.2;
        //上一句之前的暂停
        utterance.preUtteranceDelay = 0.2;
        [self.synthesizer speakUtterance:utterance];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(UIButton *)btn{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeSystem];
        _btn.frame = CGRectMake(0, 0, 50, 50);
        [_btn setTitle:@"speak" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

-(NSArray *)speechStrings{
    if (!_speechStrings) {
        _speechStrings = @[
        @"hello World",
        @"哈哈哈非农速回复就等你覅偶家",
        @"哈哈哈非农速回复就等你覅偶家"
        ];
    }
    return _speechStrings;
}

@end

