//
//  BHPokemonTableViewController.m
//  PokedexObjC
//
//  Created by Benjamin Hakes on 3/8/19.
//  Copyright © 2019 Benjamin Hakes. All rights reserved.
//

#import "BHPokemonTableViewController.h"
#import "BHPokemonDetailedViewController.h"
#import "PokedexObjC-Swift.h"

@interface BHPokemonTableViewController ()

@property PokemonAPI *pokemonController;

@end

@implementation BHPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pokemonController = [PokemonAPI sharedController];
    [_pokemonController fetchAllPokemonWithCompletionBlock:^(NSArray<BHPokemon*> * _Nullable results , NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _pokemonController.results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [_pokemonController.results[indexPath.row] name];
    
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    BHPokemonDetailedViewController *destVC = [segue destinationViewController];
    destVC.objectToObserve = _pokemonController.results[indexPath.row];
    destVC.pokemonAPI = [self pokemonController];
    
}


@end
