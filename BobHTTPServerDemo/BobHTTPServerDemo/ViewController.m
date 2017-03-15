//
//  ViewController.m
//  BobHTTPServerDemo
//
//  Created by 吴豹 on 17/3/15.
//  Copyright © 2017年 stnts. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *myText;
//通过safari传过来的值
@property (weak, nonatomic) IBOutlet UILabel *resposeLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)writeServer:(UIButton *)sender {
    
    [self commonWriteToServer];
    
}
- (IBAction)jumpSafari:(UIButton *)sender {
    [self commonWriteToServer];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://localhost:12345/apps"]];
}

- (void)commonWriteToServer {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *webPaths = [HOME_DOCUMENT stringByAppendingString:@"/Web"];
    NSString *filePath = [webPaths stringByAppendingPathComponent:@"apps"];
    // 4.查找文件，如果不存在，就创建一个文件
    if (![fileManager fileExistsAtPath:filePath]) {
        [fileManager createFileAtPath:filePath contents:nil attributes:nil];
    }
    
    NSString *newText = [NSString stringWithFormat:@"这里面是看到的值(\"%@\")",self.myText.text];
 //写入服务器文件中
    [newText writeToFile:filePath atomically:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self textFieldShouldReturn:self.myText];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
