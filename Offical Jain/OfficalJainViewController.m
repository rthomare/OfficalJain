//
//  OfficalJainViewController.m
//  Offical Jain
//
//  Created by Rohan Thomare on 1/19/14.
//  Copyright (c) 2014 TommyRayStudios. All rights reserved.
//

#import "OfficalJainViewController.h"
#import "AudioManager.h"

@interface OfficalJainViewController ()

@property (nonatomic, strong) AudioManager* audioPlayer;

@end

@implementation OfficalJainViewController

@synthesize audioPlayer= _audioPlayer;

-(AudioManager*)audioPlayer
{
    if(!_audioPlayer)
    {
        _audioPlayer = [[AudioManager alloc] init];
    }
    return _audioPlayer;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)buttonPressed:(UIButton *)sender {
    NSString* fileName = sender.titleLabel.text;
    fileName = [fileName stringByReplacingOccurrencesOfString:@" " withString:@""];
    fileName = [fileName stringByReplacingOccurrencesOfString:@"'" withString: @""];
    [self.audioPlayer playSongWithURL:fileName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
