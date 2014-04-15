//
//  BTSession.m
//  Banter
//
//  Created by William L. Schreiber on 11/14/13.
//  Copyright (c) 2013 Bus Productions. All rights reserved.
//

#import "BTSession.h"
#import "CTAppDelegate.h"
//#import "User.h"
//#import "Post.h"
//#import "NSString+URLEncoding.h"
//#import "Group.h"
//#import "Membership.h"
//#import "BTServer.h"
//#import "BTGroupViewController.h"
#import "NSString+SHAEncryption.h"

#define NULL_TO_NIL(obj) ({ __typeof__ (obj) __obj = (obj); __obj == [NSNull null] ? nil : obj; })

static BTSession* thisSession = nil;

@implementation BTSession

@synthesize baseURL;
@synthesize deviceTokenString;
@synthesize loggedInUser;
@synthesize actionAfterLogin;
@synthesize requests;
@synthesize fonts;
//@synthesize visiblePost;
//@synthesize thisViewDeck;
@synthesize notificationMessageViews;
@synthesize venueTypes;
<<<<<<< HEAD
@synthesize friendsInCity;
@synthesize friendsToChat;
@synthesize venuesInMyCity; 
=======
>>>>>>> 0819c9c8b92a14a4092897ffb410822a947979f3

//constructor
-(id) init
{
   if (thisSession) {
      return thisSession;
   }
   self = [super init];
   [self setVariables];
   return self;
}

//singleton instance
+(BTSession*) thisSession
{
   if (!thisSession) {
      thisSession = [[super allocWithZone:NULL] init];
   }
   return thisSession;
}


//prevent creation of additional instances
+(id)allocWithZone:(NSZone *)zone
{
   return [self thisSession];
}


