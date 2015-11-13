//
//  ViewController.m
//  ZazoVIPERTest
//
//  Created by Aleksandr Pronin on 11/12/15.
//  Copyright © 2015 RIT. All rights reserved.
//

#import "ZTVideoBoxesViewController.h"
#import <AVFoundation/AVFoundation.h>

#define kWidthRatio 3
#define kHeightRatio 4
#define kPreviewImageTag 1001

@interface ZTVideoBoxesViewController () <AVCaptureFileOutputRecordingDelegate>

@property (strong, nonatomic) UIView *cameraPreview;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *previewLayer;


@end

@implementation ZTVideoBoxesViewController
{
    CGFloat _xCoord;
    CGFloat _yCoord;
}

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.eventHandler updateView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ZTVideoBoxesViewInterface

- (void)configureVideoBoxesViews
{
    _xCoord = floor((self.view.frame.size.width)/sqrt(9));
    _yCoord = floor(((kHeightRatio * self.view.frame.size.width)/kWidthRatio)/sqrt(9));
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, floor(_xCoord*sqrt(9)), floor(_yCoord*sqrt(9)))];
    contentView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:contentView];
    
    int index = 0;
    NSMutableArray *newVideoBoxezViews = [NSMutableArray array];
    
    for (int y=0;y<3;y++) {
        for (int x=0;x<3;x++) {
            UIView *xView = [[UIView alloc] init];
            
            xView.backgroundColor = [UIColor lightGrayColor];
            xView.frame = CGRectMake(0+(_xCoord*x), 0+(_yCoord*y), _xCoord, _yCoord);
            
            xView.layer.borderColor = [UIColor grayColor].CGColor;
            xView.layer.borderWidth = 4;
            xView.tag = index;
            index ++;
            [contentView addSubview:xView];
            
            [newVideoBoxezViews addObject:xView];
            
            UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
            longPress.minimumPressDuration = 1.0f;
            [xView addGestureRecognizer:longPress];
            
            UITapGestureRecognizer *tapView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
            tapView.numberOfTouchesRequired = 1;
            [xView addGestureRecognizer:tapView];
            
            
            UIView *xHorPlus = [[UIView alloc] initWithFrame:CGRectMake(0, 0, xView.frame.size.width/4, 5)];
            xHorPlus.backgroundColor = [UIColor whiteColor];
            xHorPlus.center = CGPointMake(xView.frame.size.width/2, xView.frame.size.height/2);
            [xView addSubview:xHorPlus];
            
            UIView *xVerPlus = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, xHorPlus.frame.size.width)];
            xVerPlus.backgroundColor = [UIColor whiteColor];
            xVerPlus.center = CGPointMake(xView.frame.size.width/2, xView.frame.size.height/2);
            [xView addSubview:xVerPlus];
        }
    }
    
    contentView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    self.cameraPreview = newVideoBoxezViews[4];
    self.videoBoxesViews = newVideoBoxezViews;
}

- (void)configurePreviewLayer
{
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:[self.eventHandler getCaptureSession]];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    // Display the preview layer
    CGRect layerRect = CGRectMake(0, 0, _xCoord, _yCoord);
    [self.previewLayer setBounds:layerRect];
    [self.previewLayer setPosition:CGPointMake(CGRectGetMidX(layerRect),
                                          CGRectGetMidY(layerRect))];
    UIView *cameraView = [[UIView alloc] init];
    [_videoBoxesViews[4] addSubview:cameraView];
    
    [[cameraView layer] addSublayer:_previewLayer];
    
    // Start capture session
    [[self.eventHandler getCaptureSession] startRunning];
}

- (void)showVideoItems:(NSArray *)videoItems
{
    for (NSInteger index = 0; index < 9; index++) {
        if (videoItems[index] == [NSNull null]) continue;
        UIView *view = self.videoBoxesViews[index];
        UIImageView *previewImageView = [view viewWithTag:kPreviewImageTag];
        UIImage *previewImage = [videoItems[index] valueForKey:@"previewImage"];
        if (!previewImage) continue;
        if (!previewImageView) {
            previewImageView = [[UIImageView alloc] initWithImage:previewImage];
            previewImageView.frame = view.bounds;
            previewImageView.contentMode = UIViewContentModeScaleAspectFit;
            [view addSubview:previewImageView];
        } else {
            previewImageView.image = previewImage;
        }
    }
}

#pragma mark - Actions

- (void)handleLongPress:(UILongPressGestureRecognizer*)sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.cameraPreview.layer.borderColor = [UIColor redColor].CGColor;
        [self.eventHandler startRecordingWithBoxIndex:sender.view.tag andRecordingDelegate:self];
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        self.cameraPreview.layer.borderColor = [UIColor grayColor].CGColor;
        [self.eventHandler stopRecordingWithBoxIndex:sender.view.tag andCompletionHandler:^(UIImage *previewImage) {
            UIView *view = self.videoBoxesViews[sender.view.tag];
            UIImageView *previewImageView = [view viewWithTag:kPreviewImageTag];
            if (!previewImageView) {
                previewImageView = [[UIImageView alloc] initWithImage:previewImage];
                previewImageView.frame = view.bounds;
                previewImageView.contentMode = UIViewContentModeScaleAspectFit;
                [view addSubview:previewImageView];
            } else {
                previewImageView.image = previewImage;
            }
        }];
    }
}

- (void)handleTap:(UIGestureRecognizer*)sender
{
    [self.eventHandler playRecordWithBoxIndes:sender.view.tag andCompletionHandler:^(AVPlayer *player) {
        UIView *view = self.videoBoxesViews[sender.view.tag];
        AVPlayerLayer* playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
        playerLayer.frame = view.bounds;
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        playerLayer.needsDisplayOnBoundsChange = YES;
        [view.layer addSublayer:playerLayer];
        view.layer.needsDisplayOnBoundsChange = YES;
        
        [player play];
    }];
}

#pragma mark - Private

- (void)configureView
{
    self.view.backgroundColor = [UIColor grayColor];
}

@end
