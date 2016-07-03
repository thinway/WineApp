//
//  FDCWineViewController.h
//  Baccus
//
//  Created by Fran Delgado on 3/7/16.
//  Copyright © 2016 Fran Delgado. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDCWineModel.h" // Cuidado con el autocompletado porque solo se importan los .h

@interface FDCWineViewController : UIViewController

@property (strong, nonatomic) FDCWineModel *model;

-(id) initWithModel: (FDCWineModel *) aModel;

@end
