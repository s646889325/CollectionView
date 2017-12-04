//
//  ViewController.m
//  IOS 0 - 瀑布流
//
//  Created by qyhc on 16/11/12.
//  Copyright © 2016年 com.qykj. All rights reserved.
//

#import "ViewController.h"

#import "CollectionViewCell.h"
#import "CollectionViewLayout.h"

@interface ViewController ()<UICollectionViewDataSource>

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CollectionViewLayout *layout = [[CollectionViewLayout alloc]init];
    
    UICollectionView  *collectionView =[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    
    collectionView.backgroundColor = [UIColor whiteColor];
    
    collectionView.dataSource = self;
    
    [collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:collectionView];
}


-(NSInteger )numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 100;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor redColor];
    
    
    return cell;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
