//
//  ViewController.h
//  TestWappImagepicker
//
//  Created by BacancyMac-i7 on 05/11/15.
//  Copyright © 2015 BacancyMac-i7. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIScrollViewDelegate,UIImagePickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
   IBOutlet UIScrollView *scrollImage,*scrollThumb;
    NSMutableArray *arrImages;
    UIImagePickerController *picker;
    NSData *imageData;
    NSInteger pagenumber;
   IBOutlet UIButton *btnAdd;

}


@end

