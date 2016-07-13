//
//  FDCWineryModel.m
//  Baccus
//
//  Created by Fran Delgado on 5/7/16.
//  Copyright © 2016 Fran Delgado. All rights reserved.
//

#import "FDCWineryModel.h"

@interface FDCWineryModel ()

@property (strong, nonatomic) NSMutableArray *redWines;
@property (strong, nonatomic) NSMutableArray *whiteWines;
@property (strong, nonatomic) NSMutableArray *otherWines;

@end

@implementation FDCWineryModel

#pragma mark - Properties

-(NSUInteger) redWineCount {
    return [self.redWines count];
}

-(NSUInteger) whiteWineCount
{
    return [self.whiteWines count];
}

-(NSUInteger) otherWineCount
{
    return [self.otherWines count];
}

-(id) init {

    if ( self = [super init] ) {
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://golang.bz/baccus/wines.json"]];
        //NSURLResponse *response = [[NSURLResponse alloc] init];
        //NSError *error;
        //NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
        NSURLSession *session = [NSURLSession sharedSession];
        [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
        if ( data != nil ) {
            // No ha habido error
            NSArray *JSONObjects = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
            if ( JSONObjects != nil) {
                // No ha habido error
                for( NSDictionary *dict in JSONObjects ) {
                    FDCWineModel *wine = [[FDCWineModel alloc] initWithDictionary:dict];
                    
                    // Añadimos al tipo adecuado
                    if ( [wine.type isEqualToString:RED_WINE_KEY] ) {
                        if (!self.redWines) {
                            self.redWines = [NSMutableArray arrayWithObject:wine];
                        }else{
                            [self.redWines addObject:wine];
                        }
                    }else if( [wine.type isEqualToString:WHITE_WINE_KEY] ){
                        if ( !self.whiteWines ) {
                            self.whiteWines = [NSMutableArray arrayWithObject:wine];
                        }else{
                            [self.whiteWines addObject:wine];
                        }
                    }else{
                        if( !self.otherWines ){
                            self.otherWines = [NSMutableArray arrayWithObject:wine];
                        }else{
                            [self.otherWines addObject:wine];
                        }
                    }
                }
            }else{
                // Se ha producido un error al parsear el JSON
                NSLog(@"Error al parsear JSON: %@", error.localizedDescription);
            }
        }else{
            // Error al descargar los datos del servidor
            NSLog(@"Error al descargar datos del servidor: %@", error.localizedDescription);
        }
        }] resume];
    }
    
    return self;
}

-(FDCWineModel *) redWineAtIndex: (NSInteger) index
{
    return [self.redWines objectAtIndex:index];
}

-(FDCWineModel *) whiteWineAtIndex: (NSInteger) index
{
    return [self.whiteWines objectAtIndex:index];
}

-(FDCWineModel *) otherWineAtIndex: (NSInteger) index
{
    return [self.otherWines objectAtIndex:index];
}

@end
