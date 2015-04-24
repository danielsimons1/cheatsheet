//
//  ScreenshotsViewController.m
//  NoteCard
//
//  Created by Daniel Simons on 4/5/15.
//  Copyright (c) 2015 UnofficialCalculators. All rights reserved.
//

#import "ScreenshotsViewController.h"
#import "ScreenShotViewController.h"
#import "ScreenshotCollectionViewCell.h"
#import "CSScreenshot.h"
#import "DataAccess.h"

@interface ScreenshotsViewController ()

@property (strong, nonatomic) ScreenShotViewController *screenshotViewController;
@end

@implementation ScreenshotsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //self.screenshotCollectionView.delegate = self;
    self.screenshotCollectionView.dataSource = self;
    self.screenshotCollectionView.delegate = self;
    
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
    [cell.screenshotImage.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [cell.screenshotImage.layer setBorderWidth:1.];
    [cell.screenshotImage.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [cell.screenshotImage.layer setShadowOffset:CGSizeMake(0.,0.)];
    [cell.screenshotImage.layer setShadowRadius:1.];
    [cell.screenshotImage.layer setShadowOpacity:.9];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *screens = [[self.screenshots allObjects] mutableCopy];
    CSScreenshot *screenshot = [screens objectAtIndex:indexPath.row];
    [self.screenshotCollectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    
    [self performSegueWithIdentifier:@"screenshotDetail" sender:screenshot];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)screenshot {
    if ([[segue identifier] isEqualToString:@"screenshotDetail"]) {
        //NSArray *indexPaths = [self.screenshotCollectionView indexPathsForSelectedItems];
        //NSIndexPath *indexPath = [indexPaths firstObject];
        
        //Maybe use topViewController if this doesn't work
        self.screenshotViewController = [segue destinationViewController];
        self.screenshotViewController.screenshotsDelegate = self;
        
        [self.screenshotViewController setScreenshotDetailItem:screenshot];
    }
}

- (void)deleteScreenshot:(CSScreenshot *)screenshot {
    [self.screenshotViewController.navigationController popViewControllerAnimated:YES];
    [self.screenshots removeObject:screenshot];
    //[self.screenshotCollectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
    
    [[DataAccess sharedInstance] removeScreenshot:screenshot];
    
    [self.tabBarDelegate decrementTabBarBadgeValue];
}


@end
