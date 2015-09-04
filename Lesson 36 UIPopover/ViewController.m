
//  ViewController.m
//  Lesson 36 UIPopover
//
//  Created by Nik on 03.09.15.
//  Copyright (c) 2015 Nik. All rights reserved.
//

#import "ViewController.h"
#import "NSDetailsVC.h"

@interface ViewController ()<UIPopoverControllerDelegate>

@property (strong,nonatomic) UIPopoverController* popover;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) showDetailsInModal:(UIViewController*)vc{
    
    
    [self presentViewController:vc animated:YES completion:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0  * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });        }];
}

- (IBAction)actionAdd:(id)sender {
    
    NSDetailsVC* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"NSDetailsVC"];
    
    
    if  (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        
        [self showController:vc inPopoverFromButton:sender];
        
    }
    
    else{
        
        [self showDetailsInModal:vc];
        
    }
    
    
}

- (IBAction)actionPressMe:(UIButton *)sender {
    
    
    
    NSDetailsVC* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"NSDetailsVC"];
    
    
    if  (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        
        [self showController:vc inPopoverFromButton:sender];
        
        
       }
    
    else{
        
        [self showDetailsInModal:vc];
        
    }

    
    
    
    
}
#pragma delegate Popover

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    self.popover = nil;
}
#pragma mark - MyMethods 
- (void) showController:(UIViewController*) vc inPopoverFromButton:(id) sender{
    
    if (!sender) {
        return;
    }
    
    UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:vc];
    
    UIPopoverController* popover = [[UIPopoverController alloc]initWithContentViewController:nav];
    
    if([sender isKindOfClass:[UIBarButtonItem class]]){
       
        [popover presentPopoverFromBarButtonItem:sender
                        permittedArrowDirections:UIPopoverArrowDirectionAny
                                        animated:YES];
        
        
    } else if ([sender isKindOfClass:[UIButton class]]){
        
        
        [popover presentPopoverFromRect:[(UIButton*) sender frame ]
                                 inView:self.view
               permittedArrowDirections:UIPopoverArrowDirectionLeft | UIPopoverArrowDirectionRight
                               animated:YES
         ];

        
    }
    
  
    
    nav.preferredContentSize = CGSizeMake(300,300);
    
    // popover.popoverContentSize = CGSizeMake(300,300);
    
    popover.delegate = self;
    self.popover = popover;

    
}

#pragma mark - Segue

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSLog(@"segue - %d  %@",segue.identifier,NSStringFromClass([segue.destinationViewController class]));
}
@end
