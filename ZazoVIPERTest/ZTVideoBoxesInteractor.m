//
//  ZTVideoBoxesInteractor.m
//  ZazoVIPERTest
//
//  Created by Aleksandr Pronin on 11/13/15.
//  Copyright © 2015 RIT. All rights reserved.
//

#import "ZTVideoBoxesInteractor.h"
#import "ZTVideoBoxesDataManager.h"

@interface ZTVideoBoxesInteractor()

@property (nonatomic, strong) ZTVideoBoxesDataManager *dataManager;

@end

@implementation ZTVideoBoxesInteractor

- (instancetype)initWithDataManager:(ZTVideoBoxesDataManager *)dataManager
{
    if ((self = [super init])) {
        _dataManager = dataManager;
    }
    return self;
}

- (AVCaptureMovieFileOutput *)getFileOutput
{
    return [self.dataManager getFileOutput];
}

- (void)startRecordingWithBoxIndex:(NSInteger)index andRecordingDelegate:(id<AVCaptureFileOutputRecordingDelegate>)delegate
{
    [self.dataManager startRecordingWithBoxIndex:index andRecordingDelegate:delegate];
}

- (void)stopRecordingWithBoxIndex:(NSInteger)index andCompletionHandler:(void(^)(UIImage *previewImage))completionHandler
{
    [self.dataManager stopRecordingWithBoxIndex:index andCompletionHandler:completionHandler];
}

- (void)playRecordWithBoxIndes:(NSInteger)index andCompletionHandler:(void(^)(AVPlayer *player))completionHandler
{
    [self.dataManager playRecordWithBoxIndes:index andCompletionHandler:completionHandler];
}

#pragma mark - ZTVideoBoxesInteractorInput

- (void)findVideoItems
{
    __weak typeof(self) welf = self;
    [self.dataManager findVideoItemsWithCompletionHandler:^(NSArray *videoItems) {
        [welf.output foundVideoItems:videoItems];
    }];
}

@end
