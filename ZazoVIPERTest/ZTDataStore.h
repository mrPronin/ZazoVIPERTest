//
//  ZTDataStore.h
//  ZazoVIPERTest
//
//  Created by Aleksandr Pronin on 11/12/15.
//  Copyright © 2015 RIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AVCaptureMovieFileOutput;
@protocol AVCaptureFileOutputRecordingDelegate;
@class AVPlayer;

@interface ZTDataStore : NSObject

- (AVCaptureMovieFileOutput *)getFileOutput;
- (void)startRecordingWithBoxIndex:(NSInteger)index andRecordingDelegate:(id<AVCaptureFileOutputRecordingDelegate>)delegate;
- (void)stopRecordingWithBoxIndex:(NSInteger)index andCompletionHandler:(void(^)(UIImage *previewImage))completionHandler;
- (void)playRecordWithBoxIndes:(NSInteger)index andCompletionHandler:(void(^)(AVPlayer *player))completionHandler;
- (void)findVideoItemsWithCompletionHandler:(void(^)(NSArray *videoItems))completionHandler;

@end
