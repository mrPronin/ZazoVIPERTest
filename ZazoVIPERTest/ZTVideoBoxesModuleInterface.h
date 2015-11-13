//
//  ZTVideoBoxesModuleInterface.h
//  ZazoVIPERTest
//
//  Created by Aleksandr Pronin on 11/13/15.
//  Copyright © 2015 RIT. All rights reserved.
//


@class AVCaptureSession;
@protocol AVCaptureFileOutputRecordingDelegate;
@class AVPlayer;

@protocol ZTVideoBoxesModuleInterface <NSObject>

- (AVCaptureSession *)getCaptureSession;
- (void)startRecordingWithBoxIndex:(NSInteger)index andRecordingDelegate:(id<AVCaptureFileOutputRecordingDelegate>)delegate;
- (void)stopRecordingWithBoxIndex:(NSInteger)index andCompletionHandler:(void(^)(UIImage *previewImage))completionHandler;
- (void)playRecordWithBoxIndes:(NSInteger)index andCompletionHandler:(void(^)(AVPlayer *player))completionHandler;
- (void)updateView;

@end