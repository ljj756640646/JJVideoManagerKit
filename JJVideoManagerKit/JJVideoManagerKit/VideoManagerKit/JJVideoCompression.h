//
//  JJVideoCompression.h
//  JJVideoManager
//
//  Created by lujunjie on 2019/3/27.
//  Copyright © 2019 JJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JJAVAssetExportSession.h"
typedef enum JJVideoResolution{
    JJ_VIDEO_RESOLUTION_LOW,           // 352 * 288
    JJ_VIDEO_RESOLUTION_MEDIUM,        // 480 * 360
    JJ_VIDEO_RESOLUTION_HIGH,          // 640 * 480
    JJ_VIDEO_RESOLUTION_SUPER,         // 960 * 540
    JJ_VIDEO_RESOLUTION_SUPER_HIGH,    // 1280 * 720
}JJVideoResolution;

typedef enum JJVideoBitRate{
    JJ_VIDEO_BITRATE_LOW,           // （width * height * 3）/ 4
    JJ_VIDEO_BITRATE_MEDIUM,        // （width * height * 3）/ 2
    JJ_VIDEO_BITRATE_HIGH,          // （width * height * 2)
    JJ_VIDEO_BITRATE_SUPER,         // （width * height * 3)
    JJ_VIDEO_BITRATE_SUPER_HIGH,    // （width * height * 3）* 2
}JJVideoBitRate;

typedef struct JJVideoConfigurations{
    /* indicates the interval which the video composition, when enabled, should render composed video frames */
    int fps; // (0~30)
    JJVideoBitRate videoBitRate; /* bits per second, H.264 only */
    JJVideoResolution videoResolution;    // resolution
    
}JJVideoConfigurations;


typedef enum JJAudioSampleRate{
    ///  8KHz
    JJAudioSampleRate_8000Hz  = 8000,
    ///  11KHz
    JJAudioSampleRate_11025Hz = 11025,
    ///  16KHz
    JJAudioSampleRate_16000Hz = 16000,
    ///  22KHz
    JJAudioSampleRate_22050Hz = 22050,
    ///  32KHz
    JJAudioSampleRate_32000Hz = 32000,
    ///  44.1KHz
    JJAudioSampleRate_44100Hz = 44100,
    ///  48KHz
    JJAudioSampleRate_48000Hz = 48000
}JJAudioSampleRate;

typedef enum JJAudioBitRate {
    /// 32Kbps
    JJAudioBitRate_32Kbps = 32000,
    /// 64Kbps
    JJAudioBitRate_64Kbps = 64000,
    /// 96Kbps
    JJAudioBitRate_96Kbps = 96000,
    /// 128Kbps
    JJAudioBitRate_128Kbps = 128000,
    /// 192Kbps
    JJAudioBitRate_192Kbps = 192000,
    //  224kbps
    JJAudioBitRate_224Kbps = 224000
    
}JJAudioBitRate;

typedef struct JJAudioConfigurations{
    JJAudioSampleRate samplerate;
    JJAudioBitRate bitrate;
    int numOfChannels; //(1~2)
    int frameSize; /* value is an integer, one of: 8, 16, 24, 32 */
}JJAudioConfigurations;


typedef enum JJVideoCompressionState{
    JJ_VIDEO_STATE_FAILURE,
    JJ_VIDEO_STATE_SUCCESS
}JJVideoCompressionState;



NS_ASSUME_NONNULL_BEGIN

@interface JJVideoCompression :JJAVAssetExportSession

/**
 * The URL of the export session’s output.
 *
 * You can observe this property using key-value observing.
 */
@property (nonatomic, copy) NSURL *exportURL;
/**
 * The URL of the writer session’s input.
 *
 * You can observe this property using key-value observing.
 */
@property (nonatomic, copy) NSURL *inputURL;

/**
 * The settings used for encoding the video track.
 */
@property (nonatomic, assign) JJVideoConfigurations videoConfigurations;
/**
 * The settings used for encoding the audio track.
 */
@property (nonatomic, assign) JJAudioConfigurations audioConfigurations;

- (void)startCompressionWithCompletionHandler:(void (^)(JJVideoCompressionState State))handler;




@end

NS_ASSUME_NONNULL_END
