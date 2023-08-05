//
//  CharacterProfile.m
//  ProyectoRick&Morty
//
//  Created by admin on 08/08/22.
//

#import "CharacterProfile.h"
#import "AFNetworking.h"

@interface CharacterProfile (){
    NSInteger* idProfile;
    CharactersController *view;
}

@end

@implementation CharacterProfile

- (void)viewDidLoad {
    [super viewDidLoad];
    
    view = [[CharactersController alloc] init];
    view = _viewController;
    
    if (_character != nil) {
        
        idProfile = _character.id;
        [_lbName setStringValue:_character.name];
        [_lbStatus setStringValue:_character.status];
        [_lbSpecie setStringValue:_character.species];
        [_lbGender setStringValue:_character.gender];
    
        //NSImage *imageprofile = [[NSImage alloc] initWithData:[NSData dataWithData:[NSURL URLWithString:_character.image]]];
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", _character.image]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        NSImage *img = [[NSImage alloc] initWithData:data];
        
        _imgImage.image = img;
        
    }
    else{
        NSLog(@"Error");
    }
    
}

@end
