//
//  AppDelegate.m
//  Baccus
//
//  Created by Fran Delgado on 2/7/16.
//  Copyright © 2016 Fran Delgado. All rights reserved.
//

#import "AppDelegate.h"
#import "FDCWineModel.h"
#import "FDCWineViewController.h"
#import "FDCWebViewController.h"
#import "FDCWineryModel.h"
#import "FDCWineryTableViewController.h"

@implementation AppDelegate

-(UIViewController *)rootViewControllerForPhoneWithModel:(FDCWineryModel *)aModel
{
    // Controlador
    FDCWineryTableViewController *wineryVC = [[FDCWineryTableViewController alloc] initWithModel:aModel style:UITableViewStylePlain];
    
    // Combinador
    UINavigationController *wineryNav = [[UINavigationController alloc] initWithRootViewController:wineryVC];
    
    // Delegados
    wineryVC.delegate = wineryVC;
    
    return wineryNav;
}

-(UIViewController *)rootViewControllerForPadWithModel:(FDCWineryModel *)aModel
{
    // Controladores:
    
    // Controlador de la tabla
    FDCWineryTableViewController *wineryVC = [[FDCWineryTableViewController alloc] initWithModel:aModel style:UITableViewStylePlain];
    // Controlador de vino
    FDCWineViewController *wineVC = [[FDCWineViewController alloc] initWithModel:[wineryVC lastSelectedWine]];
    
    // Combinadores
    UINavigationController *wineNav = [[UINavigationController alloc] initWithRootViewController:wineVC];
    UINavigationController *wineryNav = [[UINavigationController alloc] initWithRootViewController:wineryVC];
    
    // Creamos el combinador: SplitView
    UISplitViewController *splitVC = [[UISplitViewController alloc] init];
    
    // Metemos dentro del SplitView los dos controladores
    splitVC.viewControllers = @[wineryNav, wineNav];
    
    // Asignamos delegados
    splitVC.delegate = wineVC;
    wineryVC.delegate = wineVC;
    
    return splitVC;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]; //Crea una windows que ocupe toda la pantalla
    
    // Creamos el modelo
    FDCWineryModel *winery = [[FDCWineryModel alloc] init];
    
    // Configuramos controladores, combinadores y delegados según
    // el tipo de dispositivo
    UIViewController *rootVC = nil;
    if ( !IS_IPHONE ) {
        // Tableta
        rootVC = [self rootViewControllerForPadWithModel: winery];
    }else{
        rootVC = [self rootViewControllerForPhoneWithModel: winery];
    }
    
    // Asignamos el combinador como controlador raíz
    self.window.rootViewController = rootVC;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

// Este método delegado se ejecuta cuando la aplicación deja de ser activa por ejemplo al recibir una llamada telefónica.
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

// Este método delegado se ejecuta cuando la aplicación se ha ido a segundo plano. Tenemos 5 segundos para hacer cosas: guardar datos (estado de la aplicación),
// cerrar conexiones de red, parar sonido, etc.
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

// Cuando se vuelve a primer plano. Recuperar el estado que guardamos con el método anterior.
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

// La aplicación vuelve a estar activa (podrá recibir interacción por parte del usuario).
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

// La aplicación va a terminar. No es un buen momento para guardar datos. Hay otros momentos más oportunos para guardar.
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
