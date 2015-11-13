//
//  ZTVideoBoxesPresenter.m
//  ZazoVIPERTest
//
//  Created by Aleksandr Pronin on 11/13/15.
//  Copyright © 2015 RIT. All rights reserved.
//

#import "ZTVideoBoxesPresenter.h"
#import "ZTVideoBoxesViewInterface.h"
#import "ZTVideoBoxesInteractor.h"

@interface ZTVideoBoxesPresenter ()

@property (strong, nonatomic) AVCaptureSession *captureSession;

@end

@implementation ZTVideoBoxesPresenter

- (void)configureUserInterfaceForPresentation:(id<ZTVideoBoxesViewInterface>)videoBoxesViewUserInterface
{
    [videoBoxesViewUserInterface configureVideoBoxesViews];
    [videoBoxesViewUserInterface configurePreviewLayer];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

#pragma mark - ZTVideoBoxesModuleInterface

- (AVCaptureSession *)getCaptureSession
{
    return _captureSession;
}

- (void)startRecordingWithBoxIndex:(NSInteger)index andRecordingDelegate:(id<AVCaptureFileOutputRecordingDelegate>)delegate
{
    [self.videoBoxesInteractor startRecordingWithBoxIndex:index andRecordingDelegate:delegate];
}

- (void)stopRecordingWithBoxIndex:(NSInteger)index andCompletionHandler:(void(^)(UIImage *previewImage))completionHandler
{
    [self.videoBoxesInteractor stopRecordingWithBoxIndex:index andCompletionHandler:completionHandler];
}

- (void)playRecordWithBoxIndes:(NSInteger)index andCompletionHandler:(void(^)(AVPlayer *player))completionHandler
{
    [self.videoBoxesInteractor playRecordWithBoxIndes:index andCompletionHandler:completionHandler];
}

- (void)updateView
{
    [self.videoBoxesInteractor findVideoItems];
}

#pragma mark - ZTVideoBoxesInteractorOutput

- (void)foundVideoItems:(NSArray *)videoItems
{
    [self updateUserInterfaceWithVidelItems:videoItems];
}

#pragma mark - Private

- (void)updateUserInterfaceWithVidelItems:(NSArray *)videoItems
{
    [self.userInterface showVideoItems:videoItems];
}

- (AVCaptureDevice *)frontCamera {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == AVCaptureDevicePositionFront) {
            return device;
        }
    }
    return nil;
}

- (void)setVideoBoxesInteractor:(ZTVideoBoxesInteractor *)videoBoxesInteractor
{
    _videoBoxesInteractor = videoBoxesInteractor;
    [self initCaptureSession];
}

- (void)initCaptureSession
{
    _captureSession = [[AVCaptureSession alloc] init];
    AVCaptureDevice *videoDevice = [self frontCamera];
    if (videoDevice)
    {
        NSError *error;
        AVCaptureDeviceInput *videoInputDevice = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
        if (!error)
        {
            if ([_captureSession canAddInput:videoInputDevice])
                [_captureSession addInput:videoInputDevice];
            else
                NSLog(@"Couldn't add video input");
        }
        else
        {
            NSLog(@"Couldn't create video input");
        }
    }
    else
    {
        NSLog(@"Couldn't create video capture device");
    }
    AVCaptureDevice *audioCaptureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    NSError *error = nil;
    AVCaptureDeviceInput *audioInput = [AVCaptureDeviceInput deviceInputWithDevice:audioCaptureDevice error:&error];
    if (audioInput)
    {
        [_captureSession addInput:audioInput];
    }
    // Setting movie file output
    if ([_captureSession canAddOutput:[self.videoBoxesInteractor getFileOutput]])
        [_captureSession addOutput:[self.videoBoxesInteractor getFileOutput]];
    
    // Setting image quality
    [_captureSession setSessionPreset:AVCaptureSessionPresetMedium];
    if ([_captureSession canSetSessionPreset:AVCaptureSessionPreset640x480])
        [_captureSession setSessionPreset:AVCaptureSessionPreset640x480];
}

@end
