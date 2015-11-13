//
//  ZTVideoBoxesInteractorIO.h
//  ZazoVIPERTest
//
//  Created by Aleksandr Pronin on 11/13/15.
//  Copyright © 2015 RIT. All rights reserved.
//
#import <Foundation/Foundation.h>

@protocol ZTVideoBoxesInteractorInput <NSObject>

- (void)findVideoItems;

@end

@protocol ZTVideoBoxesInteractorOutput <NSObject>

- (void)foundVideoItems:(NSArray *)videoItems;

@end