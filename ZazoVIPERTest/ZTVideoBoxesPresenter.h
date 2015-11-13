//
//  ZTVideoBoxesPresenter.h
//  ZazoVIPERTest
//
//  Created by Aleksandr Pronin on 11/13/15.
//  Copyright © 2015 RIT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZTVideoBoxesModuleInterface.h"
#import "ZTVideoBoxesInteractorIO.h"
#import <CoreMedia/CoreMedia.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@class ZTVideoBoxesInteractor;
@class ZTVideoBoxesWireframe;

@protocol ZTVideoBoxesViewInterface;

@interface ZTVideoBoxesPresenter : NSObject <ZTVideoBoxesModuleInterface, ZTVideoBoxesInteractorOutput>

@property (strong, nonatomic) ZTVideoBoxesInteractor *videoBoxesInteractor;
@property (strong, nonatomic) ZTVideoBoxesWireframe *videoBoxesWireframe;
@property (strong, nonatomic) UIViewController<ZTVideoBoxesViewInterface> *userInterface;

- (void)configureUserInterfaceForPresentation:(id<ZTVideoBoxesViewInterface>)videoBoxesViewUserInterface;

@end
