//
//  FDCWineViewController.m
//  Baccus
//
//  Created by Fran Delgado on 3/7/16.
//  Copyright © 2016 Fran Delgado. All rights reserved.
//

#import "FDCWineViewController.h"
#import "FDCWebViewController.h"

@implementation FDCWineViewController

#pragma mark - Init

//  initWithModel sería nuestro inicializador designado y debe asegurarse de haber ejecutado el inicializador designado de su clase padre antes de inicializar sus propias variables de instancia.
- (id) initWithModel:(FDCWineModel *)aModel
{
    if (self = [super initWithNibName:nil bundle:nil]) {
        _model = aModel;
        self.title = aModel.name;
    }
    return self;
}

// Toda clase UIViewController tiene este inicializador designado
// XCode identifica como inicializadores a aquellos métodos cuyo nombre comienza con initWith... y además estrictamente en ese modo.
// El inicializador designado debe asegurarse de que todas las variables de instancia queden inicializadas. En caso de que no se redefina se estaría ejecutando el inicializador de la clase padre.
// El initWithNibName: bundle: es el inicializador designado para los controladores, sólo lo puedes obviar cuando trabajes con parámetros por defecto (nil) ya que en ese caso al no estar definido,
// buscará ejecutar el inicializador designado de su clase padre.
// Más info: http://cocoamental.com/2013/02/08/instancetype-clang-llvm-objectivec/
- (id) initWithNibName: (NSString *)nibNameOrNil bundle: (NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    // En estos métodos siempre llamamos a la superclase
    [super viewWillAppear:animated];
    
    [self syncModelWithView];
    
    // Para que pinte la información del view controller debajo del navigation controller y no los superponga
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // Esta configuración no puede ir en initWithNibName xq en ese momento todavía no se ha dibujado la vista y estaríamos mandando el mensaje a nil
    // self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:0.5 green:0 blue:0.13 alpha:1];

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

#pragma mark - Actions

-(IBAction)displayWeb:(id)sender
{
    //NSLog(@"Go to %@", self.model.wineCompanyWeb);
    
    // Crear un webVC
    FDCWebViewController *webVC = [[FDCWebViewController alloc] initWithModel:self.model];
    
    // Hacemos un push
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - Utils

-(void) syncModelWithView
{
    self.nameLabel.text = self.model.name;
    self.typeLabel.text = self.model.type;
    self.originLabel.text = self.model.origin;
    self.notesLabel.text = self.model.notes;
    self.wineryLabel.text = self.model.wineCompanyName;
    self.photoView.image = self.model.photo;
    self.grapesLabel.text = [self arrayToString: self.model.grapes];
    
    [self displayRating: self.model.rating];
    
    [self.notesLabel setNumberOfLines:0]; // Para mostrar el label en varias líneas.
}

-(void) displayRating: (int) aRating
{
    [self clearRatings];
    
    UIImage *glass = [UIImage imageNamed:@"splitView_score_glass"];
    
    for(int i = 0; i < aRating; i++) {
        [[self.ratingViews objectAtIndex:i] setImage: glass];
    }
}

-(void) clearRatings
{
    for(UIImageView *imgView in self.ratingViews) {
        imgView.image = nil;
    }
}

-(NSString *) arrayToString: (NSArray *) anArray
{
    NSString *repr = nil;
    
    if ([anArray count] == 1) {
        repr = [@"100% " stringByAppendingString:[anArray lastObject]];
    }else{
        repr = [[anArray componentsJoinedByString:@", "] stringByAppendingString:@"."];
    }
    
    return repr;
}

#pragma mark - UISplitViewControllerDelegate

- (void) splitViewController:(UISplitViewController *)svc willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode
{
    if ( displayMode == UISplitViewControllerDisplayModePrimaryHidden ) {
        self.navigationItem.rightBarButtonItem = svc.displayModeButtonItem;
    }else{
        self.navigationItem.rightBarButtonItem = nil;
    }
}

#pragma mark - WineryTableViewControllerDelegate

- (void) wineryTableViewController:(FDCWineryTableViewController *)wineryVC didSelectWine:(FDCWineModel *)aWine
{
    self.model = aWine;
    self.title = aWine.name;
    
    [self syncModelWithView];
}




@end
