//
//  ViewController.m
//  BaiduMap_IOSSDKDemo
//
//  Created by devzkn on 07/10/2016.
//  Copyright © 2016 DevKevin. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()<BMKMapViewDelegate,BMKPoiSearchDelegate>

@property (nonatomic,weak) BMKMapView *mapView;
@property (nonatomic,strong) BMKPoiSearch *poisearch;

@end

@implementation ViewController

- (BMKPoiSearch *)poisearch{
    if (nil == _poisearch) {
        BMKPoiSearch *tmpView = [[BMKPoiSearch alloc]init];
        _poisearch = tmpView;
    }
    return _poisearch;
}

- (BMKMapView *)mapView{
    if (nil == _mapView) {
        BMKMapView *tmpView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, KMainScreenWidth, KMainScreenHeight)];
        _mapView = tmpView;
        // 设置地图级别
        [_mapView setZoomLevel:13];
        [tmpView setMapType:BMKMapTypeStandard];
//        [tmpView setTrafficEnabled:YES];
//        [tmpView setBaiduHeatMapEnabled:YES];
        _mapView.isSelectedAnnotationViewFront = YES;
        [self.view addSubview: tmpView];
    }
    return _mapView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self mapView];
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    addBtn.center = self.view.center;
    [addBtn addTarget:self action:@selector(poiSearchInCity) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    self.poisearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    self.poisearch.delegate = nil; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)poiSearchInCity{
    int curPage = 0;
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    citySearchOption.pageIndex = curPage;
    citySearchOption.pageCapacity = 10;
    citySearchOption.city= @"北京";
    citySearchOption.keyword = @"餐厅";
    BOOL flag = [self.poisearch poiSearchInCity:citySearchOption];
    if(flag)
    {
//        _nextPageButton.enabled = true;
        NSLog(@"城市内检索发送成功");
    }
    else
    {
//        _nextPageButton.enabled = false;
        NSLog(@"城市内检索发送失败");
    }
}

#pragma mark implement BMKSearchDelegate  POI包含四方面信息,名称、类别、经度纬度、附近的酒店饭店商铺等信息。
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
    // 清楚屏幕中所有的annotation
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    
    if (error == BMK_SEARCH_NO_ERROR) {//检索结果正常返回
        for (int i = 0; i < result.poiInfoList.count; i++) {///// poiInfoList POI列表，成员是BMKPoiInfo
            BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:i];/////POI信息类
            //创建新的annotation 模型
            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
            item.coordinate = poi.pt;
            item.title = poi.name;
            [_mapView addAnnotation:item];
            if(i == 0)
            {
                //将第一个点的坐标移到屏幕中央
                _mapView.centerCoordinate = poi.pt;
            }
        }
    } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        NSLog(@"起始点有歧义");
    } else {
        // 各种情况的判断。。。
    }
}

@end
