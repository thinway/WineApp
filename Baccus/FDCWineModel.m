//
//  FDCWineModel.m
//  Baccus
//
//  Created by Fran Delgado on 2/7/16.
//  Copyright © 2016 Fran Delgado. All rights reserved.
//

#import "FDCWineModel.h"

@implementation FDCWineModel

// Cuando creas una propiedad de solo lectura e implementas un getter personalizado,
// como estamos haciendo con photo, el compilador daa por hecho que nos vas a precisar
// una variable de instancia. En este caso no es así, y sí que necesito la variable,
// así que hay que obligarle a que la incluya. Eso se hace con la línea @synthesize,
// con la que indicamos que queremos una propiedad llamada photo con una variable
// de instancia _photo.
// En la inmensa mayoría de casos, esto es opcional
// Para más info: http://cocoamental.com/2012/12/04/auto-synthesize-property-reglas-excepciones/

@synthesize photo = _photo;

#pragma mark - Propiedades

-(UIImage *) photo
{
    // Esto no es correcto porque:
    // Va a bloquear cuando se baje la imagen de Internet y se debería hacer en segundo plano
    // Sin embargo, como no sabemos hacer eso, de momento lo dejamos.
    
    // Carga perezosa: solo cargo la imagen si hace falta
    if ( _photo == nil) {
        _photo = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.photoURL]];
    }
    
    return _photo;
}

#pragma mark - Class Methods

+(id) wineWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
              type: (NSString *) aType
            origin: (NSString *) anOrigin
            grapes: (NSArray *) arrayOfGrapes
    wineCompanyWeb: (NSURL *) aURL
             notes: (NSString *) aNotes
            rating: (int) aRating
          photoURL: (NSURL *) aPhotoURL
{
    return [[self alloc] initWithName:aName
                      wineCompanyName:aWineCompanyName
                                 type:aType origin:anOrigin
                               grapes:arrayOfGrapes
                       wineCompanyWeb:aURL
                                notes:aNotes
                               rating:aRating
                             photoURL:aPhotoURL];
}

+(id) wineWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
              type: (NSString *) aType
            origin: (NSString *) anOrigin
{
    return [[self alloc] initWithName:aName
                      wineCompanyName:aWineCompanyName
                                 type:aType
                               origin:anOrigin];
}

#pragma mark - JSON

-(id) initWithDictionary:(NSDictionary *)aDict
{
    return [self initWithName:[aDict objectForKey:@"name"]
              wineCompanyName:[aDict objectForKey:@"wineCompanyName"]
                         type:[aDict objectForKey:@"type"]
                       origin:[aDict objectForKey:@"origin"]
                       grapes:[self extractGrapesFromJSONArray:[aDict objectForKey:@"grapes"]]
               wineCompanyWeb:[aDict objectForKey:@"wineCompanyWeb"]
                        notes:[aDict objectForKey:@"notes"]
                       rating:[[aDict objectForKey:@"rating"] intValue]
                     photoURL:[NSURL URLWithString:[aDict objectForKey:@"picture"]]];
}

-(NSDictionary *)proxyForJSON
{
    return @{@"name"            : self.name,
             @"wineCompanyName" : self.wineCompanyName,
             @"wineCompanyWeb"  : self.wineCompanyWeb,
             @"type"            : self.type,
             @"origin"          : self.origin,
             @"grapes"          : self.grapes,
             @"notes"           : self.notes,
             @"rating"          : @(self.rating),
             @"picture"         : [self.photoURL path]};
}

#pragma mark - Init

-(id) initWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
              type: (NSString *) aType
            origin: (NSString *) anOrigin
            grapes: (NSArray *) arrayOfGrapes
    wineCompanyWeb: (NSURL *) aURL
             notes: (NSString *) aNotes
            rating: (int) aRating
          photoURL: (NSURL *) aPhotoURL
{
    if (self = [super init]) {
        // Asignamos los parámetros a las variables de instancia
        _name = aName;
        _wineCompanyName = aWineCompanyName;
        _type = aType;
        _origin = anOrigin;
        _grapes = arrayOfGrapes;
        _wineCompanyWeb = aURL;
        _notes = aNotes;
        _rating = aRating;
        _photoURL = aPhotoURL;
    }
    
    return self;
}

-(id) initWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
              type: (NSString *) aType
            origin: (NSString *) anOrigin
{
    return [self initWithName:aName
              wineCompanyName:aWineCompanyName
                         type:aType
                       origin:anOrigin
                       grapes:nil
               wineCompanyWeb:nil
                        notes:nil
                       rating:NO_RATING
                     photoURL:nil];
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"Name: %@\nCompany name: %@\nType: %@\nOrigin: %@\nGrapes: %@\nWine company web: %@\nNotes: %@\nRating: %d\n",
            self.name, self.wineCompanyWeb, self.type, self.origin, self.grapes, self.wineCompanyWeb, self.notes, self.rating];
}
#pragma mark - Utils

-(NSArray *)extractGrapesFromJSONArray:(NSArray *) JSONArray
{
    NSMutableArray *grapes = [NSMutableArray arrayWithCapacity:[JSONArray count]];
    
    for(NSDictionary *dict in JSONArray) {
        [grapes addObject:[dict objectForKey:@"grape"]];
    }
    
    return grapes;
}

-(NSArray *)packGrapesIntoJSONArray
{
    NSMutableArray *jsonArray = [NSMutableArray arrayWithCapacity:[self.grapes count]];
    
    for(NSString *grape in self.grapes) {
        [jsonArray addObject:@{@"grape": grape}];
    }
    
    return jsonArray;
}
@end
