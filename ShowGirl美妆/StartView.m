//
//  StartView.m
//  ShowGirl美妆
//
//  Created by 徐 军 on 13-8-10.
//  Copyright (c) 2013年 徐 军. All rights reserved.
//

#import "StartView.h"

#import "HoldBeautyView.h"
#import "ImageEditingView.h"
#import "SetupViewController.h"
#import "DeclareTimePickerViewController.h"
#import "DeclareTimePickerViewController.h"
#import "IphoneScreen.h"

#import "YouMiWall.h"

@interface StartView ()

@end

@implementation StartView

@synthesize holdBeautyVeiwController;
@synthesize setupViewController;
@synthesize staticLabel1, staticLabel2, staticLabel3;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
       /* [NSTimer scheduledTimerWithTimeInterval:3.0
                                         target:self
                                       selector:@selector(targetMethodCheckTime:)
                                       userInfo:[self userInfo]
                                        repeats:YES];
        */
        
        if ([self getCurrentHour] <SHOWTIME_END) {
            isRemindedDeclare = NO;
        }else{
            
            isRemindedDeclare = YES;
            
        }
        
        isRemindedMission = NO;
        
        isDeclare = NO;
        
        
    }
    return self;
}

- (NSDictionary *)userInfo {
    return @{ @"Check time" : [NSDate date] };
}


- (IBAction)setup:(id)sender {
    
    [self presentViewController:setupViewController animated:YES completion:NULL];

    
}

-(void)targetMethodCheckTime:(NSTimer*)theTimer
{
    

    
    /*
    //另一天后，自动置为未宣言
    if ([self getCurrentDay] != CurrentDay) {
        isRemindedDeclare = NO;
        isRemindedMission = NO;
        isDeclare = NO;
    }
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDate *declareTime = [defaults valueForKey:DEFAULT_DECLARE_TIME];
    NSDate *missionTime = [defaults valueForKey:DEFAULT_MISSION_TIME];
    if (missionTime == nil && declareTime == nil) {
        return;
    }
    
    
    NSDate *CurrentTime = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* compsUser, *compsCurrent;
    compsCurrent =[calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit)fromDate:CurrentTime];
    
    if (!isRemindedDeclare && [defaults boolForKey:DEFAULTS_IS_DECLARE_TIME]&&declareTime!=nil) {
        
        compsUser =[calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit)fromDate:declareTime];
      
        if (([compsUser hour] == [compsCurrent hour]) && ([compsUser minute] == [compsCurrent minute])) {
            [self showAlert:@"你今天该做宣言了"];
            isRemindedDeclare = YES;
        }
       
      
        if ([self getCurrentHour]>SHOWTIME_END && [defaults boolForKey:DEFAULTS_IS_DECLARE_TIME] && isRemindedDeclare==NO) {
            [self showAlert:@"你今天该做宣言了"];
            isRemindedDeclare = YES;
        }
    }
    
    if (!isRemindedMission && [defaults boolForKey:DEFAULTS_IS_MISSION_TIME]&& missionTime != nil)
    {
        compsUser =[calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit)fromDate:missionTime];
    
        if (([compsUser hour] == [compsCurrent hour]) && ([compsUser minute] == [compsCurrent minute])) {
            [self showAlert:@"你今天该做美丽任务了"];
            isRemindedMission = YES;
        } 
    }
    */
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    //是否为新装的应用，进行初始化
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults stringForKey:@"isNewApp"]==nil) {
        [defaults setBool:YES forKey:DEFAULTS_IS_DECLARE_TIME];
        [defaults setBool:YES forKey:DEFAULTS_IS_MISSION_TIME];
        
        //设置默认的提醒时间
        NSDateComponents *components = [[NSDateComponents alloc] init];
        NSCalendar* calendar = [NSCalendar currentCalendar];
       
        [components setHour:7];
        [components setMinute:0];
        [components setSecond:0];
        NSDate *fireDate = [calendar dateFromComponents:components];
        [defaults setObject:fireDate forKey:DEFAULT_DECLARE_TIME];
        [defaults synchronize];
     
        
        [components setHour:21];
        [components setMinute:0];
        [components setSecond:0];
        NSDate *fireDate1 = [calendar dateFromComponents:components];
        [defaults setObject:fireDate1 forKey:DEFAULT_MISSION_TIME];
        [defaults synchronize];

        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        
        //设置不是第一次起动
        [defaults setObject:@"Not New" forKey:@"isNewApp"];
        [defaults synchronize];
    }
    
    
    //定时闹钟
    NSDate *declareTime = [defaults valueForKey:DEFAULT_DECLARE_TIME];
    
    if ([defaults boolForKey:DEFAULTS_IS_DECLARE_TIME]&&declareTime)
    {
        UILocalNotification *declareNotification=[[UILocalNotification alloc] init];
        if (declareNotification!=nil)
        {
            
            declareNotification.fireDate = declareTime;
            declareNotification.repeatInterval = kCFCalendarUnitDay;
            declareNotification.timeZone=[NSTimeZone defaultTimeZone];
            declareNotification.alertBody = NSLocalizedString(@"Declare time is on", @"");
            
            NSDictionary* info = [NSDictionary dictionaryWithObject:@"IsDeclareTime" forKey:@"DeclareOrMissionTime"];
            declareNotification.userInfo = info;
            
            [[UIApplication sharedApplication] scheduleLocalNotification:declareNotification];
            
        }
    }
    
    NSDate *missioTime = [defaults valueForKey:DEFAULT_MISSION_TIME];
    if ([defaults boolForKey:DEFAULTS_IS_MISSION_TIME]&&missioTime)
    {
        UILocalNotification *missionNotification=[[UILocalNotification alloc] init];
        if (missionNotification!=nil)
        {
            
            missionNotification.fireDate = missioTime;
            missionNotification.repeatInterval = kCFCalendarUnitDay;
            missionNotification.timeZone=[NSTimeZone defaultTimeZone];
            missionNotification.alertBody = NSLocalizedString(@"Mission time is on", @"");
            
            NSDictionary* info = [NSDictionary dictionaryWithObject:@"IsMissionTime" forKey:@"DeclareOrMissionTime"];
            missionNotification.userInfo = info;
            
            [[UIApplication sharedApplication] scheduleLocalNotification:missionNotification];
            
        }
    }
    
    
    CurrentDay =[self getCurrentDay];
    
    imageEditing = [[ImageEditingView alloc] initWithNibName:@"ImageEditingView" bundle:nil];
    

    
    
    self.holdBeautyVeiwController = [[HoldBeautyView alloc] initWithNibName:@"HoldBeautyView" bundle:nil];
    
    if (self.holdBeautyVeiwController == nil) {
        NSLog(@"holdBeautyVeiwController == nil");
    }
    
    self.setupViewController = [[SetupViewController alloc] initWithNibName:@"SetupViewController" bundle:nil];
    
    if (self.setupViewController == nil) {
        NSLog(@"setupViewController == nil");
    }
    
    

    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL isFirstTime = [defaults boolForKey:@"isFirstTimeUse"];
    if (isFirstTime == NO) {
        
        [defaults setBool:YES forKey:@"isFirstTimeUse"];
        
    }else
    {
        staticLabel1.hidden = YES;
        staticLabel2.hidden = YES;
        staticLabel3.hidden = YES;
        
    }


    
}

