//
//  CollectionViewLayout.m
//  IOS 0 - 瀑布流
//
//  Created by qyhc on 16/11/12.
//  Copyright © 2016年 com.qykj. All rights reserved.
//

#import "CollectionViewLayout.h"

@interface CollectionViewLayout ()

@property (nonatomic, strong) NSMutableArray *arrayForMaxY;

@end

//确定最大的列数
static  NSInteger maxColum = 3 ;

@implementation CollectionViewLayout


-(NSMutableArray *)arrayForMaxY{
    
    if(!_arrayForMaxY){
        _arrayForMaxY = [NSMutableArray array];
    }
    return _arrayForMaxY;
}


-(instancetype)init{
    
    self = [super init];
    if(self){
        
    }
    return self;
}

//准备布局的时候调用，当布局刷新（改变）
-(void)prepareLayout{
    
    [super prepareLayout];
}


#pragma mark - 返回的是每一个cell的属性
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //确定行间距 列间距
    CGFloat columMargin = 10;
    CGFloat rowMargin = 10;
    
    //确定组的内间距
    UIEdgeInsets sectionInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    
    //取出collectionView 的 size
    CGSize collectionViewSize = self.collectionView.frame.size;
    
    //确定cell 的宽度
    CGFloat itemWidth = (collectionViewSize.width - sectionInsets.left - sectionInsets.right - (maxColum - 1) * columMargin ) / 3;
    
    //确定cell 的高度
#warning cell Height
    CGFloat itemHeight = arc4random_uniform(100)+ 100;
    
     //确定cell 的 x 和 y

     //找到最短的最大Y值
    CGFloat minMaxY = [self.arrayForMaxY[0] doubleValue];
    
     //定义 最短的列
    NSInteger minColumn = 0;
    
    for (int i = 1; i < maxColum; i++) {
        
         //找到数组中的Y值
        CGFloat arrayY = [self.arrayForMaxY[i] doubleValue];
        
        if(minMaxY > arrayY){
            
            //确定最短的最大Y值
            minMaxY  = arrayY;
            
            minColumn = i;
            
        }
    }
    
    CGFloat itemX = minColumn * itemWidth + minColumn * columMargin + sectionInsets.left;
    
    
    CGFloat itemY = minMaxY + rowMargin;
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.frame = CGRectMake(itemX, itemY, itemWidth, itemHeight);
    
    //记录最大Y值
    self.arrayForMaxY[minColumn] =@(CGRectGetMaxY(attributes.frame));
    
    return attributes;
    
}


#pragma mark - 返回的是可见区域cell属性

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    //在每次调用这个方法时，最好把arrayForMaxY 给清空掉
    [self.arrayForMaxY removeAllObjects];
    
    //对数组做初始化
    for (int i = 0; i<maxColum; i++) {
        [self.arrayForMaxY addObject:@0];
    }
    
    //实例化一个可变数组
    NSMutableArray *itemArray = [NSMutableArray array];
    
    //取出当前有多少个cell，返回第0组有多少个cell
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    
    for (int i=0; i<itemCount; i++) {
        
        //创建一个indexPath
        NSIndexPath  *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        //调用layoutAttributesForItemAtIndexPath：返回是对应到indexPath中cell的属性
        UICollectionViewLayoutAttributes *attri = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        //把cell的属性放到itemArray可变数组中
        [itemArray addObject:attri];
    }
    return itemArray;
}





@end
