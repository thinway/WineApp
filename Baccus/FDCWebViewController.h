//
//  FDCWebViewController.h
//  Baccus
//
//  Created by Fran Delgado on 3/7/16.
//  Copyright © 2016 Fran Delgado. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDCWineModel.h"

@interface FDCWebViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) FDCWineModel *model;
@property (weak, nonatomic) IBOutlet UIWebView *browser;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

-(id) initWithModel: (FDCWineModel *) aModel;

@end
