//
//  CharacterProfile.h
//  ProyectoRick&Morty
//
//  Created by admin on 08/08/22.
//

#import <Cocoa/Cocoa.h>
#import "Entity/Character.h"
#import "CharactersController.h"

@interface CharacterProfile : NSViewController

@property (nonatomic, retain) CharactersController* viewController;

@property (nonatomic, retain) Character *character;


@property (strong) IBOutlet NSTextField *lbName;
@property (strong) IBOutlet NSTextField *lbStatus;
@property (strong) IBOutlet NSTextField *lbSpecie;
@property (strong) IBOutlet NSTextField *lbGender;
@property (strong) IBOutlet NSImageView *imgImage;

@end
