//
//  AudioManager.m
//  Go-Larm
//
//  Created by Rohan Thomare on 7/6/13.
//  Copyright (c) 2013 Rohan Thomare. All rights reserved.
//

#import "AudioManager.h"


#warning impliment audio manager

@interface AudioManager()

@property (nonatomic, weak) AVAudioSession* appSession;
@property (nonatomic, strong) AVAudioPlayer* audioPlayer;
@property (nonatomic, strong) NSNumber* startingTime;
@property (nonatomic, strong) NSNumber* endingTime;
@property (nonatomic, strong) NSTimer* timer;

@end

@implementation AudioManager

@synthesize audioPlayer = _audioPlayer;
@synthesize appSession = _appSession;
@synthesize startingTime = _startingTime;
@synthesize endingTime = _endingTime;
@synthesize timer = _timer;

-(id)init
{
    self = [super init];
    if(self)
    {
        //custom initalization of audioPlayer
        _appSession = [AVAudioSession sharedInstance];
        if(_appSession)
        {
           [_appSession setCategory:AVAudioSessionCategoryPlayback error:nil];
        }
    }
    return self;
}

-(void)startVibration
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(vibrate:)
                                   userInfo:nil
                                    repeats:YES];
}

-(void)stopVibration
{
    [_timer invalidate];
    _timer = nil;
}

-(void)vibrate:(NSTimer*)timer
{
    //start vibration pattern
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

-(void)setSound:(NSURL*)url withStartingTime:(NSNumber*)startTime andEndingTime:(NSNumber*)endTime
{
    if(startTime)
        self.startingTime = [startTime copy];
    
    if(endTime)
        self.startingTime = [endTime copy];
    
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
}

-(void)stop
{
    [self.audioPlayer stop];
    [self stopVibration];
    [_appSession setActive:NO error:nil];
}

-(void)playSongWithURL:(NSString *)fileName
{
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:fileName ofType:GO_LARM_DEFUALT_ALARM_TYPE]];
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [_audioPlayer setNumberOfLoops:0];
    _audioPlayer.delegate = self;
    //active audio session
    [_appSession setActive:YES error:nil];
    [self.audioPlayer play];
    //set up alarm to intake defualt alarm music provided
}

-(void)pause
{
    [self.audioPlayer pause];
}

-(void)audioPlayerBeginInterruption:(AVAudioPlayer *)player
{
    [self.audioPlayer pause];
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if(flag)
    {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
    [self stop];
}

-(void)audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    [self.audioPlayer play];
}

@end
