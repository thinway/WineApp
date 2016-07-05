//
//  FDCWineryModel.h
//  Baccus
//
//  Created by Fran Delgado on 5/7/16.
//  Copyright © 2016 Fran Delgado. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FDCWineModel.h"

@interface FDCWineryModel : NSObject

@property (readonly, nonatomic) NSUInteger redWineCount; // con readonly el compilador solo creará el getter, no creará el setter
@property (readonly, nonatomic) NSUInteger whiteWineCount;
@property (readonly, nonatomic) NSUInteger otherWineCount;

-(FDCWineModel *) redWineAtIndex: (int) index;
-(FDCWineModel *) whiteWineAtIndex: (int) index;
-(FDCWineModel *) otherWineAtIndex: (int) index;

@end
