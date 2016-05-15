//
//  AudioManager.h
//  Go-Larm
//
//  Created by Rohan Thomare on 7/6/13.
//  Copyright (c) 2013 Rohan Thomare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioServices.h>

#define GO_LARM_DEFAULT_ALARM_NAME @"Go-LarmBaseAlarm"
#define GO_LARM_DEFUALT_ALARM_TYPE @"mp3"

@interface AudioManager : NSObject <AVAudioPlayerDelegate>

- (void)playSongWithURL:(NSString*)fileName;

- (void)pause;

- (void)stop;

-(void) setSound:(NSURL*)url
withStartingTime:(NSNumber*)startTime
   andEndingTime:(NSNumber*)endTime;

@end
