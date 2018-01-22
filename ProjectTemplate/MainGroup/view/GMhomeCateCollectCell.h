//
//  GMhomeCateCollectCell.h
//  ProjectTemplate
//
//  Created by 雨停 on 2017/11/28.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GMhomeBlockModel,gameModel;

@interface GMhomeCateCollectCell : UICollectionViewCell
@property (nonatomic,strong)GMhomeBlockModel  * model;
@property (nonatomic,strong)gameModel         * gamemodel;
@end
