//
//  JJVideoCompression.m
//  JJVideoManager
//
//  Created by lujunjie on 2019/3/27.
//  Copyright © 2019 JJ. All rights reserved.
//

#import "JJVideoCompression.h"
#import <UIKit/UIKit.h>
@interface JJVideoCompression()
@property (nonatomic,assign) NSInteger width;
@property (nonatomic,assign) NSInteger height;
@end

@implementation JJVideoCompression


+ (instancetype)sharedCompression
{
    static JJVideoCompression *_selfObject;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _selfObject = [[self alloc] init];
    });
    return _selfObject;
}
- (void)startCompressionWithCompletionHandler:(void (^)(JJVideoCompressionState State))handler
{
    NSParameterAssert(handler != nil);
    
    NSParameterAssert(self.inputURL != nil);
    
    NSParameterAssert(self.exportURL != nil);
    
    
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:self.inputURL options:nil];
    AVAssetTrack *videoTrack = [[avAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
    float videoBitRate = [videoTrack estimatedDataRate];
    float configurationsBitRate = [self getVideoConfigurationsBitRate];
    
    
    
    
    self.asset = avAsset;
    self.outputURL = self.exportURL;
    self.outputFileType = AVFileTypeMPEG4;
    self.shouldOptimizeForNetworkUse = YES;
    
    NSMutableDictionary *videoParameter = [NSMutableDictionary dictionary];
    [videoParameter setObject:AVVideoCodecH264 forKey:AVVideoCodecKey];
    [videoParameter setObject:@(self.height) forKey:AVVideoHeightKey];
    [videoParameter setObject:@(self.width) forKey:AVVideoWidthKey];
    
    
    NSMutableDictionary *propertiesParameter = [NSMutableDictionary dictionary];
    [propertiesParameter setObject:@(self.videoConfigurations.fps) forKey:AVVideoAverageNonDroppableFrameRateKey];
    [propertiesParameter setObject:AVVideoProfileLevelH264MainAutoLevel forKey:AVVideoProfileLevelKey];
    if (videoBitRate > configurationsBitRate) {
        [propertiesParameter setObject:@(configurationsBitRate) forKey:AVVideoAverageBitRateKey];
    }
    [videoParameter setObject:propertiesParameter forKey:AVVideoCompressionPropertiesKey];
    self.videoSettings = videoParameter;
    
    
    
    
    NSMutableDictionary *audioParameter = [NSMutableDictionary dictionary];
    [audioParameter setObject:@(kAudioFormatMPEG4AAC) forKey:AVFormatIDKey];
    [audioParameter setObject:@(self.audioConfigurations.numOfChannels) forKey:AVNumberOfChannelsKey];
    [audioParameter setObject:@(self.audioConfigurations.samplerate) forKey:AVSampleRateKey];
    NSInteger bitrate = self.audioConfigurations.bitrate;
    [audioParameter setObject:@(bitrate) forKey:AVEncoderBitRateKey];

    self.audioSettings = audioParameter;
    
    
    [self exportAsynchronouslyWithCompletionHandler:^{
        if ([self status] == AVAssetExportSessionStatusCompleted) {
            
            handler(JJ_VIDEO_STATE_SUCCESS);
            // 成功
        }else if(self.status == AVAssetExportSessionStatusExporting){
            
        }else{
            handler(JJ_VIDEO_STATE_FAILURE);
            // 失败
        }
    }];
}


- (float)getVideoConfigurationsBitRate
{
    float bitRate = 0;
    switch (self.videoConfigurations.videoResolution) {
        case JJ_VIDEO_RESOLUTION_LOW:
            self.height = 352;
            self.width = 288;
            switch (self.videoConfigurations.videoBitRate) {
                case JJ_VIDEO_BITRATE_LOW:
                    bitRate =(352 * 288 * 3)/4;
                    break;
                case JJ_VIDEO_BITRATE_MEDIUM:
                    
                    bitRate =(352 * 288 * 3)/2;
                    
                    break;
                case JJ_VIDEO_BITRATE_HIGH:
                    bitRate =(352 * 288 * 2);
                    
                    break;
                case JJ_VIDEO_BITRATE_SUPER:
                    bitRate =(352 * 288 * 3);
                    
                    break;
                case JJ_VIDEO_BITRATE_SUPER_HIGH:
                    bitRate =(352 * 288 * 3) * 2;
                    
                    break;
                default:
                    break;
            }
            
            
            
            break;
        case JJ_VIDEO_RESOLUTION_MEDIUM:
            self.height = 480;
            self.width = 360;
            switch (self.videoConfigurations.videoBitRate) {
                case JJ_VIDEO_BITRATE_LOW:
                    bitRate =(480 * 360 * 3)/4;
                    break;
                case JJ_VIDEO_BITRATE_MEDIUM:
                    bitRate =(480 * 360 * 3)/2;
                    
                    break;
                case JJ_VIDEO_BITRATE_HIGH:
                    bitRate =(480 * 360 * 2);
                    
                    break;
                case JJ_VIDEO_BITRATE_SUPER:
                    bitRate =(480 * 360 * 3);
                    
                    break;
                case JJ_VIDEO_BITRATE_SUPER_HIGH:
                    bitRate =(480 * 360 * 3) * 2;
                    break;
                default:
                    break;
            }
            
            break;
        case JJ_VIDEO_RESOLUTION_HIGH:
            self.height = 640;
            self.width = 480;
            switch (self.videoConfigurations.videoBitRate) {
                case JJ_VIDEO_BITRATE_LOW:
                    bitRate =(640 * 480 * 3)/4;
                    break;
                case JJ_VIDEO_BITRATE_MEDIUM:
                    bitRate =(640 * 480 * 3)/2;
                    
                    break;
                case JJ_VIDEO_BITRATE_HIGH:
                    bitRate =(640 * 480 * 2);
                    
                    break;
                case JJ_VIDEO_BITRATE_SUPER:
                    bitRate =(640 * 480 * 3);
                    
                    break;
                case JJ_VIDEO_BITRATE_SUPER_HIGH:
                    bitRate =(640 * 480 * 3) * 2;
                    break;
                default:
                    break;
            }
            
            break;
        case JJ_VIDEO_RESOLUTION_SUPER:
            self.height = 960;
            self.width = 540;
            switch (self.videoConfigurations.videoBitRate) {
                case JJ_VIDEO_BITRATE_LOW:
                    bitRate =(960 * 540 * 3)/4;
                    break;
                case JJ_VIDEO_BITRATE_MEDIUM:
                    bitRate =(960 * 540 * 3)/2;
                    
                    break;
                case JJ_VIDEO_BITRATE_HIGH:
                    bitRate =(960 * 540 * 2);
                    
                    break;
                case JJ_VIDEO_BITRATE_SUPER:
                    bitRate =(960 * 540 * 3);
                    
                    break;
                case JJ_VIDEO_BITRATE_SUPER_HIGH:
                    bitRate =(960 * 540 * 3) * 2;
                    break;
                default:
                    break;
            }
            
            break;
        case JJ_VIDEO_RESOLUTION_SUPER_HIGH:
            self.height = 1280;
            self.width = 720;
            switch (self.videoConfigurations.videoBitRate) {
                case JJ_VIDEO_BITRATE_LOW:
                    bitRate =(1280 * 720 * 3)/4;
                    break;
                case JJ_VIDEO_BITRATE_MEDIUM:
                    bitRate =(1280 * 720 * 3)/2;
                    
                    break;
                case JJ_VIDEO_BITRATE_HIGH:
                    bitRate =(1280 * 720 * 2);
                    
                    break;
                case JJ_VIDEO_BITRATE_SUPER:
                    bitRate =(1280 * 720 * 3);
                    
                    break;
                case JJ_VIDEO_BITRATE_SUPER_HIGH:
                    bitRate =(1280 * 720 * 3) * 2;
                    break;
                default:
                    break;
            }
            
            break;
        default:
            break;
    }
    
    
    
    return bitRate;
}



@end
