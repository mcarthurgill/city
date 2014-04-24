//
//  CTMapViewController.m
//  city
//
//  Created by Joseph McArthur Gill on 4/24/14.
//  Copyright (c) 2014 Joseph McArthur Gill. All rights reserved.
//

#import "CTMapViewController.h"

@interface CTMapViewController ()

@end

@implementation CTMapViewController

@synthesize mapView;
@synthesize tableview;
@synthesize searchBar;
@synthesize searchButton;
@synthesize nearbyResults;
@synthesize searchResults;

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
    searchBar.delegate = self;
    tableview.delegate = self;
    tableview.dataSource = self;
    mapView.delegate = self;

    nearbyResults = [[NSMutableArray alloc] init];
    searchResults = [[NSMutableArray alloc] init];

    [self setupMapAndLocationManager];
    [self queryGooglePlaces:@""];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tabBarController.navigationController setNavigationBarHidden:YES];
    MKCoordinateRegion region;
    region = MKCoordinateRegionMakeWithDistance(locationManager.location.coordinate,10000,10000);
    
    [mapView setRegion:region animated:YES];
}

- (void) viewWillDisappear:(BOOL)animated {
    [self resetSearchResults]; 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupMapAndLocationManager {
    self.mapView.delegate = self;
    
    // Ensure that you can view your own location in the map view.
    [self.mapView setShowsUserLocation:YES];
    
    locationManager = [[CLLocationManager alloc] init];
    
    [locationManager setDelegate:self];
    
    [locationManager setDistanceFilter:kCLDistanceFilterNone];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
}


- (BOOL) searchActivated {
    return (searchResults.count > 0 || searchBar.text.length > 0);
}


#pragma mark - MKMapView methods.

- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views {
    NSLog(@"didAddAnnotations");
}

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    [self scrollViewDidScroll:[[UIScrollView alloc] init]];
}

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    NSLog(@"regionDidChange");
    //Get the east and west points on the map so you can calculate the distance (zoom level) of the current map view.
    MKMapRect mRect = self.mapView.visibleMapRect;
    MKMapPoint eastMapPoint = MKMapPointMake(MKMapRectGetMinX(mRect), MKMapRectGetMidY(mRect));
    MKMapPoint westMapPoint = MKMapPointMake(MKMapRectGetMaxX(mRect), MKMapRectGetMidY(mRect));
    
    //Set your current distance instance variable.
    currenDist = MKMetersBetweenMapPoints(eastMapPoint, westMapPoint);
    
    //Set your current center point on the map instance variable.
    currentCentre = self.mapView.centerCoordinate;
}

- (NSMutableArray *)createAnnotationsFromArray:(NSMutableArray *)places
{
    [mapView removeAnnotations:mapView.annotations];
    NSMutableArray *annotations = [[NSMutableArray alloc] init];
    
    for (NSDictionary *item in places) {
        NSNumber *latitude = [[[item objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lat"];
        NSNumber *longitude = [[[item objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lng"];
        NSString *title = [item objectForKey:@"name"];

        CLLocationCoordinate2D coord;
        coord.latitude = latitude.doubleValue;
        coord.longitude = longitude.doubleValue;
        CTMapViewAnnotation *annotation = [[CTMapViewAnnotation alloc] initWithTitle:title AndCoordinate:coord];
        [annotations addObject:annotation];
    }
    return [annotations copy];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self searchActivated]) {
        return [searchResults count];
    }
    return [nearbyResults count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }

    if ([self searchActivated]) {
        [cell.textLabel setText:[[searchResults objectAtIndex:indexPath.row] objectForKey:@"name"]];
    } else {
        [cell.textLabel setText:[[nearbyResults objectAtIndex:indexPath.row] objectForKey:@"name"]];
    }
    
    return cell;
}

# pragma mark - Search Bar

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

-(void) queryGooglePlaces:(NSString *)name{
    NSLog(@"query google places");
    //NSString *longitude;
    //NSString *latitude;
    //if(current_user_did_not_grant_location || current_users_location_is_not_near_their_current_city)
      //use long/lat of their current city on the app
      //set sensor = false in the request
    //else
      //use their current location's long/lat
      //set sensor = true in request
    //end
    NSString *longitude = @"-86.783333";
    NSString *latitude = @"36.166667";
    NSString *sensor = @"false";
    if (currenDist > 50000) {
        currenDist = 50000;
    } else if(currenDist == 0){
        currenDist = 1500;
    }
    
    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%@,%@&radius=%@&types=bar|restaurant&name=%@&sensor=%@&key=AIzaSyDCARuI3o8xTpVqCMI19jAeBs5V7L_SvmQ", latitude, longitude, [NSString stringWithFormat:@"%i", currenDist], name, sensor];

    NSString *mutatedURL = [url stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    //Formulate the string as a URL object.
    NSURL *googleRequestURL = [NSURL URLWithString:[mutatedURL stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
    // Retrieve the results of the URL.
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:googleRequestURL];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });
}

-(void)fetchedData:(NSData *)responseData {
    NSLog(@"fetchedData");
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          
                          options:kNilOptions
                          error:&error];
    
    //The results from Google will be an array obtained from the NSDictionary object with the key "results".
    NSArray* places = [json objectForKey:@"results"];
    
    if ([self searchActivated]) {
         searchResults = [places mutableCopy];
        [self.mapView addAnnotations:[self createAnnotationsFromArray:searchResults]];
    } else {
        nearbyResults = [places mutableCopy];
        [self.mapView addAnnotations:[self createAnnotationsFromArray:nearbyResults]];
    }
    NSLog(@"search : %@", searchResults);
    [self.tableview reloadData];
}

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    searchText = [searchText lowercaseString];
    if (searchText.length == 0) {
        [self resetSearchResults];
    }
    NSLog(@"**********%@", searchText);
}

- (IBAction)searchButtonAction:(id)sender {
    NSLog(@"searching for %@", self.searchBar.text);
    [self scrollViewDidScroll:[[UIScrollView alloc] init]];
    [self queryGooglePlaces:self.searchBar.text];
}

- (void) resetSearchResults {
    searchBar.text= @"";
    [searchResults removeAllObjects];
    [self.mapView addAnnotations:[self createAnnotationsFromArray:nearbyResults]];
    [tableview reloadData];
}
@end
