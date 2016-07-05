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
    }
    
    return self;
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
    
    // Creamos un controlador para dicho vino
    FDCWineViewController *wineVC = [[FDCWineViewController alloc] initWithModel:wine];
    
    // Hacemos un push al navigation controller dentro del cual estamos
    [self.navigationController pushViewController:wineVC animated:YES];
}
@end
