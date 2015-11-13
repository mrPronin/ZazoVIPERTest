//
//  ZTVideoBoxesDataManager.m
//  ZazoVIPERTest
//
//  Created by Aleksandr Pronin on 11/12/15.
//  Copyright © 2015 RIT. All rights reserved.
//

#import "ZTVideoBoxesDataManager.h"
#import "ZTDataStore.h"


@implementation ZTVideoBoxesDataManager

- (AVCaptureMovieFileOutput *)getFileOutput
{
    return [_dataStore getFileOutput];
}

- (void)startRecordingWithBoxIndex:(NSInteger)index andRecordingDelegate:(id<AVCaptureFileOutputRecordingDelegate>)delegate
{
    [self.dataStore startRecordingWithBoxIndex:index andRecordingDelegate:delegate];
}

- (void)stopRecordingWithBoxIndex:(NSInteger)index andCompletionHandler:(void(^)(UIImage *previewImage))completionHandler
{
    [self.dataStore stopRecordingWithBoxIndex:index andCompletionHandler:completionHandler];
}

- (void)playRecordWithBoxIndes:(NSInteger)index andCompletionHandler:(void(^)(AVPlayer *player))completionHandler
{
    [self.dataStore playRecordWithBoxIndes:index andCompletionHandler:completionHandler];
}

- (void)findVideoItemsWithCompletionHandler:(void(^)(NSArray *videoItems))completionHandler
{
    [self.dataStore findVideoItemsWithCompletionHandler:completionHandler];
}

@end
