//
//  ZTVideoBoxesDataManager.h
//  ZazoVIPERTest
//
//  Created by Aleksandr Pronin on 11/12/15.
//  Copyright © 2015 RIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZTDataStore;
@class ZTVideoBoxItem;
@class AVCaptureMovieFileOutput;
@protocol AVCaptureFileOutputRecordingDelegate;
@class AVPlayer;

@interface ZTVideoBoxesDataManager : NSObject

@property (nonatomic, strong) ZTDataStore *dataStore;

- (AVCaptureMovieFileOutput *)getFileOutput;
- (void)startRecordingWithBoxIndex:(NSInteger)index andRecordingDelegate:(id<AVCaptureFileOutputRecordingDelegate>)delegate;
- (void)stopRecordingWithBoxIndex:(NSInteger)index andCompletionHandler:(void(^)(UIImage *previewImage))completionHandler;
- (void)playRecordWithBoxIndes:(NSInteger)index andCompletionHandler:(void(^)(AVPlayer *player))completionHandler;
- (void)findVideoItemsWithCompletionHandler:(void(^)(NSArray *videoItems))completionHandler;

@end
