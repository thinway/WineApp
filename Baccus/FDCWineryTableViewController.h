//
//  FDCWineryTableViewController.h
//  Baccus
//
//  Created by Fran Delgado on 5/7/16.
//  Copyright © 2016 Fran Delgado. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDCWineryModel.h"

@interface FDCWineryTableViewController : UITableViewController

@property (strong, nonatomic) FDCWineryModel *model;

-(id) initWithModel: (FDCWineryModel *) aModel
              style: (UITableViewStyle) aStyle; // UITableViewStyle no lleva * xq no es un objeto sino una constante

@end
