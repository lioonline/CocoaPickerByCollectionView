//
//  ViewController.m
//  CocoaTags_CollectionView
//
//  Created by Cocoa Lee on 8/28/15.
//  Copyright (c) 2015 Cocoa Lee. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#define MAX_SIZE_HEIGHT 5000



#define COLOR_ARRAY @[[UIColor colorWithRed:239/255.0 green:43/255.0 blue:41/255.0 alpha:1],\
[UIColor colorWithRed:225/255.0 green:0/255.0 blue:81/255.0 alpha:1],\
[UIColor colorWithRed:137/255.0 green:0/255.0 blue:161/255.0 alpha:1],\
[UIColor colorWithRed:83/255.0 green:33/255.0 blue:168/255.0 alpha:1],\
[UIColor colorWithRed:48/255.0 green:58/255.0 blue:165/255.0 alpha:1],\
[UIColor colorWithRed:30/255.0 green:127/255.0 blue:239/255.0 alpha:1],\
[UIColor colorWithRed:19/255.0 green:150/255.0 blue:240/255.0 alpha:1],\
[UIColor colorWithRed:22/255.0 green:175/255.0 blue:202/255.0 alpha:1],\
[UIColor colorWithRed:153/255.0 green:133/255.0 blue:7/255.0 alpha:1],\
[UIColor colorWithRed:122/255.0 green:187/255.0 blue:58/255.0 alpha:1],\
[UIColor colorWithRed:251/255.0 green:63/255.0 blue:27/255.0 alpha:1]\
];

@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong)  NSMutableArray  *tagsArray;
@property (nonatomic,strong) UITextField *textFiled;
@property (nonatomic,strong)  UICollectionView *collectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    collectionView.backgroundColor = [UIColor colorWithRed:240/250.0 green:240/250.0 blue:240/250.0 alpha:1];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.view addSubview:collectionView];
    _collectionView = collectionView;
    
    
    NSArray* array = @[@"123",@"德玛西亚",@"洁白月光",@"秦时明月",@"花草",@"大圣归来",@"你在干嘛呢",@"碉堡了",@"然并卵",@"纯则脆，阳则钢"];
    _tagsArray = [NSMutableArray arrayWithArray:array];
    
    
    
    
    
    UITextField *textFiled = [[UITextField alloc] initWithFrame:CGRectMake(30, CGRectGetHeight(self.view.bounds) - 348, CGRectGetWidth(self.view.bounds) - 60, 40)];
    textFiled.backgroundColor = [UIColor colorWithRed:255/255.0 green:247/255.0 blue:217/255.0 alpha:1];
    [textFiled becomeFirstResponder];
    textFiled.delegate =self;
    textFiled.placeholder = @"标签用 “，”隔开";
    [self.view addSubview:textFiled];
    _textFiled = textFiled;
    
    
    
    
    
    
    
    UIButton *button = [UIButton new];
    button.center = CGPointMake(textFiled.center.x, textFiled.center.y  + 60);
    button.bounds = CGRectMake(0, 0, 90, 30);
    [button setTitle:@"添加" forState:normal];
    button.backgroundColor = [UIColor colorWithRed:22/255.0 green:175/255.0 blue:202/255.0 alpha:1];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(addTags:) forControlEvents:UIControlEventTouchUpInside];
    

    
    
    
    
    
}




-(void)addTags:(UIButton *)button{
    if (_textFiled.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入内容" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    
    //============把textFiled中的文字转成array=========
    NSMutableArray * array = [NSMutableArray array];
    //既有中文都好，又有英文逗号
    if ([_textFiled.text rangeOfString:@","].length > 0 && [_textFiled.text rangeOfString:@"，"].length > 0 ) {
        
        NSArray *arrayOne = [_textFiled.text componentsSeparatedByString:@","];
        for (NSString *str in arrayOne) {
            if ([str rangeOfString:@"，"].length > 0) {
                NSArray *arrayTwo = [str componentsSeparatedByString:@"，"];
                [array addObjectsFromArray:arrayTwo];
            }
            else{
                NSMutableArray *arrayThree = [NSMutableArray arrayWithArray:@[str]];
                [array addObjectsFromArray:arrayThree];
            }
            
        }
    }
    else{
        //    字符串中有英文逗号
        if ([_textFiled.text rangeOfString:@","].length > 0 ) {
            array = [NSMutableArray arrayWithArray:[_textFiled.text componentsSeparatedByString:@","]];
        }
        //    字符串中有中文逗号
        else if ([_textFiled.text rangeOfString:@"，"].length > 0 ) {
            array = [NSMutableArray arrayWithArray:[_textFiled.text componentsSeparatedByString:@"，"]];
        }
        else{
            array = [NSMutableArray arrayWithArray:@[_textFiled.text]];
            
        }
    }
    NSLog(@"----- %ld",_tagsArray.count);
    [_tagsArray addObjectsFromArray:array];
    NSLog(@"----- %ld",_tagsArray.count);

    [_collectionView reloadData];
    

    _textFiled.text = @"";
}









- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return _tagsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"cell";
    UICollectionViewCell * cell = (UICollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];

    UILabel *label = [[UILabel alloc] initWithFrame:cell.bounds];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = _tagsArray[indexPath.row];
    label.backgroundColor = [UIColor redColor];
    cell.backgroundView = label;

    
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = _tagsArray[indexPath.row];
    
     CGSize size = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    
    
    return CGSizeMake(size.width + 20, size.height + 10);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20, 5, 20, 5);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"  ---%ld",indexPath.row);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
