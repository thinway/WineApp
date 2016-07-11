//
//  FDCWineryTableViewController.h
//  Baccus
//
//  Created by Fran Delgado on 5/7/16.
//  Copyright © 2016 Fran Delgado. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDCWineryModel.h"

#define RED_WINE_SECTION    0
#define WHITE_WINE_SECTION  1
#define OTHER_WINE_SECTION  2
#define NEW_WINE_NOTIFICATION_NAME @"newWine"
#define WINE_KEY @"wine"

@class FDCWineryTableViewController;

@protocol WineryTableViewControllerDelegate <NSObject>
// El <NSObject> quiere decir que este protocolo también responde a los métodos delegados de NSObject
- (void) wineryTableViewController: (FDCWineryTableViewController *) wineryVC didSelectWine: (FDCWineModel *) aWine;

@end

@interface FDCWineryTableViewController : UITableViewController

@property (strong, nonatomic) FDCWineryModel *model;
@property (weak, nonatomic) id<WineryTableViewControllerDelegate> delegate; // id<protocolo>: cualquier tipo de objeto que responda al protocolo

-(id) initWithModel: (FDCWineryModel *) aModel
              style: (UITableViewStyle) aStyle; // UITableViewStyle no lleva * xq no es un objeto sino una constante

@end

