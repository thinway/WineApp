//
//  FDCWineModel.h
//  Baccus
//
//  Created by Fran Delgado on 2/7/16.
//  Copyright © 2016 Fran Delgado. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface FDCWineModel : NSObject

// Todas las propiedades de tipo objeto llevan strong
// El nonatomic es xq todos los accesores son creados de manera que sean seguros en un entorno multitarea. Si ponemos el nonatomic los va a generar sin esa seguridad extra.
// ¿Por qué se pone nonatomic? Porque de esta manera se ahorra un poco de tiempo. Es la norma de Apple.
// definir tus propertys como atomic, el tema aquí es que en caso de que redefinamos por ejemplo un setter habría un conflicto ya que la partícula atomic no permite estas
// combinaciones de métodos accesores propios y definidos por el usuario; por ello, y aunque la partícula nonatomic no garantiza el acceso seguro en entornos multi hilo,
// encontrarás que muchas veces usamos nonatomic para garantizar esta combinación de métodos getter/setter propios del sistema con métodos getter/setter redefinidos por el
// usuario.
// Más info: https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/EncapsulatingData/EncapsulatingData.html

@property (strong, nonatomic)   NSString    *type;
@property (strong, nonatomic)   UIImage     *photo; // representa una imagen pero no la muestra en pantalla. Recordemos que estamos en el modelo.
@property (strong, nonatomic)   NSURL       *wineCompanyWeb;
@property (strong, nonatomic)   NSString    *notes;
@property (strong, nonatomic)   NSString    *origin;
@property (nonatomic)           int         rating;
@property (strong, nonatomic)   NSArray     *grapes;
@property (strong, nonatomic)   NSString    *name;
@property (strong, nonatomic)   NSString    *wineCompanyName;

@end