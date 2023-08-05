//
//  CharactersController.m
//  ProyectoRick&Morty
//
//  Created by admin on 07/08/22.
//

#import "CharactersController.h"
#import "Entity/Character.h"
#import "AFNetworking.h"
#import "CharacterProfile.h"

@implementation CharactersController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _Characters = [[NSMutableArray alloc] init];
    
    [self chargeData];
}

- (IBAction)onInfo:(id)sender {
}

-(void) chargeData{
    
    [_Characters removeAllObjects];
    
    @try {
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager
                                         manager];
        
        manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        
        AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
        
        [serializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [serializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        
        
        [self Initializeprogress];
        
        [manager
         GET:@"https://rickandmortyapi.com/api/character"
          parameters:nil
             headers:nil
            progress:nil
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [self Finishprogress];
            
            self -> dataJson = (NSDictionary *) responseObject;
            
            for (NSObject* key in [self->dataJson valueForKey:@"results"]) {
                
                Character *character = [[Character alloc] init];
                
                [character setName:(NSString *)[key valueForKey:@"name"]];
                [character setStatus:(NSString *)[key valueForKey:@"status"]];
                [character setSpecies:(NSString *)[key valueForKey:@"species"]];
                [character setGender:(NSString *)[key valueForKey:@"gender"]];
                [character setImage:(NSString *)[key valueForKey:@"image"]];
                
                [self->_Characters addObject:character];
                
            }
            
            [NSThread sleepForTimeInterval:5.0f];
            
            [self->_Table reloadData];
            
            [self Finishprogress];
                        
        }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"Error: %@", error);
            [self Finishprogress];
        
        }];
        
        
    } @catch (NSException *exception) {
        NSLog(@"Error: %@", exception.reason);
    } @finally {
        //...
    }
    
}

-(NSInteger) numberOfRowsInTableView:(NSTableView *)tableView{
    return [_Characters count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    
    Character *p = [_Characters objectAtIndex:row];
    
    NSString* identifier = [tableColumn identifier];
    NSString* column = [p valueForKey:identifier];
    return column;
    
}

-(void) Initializeprogress{
    [_progressIndicator setHidden:NO];
    [_progressIndicator setIndeterminate:YES];
    [_progressIndicator setUsesThreadedAnimation:YES];
    [_progressIndicator startAnimation:nil];
}

-(void) Finishprogress{
    [_progressIndicator stopAnimation:nil];
    [_progressIndicator setHidden:YES];
}

-(void) Message:(NSString *)title Body:(NSString *) Message{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:@"Continue"];
    [alert setMessageText:title];
    [alert setInformativeText:Message];
    [alert setAlertStyle:NSAlertStyleInformational];
    [alert runModal];
}


- (void)prepareForSegue:(NSStoryboardSegue *)segue sender:(id)sender{
   
    @try {
        
        if ([[segue identifier] isEqualToString:@"profile"]) {
            
            NSInteger row = [_Table selectedRow];
            
            if (row != -1) {
                
                Character *character = [_Characters objectAtIndex:row];
                
                CharacterProfile *show = [segue destinationController];
                
                show.viewController = self;
                show.character = character;
                
                
            }
            else{
                [self Message:@"Select a row " Body:@"Table"];
                
                return;
                
            }
        }
    } @catch (NSException *exception) {
        
        [self Message:@"Error" Body:exception.reason];
        
    } @finally {
        //...
    }
}
    

@end