-(void) setVariables
{
   NSLog(@"Setting Singleton Variables");
    
    CTAppDelegate *appDelegate = (CTAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Venue" inManagedObjectContext:context]];
    
    NSError *err;
    NSUInteger count = [context countForFetchRequest:request error:&err];
    if(count == 0) {
        NSLog(@"no users");
        User *user = [NSEntityDescription
                      insertNewObjectForEntityForName:@"User"
                      inManagedObjectContext:context];
        [user setValue:@"McArthur Gill" forKey:@"name"];
        [user setValue:@"3343994374" forKey:@"phone"];
        NSLog(@"created %@", user.name);
        
        User *user1 = [NSEntityDescription
                      insertNewObjectForEntityForName:@"User"
                      inManagedObjectContext:context];
        [user1 setValue:@"Suzie Hotcakes" forKey:@"name"];
        [user1 setValue:@"6144324790" forKey:@"phone"];
        NSLog(@"created %@", user1.name);

        
        User *user2 = [NSEntityDescription
                      insertNewObjectForEntityForName:@"User"
                      inManagedObjectContext:context];
        [user2 setValue:@"Will Schreiber" forKey:@"name"];
        [user2 setValue:@"2059360524" forKey:@"phone"];
        NSLog(@"created %@", user2.name);

        
        User *user3 = [NSEntityDescription
                      insertNewObjectForEntityForName:@"User"
                      inManagedObjectContext:context];
        [user3 setValue:@"Reed Whitcraft" forKey:@"name"];
        [user3 setValue:@"6463225988" forKey:@"phone"];
        NSLog(@"created %@", user3.name);

        
        User *user4 = [NSEntityDescription
                      insertNewObjectForEntityForName:@"User"
                      inManagedObjectContext:context];
        [user4 setValue:@"Sarah Betack" forKey:@"name"];
        [user4 setValue:@"2038033319" forKey:@"phone"];
        NSLog(@"created %@", user4.name);

        
        User *user5 = [NSEntityDescription
                      insertNewObjectForEntityForName:@"User"
                      inManagedObjectContext:context];
        [user5 setValue:@"Sam Gray" forKey:@"name"];
        [user5 setValue:@"2055401018" forKey:@"phone"];
        NSLog(@"created %@", user5.name);

        
        User *user6 = [NSEntityDescription
                      insertNewObjectForEntityForName:@"User"
                      inManagedObjectContext:context];
        [user6 setValue:@"Andrew Kuykendall" forKey:@"name"];
        [user6 setValue:@"3528431711" forKey:@"phone"];
        NSLog(@"created %@", user6.name);

        
        User *user7 = [NSEntityDescription
                      insertNewObjectForEntityForName:@"User"
                      inManagedObjectContext:context];
        [user7 setValue:@"George Harwood" forKey:@"name"];
        [user7 setValue:@"3345469168" forKey:@"phone"];
        NSLog(@"created %@", user7.name);

        
        User *user8 = [NSEntityDescription
                      insertNewObjectForEntityForName:@"User"
                      inManagedObjectContext:context];
        [user8 setValue:@"Pierce Cobb" forKey:@"name"];
        [user8 setValue:@"3343011335" forKey:@"phone"];
        NSLog(@"created %@", user8.name);

        
        //nashville
        City *nash = [NSEntityDescription
                      insertNewObjectForEntityForName:@"City"
                      inManagedObjectContext:context];
        NSNumber *longitude = [[NSNumber alloc] initWithFloat:30.389234];
        NSNumber *latitude = [[NSNumber alloc] initWithFloat:-80.238492];
        [nash setValue:longitude forKey:@"longitude"];
        [nash setValue:latitude forKey:@"latitude"];
        [nash setValue:@"Nashville" forKeyPath:@"cityName"];
        NSLog(@"created %@", nash.cityName);

        
        //montgomery
        City *gump = [NSEntityDescription
                      insertNewObjectForEntityForName:@"City"
                      inManagedObjectContext:context];
        NSNumber *gumplong = [[NSNumber alloc] initWithFloat:35.382943];
        NSNumber *gumplat = [[NSNumber alloc] initWithFloat:-83.238492];
        [gump setValue:gumplong forKey:@"longitude"];
        [gump setValue:gumplat forKey:@"latitude"];
        [gump setValue:@"Montgomery" forKeyPath:@"cityName"];
        NSLog(@"created %@", gump.cityName);

        
        //Cinci
        City *cinci = [NSEntityDescription
                    insertNewObjectForEntityForName:@"City"
                    inManagedObjectContext:context];
        NSNumber *sflong = [[NSNumber alloc] initWithFloat:31.384924];
        NSNumber *sflat = [[NSNumber alloc] initWithFloat:-79.283492];
        [cinci setValue:sflong forKey:@"longitude"];
        [cinci setValue:sflat forKey:@"latitude"];
        [cinci setValue:@"Cincinnati" forKeyPath:@"cityName"];
        NSLog(@"created %@", cinci.cityName);
        
        
        [nash addUsersObject:user];
        [nash addUsersObject:user2];
        [nash addUsersObject:user4];
        [nash addUsersObject:user5];
        [nash addUsersObject:user6];
        
        [gump addUsersObject:user3];
        [gump addUsersObject:user7];
        [gump addUsersObject:user8];
        
        [cinci addUsersObject:user1];
        
        
        //VenueTypes
        VenueType *bar = [NSEntityDescription
                        insertNewObjectForEntityForName:@"VenueType"
                        inManagedObjectContext:context];
        [bar setValue:@"Bar" forKey:@"typeName"];
        
        VenueType *restaurant = [NSEntityDescription
                          insertNewObjectForEntityForName:@"VenueType"
                          inManagedObjectContext:context];
        [restaurant setValue:@"Restaurant" forKey:@"typeName"];
        NSLog(@"created venuetypes");
        
        
        //Venues
        Venue *winners = [NSEntityDescription
                          insertNewObjectForEntityForName:@"Venue"
                          inManagedObjectContext:context];
        [winners setValue:@"Winners" forKey:@"venueName"];
        [winners setVenueType:bar];
        NSLog(@"got here");
        [nash addVenuesObject:winners];
        NSLog(@"but not here");
        Venue *rebar = [NSEntityDescription
                          insertNewObjectForEntityForName:@"Venue"
                          inManagedObjectContext:context];
        [rebar setValue:@"Rebar" forKey:@"venueName"];
        [rebar setVenueType:bar];
        [nash addVenuesObject:rebar];
        
        Venue *rippys = [NSEntityDescription
                          insertNewObjectForEntityForName:@"Venue"
                          inManagedObjectContext:context];
        [rippys setValue:@"Rippys" forKey:@"venueName"];
        [rippys setVenueType:bar];
        [nash addVenuesObject:rippys];
        
        Venue *losers = [NSEntityDescription
                         insertNewObjectForEntityForName:@"Venue"
                         inManagedObjectContext:context];
        [losers setValue:@"Losers" forKey:@"venueName"];
        [losers setVenueType:bar];
        [nash addVenuesObject:losers];
        
        Venue *kayne = [NSEntityDescription
                         insertNewObjectForEntityForName:@"Venue"
                         inManagedObjectContext:context];
        [kayne setValue:@"Kayne Prime" forKey:@"venueName"];
        [kayne setVenueType:restaurant];
        [nash addVenuesObject:kayne];
        
        Venue *virago = [NSEntityDescription
                         insertNewObjectForEntityForName:@"Venue"
                         inManagedObjectContext:context];
        [virago setValue:@"Virago" forKey:@"venueName"];
        [virago setVenueType:restaurant];
<<<<<<< HEAD
        [nash addVenuesObject:virago];
=======
        [nash addVenuesObject:kayne];
>>>>>>> 0819c9c8b92a14a4092897ffb410822a947979f3
        
        Venue *dog = [NSEntityDescription
                         insertNewObjectForEntityForName:@"Venue"
                         inManagedObjectContext:context];
        [dog setValue:@"The Dog" forKey:@"venueName"];
        [dog setVenueType:restaurant];
        [nash addVenuesObject:dog];
        
        Venue *taco = [NSEntityDescription
                         insertNewObjectForEntityForName:@"Venue"
                         inManagedObjectContext:context];
        [taco setValue:@"Local Taco" forKey:@"venueName"];
        [taco setVenueType:restaurant];
        [nash addVenuesObject:taco];
        
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
    
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"User" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (User *person in fetchedObjects) {
        if ([person.name isEqualToString:@"McArthur Gill"]) {
            [self loginUser:person];
        }
        NSLog(@"Name: %@", person.name);
        NSLog(@"Phone: %@", person.phone);
        NSLog(@"user => city: %@", [person.city cityName]);
    }
    
    NSLog(@"loggedInUser : %@", [[self loggedInUser] name]);
    
    NSFetchRequest *fr = [[NSFetchRequest alloc] init];
    NSEntityDescription *ent = [NSEntityDescription
                                   entityForName:@"VenueType" inManagedObjectContext:context];
    [fr setEntity:ent];
    NSArray *fo = [context executeFetchRequest:fr error:&error];
    venueTypes = [[NSArray alloc] initWithArray:fo];
}

- (NSDictionary*) countryCallingCodes
{
   return [NSDictionary dictionaryWithObjectsAndKeys:@"972", @"IL",
                               @"93", @"AF", @"355", @"AL", @"213", @"DZ", @"1", @"AS",
                               @"376", @"AD", @"244", @"AO", @"1", @"AI", @"1", @"AG",
                               @"54", @"AR", @"374", @"AM", @"297", @"AW", @"61", @"AU",
                               @"43", @"AT", @"994", @"AZ", @"1", @"BS", @"973", @"BH",
                               @"880", @"BD", @"1", @"BB", @"375", @"BY", @"32", @"BE",
                               @"501", @"BZ", @"229", @"BJ", @"1", @"BM", @"975", @"BT",
                               @"387", @"BA", @"267", @"BW", @"55", @"BR", @"246", @"IO",
                               @"359", @"BG", @"226", @"BF", @"257", @"BI", @"855", @"KH",
                               @"237", @"CM", @"1", @"CA", @"238", @"CV", @"345", @"KY",
                               @"236", @"CF", @"235", @"TD", @"56", @"CL", @"86", @"CN",
                               @"61", @"CX", @"57", @"CO", @"269", @"KM", @"242", @"CG",
                               @"682", @"CK", @"506", @"CR", @"385", @"HR", @"53", @"CU",
                               @"537", @"CY", @"420", @"CZ", @"45", @"DK", @"253", @"DJ",
                               @"1", @"DM", @"1", @"DO", @"593", @"EC", @"20", @"EG",
                               @"503", @"SV", @"240", @"GQ", @"291", @"ER", @"372", @"EE",
                               @"251", @"ET", @"298", @"FO", @"679", @"FJ", @"358", @"FI",
                               @"33", @"FR", @"594", @"GF", @"689", @"PF", @"241", @"GA",
                               @"220", @"GM", @"995", @"GE", @"49", @"DE", @"233", @"GH",
                               @"350", @"GI", @"30", @"GR", @"299", @"GL", @"1", @"GD",
                               @"590", @"GP", @"1", @"GU", @"502", @"GT", @"224", @"GN",
                               @"245", @"GW", @"595", @"GY", @"509", @"HT", @"504", @"HN",
                               @"36", @"HU", @"354", @"IS", @"91", @"IN", @"62", @"ID",
                               @"964", @"IQ", @"353", @"IE", @"972", @"IL", @"39", @"IT",
                               @"1", @"JM", @"81", @"JP", @"962", @"JO", @"77", @"KZ",
                               @"254", @"KE", @"686", @"KI", @"965", @"KW", @"996", @"KG",
                               @"371", @"LV", @"961", @"LB", @"266", @"LS", @"231", @"LR",
                               @"423", @"LI", @"370", @"LT", @"352", @"LU", @"261", @"MG",
                               @"265", @"MW", @"60", @"MY", @"960", @"MV", @"223", @"ML",
                               @"356", @"MT", @"692", @"MH", @"596", @"MQ", @"222", @"MR",
                               @"230", @"MU", @"262", @"YT", @"52", @"MX", @"377", @"MC",
                               @"976", @"MN", @"382", @"ME", @"1", @"MS", @"212", @"MA",
                               @"95", @"MM", @"264", @"NA", @"674", @"NR", @"977", @"NP",
                               @"31", @"NL", @"599", @"AN", @"687", @"NC", @"64", @"NZ",
                               @"505", @"NI", @"227", @"NE", @"234", @"NG", @"683", @"NU",
                               @"672", @"NF", @"1", @"MP", @"47", @"NO", @"968", @"OM",
                               @"92", @"PK", @"680", @"PW", @"507", @"PA", @"675", @"PG",
                               @"595", @"PY", @"51", @"PE", @"63", @"PH", @"48", @"PL",
                               @"351", @"PT", @"1", @"PR", @"974", @"QA", @"40", @"RO",
                               @"250", @"RW", @"685", @"WS", @"378", @"SM", @"966", @"SA",
                               @"221", @"SN", @"381", @"RS", @"248", @"SC", @"232", @"SL",
                               @"65", @"SG", @"421", @"SK", @"386", @"SI", @"677", @"SB",
                               @"27", @"ZA", @"500", @"GS", @"34", @"ES", @"94", @"LK",
                               @"249", @"SD", @"597", @"SR", @"268", @"SZ", @"46", @"SE",
                               @"41", @"CH", @"992", @"TJ", @"66", @"TH", @"228", @"TG",
                               @"690", @"TK", @"676", @"TO", @"1", @"TT", @"216", @"TN",
                               @"90", @"TR", @"993", @"TM", @"1", @"TC", @"688", @"TV",
                               @"256", @"UG", @"380", @"UA", @"971", @"AE", @"44", @"GB",
                               @"1", @"US", @"598", @"UY", @"998", @"UZ", @"678", @"VU",
                               @"681", @"WF", @"967", @"YE", @"260", @"ZM", @"263", @"ZW",
                               @"591", @"BO", @"673", @"BN", @"61", @"CC", @"243", @"CD",
                               @"225", @"CI", @"500", @"FK", @"44", @"GG", @"379", @"VA",
                               @"852", @"HK", @"98", @"IR", @"44", @"IM", @"44", @"JE",
                               @"850", @"KP", @"82", @"KR", @"856", @"LA", @"218", @"LY",
                               @"853", @"MO", @"389", @"MK", @"691", @"FM", @"373", @"MD",
                               @"258", @"MZ", @"970", @"PS", @"872", @"PN", @"262", @"RE",
                               @"7", @"RU", @"590", @"BL", @"290", @"SH", @"1", @"KN",
                               @"1", @"LC", @"590", @"MF", @"508", @"PM", @"1", @"VC",
                               @"239", @"ST", @"252", @"SO", @"47", @"SJ", @"963", @"SY",
                               @"886", @"TW", @"255", @"TZ", @"670", @"TL", @"58", @"VE",
                               @"84", @"VN", @"1", @"VG", @"1", @"VI", nil];
}

- (NSDictionary*) countryCodeByCallingCode
{
   NSMutableDictionary* cd = [[NSMutableDictionary alloc] init];
   NSDictionary* cdd = [self countryCallingCodes];
   NSArray* ckeys = [cdd allKeys];
   for (int i = 0; i < ckeys.count; ++i) {
      [cd setObject:[ckeys objectAtIndex:i] forKey:[cdd objectForKey:[ckeys objectAtIndex:i]]];
   }
   return (NSDictionary*) cd;
}

- (NSDictionary*) countriesByCountryCode
{
   NSMutableDictionary* cd = [[NSMutableDictionary alloc] init];
   NSDictionary* cdd = [self countryCallingCodes];
   NSArray* ckeys = [cdd allKeys];
   for (int i = 0; i < ckeys.count; ++i) {
      [cd setObject:[[NSLocale currentLocale] displayNameForKey:NSLocaleCountryCode value:[ckeys objectAtIndex:i]] forKey:[ckeys objectAtIndex:i]];
   }
   return (NSDictionary*) cd;
}

- (NSDictionary*) countriesByCountryName
{
   NSMutableDictionary* cd = [[NSMutableDictionary alloc] init];
   NSDictionary* cdd = [self countryCallingCodes];
   NSArray* ckeys = [cdd allKeys];
   for (int i = 0; i < ckeys.count; ++i) {
      [cd setObject:[ckeys objectAtIndex:i] forKey:[[NSLocale currentLocale] displayNameForKey:NSLocaleCountryCode value:[ckeys objectAtIndex:i]]];
   }
   return (NSDictionary*) cd;
}

- (void) initialLoad
{
//   [self userDetailHTTP:[[self loggedInUser] user_id] password:[[self loggedInUser] password]];
//   [self getAllUnseenPostsHTTP];
}

- (void) setFontsArray
{
//   NSDictionary* f1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Futura-Medium", @"name", [NSNumber numberWithFloat:1], @"multiplier", nil];
//   NSDictionary* f2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Futura-CondensedExtraBold", @"name", [NSNumber numberWithFloat:(21.0f/18.0f)], @"multiplier", nil];
//   NSDictionary* f3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Courier-Bold", @"name", [NSNumber numberWithFloat:1], @"multiplier", nil];
//   NSDictionary* f4 = [[NSDictionary alloc] initWithObjectsAndKeys:@"SnellRoundhand-Black", @"name", [NSNumber numberWithFloat:(21.0f/18.0f)], @"multiplier", nil];
//   NSDictionary* f5 = [[NSDictionary alloc] initWithObjectsAndKeys:@"MarkerFelt-Wide", @"name", [NSNumber numberWithFloat:(18.0f/18.0f)], @"multiplier", nil];
//   NSDictionary* f6 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Baskerville-Bold", @"name", [NSNumber numberWithFloat:(18.0f/18.0f)], @"multiplier", nil];

   NSDictionary* f1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"MuseoSans-500", @"name", [NSNumber numberWithFloat:1], @"multiplier", nil];
   //NSDictionary* f2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"MuseoSans-700", @"name", [NSNumber numberWithFloat:(21.0f/18.0f)], @"multiplier", nil];
   NSDictionary* f3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"ChunkFive", @"name", [NSNumber numberWithFloat:1], @"multiplier", nil];
   NSDictionary* f4 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Folk-solid", @"name", [NSNumber numberWithFloat:(25.0f/18.0f)], @"multiplier", nil];
   NSDictionary* f5 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Lobster1.4", @"name", [NSNumber numberWithFloat:(21.0f/18.0f)], @"multiplier", nil];
   NSDictionary* f6 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Amatic-Bold", @"name", [NSNumber numberWithFloat:(25.0f/18.0f)], @"multiplier", nil];
   NSDictionary* f7 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Blackout-Midnight", @"name", [NSNumber numberWithFloat:(16.0f/18.0f)], @"multiplier", nil];
   NSDictionary* f8 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Blackout-2AM", @"name", [NSNumber numberWithFloat:(18.0f/18.0f)], @"multiplier", nil];
   
   [self setFonts:[[NSArray alloc] initWithObjects:f1, f3, f4, f5, f6, f7, f8, nil]];
}


