//
//  AddFileViewController.m
//  PoemKing
//
//  Created by Leon Guo on 2018/11/5.
//  Copyright © 2018 Leon Guo. All rights reserved.
//

#import "AddFileViewController.h"
#import "Masonry.h"
#import "HTTPServer.h"
#import "MyHTTPConnection.h"
#import "LGUtils.h"

@interface AddFileViewController ()

@property (assign, nonatomic) BOOL isShowHttpServerAddress;
@property (strong, nonatomic) UILabel *uploadTipLabel;
@property (strong, nonatomic) UILabel *serverAddressLabel;
@property (strong, nonatomic) HTTPServer *httpServer;


@end

@implementation AddFileViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"添加文件";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initialPage];
    [self initialHttpFileServer];
    
}

- (void)initialHttpFileServer{
    
    _httpServer = [[HTTPServer alloc] init];
    [_httpServer setPort:50517];
    [_httpServer setType:@"_http._tcp."];
    
    NSString *webResourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"web"];
    [_httpServer setDocumentRoot:webResourcePath];
    [_httpServer setConnectionClass:[MyHTTPConnection class]];
    NSError *err;
    if([_httpServer start:&err]){
         NSLog(@"start server success in port %d %@",[_httpServer listeningPort],[_httpServer publishedName]);
    }else{
        NSLog(@"%@",err);
    }
    NSString *ipStr = [LGUtils getIpAddresses1];
    NSLog(@"ip address : %@",ipStr);
    
}

- (void)initialPage{
    
    UIView *selfAddView = [UIView new];
    UIView *artificialServiceView = [UIView new];
    
    
    [self.view addSubview:selfAddView];
    [self.view addSubview:artificialServiceView];
    
    selfAddView.backgroundColor = [UIColor lightGrayColor];
    artificialServiceView.backgroundColor = [UIColor lightGrayColor];
    
    [selfAddView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(10);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-10);
        make.centerY.mas_equalTo(self.view.mas_centerY).mas_offset(-100);
        make.height.mas_equalTo(160);
    }];
    
    [artificialServiceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(10);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-10);
        make.centerY.mas_equalTo(self.view.mas_centerY).mas_offset(100);
        make.height.mas_equalTo(160);
    }];
    
}



@end
