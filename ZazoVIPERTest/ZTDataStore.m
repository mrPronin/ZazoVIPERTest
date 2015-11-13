//
//  ZTDataStore.m
//  ZazoVIPERTest
//
//  Created by Aleksandr Pronin on 11/12/15.
//  Copyright © 2015 RIT. All rights reserved.
//

#import "ZTDataStore.h"
#import <AVFoundation/AVFoundation.h>
#import "ZTVideoBoxItem.h"

#define kFileDraft  @"output%li.mov"

@interface ZTDataStore ()

@property (strong, nonatomic) AVCaptureMovieFileOutput *movieFileOutput;

@end

@implementation ZTDataStore

- (instancetype)init
{
    self = [super init];
    if (self) {
        _movieFileOutput = [[AVCaptureMovieFileOutput alloc] init];
        Float64 TotalSeconds = 60;
        int32_t preferredTimeScale = 30;
        CMTime maxDuration = CMTimeMakeWithSeconds(TotalSeconds, preferredTimeScale);
        _movieFileOutput.maxRecordedDuration = maxDuration;
        _movieFileOutput.minFreeDiskSpaceLimit = 1024 * 1024;
    }
    return self;
}

- (AVCaptureMovieFileOutput *)getFileOutput
{
    return _movieFileOutput;
}

- (void)startRecordingWithBoxIndex:(NSInteger)index andRecordingDelegate:(id<AVCaptureFileOutputRecordingDelegate>)delegate
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:kFileDraft, (long)index]];
    NSURL *outputURL = [[NSURL alloc] initFileURLWithPath:filePath];
    if ([fileManager fileExistsAtPath:filePath])
    {
        NSError *error;
        if ([fileManager removeItemAtPath:filePath error:&error] == NO)
        {
            NSLog(@"[%@ %@] -- Can't delete file at path: %@", [self class], NSStringFromSelector(_cmd), filePath);
        }
    }
    //Start recording
    [self.movieFileOutput startRecordingToOutputFileURL:outputURL recordingDelegate:delegate];
}

- (void)stopRecordingWithBoxIndex:(NSInteger)index andCompletionHandler:(void(^)(UIImage *previewImage))completionHandler
{
    [self.movieFileOutput stopRecording];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:kFileDraft, (long)index]];
        NSURL *videoURL = [NSURL fileURLWithPath:filePath];
        
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
        AVAssetImageGenerator *generateImg = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        generateImg.appliesPreferredTrackTransform = YES;
        NSError *error = NULL;
        CMTime time = CMTimeMake(1, 65);
        CGImageRef refImg = [generateImg copyCGImageAtTime:time actualTime:NULL error:&error];
        UIImage *previewImage = [[UIImage alloc] initWithCGImage:refImg];
        completionHandler(previewImage);
    });
}

- (void)playRecordWithBoxIndes:(NSInteger)index andCompletionHandler:(void(^)(AVPlayer *player))completionHandler
{
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:kFileDraft, (long)index]];
    NSURL *outputURL = [[NSURL alloc] initFileURLWithPath:filePath];
    AVPlayer *avPlayer = [AVPlayer playerWithURL:outputURL];
    completionHandler(avPlayer);
}

- (void)findVideoItemsWithCompletionHandler:(void(^)(NSArray *videoItems))completionHandler
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSMutableArray *currentVideoItems = [NSMutableArray array];
    for (NSInteger i = 0; i < 9; i++) {
        NSString *filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:kFileDraft, (long)i]];
        if ([fileManager fileExistsAtPath:filePath]) {
            NSURL *outputURL = [[NSURL alloc] initFileURLWithPath:filePath];
            AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:outputURL options:nil];
            AVAssetImageGenerator *generateImg = [[AVAssetImageGenerator alloc] initWithAsset:asset];
            generateImg.appliesPreferredTrackTransform = YES;
            NSError *error = NULL;
            CMTime time = CMTimeMake(1, 65);
            CGImageRef refImg = [generateImg copyCGImageAtTime:time actualTime:NULL error:&error];
            UIImage *previewImage = [[UIImage alloc] initWithCGImage:refImg];
            ZTVideoBoxItem *newVideoItem = [[ZTVideoBoxItem alloc] init];
            newVideoItem.previewImage = previewImage;
            [currentVideoItems addObject:newVideoItem];
        } else {
            [currentVideoItems addObject:[NSNull null]];
        }
    }
    completionHandler(currentVideoItems);
}

@end
