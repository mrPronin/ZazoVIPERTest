//
//  ZTVideoBoxesWireframe.m
//  ZazoVIPERTest
//
//  Created by Aleksandr Pronin on 11/13/15.
//  Copyright © 2015 RIT. All rights reserved.
//

#import "ZTVideoBoxesWireframe.h"
#import "ZTVideoBoxesPresenter.h"
#import "ZTVideoBoxesViewController.h"
#import "ZTRootWireframe.h"

static NSString *VideoBoxesViewControllerIdentifier = @"ZTVideoBoxesViewController";

@interface ZTVideoBoxesWireframe ()

@property (strong, nonatomic) ZTVideoBoxesViewController* videoBoxesViewController;

@end

@implementation ZTVideoBoxesWireframe

- (void)presentVideoBoxesInterfaceFromWindow:(UIWindow *)window
{
    ZTVideoBoxesViewController *videoBoxesViewController = [self videoBoxesViewControllerFromStoryboard];
    videoBoxesViewController.eventHandler = self.videoBoxesPresenter;
    self.videoBoxesPresenter.userInterface = videoBoxesViewController;
    self.videoBoxesViewController = videoBoxesViewController;
    [self.videoBoxesPresenter configureUserInterfaceForPresentation:videoBoxesViewController];
    [self.rootWireframe showRootViewController:videoBoxesViewController inWindow:window];
}

#pragma mark - Private

- (ZTVideoBoxesViewController *)videoBoxesViewControllerFromStoryboard
{
    UIStoryboard *storyboard = [self mainStoryboard];
    ZTVideoBoxesViewController *vc = [storyboard instantiateViewControllerWithIdentifier:VideoBoxesViewControllerIdentifier];
    return vc;
}

- (UIStoryboard *)mainStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:[NSBundle mainBundle]];
    
    return storyboard;
}

@end
