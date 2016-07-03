//
//  FDCWineViewController.m
//  Baccus
//
//  Created by Fran Delgado on 3/7/16.
//  Copyright © 2016 Fran Delgado. All rights reserved.
//

#import "FDCWineViewController.h"

@implementation FDCWineViewController

//  initWithModel sería nuestro inicializador designado y debe asegurarse de haber ejecutado el inicializador designado de su clase padre antes de inicializar sus propias variables de instancia.
- (id) initWithModel:(FDCWineModel *)aModel
{
    if (self = [super initWithNibName:nil bundle:nil]) {
        _model = aModel;
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
    NSLog(@"Go to %@", self.model.wineCompanyWeb);
}

@end