- (void) saveMyData:(NSNotification*)notification
{
   //   NSLog(@"SAVING DATA");
   //   [NSKeyedArchiver archiveRootObject:self.loggedInUser toFile:[self userFileInDocumentsDirectory]];
}


//Saving / Archiving

//
- (NSFileManager*) fileManager
{
   return [NSFileManager defaultManager];
}

// Returns the URL to the application's Documents directory.
- (NSString *)applicationDocumentsDirectory
{
   NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
   NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
   return basePath;
}



// METHODS

- (BOOL) isLoggedIn
{
   if (self.loggedInUser) {
      return YES;
   }
    return NO;
}


<<<<<<< HEAD
- (void)setupVenueData:(City *)city {
    NSMutableArray *venues = [[city venues] mutableCopy];
    NSMutableArray *bars = [[NSMutableArray alloc] init];
    NSMutableArray *restaurants = [[NSMutableArray alloc] init];
    for (Venue *venue in venues) {
        if ([[[venue venueType] typeName] isEqualToString:@"Bar"]) {
            [bars addObject:venue];
        }else {
            [restaurants addObject:venue];
        }
    }
    
    NSDictionary *barDict = [NSDictionary dictionaryWithObject:bars forKey:@"Bars"];
    NSDictionary *restDict = [NSDictionary dictionaryWithObject:restaurants forKey:@"Restaurants"];
    self.venuesInMyCity = [[NSArray alloc] initWithObjects:barDict, restDict, nil];
    
}


