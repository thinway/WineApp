//
//  FDCWineryTableViewController.m
//  Baccus
//
//  Created by Fran Delgado on 5/7/16.
//  Copyright © 2016 Fran Delgado. All rights reserved.
//

#import "FDCWineryTableViewController.h"
#import "FDCWineViewController.h"

@interface FDCWineryTableViewController ()

@end

@implementation FDCWineryTableViewController

-(id) initWithModel: (FDCWineryModel *) aModel
              style: (UITableViewStyle) aStyle
{
    if ( self = [super initWithStyle:aStyle] ) {
        _model = aModel;
        self.title = @"Baccus";
    }
    
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:0.5 green:0 blue:0.13 alpha:1];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ( section == RED_WINE_SECTION ) {
        return @"Red Wines";
    }else if( section == WHITE_WINE_SECTION ) {
        return @"White Wines";
    }else{
        return @"Other Wines";
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ( section == RED_WINE_SECTION ) {
        return self.model.redWineCount;
    }else if( section == WHITE_WINE_SECTION ) {
        return self.model.whiteWineCount;
    }else{
        return self.model.otherWineCount;
    }
}


// Un objeto NSIndexPath tiene dos propiedades: section y row
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if ( cell == nil ) {
        // No tiene ninguna celda disponible y hay que crearla a mano
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Averiguar de qué modelo (vino) nos están hablando
    FDCWineModel *wine = nil;
    
    if ( indexPath.section == RED_WINE_SECTION) {
        wine = [self.model redWineAtIndex:indexPath.row];
    }else if( indexPath.section == WHITE_WINE_SECTION ) {
        wine = [self.model whiteWineAtIndex:indexPath.row];
    }else{
        wine = [self.model otherWineAtIndex:indexPath.row];
    }
    
    // Sincronizar celda (vista) y modelo (vino). Recordar que la celda es una vista
    cell.imageView.image = wine.photo;
    cell.textLabel.text = wine.name;
    cell.detailTextLabel.text = wine.wineCompanyName;
    
    // La devolvemos
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table view delegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Suponemos que estamos dentro de un navigation controller
    
    // Averiguamos de qué vino se trata
    FDCWineModel *wine = nil;
    if ( indexPath.section == RED_WINE_SECTION) {
        wine = [self.model redWineAtIndex:indexPath.row];
    }else if( indexPath.section == WHITE_WINE_SECTION ) {
        wine = [self.model whiteWineAtIndex:indexPath.row];
    }else{
        wine = [self.model otherWineAtIndex:indexPath.row];
    }
    
    // Mandamos mensaje a nuestro delegado
    // Con esto la responsabilidad de la tabla ha terminado.
    // Se le manda un mensaje al delegado y éste que se busque la vida.
    [self.delegate wineryTableViewController:self didSelectWine:wine];
    
    // Los delegados y notificaciones no son excluyentes
    // es decir, podemos enviar el mismo mensaje de distinta forma
    // es lo que vamos a hacer.
    // Para crear una notificación hay que seguir dos pasos:
    //  1º - Crear la notificación
    //  2º - Enviarla
    
    // Creamos la notificación
    NSNotification *n = [NSNotification notificationWithName: NEW_WINE_NOTIFICATION_NAME
                                                      object:self
                                                    userInfo:@{WINE_KEY: wine}];
    
    // Enviamos la notificación creando una referencia al NotificationCenter
    [[NSNotificationCenter defaultCenter] postNotification:n];
    
    // Guardamos el último vino seleccionado
    [self saveLastSelectedWineAtSection:indexPath.section row:indexPath.row];
    
}

#pragma mark - WineryTableViewControllerDelegate

-(void)wineryTableViewController:(FDCWineryTableViewController *)wineryVC didSelectWine:(FDCWineModel *)aWine
{
    // Crear el controlador
    FDCWineViewController *wineVC = [[FDCWineViewController alloc] initWithModel: aWine];
    
    // Hacer un push
    [self.navigationController pushViewController:wineVC animated:YES];
}

#pragma mark - Utils

- (FDCWineModel *)wineForIndexPath:(NSIndexPath *)indexPath
{
    // Averiguamos de qué vino se trata
    FDCWineModel *wine = nil;
    
    if ( indexPath.section == RED_WINE_SECTION ) {
        wine = [self.model redWineAtIndex:indexPath.row];
    }else if( indexPath.section == WHITE_WINE_SECTION ){
        wine = [self.model whiteWineAtIndex:indexPath.row];
    }else{
        wine = [self.model otherWineAtIndex:indexPath.row];
    }
    
    return wine;
}

#pragma mark - NSUserDefaults

- (NSDictionary *) setDefaults
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // Por defecto, mostraremos el primero de los tintos
    NSDictionary *defaultWineCoords = @{SECTION_KEY : @(RED_WINE_SECTION), ROW_KEY: @0};
    
    // lo asignamos
    [defaults setObject:defaultWineCoords forKey:LAST_WINE_KEY];
    
    // guardamos por si las moscas
    [defaults synchronize];
    
    return defaultWineCoords;
}

- (void) saveLastSelectedWineAtSection:(NSUInteger) section row:(NSUInteger)row
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:@{SECTION_KEY: @(section), ROW_KEY: @(row)} forKey:LAST_WINE_KEY];
    
    [defaults synchronize];
}

- (FDCWineModel *)lastSelectedWine
{
    NSIndexPath *indexPath = nil;
    NSDictionary *coords = nil;
    
    coords = [[NSUserDefaults standardUserDefaults] objectForKey: LAST_WINE_KEY];
    
    if ( coords == nil ) {
        // No hay nada bajo la clave LAST_WINE_KEY
        // Esto quiere decir que es la primera vez que se llama a la App
        // Ponemos un valor por defecto: el primero de los tintos
        coords = [self setDefaults];
    } else {
        // Ya hay algo, es decir, en algún momento se guardó
        // No hay nada en especial que hacer.
    }
    
    // Transformamos esas coordenadas en un indexpath
    indexPath = [NSIndexPath indexPathForRow:[[coords objectForKey: ROW_KEY] integerValue]
                                   inSection:[[coords objectForKey: SECTION_KEY] integerValue]];
    
    // Devolvemos el vino en cuestión
    return [self wineForIndexPath: indexPath];
}
@end
