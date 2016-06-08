//
//  GuideViewController.m
//  GuidePage
//
//  Created by Fred on 13-11-26.
//  Copyright (c) 2013年 PwC. All rights reserved.
//

#import "iPadGuideView.h"

@interface iPadGuideView ()

@end

@implementation iPadGuideView
{
    UIPageControl *_pageControl;
    UIScrollView *_scrollView;
    UIButton *btn;
    NSUInteger imgCount;
}

@synthesize isShowing = _isShowing;

- (id)init
{
    _isShowing = NO;
    NSString *fileExt = @"png";
    NSString *folderName = UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) ? @"iPadGuideImages/Vertical" : @"iPadGuideImages/Horizontal";
    
    //CGSize size=[[UIScreen mainScreen] bounds].size;
    CGFloat screenWidth=768;
    CGFloat screenHeight=1024;
    
    UIInterfaceOrientation orientation=  [UIApplication sharedApplication].statusBarOrientation;
    if(orientation == UIDeviceOrientationLandscapeLeft || orientation ==UIDeviceOrientationLandscapeRight)
    {
        screenWidth=1024;
        screenHeight=768;
    }
    
    self = [super initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    if (self)
    {
        NSArray *arrImages=[[NSBundle mainBundle] pathsForResourcesOfType:fileExt inDirectory:folderName];
        imgCount=[arrImages count];
        
        if([self CheckGuidePageDisplay:fileExt FolderName:folderName])
        {
            _scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
            _scrollView.contentSize = CGSizeMake(screenWidth*imgCount, screenHeight);
            _scrollView.showsHorizontalScrollIndicator=NO;
            _scrollView.pagingEnabled=YES;
            _scrollView.bounces=NO;
            _scrollView.delegate = self;
            
            for(int i=0;  i < imgCount ; i++)
            {
                UIImage *img = [UIImage imageWithContentsOfFile:[arrImages objectAtIndex:i]];
                CGFloat imageWidth=img.size.width;
                CGFloat imageHeight=img.size.height;
                
                UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenWidth*imageHeight/imageWidth)];
                [imageView setImage:img];
                imageView.center=CGPointMake(screenWidth*i+screenWidth/2, screenHeight/2);
                imageView.contentMode=UIViewContentModeScaleAspectFit;
                [_scrollView addSubview:imageView];
                
                if(i == (imgCount-1))
                {
                    btn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 480, 76)];
                    btn.center=CGPointMake(screenWidth*i+screenWidth/2, screenHeight-250);
                    [btn setImage:[UIImage imageNamed:@"iPad-EnterButton.png"] forState:UIControlStateNormal];
                    [btn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
                    [_scrollView addSubview:btn];
                }
 
                [self addSubview:_scrollView];
            }
            _isShowing = YES;
        }
        else
        {
            self=Nil;
        }
    }
    
    return self;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGSize size=[[UIScreen mainScreen] bounds].size;
    CGFloat screenWidth=size.width;
    
    int page = scrollView.contentOffset.x/screenWidth;
    _pageControl.currentPage = page;
}
 
-(BOOL)CheckGuidePageDisplay:(NSString *)fileExt FolderName:(NSString *)folderName
{
    BOOL returnValue = NO;

    if(imgCount > 0)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"app.plist"];
        NSMutableDictionary *dictPlist = [[NSMutableDictionary alloc] init];
        
        NSFileManager *fileManager=[NSFileManager defaultManager];
        if(![fileManager fileExistsAtPath:filePath])
        {
            [fileManager createFileAtPath:filePath contents:Nil attributes:Nil];
            [dictPlist setObject:@"" forKey:@"BundleVersion"];
            [dictPlist writeToFile:filePath atomically:YES];
        }
        else
        {
            dictPlist = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
        }
        
        //New Version
        NSString *newVersion=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        NSLog(@"New Version is %@", newVersion);
        
        //Old Version
        NSString *oldVersion=[dictPlist objectForKey:@"BundleVersion"];
        NSLog(@"Old Version is %@", oldVersion);
        
        if(![newVersion isEqualToString:oldVersion])
        {
            [dictPlist setObject:newVersion forKey:@"BundleVersion"];
            [dictPlist writeToFile:filePath atomically:YES];
            
            returnValue=YES;
        }
    }
    
    return returnValue;
}

-(void)btnOnClick:(UIButton *)button
{
    [self removeFromSuperview];
    _isShowing = NO;
}


@end