//显示每日养言界面
- (IBAction)ShowHold:(id)sender
{
    NSLog(@"Into Show hold view....");
    
    //[self dismissViewControllerAnimated:NO completion:(NULL)];
    [self presentViewController:self.holdBeautyVeiwController animated:YES completion:NULL];
    
}

//显示每日宣言界面
- (IBAction)showDeclaration:(id)sender
{
    NSLog(@"Into Show declaraion....");
   
   [self doTakePhoto:NULL];
    

    
}


- (IBAction)youMiAd:(id)sender
{
    [YouMiWall showOffers:NO didShowBlock:^{
        NSLog(@"有米积推荐已显示");
    } didDismissBlock:^{
        NSLog(@"有米积推荐已退出");
    }];
    
}


- (IBAction)doTakePhoto:(id)sender
{
    /*
    //一天只能宣言一次
    if (isDeclare && setupViewController.isEveryDayDeclare.on) {
        [self showAlert:@"你今天已经做过宣言了！"];
        return;
    }
     */

    /*
     //限制宣言时间为早上
     if (self.getCurrentHour>SHOWTIME_START && self.getCurrentHour <=SHOWTIME_END)
     {
     NSLog(@"The time is between 5 to 9 o'clock!");
     } else
     {
     NSLog(@"The time is not between 5 to 9 o'clock!");
     [self showAlert:@"已经不是早上了，明天早点来哦!"];
     return;
     
     }
     */
    

    //调用自定义的图片处理控制器
    
       CustomImagePickerController* _picker =[[CustomImagePickerController alloc] init];
        //判断是否有相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            [_picker setSourceType:UIImagePickerControllerSourceTypeCamera];
            _picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            [_picker setIsDeclare:YES];
        }else{
            [_picker setIsSingle:YES];
            [_picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        }
        //指向他的委托函数？？
        [_picker setCustomDelegate:self];
 

     
    
    //调起pick处理器，及其view
    [self presentViewController:_picker animated:YES completion:NULL];
    
}


- (void)cameraPhoto:(UIImage *)image  //选择完图片
{
    
 
      ImageFilterProcessViewController*  fitler = [[ImageFilterProcessViewController alloc] init];
        [fitler setDelegate:self];
    fitler.currentImage = image;
    [self presentViewController:fitler animated:YES completion:NULL];
    
}
- (void)imageFitlerProcessDone:(UIImage *)image //图片处理完
{
    
    [imageEditing setEditImage:image];
    [imageEditing setImageEditingDelegate:self];
    [self presentViewController:imageEditing animated:YES completion:NULL];
    
    isDeclare = YES;
}


-(void)showAlert:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:nil
                          message:msg
                          delegate:self
                          cancelButtonTitle:@"确定"
                          otherButtonTitles: nil];
    [alert show];
}


- (void)cancelCamera
{
    isDeclare = NO;
}

- (IBAction)backToStart:(id)sender
{
    
    [self dismissViewControllerAnimated:NO completion:NULL];
    
}

//暂时没用
- (void)imageEditingFinishReturn
{
    NSLog(@"Get delegate imageEditingFinishReturn");
    //[self backToStart:NULL];
}


- (NSInteger)getCurrentDay
{
    //查看现在时间， 只在早上5点到9点之间开启
    NSDate* date = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* comps;
    
    // 年月日获得
    
    comps =[calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit)
            
                       fromDate:date];
    
    NSInteger day = [comps day];
    return day;
}

- (NSInteger)getCurrentHour
{
    //查看现在时间， 只在早上5点到9点之间开启
    NSDate* date = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* comps;
    
    
    //当前的时分秒获得
    comps =[calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit |NSSecondCalendarUnit)fromDate:date];
    NSInteger hour = [comps hour];
    
    return hour;
}



@end
