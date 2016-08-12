//
//  ViewController.m
//  TestWappImagepicker
//
//  Created by BacancyMac-i7 on 05/11/15.
//  Copyright © 2015 BacancyMac-i7. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

-(AppDelegate *)appDelegate
{
    return (AppDelegate *) [[UIApplication sharedApplication] delegate];
}

- (void)viewDidLoad
{
    


    [super viewDidLoad];
   
    arrImages=[[NSMutableArray alloc] init];
    pagenumber=0;

    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    NSLog(@"AppDelegate Test kaushik == %@",[self appDelegate].testArray);
}

-(IBAction) imagepickerData:(id)sender
{
    [self startLibraryPickerFromViewController:self usingDelegate:self];

}
-(void)setImageTo:(id)sender
{
    CGRect frame = scrollImage.frame;
    frame.origin.x = frame.size.width * [[sender view] tag];
    frame.origin.y = 0;
    [scrollImage scrollRectToVisible:frame animated:YES];
}
- (BOOL)startLibraryPickerFromViewController:(UIViewController*)controller usingDelegate:(id<UIImagePickerControllerDelegate>)delegateObject
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        picker = [[UIImagePickerController alloc]init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = YES;
        picker.delegate = self;
        [controller presentViewController:picker animated:YES completion:^{
            
        }];
        
    }
    return YES;
}

-(UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
   
    
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)imagePickerController:(UIImagePickerController *)picker1 didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"Working on imagePickerController");
    NSLog(@"LogSencod");
    [picker1 dismissViewControllerAnimated:YES completion:^{
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        [scrollImage.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
        [scrollThumb.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
        //store image into NSMutableArray
        [arrImages addObject:image];
         [scrollImage setContentSize:CGSizeMake(scrollImage.frame.size.width*[arrImages count], scrollImage.frame.size.height)];
        [scrollThumb setContentSize:CGSizeMake(90*([arrImages count]+1), scrollThumb.frame.size.height)];
        
        for (int cnt=0; cnt<arrImages.count; cnt++){
            
            UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake((scrollImage.frame.size.width*cnt)+10,10, scrollImage.frame.size.width-20, scrollImage.frame.size.height-20)];
            img.contentMode = UIViewContentModeScaleAspectFit;
            
            [img setImage:arrImages[cnt]];
            [scrollImage addSubview:img];
            
            
            UIImageView *imgThumb=[[UIImageView alloc] initWithFrame:CGRectMake((90*cnt)+10,0,80, 80)];
            imgThumb.contentMode = UIViewContentModeScaleToFill;
            imgThumb.tag=cnt;
            UITapGestureRecognizer *tapimg=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setImageTo:)];
            tapimg.numberOfTapsRequired=1;
            [imgThumb setUserInteractionEnabled:YES];
            [imgThumb addGestureRecognizer:tapimg];
            [imgThumb setImage:arrImages[cnt]];
            [scrollThumb addSubview:imgThumb];
            if (cnt==arrImages.count-1){
                btnAdd.backgroundColor=[UIColor redColor];
                btnAdd.frame=CGRectMake((90*(cnt+1))+10,0,80, 80);
                [scrollThumb addSubview:btnAdd];
            }
            
        }
        pagenumber=[arrImages count]-1;
        
      [scrollImage scrollRectToVisible:CGRectMake(scrollImage.contentSize.width - 1,scrollImage.contentSize.height - 1, 1, 1) animated:YES];
        [scrollThumb scrollRectToVisible:CGRectMake(scrollThumb.contentSize.width - 1,scrollThumb.contentSize.height - 1, 1, 1) animated:YES];
        
        imageData = UIImageJPEGRepresentation(image, 0.5);
        
    }];
}
-(IBAction)deleteAction:(id)sender
{
     NSLog(@"Working on deleteAction");
    if ([arrImages count]>0)
    {
        [scrollImage.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
        [scrollThumb.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
        if (arrImages.count==1)
        {
            [scrollThumb addSubview:btnAdd];
            btnAdd.frame=CGRectMake(10,0,80, 80);

        }

        [arrImages removeObjectAtIndex:pagenumber];
        [scrollImage setContentSize:CGSizeMake(scrollImage.frame.size.width*[arrImages count], scrollImage.frame.size.width)];
        [scrollThumb setContentSize:CGSizeMake(90*([arrImages count]+1), scrollThumb.frame.size.height)];
        for (int cnt=0; cnt<arrImages.count; cnt++)
        {
            UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake((scrollImage.frame.size.width*cnt)+10,10, scrollImage.frame.size.width-20, scrollImage.frame.size.height-20)];
            img.contentMode = UIViewContentModeScaleAspectFit;
            [img setImage:arrImages[cnt]];
            [scrollImage addSubview:img];
            UIImageView *imgThumb=[[UIImageView alloc] initWithFrame:CGRectMake((90*cnt)+10,0,80, 80)];
            imgThumb.contentMode = UIViewContentModeScaleToFill;
            imgThumb.tag=cnt;
            UITapGestureRecognizer *tapimg=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setImageTo:)];
            tapimg.numberOfTapsRequired=1;
            [imgThumb setUserInteractionEnabled:YES];
            [imgThumb addGestureRecognizer:tapimg];
            [imgThumb setImage:arrImages[cnt]];
            [scrollThumb addSubview:imgThumb];
            if (cnt==arrImages.count-1)
            {
                btnAdd.backgroundColor=[UIColor redColor];
                btnAdd.frame=CGRectMake((90*(cnt+1))+10,0,80, 80);
                [scrollThumb addSubview:btnAdd];
            }
        }
        pagenumber=[arrImages count]-1;
        [scrollImage scrollRectToVisible:CGRectMake(scrollImage.contentSize.width - 1,scrollImage.contentSize.height - 1, 1, 1) animated:YES];
        [scrollThumb scrollRectToVisible:CGRectMake(scrollThumb.contentSize.width - 1,scrollThumb.contentSize.height - 1, 1, 1) animated:YES];
    }

}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView==scrollImage) {
        CGFloat width = scrollView.frame.size.width;
        pagenumber= (scrollView.contentOffset.x + (0.5f * width)) / width;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
