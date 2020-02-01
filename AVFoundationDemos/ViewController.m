//
//  ViewController.m
//  AVFoundationDemos
//
//  Created by 丁侃 on 2020/1/22.
//  Copyright © 2020 丁侃. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *mainView;
@property (nonatomic, strong) NSArray *datas;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.datas = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AVFDemo.plist" ofType:nil]];
 
    [self.view addSubview:self.mainView];
    NSLog(@"%@",self.datas);
}


#pragma dataSouce,dalegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    NSString *des = self.datas[indexPath.row];
    cell.textLabel.text = des;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Class tmp = NSClassFromString(self.datas[indexPath.row]);
    UIViewController *vc = [[tmp alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}

-(UITableView *)mainView{
    if (!_mainView) {
        _mainView = [[UITableView alloc]initWithFrame:self.view.bounds];
        _mainView.dataSource = self;
        _mainView.delegate = self;
        _mainView.backgroundColor = [UIColor whiteColor];
        [_mainView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _mainView;
}

@end
