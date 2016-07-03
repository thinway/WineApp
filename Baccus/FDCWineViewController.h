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

// Los IBOutlet llevan el modificador weak
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *wineryLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *originLabel;
@property (weak, nonatomic) IBOutlet UILabel *grapesLabel;
@property (weak, nonatomic) IBOutlet UILabel *notesLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *ratingViews;

@property (strong, nonatomic) FDCWineModel *model;

-(id) initWithModel: (FDCWineModel *) aModel;

-(IBAction)displayWeb:(id)sender;

@end
