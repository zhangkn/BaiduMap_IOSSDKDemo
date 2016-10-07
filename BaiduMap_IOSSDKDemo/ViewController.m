//
//  ViewController.m
//  BaiduMap_IOSSDKDemo
//
//  Created by devzkn on 07/10/2016.
//  Copyright © 2016 DevKevin. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()<BMKMapViewDelegate>

@property (nonatomic,weak) BMKMapView *mapView;

@end

@implementation ViewController

- (BMKMapView *)mapView{
    if (nil == _mapView) {
        BMKMapView *tmpView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, KMainScreenWidth, KMainScreenHeight)];
        _mapView = tmpView;
        self.view = tmpView;
    }
    return _mapView;
}

- (void)loadView{
    [self mapView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