=======
>>>>>>> 0819c9c8b92a14a4092897ffb410822a947979f3
- (void) checkForLoggedInUser
{
//   NSManagedObjectContext *moc = [(CTAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
//   
//   NSEntityDescription *entityDescription = [NSEntityDescription
//                                             entityForName:@"User" inManagedObjectContext:moc];
//   NSFetchRequest *request = [[NSFetchRequest alloc] init];
//   [request setEntity:entityDescription];
//   
//   // Set example predicate and sort orderings...
//   NSPredicate *predicate = [NSPredicate predicateWithFormat:
//                             @"(logged_in_user == %@)", [NSNumber numberWithBool:YES]];
//   [request setPredicate:predicate];
//   
//   NSError* error;
//   NSMutableArray *array = [NSMutableArray arrayWithArray:[moc executeFetchRequest:request error:&error]];
//   
//   if (array.count==0) {
//      //NOT LOGGED IN
//      NSLog(@"NO LOGGED IN USER FOUND");
//   } else {
//      [self setLoggedInUser:[array firstObject]];
//      NSLog(@"LOGGED IN USER FOUND AND SET");
//   }
}



- (UIColor*) greenColor
{
   return [UIColor colorWithRed:0.498 green:.690 blue:.255 alpha:1];
}

- (UIColor*) greenColorTrans
{
   return [UIColor colorWithRed:0.498 green:.690 blue:.255 alpha:0.7];
}

