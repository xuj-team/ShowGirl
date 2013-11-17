//
//  ChooseStringViewController.m
//  ShowGirl美妆
//
//  Created by 徐 军 on 13-10-20.
//  Copyright (c) 2013年 徐 军. All rights reserved.
//

#import "ChooseStringViewController.h"

#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f
#define DEFAULT_CHOOSE_STRING_KEY  @"DefaultChooseString"


@interface ChooseStringViewController ()

@end

static NSString *CellTableIdentifier = @"CellTableIdentifier";

@implementation ChooseStringViewController

@synthesize declareTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
   // [self registerClass:[CustomCell class] forCellReuseIdentifier:@"Cell1"];

    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    self.dataSourceArray = [defaults objectForKey:DEFAULT_CHOOSE_STRING_KEY];
    if (self.dataSourceArray == nil)
    {
        self.dataSourceArray = [NSMutableArray arrayWithObjects:
                                [NSDictionary dictionaryWithObjectsAndKeys:
                                 NSLocalizedString(@"DeclareString_1", @""), @"kDeclareStringKey",
                                 self.SelectDeclare, @"KSelectKey",
                                 nil],
                                [NSDictionary dictionaryWithObjectsAndKeys:
                                 NSLocalizedString(@"DeclareString_2", @""),@"kDeclareStringKey",
                                 self.SelectDeclare, @"KSelectKey",
                                 nil],
                                [NSDictionary dictionaryWithObjectsAndKeys:
                                 NSLocalizedString(@"DeclareString_3", @""), @"kDeclareStringKey",
                                 self.SelectDeclare, @"KSelectKey",
                                 nil],
                                nil];
        [defaults setObject:self.dataSourceArray forKey:DEFAULT_CHOOSE_STRING_KEY];
        [defaults synchronize];
        
    }

    //currentSelect = [defaults integerForKey:@"initSelect"];
   // if (currentSelect == 0) {
  //      currentSelect = 1;
   // }

    
   // [defaults setInteger:initSelect forKey:@"initSelect"];
    
    // [defaults synchronize];
    
}


- (UITableViewCell*) SelectDeclare
{
    
    
    return NULL;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dataSourceArray count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell1";
    
    [tableView registerClass:[UITableViewCell class]  forCellReuseIdentifier:CellIdentifier];

    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...

    
	cell.textLabel.text = [[self.dataSourceArray objectAtIndex:indexPath.row] objectForKey:@"kDeclareStringKey"];

    cell.imageView.image = [UIImage imageNamed:@"btn_back.png"];
   
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    currentSelect = [defaults integerForKey:@"current"];
    
    if (indexPath.row == currentSelect) {
        [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        cell.imageView.image = [UIImage imageNamed:@"camera_btn_ok.png"];

    }
    

    
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
 // 列寬
 CGFloat contentWidth = self.view.frame.size.width;

 
 // 該行要顯示的內容
 NSString *content = [[self.dataSourceArray objectAtIndex:indexPath.row] objectForKey:@"kDeclareStringKey"];
    
    CGSize size = [content boundingRectWithSize:CGSizeMake(contentWidth, 500) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:30]}  context:nil].size;
    // 這裏返回需要的高度
    return size.height;
 
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    
    cell.imageView.image = [UIImage imageNamed:@"camera_btn_ok.png"];
 
    
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setInteger:indexPath.row forKey:@"current"];
    
    [defaults synchronize];
    

    
}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.imageView.image = [UIImage imageNamed:@"btn_back.png"];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/
/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

- (IBAction)finishReturn:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
