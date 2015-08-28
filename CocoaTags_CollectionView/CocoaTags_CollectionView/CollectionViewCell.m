//
//  CollectionViewCell.m
//  CocoaTags_CollectionView
//
//  Created by Cocoa Lee on 8/28/15.
//  Copyright (c) 2015 Cocoa Lee. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (id)init{
    self = [super init];
    if (self) {
        _tagLabel = [[UILabel alloc] init];
        _tagLabel.textColor = [UIColor whiteColor];
        _tagLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_tagLabel];
    }
    return self;
}






@end
