# JJVideoManagerKit
JJVideoManagerKit is  Video compression
iOS 视频压缩压缩工具
支持音频压缩、视频压缩可以设置具体参数

使用方法：
        

        JJVideoCompression *compression = [[JJVideoCompression alloc]init]; // 创建对象
        compression.inputURL = ((AVURLAsset*)avasset).URL; // 视频输入路径
        compression.exportURL = [NSURL fileURLWithPath:[self getOutputPath]]; // 视频输出路径
        
        
        JJAudioConfigurations audioConfigurations;// 音频压缩配置
        audioConfigurations.samplerate = JJAudioSampleRate_11025Hz; // 采样率
        audioConfigurations.bitrate = JJAudioBitRate_32Kbps;// 音频的码率
        audioConfigurations.numOfChannels = 1;// 声道数
        audioConfigurations.frameSize = 8; // 采样深度
        
        compression.audioConfigurations = audioConfigurations;
        
        
        JJVideoConfigurations videoConfigurations;
        
        videoConfigurations.fps = 15; // 帧率 一秒中有多少帧
        videoConfigurations.videoBitRate = JJ_VIDEO_BITRATE_LOW; // 视频质量 码率
        videoConfigurations.videoResolution =  JJ_VIDEO_RESOLUTION_SUPER; //视频尺寸
        
        compression.videoConfigurations = videoConfigurations;
        
        [compression startCompressionWithCompletionHandler:^(JJVideoCompressionState State) {
            if (State == JJ_VIDEO_STATE_FAILURE) {
                NSLog(@"压缩失败");
            }else
            {
                NSLog(@"压缩成功");
            }
        }];
