//
//  FDCWineryModel.m
//  Baccus
//
//  Created by Fran Delgado on 5/7/16.
//  Copyright © 2016 Fran Delgado. All rights reserved.
//

#import "FDCWineryModel.h"

@interface FDCWineryModel ()

@property (strong, nonatomic) NSArray *redWines;
@property (strong, nonatomic) NSArray *whiteWines;
@property (strong, nonatomic) NSArray *otherWines;

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
        FDCWineModel *tintorro = [FDCWineModel wineWithName:@"Bembibre"
                                            wineCompanyName:@"Dominio de Tares"
                                                       type:@"Tinto"
                                                     origin:@"El Bierzo"
                                                     grapes:@[@"Mencía"]
                                             wineCompanyWeb:[NSURL URLWithString:@"http://www.dominiodetares.com/portfolio/bembibre/"]
                                                      notes:@"Este vino muestra toda la complejidad y al elegancia de la variedad Mencía. En fase visual luce un color rojo picota muy cubierto con tonalidades violáceasen el menisco. En nariz aparecen recuerdos frutales muy intensos de frutas rojas (frambuesa, cereza) y una potente ciruela negra, así como tonos florales de la gama de las rosas y violetas, vegetales muy elegantes y complementarios, hojarasca verde, tabaco y maderas aromáticas (sándalo) que le brindan un toque ciertamente perfumado"
                                                     rating:5
                                                      photo:[UIImage imageNamed:@"bembibre.jpg"]];
        
        FDCWineModel *albarino = [FDCWineModel wineWithName:@"Zárate"
                                            wineCompanyName:@"Zárate"
                                                       type:@"Blanco"
                                                     origin:@"Rías Bajas"
                                                     grapes:@[@"Albariño"]
                                             wineCompanyWeb:[NSURL URLWithString:@"http://bodegas-zarate.com/productos/vinos/albarino-zarate/"]
                                                      notes:@"El albariño Zárate es un vino blanco monovarietal que pertenece a la Denominación de Origen Rías Baixas. Considerado por la crítica especializada como uno de los grandes vinos blancos del mundo, el albariño ya es todo un mito."
                                                     rating:4
                                                      photo:[UIImage imageNamed:@"zarate.jpg"]];
        
        FDCWineModel *champagne = [FDCWineModel wineWithName:@"Comtes de Champagne"
                                             wineCompanyName:@"Champagne Taittinger"
                                                        type:@"Otro"
                                                      origin:@"Champagne"
                                                      grapes:@[@"Chardonnay"]
                                              wineCompanyWeb:[NSURL URLWithString:@"http://www.taittinger.com/"]
                                                       notes:@"Elaborado en las bodegas de la antigua abadía de San-Nicasio en Reims (siglo XVIII), Taittinger Comtes de Champagne Blanc de Blancs disfruta hasta su apogeo de una sucesión deatentos cuidados, y sólo se elabora en los años que reúnen las condiciones excepcionales que conforman toda su rareza: La cosecha Comtes de Champagne Blanc de Blancs está elaborada al 100% a partir de Chardonnays de los más grandes viñedos de las prestigiosa Côte des Blancs. Sólo se produce cuando la vendimia resulta ser de una excepcional calidad y digna de merecer una añada. Tan sólo se utiliza el vino de primer prensado – la Cuvée – aval absoluto de finura. El 5% de los vinos que entran en su composición han envejecido 4 meses en barricas de roble nuevas (un tercio de las cuales se renueva cada año), lo que realza las cualidades intrínsecas del ensamblaje final. Sólo después de una lenta y paciente crianza de varios años en las Crayères de Saint-Nicaise, esta cosecha de excepción ve la luz. A pesar de una climatología sin excesos, el año 2004 fue exuberante. El invierno , fresco pero sin períodos de frío intenso. La primavera, marcada por una pluvio- sidad débil, muy agradable. La floración, muy escalonada, arranco a mediados de junio con temperaturas frescas. Poco soleado y fresco, el verano se muestra seco hasta mediados de agosto donde llega un período de lluvias benefactoras. La vuelta del sol y del calor a principios de septiembre favoreció la maduración. La vendimia arranca a partir del 20 de septiembre con chardonnays y resulta ser de las más abundantes de la historia de la Champaña. Muy sana y de un excelente nivel cualitativo. Los chardonnays tienen una calidad sobresaliente: equilibrados, complejos, largos, frescos y tónicos. Los Pinots Noirs son elegantes y estructurados."
                                                      rating:4
                                                       photo:[UIImage imageNamed:@"comtes.jpg"]];
        
        self.redWines = @[tintorro];
        self.whiteWines = @[albarino];
        self.otherWines = @[champagne];
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
