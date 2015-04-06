//
//  ScreenshotsViewController.m
//  CheatSheet
//
//  Created by Daniel Simons on 4/5/15.
//  Copyright (c) 2015 UnofficialCalculators. All rights reserved.
//

#import "ScreenshotsViewController.h"
#import "ScreenshotCollectionViewCell.h"
#import "CSScreenshot.h"

@interface ScreenshotsViewController ()

@end

@implementation ScreenshotsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //self.screenshotCollectionView.delegate = self;
    self.screenshotCollectionView.dataSource = self;
    //[self.screenshotCollectionView registerClass:[ScreenshotCollectionViewCell class] forCellWithReuseIdentifier:@"MyBasicCollectionCell"];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.screenshotCollectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UICollectionViewDataSource Delegate Methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.screenshots count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ScreenshotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyBasicBitchCell" forIndexPath:indexPath];
    CSScreenshot *screenshot = [[self.screenshots allObjects] objectAtIndex:indexPath.row];
    [cell.screenshotImage setImage: [UIImage imageWithData:screenshot.imageData]];
    return cell;
}

@end
