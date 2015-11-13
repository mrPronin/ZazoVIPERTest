//
//  ZTVideoBoxesInteractor.h
//  ZazoVIPERTest
//
//  Created by Aleksandr Pronin on 11/13/15.
//  Copyright © 2015 RIT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZTVideoBoxesInteractorIO.h"

@class ZTVideoBoxesDataManager;
@class AVCaptureMovieFileOutput;
@protocol AVCaptureFileOutputRecordingDelegate;
@class AVPlayer;

@interface ZTVideoBoxesInteractor : NSObject <ZTVideoBoxesInteractorInput>

@property (weak, nonatomic) id<ZTVideoBoxesInteractorOutput> output;

- (instancetype)initWithDataManager:(ZTVideoBoxesDataManager *)dataManager;
- (AVCaptureMovieFileOutput *)getFileOutput;
- (void)startRecordingWithBoxIndex:(NSInteger)index andRecordingDelegate:(id<AVCaptureFileOutputRecordingDelegate>)delegate;
- (void)stopRecordingWithBoxIndex:(NSInteger)index andCompletionHandler:(void(^)(UIImage *previewImage))completionHandler;
- (void)playRecordWithBoxIndes:(NSInteger)index andCompletionHandler:(void(^)(AVPlayer *player))completionHandler;

@end
