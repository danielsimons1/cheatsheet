//
//  DetailViewController.m
//  CheatSheet
//
//  Created by Daniel Simons on 3/30/15.
//  Copyright (c) 2015 UnofficialCalculators. All rights reserved.
//

#import "DetailViewController.h"
#import <WatchCoreDataProxy/WatchCoreDataProxy.h>
#import "ScreenshotsViewController.h"

@interface DetailViewController ()

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *captureImageViews;
@property (strong, nonatomic) NSData *fullImageBackup;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(CSData *)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        //[self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.navigationItem.title = self.detailItem.title;
        if (self.detailItem.fullImage) {
            self.parentViewController.navigationItem.rightBarButtonItem = self.parentViewController.editButtonItem;
            self.imageView.image = [UIImage imageWithData:self.detailItem.fullImage];
            self.uploadPhotoView.hidden = YES;
            
            for (UIView *view in self.captureImageViews) {
                view.hidden = NO;
            }
            
        } else {
            self.navigationItem.rightBarButtonItem = nil;
            for (UIView *view in self.captureImageViews) {
                view.hidden = YES;
            }
            self.uploadPhotoView.hidden = NO;
            [self.selectPhotoButton.layer setCornerRadius:12.];
            [self.takePhotoButton.layer setCornerRadius:12.];
        }
    }
    
    self.screenshotView.layer.borderColor = [[UIColor darkGrayColor] CGColor];
    self.screenshotView.layer.borderWidth = 2.;
    
    [self.captureButton.layer setCornerRadius:20.];
    [self.captureButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [self.captureButton.layer setShadowRadius:0.];
    [self.captureButton.layer setShadowOffset:CGSizeMake(0., 0.)];
    [self.captureButton.layer setShadowOpacity:.5];

    
    self.imageView.userInteractionEnabled = YES;
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scaleImage:)];
    [self.imageView addGestureRecognizer:pinchGestureRecognizer];
    pinchGestureRecognizer.delegate = self;
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panImage:)];
    [self.imageView addGestureRecognizer:panGestureRecognizer];
    panGestureRecognizer.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scaleImage:(UIPinchGestureRecognizer *)recognizer {
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    recognizer.scale = 1;
}

- (IBAction)panImage:(UIPanGestureRecognizer *)recognizer {
    if([recognizer state] == UIGestureRecognizerStateBegan) {
        
        firstX = [[recognizer view] center].x;
        firstY = [[recognizer view] center].y;
    }
    
    CGPoint translation = [recognizer translationInView:[self.imageView superview]];
    
    [self.imageView setCenter:CGPointMake(translation.x + firstX, translation.y + firstY)];
}


- (IBAction)takePhoto:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)selectPhoto:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    self.detailItem.fullImage = UIImageJPEGRepresentation(chosenImage, 0.0);
    
    [[DataAccess sharedInstance] saveContext];
//    NSError *error = nil;
//    if (![context save:&error]) {
//        // Replace this implementation with code to handle the error appropriately.
//        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//        abort();
//    }


    [picker dismissViewControllerAnimated:YES completion:NULL];
    [self.parentViewController setEditing:NO animated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    self.detailItem.fullImage = self.fullImageBackup;
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [self.parentViewController setEditing:NO animated:YES];
    [self configureView];
}

- (IBAction)didPressCaptureButton:(UIButton *)sender {
    
    float imageScale = sqrtf(powf(self.imageView.transform.a, 2.f) + powf(self.imageView.transform.c, 2.f));
    
    [self captureScreenshot:imageScale imageTranslationX:self.imageView.frame.origin.x imageTranslationY:self.imageView.frame.origin.y];
}

# pragma mark - private methods

- (void)captureScreenshot:(CGFloat)imageScale imageTranslationX:(CGFloat)imageTranslationX imageTranslationY:(CGFloat)imageTranslationY {
    
    //Image Size
    CGSize captureSize = CGSizeMake(self.screenshotView.frame.size.width, self.screenshotView.frame.size.height);
    
    //Begin Graphics Context
    UIGraphicsBeginImageContextWithOptions(captureSize, YES, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //Translate
    CGContextTranslateCTM(context, -self.screenshotView.frame.origin.x + imageTranslationX, -self.screenshotView.frame.origin.y + imageTranslationY );
    
    //Scale
    CGContextScaleCTM(context, imageScale, imageScale);
    
    //Render
    [self.imageView.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    //End Graphics Context
    UIGraphicsEndImageContext();
    
    //Store Screenshot
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"image.png"]; //Add the file name
    NSData *pngData = UIImagePNGRepresentation(img);
    
    [[DataAccess sharedInstance] storeScreenshotForData:self.detailItem screenshotData:pngData scale:imageScale translationX:imageTranslationX translationY:imageTranslationY];
    
    //Print to file for testing purposes only
    [UIImagePNGRepresentation(img)  writeToFile:filePath atomically:YES];
    
    [self flashScreen];
    
    [self updateScreenshotBadgeValue];
}

- (void)updateScreenshotBadgeValue {
    [self.tabBarDelegate incrementTabBarBadgeValue];
}

- (void)flashScreen {
    //make the view if we haven't already and add it as a subview
    [self.screenshotView setAlpha:1.0f];
    [self.screenshotView setBackgroundColor:[UIColor blackColor]];
    //flash animation code
    [UIView beginAnimations:@"flash screen" context:nil];
    [UIView setAnimationDuration:0.8f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    [self.screenshotView setBackgroundColor:[UIColor clearColor]];
    
    [UIView commitAnimations];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    if (editing) {
        self.fullImageBackup = self.detailItem.fullImage;
        self.detailItem.fullImage = nil;
    } else if (!self.detailItem.fullImage) {
        self.detailItem.fullImage = self.fullImageBackup;
    }
    [self configureView];
}


@end
