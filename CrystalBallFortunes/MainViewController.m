//
//  MainViewController.m
//  CrystalBallFortunes
//
//  Created by Thuy Copeland on 3/26/13.
//  Copyright (c) 2013 Thuy Copeland. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

NSArray *fortunesArray;
int tries;

@implementation MainViewController

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
    // Do any additional setup after loading the view from its nib.

    // set up the array
    fortunesArray = [[NSArray alloc]initWithObjects: @"It is certain",  @"It is decidedly so", @"Without a doubt", @"Yes – definitely",@"You may rely on it",@"As I see it, yes",@"Most likely", @"Outlook good",@"Yes",@"Signs point to yes",@"Reply hazy, try again",@"Ask again later",@"Better not tell you now",@"Cannot predict now",@"Concentrate and ask again",@"Don't count on it",@"My reply is no",@"My sources say no",@"Outlook not so good", @"Very doubtful", nil];
    tries = 0;
    
    
    // check to see if user is over freebie limits
    BOOL overage = [[NSUserDefaults standardUserDefaults]boolForKey:@"freeloader"];
    if(overage)
    {
        // warn user they are out of freebies.
        [self upgradeIt];
        self.fortuneBtn.hidden = YES;
    }

}
- (void)upgradeIt
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!"
                                                    message:@"Out of freebies. Purchase upgrade."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil,nil];
    [alert show];
}
- (void)runFortune
{
    if(tries <3)
    {
        // count the number of times the user has tried this app
        tries ++;
        
        // randomly choose a number 
        int randomize = arc4random_uniform([fortunesArray count]);
        
        // save the fortune
        NSString *myFortune = [fortunesArray objectAtIndex:randomize];
        
        [self.fortuneText setText:myFortune];
        
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:@"freeloader"];
        [self upgradeIt];
    }
}

- (IBAction)fortuneBtn:(id)sender
{
    [self runFortune];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
