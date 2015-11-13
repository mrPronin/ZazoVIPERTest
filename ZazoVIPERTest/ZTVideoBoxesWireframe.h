//
//  ZTVideoBoxesWireframe.h
//  ZazoVIPERTest
//
//  Created by Aleksandr Pronin on 11/13/15.
//  Copyright © 2015 RIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZTVideoBoxesPresenter;
@class ZTRootWireframe;

@interface ZTVideoBoxesWireframe : NSObject

@property (strong, nonatomic) ZTVideoBoxesPresenter *videoBoxesPresenter;
@property (strong, nonatomic) ZTRootWireframe *rootWireframe;

- (void)presentVideoBoxesInterfaceFromWindow:(UIWindow *)window;

@end
