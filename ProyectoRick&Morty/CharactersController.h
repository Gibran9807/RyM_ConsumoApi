//
//  CharactersController.h
//  ProyectoRick&Morty
//
//  Created by admin on 07/08/22.
//

#import <Cocoa/Cocoa.h>

@interface CharactersController : NSViewController<NSTableViewDataSource>
{
    NSDictionary *dataJson;
}

@property (nonatomic, retain) NSMutableArray *Characters;

@property (strong) IBOutlet NSProgressIndicator *progressIndicator;
@property (strong) IBOutlet NSTableView *Table;
- (IBAction)onInfo:(id)sender;

-(void) chargeData;

@end