- (UIColor*) redColor
{
   return [UIColor colorWithRed:.804 green:.267 blue:.267 alpha:1];
}

- (UIColor*) offwhiteColor
{
   return [UIColor colorWithRed:.929 green:.925 blue:.910 alpha:1];
}

- (UIColor*) softBlackColor
{
   return [UIColor colorWithRed:.216 green:.216 blue:.216 alpha:1];
}

- (UIColor*) softerBlackColor
{
   return [UIColor colorWithRed:.137 green:.137 blue:.137 alpha:1];
}

- (UIColor*) goldColor
{
   return [UIColor colorWithRed:.894 green:.718 blue:.286 alpha:1];
}

- (UIFont*) helveticaFont:(float)size
{
   return [UIFont fontWithName:@"HelveticaNeue-Thin" size:size];
}

- (void) logFontNames
{
   // List all fonts on iPhone
   NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
   NSArray *fontNames;
   NSInteger indFamily, indFont;
   for (indFamily=0; indFamily<[familyNames count]; ++indFamily)
   {
      NSLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
      fontNames = [[NSArray alloc] initWithArray:
                   [UIFont fontNamesForFamilyName:
                    [familyNames objectAtIndex:indFamily]]];
      for (indFont=0; indFont<[fontNames count]; ++indFont)
      {
         NSLog(@"    Font name: %@", [fontNames objectAtIndex:indFont]);
      }
   }
}


- (void) setLoginUser:(User *)user {
    loggedInUser = user;
}

- (void) loginUser:(User *)user
{
    NSLog(@"login user ****");
   [self setLoginUser:user];
//   [self updateDeviceTokenHTTP];
}

- (void) logoutUser
{
   [self setLoginUser:nil];
   [self saveCoreDataContext];
}

