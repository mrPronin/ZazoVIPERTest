//
//  ZTAppDependencies.m
//  ZazoVIPERTest
//
//  Created by Aleksandr Pronin on 11/12/15.
//  Copyright © 2015 RIT. All rights reserved.
//

#import "ZTAppDependencies.h"
#import "ZTDataStore.h"
#import "ZTRootWireframe.h"

#import "ZTVideoBoxesWireframe.h"
#import "ZTVideoBoxesPresenter.h"
#import "ZTVideoBoxesDataManager.h"
#import "ZTVideoBoxesInteractor.h"

@interface ZTAppDependencies ()

@property (strong, nonatomic) ZTVideoBoxesWireframe *videoBoxesWireframe;

@end

@implementation ZTAppDependencies

- (id)init
{
    if ((self = [super init]))
    {
        [self configureDependencies];
    }
    
    return self;
}

- (void)installRootViewControllerIntoWindow:(UIWindow *)window
{
    [self.videoBoxesWireframe presentVideoBoxesInterfaceFromWindow:window];
}

#pragma mark - Private

- (void)configureDependencies
{
    // Root Level Classes
    ZTDataStore *dataStore = [[ZTDataStore alloc] init];
    ZTRootWireframe *rootWireframe = [[ZTRootWireframe alloc] init];
    
    // Video Boxes Classes
    ZTVideoBoxesWireframe *videoBoxesWireframe = [[ZTVideoBoxesWireframe alloc] init];
    ZTVideoBoxesPresenter *videoBoxesPresenter = [[ZTVideoBoxesPresenter alloc] init];
    ZTVideoBoxesDataManager *videoBoxesDataManager = [[ZTVideoBoxesDataManager alloc] init];
    ZTVideoBoxesInteractor *videoBoxesInteractor = [[ZTVideoBoxesInteractor alloc] initWithDataManager:videoBoxesDataManager];
    
    videoBoxesInteractor.output = videoBoxesPresenter;
    videoBoxesDataManager.dataStore = dataStore;
    videoBoxesPresenter.videoBoxesInteractor = videoBoxesInteractor;
    videoBoxesPresenter.videoBoxesWireframe = videoBoxesWireframe;
    videoBoxesWireframe.videoBoxesPresenter = videoBoxesPresenter;
    videoBoxesWireframe.rootWireframe = rootWireframe;
    self.videoBoxesWireframe = videoBoxesWireframe;
}

@end
