//
//  ViewController.h
//  ZazoVIPERTest
//
//  Created by Aleksandr Pronin on 11/12/15.
//  Copyright © 2015 RIT. All rights reserved.
//

#import "ZTVideoBoxesModuleInterface.h"
#import "ZTVideoBoxesViewInterface.h"

@interface ZTVideoBoxesViewController : UIViewController <ZTVideoBoxesViewInterface>

@property (strong, nonatomic) id<ZTVideoBoxesModuleInterface> eventHandler;
@property (strong, nonatomic) NSArray *videoBoxesViews;

@end

