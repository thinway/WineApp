//
//  FDCWebViewController.m
//  Baccus
//
//  Created by Fran Delgado on 3/7/16.
//  Copyright © 2016 Fran Delgado. All rights reserved.
//

#import "FDCWebViewController.h"
#import "FDCWineryTableViewController.h"

@implementation FDCWebViewController

#pragma mark - Init

- (id) initWithModel: (FDCWineModel *) aModel
{
    if( self = [super initWithNibName:nil bundle:nil]) {
        _model = aModel;
        self.title = @"Web";
    }
    
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self displayURL: self.model.wineCompanyWeb];
    
    // Solo tiene sentido darse de alta cuando la vista se hace visible
    // Alta en notificación
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver: self                           // ¿Quién se va a suscribir a esta notificación?
               selector: @selector(wineDidChange:)      // selector: Número que representa a un mensaje.
                   name: NEW_WINE_NOTIFICATION_NAME     // Notificación a la que me quiero suscribir
                 object: nil];                          // Objeto que genera la notificación. Si me da igual: nil
    
    
}

- (void) wineDidChange: (NSNotification *) notification
{
    NSDictionary *dict = [notification userInfo];
    FDCWineModel *newWine = [dict objectForKey:WINE_KEY];
    
    // Actualizar el modelo
    self.model = newWine;
    
    // Mostrar la nueva página
    [self displayURL:self.model.wineCompanyWeb];
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    // Baja en la notificación
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