- (void) saveCoreDataContext
{
   [[(CTAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext] save:nil];
}



//
//- (void) showNewGroupAndSidebar
//{
//   
//   Group* g = [[Group alloc] getNewestGroup];
//   
//   UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//   UINavigationController* gvc = [storyboard instantiateViewControllerWithIdentifier:@"groupController"];
//   [(BTGroupViewController*)[[gvc viewControllers] objectAtIndex:0] setGroup:g];
//   
//   [self.thisViewDeck setCenterController:gvc];
//   
//   [self.thisViewDeck toggleRightView];
//   
//}

//
//- (void) contactsSelectorReturnsWithArrayOfContacts:(NSMutableDictionary*)people
//{
//   NSLog(@"Returned Dictionary of People! Count: %lu", (unsigned long)people.allKeys.count);
//   NSMutableArray* all_numbers = [[NSMutableArray alloc] init];
//   NSArray* keys = people.allKeys;
//   for (int i = 0; i < people.count; ++i) {
//      NSLog(@"%@", [people objectForKey:[keys objectAtIndex:i]]);
//      NSArray* numbers = [[[people objectForKey:[keys objectAtIndex:i]] objectForKey:@"phone"] allKeys];
//      for (int j = 0; j < numbers.count; ++j) {
//         [all_numbers addObject:[numbers objectAtIndex:j]];
//      }
//   }
//   [self groupSendInvitationsHTTP:all_numbers groupID:[[[Group alloc] getNewestGroup] group_id]];
//   NSLog(@"ALL NUMBERS: %@", all_numbers);
//}


- (NSString*) timeAgoInWords:(double) relativeTimestamp
{
   NSLog(@"Calculating TimeAgoInWords");
   double currentTimestamp = [[NSDate date] timeIntervalSince1970];
   double difference = currentTimestamp - relativeTimestamp;
   NSLog(@"TIME: %f - %f = %f", currentTimestamp, relativeTimestamp, difference);
   //difference = difference/1; //convert from ms to s
   NSLog(@"TIME DIFFERENCE/100: %f", difference);
   if (difference < 90) {
      return @"about a minute ago";
   } else if (difference < 3600) {
      return [NSString stringWithFormat:@"%i minute%@ ago", (int)(difference+30)/60, ((int)(difference+30)/60 == 1 ? @"" : @"s")];
   } else if (difference < 86400) {
      return [NSString stringWithFormat:@"%i hour%@ ago", (int)(difference+1200)/3600, ((int)(difference+1200)/3600 == 1 ? @"" : @"s")];
   } else if (difference < 172800) {
      return [NSString stringWithFormat:@"yesterday"];
   } else if (difference < 2592000) {
      return [NSString stringWithFormat:@"%i day%@ ago", (int)(difference+43200)/86400, ((int)(difference+43200)/86400 == 1 ? @"" : @"s")];
   } else if (difference < 5184000) {
      return [NSString stringWithFormat:@"last month"];
   } else if (difference < 31536000) {
      return [NSString stringWithFormat:@"%i month%@ ago", (int)(difference+43200)/2592000, ((int)(difference+43200)/2592000 == 1 ? @"" : @"s")];
   }
   return @"back when dinosaurs roamed the earth";
}

//
//- (NSString*) getAuthTokenBase
//{
//   int time = ((int)[[NSDate date] timeIntervalSince1970])/100;
//   int offset = [self loggedInUserID] ? ([[self loggedInUserID] intValue])%10 : 0;
//   time = time - offset;
//   NSString* value = [NSString stringWithFormat:@"%@%i%@", ([self loggedInUserID] ? [self loggedInUserID] : @"0"), time, (([self loggedInUser] && [[self loggedInUser] password]) ? [[[self loggedInUser] password] substringToIndex:3] : @"blank")];
//   NSLog(@"getAuthTokenBase: %@", value);
//   return value;
//}

//
////== DEVICE TOKEN
//
//- (void) updateDeviceToken:(NSData*)deviceToken
//{
//   NSString *tokenString = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
//   tokenString = [tokenString stringByReplacingOccurrencesOfString:@" " withString:@""];
//   NSLog(@"TOKEN STRING: %@", tokenString);
//   
//   [self setDeviceTokenString:tokenString];
//   [self updateDeviceTokenHTTP];
//   
//}
//
//- (void) updateDeviceTokenHTTP
//{
//   if (self.deviceTokenString) {
//      
//      BTServer* server = [[BTServer alloc] init];
//      [self.requests addObject:server];
//      
//      if ([self isLoggedIn]) {
//         //NSNumber *userID = [[self loggedInUser] user_id];
//         [server setLoadJson:[LoadURLJson download:[NSString stringWithFormat:@"/device_tokens.json?device_token[ios_device_token]=%@&device_token[user_id]=%@", self.deviceTokenString, [self loggedInUserID]] withDelegate:server withMethod:@"POST" withParameters:nil]];
//      } else {
//         [server setLoadJson:[LoadURLJson download:[NSString stringWithFormat:@"/device_tokens.json?device_token[ios_device_token]=%@", self.deviceTokenString] withDelegate:server withMethod:@"POST" withParameters:nil]];
//      }
//   }
//   
//   NSLog(@"Request Made");
//}
//
//
////==== SERVER STUFF
//
//
/////USERS
//
//- (void) sendTokenHTTP:(NSString*)number key:(NSString*)key countryCode:(NSString*)countyCode
//{
//   BTServer* server = [[BTServer alloc] init];
//   [self.requests addObject:server];
//   [server setLoadJson:[LoadURLJson download:[NSString stringWithFormat:@"/users/verify_number.json?user[code]=%@&user[phone]=%@&user[country_code]=%@", [key urlEncodeUsingEncoding:NSUTF8StringEncoding ], [number urlEncodeUsingEncoding:NSUTF8StringEncoding], [countyCode urlEncodeUsingEncoding:NSUTF8StringEncoding]] withDelegate:server withMethod:@"POST" withParameters:nil]];
//}
//
//- (void) loginUserHTTP:(NSString*)phone nakedPassword:(NSString*)nakedPassword name:(NSString*)name countryCode:(NSString*)countryCode
//{
//   BTServer* server = [[BTServer alloc] init];
//   [self.requests addObject:server];
//   [server setLoadJson:[LoadURLJson download:[NSString stringWithFormat:@"/users.json?user[phone]=%@&user[password]=%@&user[name]=%@&user[country_code]=%@", [phone urlEncodeUsingEncoding:NSUTF8StringEncoding ], [nakedPassword urlEncodeUsingEncoding:NSUTF8StringEncoding], [name urlEncodeUsingEncoding:NSUTF8StringEncoding], [countryCode urlEncodeUsingEncoding:NSUTF8StringEncoding]] withDelegate:server withMethod:@"POST" withParameters:nil]];
//}
//
//
//- (void) userDetailHTTP:(NSNumber*)user_id password:(NSString*)encryptedPassword
//{
//   if ([self isLoggedIn]) {
//      BTServer* server = [[BTServer alloc] init];
//      [self.requests addObject:server];
//      [server setLoadJson:[LoadURLJson download:[NSString stringWithFormat:@"/users/%@.json?user[password]=%@", self.loggedInUser.user_id, [self.loggedInUser.password urlEncodeUsingEncoding:NSUTF8StringEncoding]] withDelegate:server withMethod:@"GET" withParameters:nil]];
//   }
//}
//
//- (void) updateUserHTTP:(NSString*)name
//{
//   if ([self isLoggedIn]) {
//      BTServer* server = [[BTServer alloc] init];
//      [self.requests addObject:server];
//      [server setLoadJson:[LoadURLJson download:[NSString stringWithFormat:@"/users/%@.json?user[password]=%@&user[name]=%@", self.loggedInUser.user_id, [self.loggedInUser.password urlEncodeUsingEncoding:NSUTF8StringEncoding], [name urlEncodeUsingEncoding:NSUTF8StringEncoding]] withDelegate:server withMethod:@"PUT" withParameters:nil]];
//   }
//}
//
/////POSTS
//
//- (void) getAllUnseenPostsHTTP
//{
//   if ([self isLoggedIn]) {
//      BTServer* server = [[BTServer alloc] init];
//      [self.requests addObject:server];
//      [server setLoadJson:[LoadURLJson download:[NSString stringWithFormat:@"/users/%@/all_unseen_posts.json?user[password]=%@", self.loggedInUser.user_id, [self.loggedInUser.password urlEncodeUsingEncoding:NSUTF8StringEncoding]] withDelegate:server withMethod:@"GET" withParameters:nil]];
//   }
//}
//
//- (void) submitPostViewHTTP:(Post*)post
//{
//   if ([self isLoggedIn]) {
//      BTServer* server = [[BTServer alloc] init];
//      [self.requests addObject:server];
//      [server setLoadJson:[LoadURLJson download:[NSString stringWithFormat:@"/views.json?view[post_id]=%@&view[user_id]=%@", post.post_id, self.loggedInUserID] withDelegate:server withMethod:@"POST" withParameters:nil]];
//   }
//}
//
//- (void) submitPostLikeHTTP:(Post*)post
//{
//   if ([self isLoggedIn]) {
//      BTServer* server = [[BTServer alloc] init];
//      [self.requests addObject:server];
//      [server setLoadJson:[LoadURLJson download:[NSString stringWithFormat:@"/favorites.json?favorite[post_id]=%@&favorite[user_id]=%@", post.post_id, self.loggedInUserID] withDelegate:server withMethod:@"POST" withParameters:nil]];
//   }
//}
//
//- (void) submitPostHTTP:(Post*)post image:(UIImage*)image video:(NSString*)videoURL
//{
//   if ([self isLoggedIn]) {
//      
//      BTServer* server = [[BTServer alloc] init];
//      [self.requests addObject:server];
//      
//      NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//      
//      NSString* authTokenBase = [[BTSession thisSession] getAuthTokenBase];
//      
//      [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/posts.json?post[group_id]=%@&post[phone_timestamp]=%@&post[post_type]=%@&post[user_id]=%@&password=%@&sk=%@&usk=%@&uid=%@", [[BTSession thisSession] baseURL], post.group_id, post.phone_timestamp, post.post_type, post.user_id, [self.loggedInUser password], @"foeiuh9q28734gfa9w8hfg92830rq892g0oaw8hf",[authTokenBase shaEncrypted], [[BTSession thisSession] loggedInUserID]]]];
//      
//      //[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:3000/posts.json?post[group_id]=%@&post[phone_timestamp]=%@&post[post_type]=%@&post[user_id]=%@&sk=%@", [NSNumber numberWithInt:3], [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]], @"image", [NSNumber numberWithInt:3], @"foeiuh9q28734gfa9w8hfg92830rq892g0oaw8hf"]]];
//      
//      [request setHTTPMethod:@"POST"];
//      
//      
//      NSMutableData *postData = [NSMutableData data];
//      
//      
//      NSData *photo;
//      if ([post.post_type isEqualToString:@"image"]) {
//         
//         
//         NSString *boundary = @"---------------------------14737809831466499882746641449";
//         NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
//         [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
//         
//         
//         [postData appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//         
//         // Append the Usertoken
//         [postData appendData:[@"Content-Disposition: form-data; name=\"token\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//         [postData appendData:[@"Content-Type: application/json\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//         //[postData appendData:[[NSString stringWithFormat:@"%@", token] dataUsingEncoding:NSUTF8StringEncoding]];
//         
//         
//         photo = UIImageJPEGRepresentation(image, 1.0f);
//         
//         // Append the file
//         [postData appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//         [postData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@.%@\"\r\n", @"new", ([post.post_type isEqualToString:@"image"] ? @"jpg" : @"mov")]dataUsingEncoding:NSUTF8StringEncoding]];
//         [postData appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//         [postData appendData:[NSData dataWithData:photo]];
//         
//         // Close
//         [postData appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//         
//      } else if ([post.post_type isEqualToString:@"video"]) {
//         
//         NSLog(@"----video string as passed in: %@", videoURL);
//         NSLog(@"----video string as converted: %@", [[NSURL URLWithString:videoURL] path]);
//         
//         
//         NSString *boundary = @"---------------------------14737809831466499882746641449";
//         NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
//         [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
//         
//         /*  body of the post */
//         
//         [postData appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//         
//         NSError* error = nil;
//         //photo = [NSData dataWithContentsOfURL:[NSURL URLWithString:videoURL] options:NSDataReadingUncached error:&error];
//         photo = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@",[[NSURL URLWithString:videoURL] path]] options:NSDataReadingMapped error:&error];
//         if (error) {
//            NSLog(@"%@", [error localizedDescription]);
//         } else {
//            NSLog(@"Data has loaded successfully.");
//         }
//         
//         NSLog(@"VIDEO EXISTS AT PATH: %hhd", [[NSFileManager defaultManager] fileExistsAtPath:videoURL]);
//         
//         NSLog(@"VIDEO FILE SIZE: %.5f", (float)photo.length);
//         
//         [postData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"mynewwatermarkedvideo-%@.mov\"\r\n", post.phone_timestamp] dataUsingEncoding:NSUTF8StringEncoding]];
//         [postData appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//         [postData appendData:[NSData dataWithData:photo]];
//         [postData appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//         
//      }
//      
//      // Append
//      [request setHTTPBody:postData];
//      
//      //NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
//      //[connection scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
//      
//      //[connection start];
//      
//      [NSURLConnection sendAsynchronousRequest:request
//                                         queue:[NSOperationQueue mainQueue]
//                             completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//                                
//                                NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error:&error];
//                                NSLog(@"%@",dictionary);
//                                [server analyzeResponse:dictionary];
//                                
//                             }];
//      
//      NSLog(@"%@", request);
//      
//      NSLog(@"UPLOAD MEDIA Request Made");
//      
//   }
//}
//
//- (void) submitScreenshotHTTP:(Post *)post
//{
//   if ([self isLoggedIn]) {
//      BTServer* server = [[BTServer alloc] init];
//      [self.requests addObject:server];
//      [server setLoadJson:[LoadURLJson download:[NSString stringWithFormat:@"/screenshots.json?screenshot[post_id]=%@&screenshot[user_id]=%@", [post post_id], self.loggedInUserID] withDelegate:server withMethod:@"POST" withParameters:nil]];
//   }
//}
//
////GROUPS
//
//- (void) createGroupWithNameHTTP:(NSString *)group_name
//{
//   if ([self isLoggedIn]) {
//      BTServer* server = [[BTServer alloc] init];
//      [self.requests addObject:server];
//      [server setLoadJson:[LoadURLJson download:[NSString stringWithFormat:@"/groups.json?group[group_name]=%@&user_id=%@&password=%@", [group_name urlEncodeUsingEncoding:NSUTF8StringEncoding], self.loggedInUser.user_id, self.loggedInUser.password] withDelegate:server withMethod:@"POST" withParameters:nil]];
//   }
//}
//
//- (void) updateGroupWithIDHTTP:(NSNumber *)group_id groupName:(NSString*)group_name
//{
//   if ([self isLoggedIn]) {
//      if ([self isLoggedIn]) {
//         BTServer* server = [[BTServer alloc] init];
//         [self.requests addObject:server];
//         [server setLoadJson:[LoadURLJson download:[NSString stringWithFormat:@"/groups/%@.json?group[group_name]=%@&user_id=%@&password=%@", group_id, [group_name urlEncodeUsingEncoding:NSUTF8StringEncoding], self.loggedInUser.user_id, self.loggedInUser.password] withDelegate:server withMethod:@"PUT" withParameters:nil]];
//      }
//   }
//}
//
//- (void) groupDetailWithIDHTTP:(NSNumber *)group_id
//{
//   if ([self isLoggedIn]) {
//      BTServer* server = [[BTServer alloc] init];
//      [self.requests addObject:server];
//      [server setLoadJson:[LoadURLJson download:[NSString stringWithFormat:@"/groups/%@.json?", group_id] withDelegate:server withMethod:@"GET" withParameters:nil]];
//   }
//}
//
//- (void) groupSendInvitationsHTTP:(NSArray *)numbers groupID:(NSNumber*)group_id
//{
//   if ([self isLoggedIn]) {
//      BTServer* server = [[BTServer alloc] init];
//      [self.requests addObject:server];
//      
//      NSString* invites = @"";
//      for (int i = 0; i<numbers.count; ++i) {
//         invites = [NSString stringWithFormat:@"%@&invitations[]=%@", invites, [[numbers objectAtIndex:i] urlEncodeUsingEncoding:NSUTF8StringEncoding]];
//      }
//      [server setLoadJson:[LoadURLJson download:[NSString stringWithFormat:@"/invitations.json?group_id=%@&user_id=%@%@", group_id, [[BTSession thisSession] loggedInUserID], invites] withDelegate:server withMethod:@"POST" withParameters:nil]];
//   }
//}
//
////MEMBERSHIP
//- (void) updateMembershipHTTP:(Membership*)membership withUserName:(NSString*)userName
//{
//   if ([self isLoggedIn]) {
//      BTServer* server = [[BTServer alloc] init];
//      [self.requests addObject:server];
//      [server setLoadJson:[LoadURLJson download:[NSString stringWithFormat:@"/memberships/%@.json?user_name=%@", membership.membership_id, [userName urlEncodeUsingEncoding:NSUTF8StringEncoding]] withDelegate:server withMethod:@"PUT" withParameters:nil]];
//   }
//}
//
//- (void) destroyMembership:(Membership*)membership
//{
//   if ([self isLoggedIn]) {
//      
//      [self destroyMembershipHTTP:membership];
//      [self.loggedInUser removeGroupsObject:membership.group];
//      [self.loggedInUser removeMembershipsObject:membership];
//      [self.loggedInUser leaveGroupWithMembership:membership];
//      [self.loggedInUser.managedObjectContext save:nil];
//      [self setLoggedInUser:[[User alloc] getUserWithID:self.loggedInUser.user_id]];
//   }
//}
//
//- (void) destroyMembershipHTTP:(Membership*)membership
//{
//   if ([self isLoggedIn]) {
//      BTServer* server = [[BTServer alloc] init];
//      [self.requests addObject:server];
//      [server setLoadJson:[LoadURLJson download:[NSString stringWithFormat:@"/memberships/%@.json?", membership.membership_id] withDelegate:server withMethod:@"DELETE" withParameters:nil]];
//   }
//}
//
//- (void) toggleNotificationSettingForMembers:(Membership*)membership to:(NSString*)newSetting
//{
//   if ([self isLoggedIn]) {
//      BTServer* server = [[BTServer alloc] init];
//      [self.requests addObject:server];
//      [server setLoadJson:[LoadURLJson download:[NSString stringWithFormat:@"/memberships/%@.json?notification_preference=%@", membership.membership_id, newSetting] withDelegate:server withMethod:@"PUT" withParameters:nil]];
//   }
//}
//
//
//
//
//
////==== notifications
//
//- (void) createNotificationWindowWithMessage:(NSString*)message
//{
//   NSLog(@"Creating Notification Subview With Message: %@", message);
//   BTAppDelegate* appDelegate = (BTAppDelegate*)[[UIApplication sharedApplication] delegate];
//   UIView* newview = [[UIView alloc] initWithFrame:CGRectMake(0, appDelegate.window.frame.size.height-60, 320, 60 )];
//   UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 60)];
//   [label setText:message];
//   [label setTextColor:[UIColor whiteColor]];
//   [label setFont:[self helveticaFont:14]];
//   [label setMinimumFontSize:8];
//   [label setNumberOfLines:2];
//   [label setLineBreakMode:NSLineBreakByWordWrapping];
//   [newview addSubview:label];
//   [newview setBackgroundColor:[UIColor colorWithRed:19.0f/255.0f green:52.0f/255.0f blue:99.0f/255.0f alpha:1]];
//   [newview setAlpha:0];
//   [self addNotificationViewToList:newview];
//}
//
//- (void) addNotificationViewToList:(UIView*)tv
//{
//   [self.notificationMessageViews addObject:tv];
//   [self checkToSeeChangeViews];
//}
//
//- (void) checkToSeeChangeViews
//{
//   if (notificationMessageIndex < notificationMessageViews.count) {
//      
//      BTAppDelegate* appDelegate = (BTAppDelegate*)[[UIApplication sharedApplication] delegate];
//      if (![[appDelegate.window subviews] containsObject:[notificationMessageViews objectAtIndex:notificationMessageIndex]]) {
//         [appDelegate.window addSubview:[notificationMessageViews objectAtIndex:notificationMessageIndex]];
//      }
//      
//      [UIView animateWithDuration:0.7
//                       animations:^{
//                          [[notificationMessageViews objectAtIndex:notificationMessageIndex] setAlpha:1];
//                       }
//                       completion:^(BOOL finished){
//                       }];
//      
//      int current_index = notificationMessageIndex;
//      
//      double delayInSeconds = 3.0;
//      dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//      dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//         //code to be executed on the main queue after delay
//         [UIView animateWithDuration:0.7
//                          animations:^{
//                             [[notificationMessageViews objectAtIndex:current_index] setAlpha:0];
//                          }
//                          completion:^(BOOL finished){
//                             [self hideNotificationViewWithIndex:current_index];
//                             ++notificationMessageIndex;
//                             [self checkToSeeChangeViews];
//                          }];
//      });
//      
//   }
//}
//
//- (void) hideNotificationViewWithIndex:(int)index
//{
//   NSLog(@"SHOULD HIDE NOTIFICATION VIEW WITH INDEX %i", index);
//   if (index < notificationMessageViews.count) {
//      [[notificationMessageViews objectAtIndex:index] removeFromSuperview];
//   }
//}
//

@end
