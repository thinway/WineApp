//
//  FDCWebViewController.m
//  Baccus
//
//  Created by Fran Delgado on 3/7/16.
//  Copyright © 2016 Fran Delgado. All rights reserved.
//

#import "FDCWebViewController.h"


@implementation FDCWebViewController

#pragma mark - Init

-(id) initWithModel: (FDCWineModel *) aModel
{
    if( self = [super initWithNibName:nil bundle:nil]) {
        _model = aModel;
    }
    
    return self;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self displayURL: self.model.wineCompanyWeb];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UIWebViewDelegate

-(void) webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityView stopAnimating];
    [self.activityView setHidden:YES];
}

#pragma mark - Utils

-(void) displayURL: (NSURL *) aURL
{
    self.browser.delegate = self; // Hacemos al controlador delegado del WebView
    self.activityView.hidden = NO;
    [self.activityView startAnimating];
    [self.browser loadRequest:[NSURLRequest requestWithURL:aURL]];
    
    
}

@end
