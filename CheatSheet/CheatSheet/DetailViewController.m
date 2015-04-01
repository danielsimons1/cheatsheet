//
//  DetailViewController.m
//  CheatSheet
//
//  Created by Daniel Simons on 3/30/15.
//  Copyright (c) 2015 UnofficialCalculators. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem title];
        self.navigationItem.title = self.detailItem.title;
        if (self.detailItem.doc.fullImage) {
            self.imageView.image = [UIImage imageWithData:self.detailItem.doc.fullImage];
            self.uploadPhotoView.hidden = YES;
            self.imageView.hidden = NO;
        } else {
            self.imageView.hidden = YES;
            self.uploadPhotoView.hidden = NO;
            [self.selectPhotoButton.layer setCornerRadius:6.];
            [self.takePhotoButton.layer setCornerRadius:6.];
        }
    }
    
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

- (IBAction)scaleImage:(UIPinchGestureRecognizer *)recognizer {
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
    
    if (! self.detailItem.doc) {
        self.detailItem.doc = [NSEntityDescription insertNewObjectForEntityForName:@"CSDoc" inManagedObjectContext:self.managedObjectContext];
    }
    
    self.detailItem.doc.fullImage = UIImagePNGRepresentation(chosenImage);
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
//    NSError *error = nil;
//    if (![context save:&error]) {
//        // Replace this implementation with code to handle the error appropriately.
//        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//        abort();
//    }


    [picker dismissViewControllerAnimated:YES completion:NULL];
    [self configureView];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [self configureView];
}


@end
