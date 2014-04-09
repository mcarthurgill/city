//
//  BTSession.h
//  Banter
//
//  Created by William L. Schreiber on 11/14/13.
//  Copyright (c) 2013 Bus Productions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoadURLJson.h"
#import "User.h"
//#import "Post.h"
//#import "Group.h"
//#import "IIViewDeckController.h"

@interface BTSession : NSObject 
{
   LoadURLJson* loadJson;
   int notificationMessageIndex;
}

+(BTSession*) thisSession;
-(void) setVariables;

@property (strong, nonatomic) NSString* baseURL;

@property (strong, nonatomic) NSMutableArray* requests;

@property (strong, nonatomic) NSString* deviceTokenString;

@property (strong, nonatomic) User* loggedInUser;

@property (strong, nonatomic) NSString* actionAfterLogin;

//@property (strong, nonatomic) Group* currentGroup;

@property (strong, nonatomic) NSArray* fonts;

- (NSDictionary*) countryCodeByCallingCode;
- (NSDictionary*) countryCallingCodes;
- (NSDictionary*) countriesByCountryCode;
- (NSDictionary*) countriesByCountryName;

- (NSString *)applicationDocumentsDirectory;

//@property (strong, nonatomic) Post* visiblePost;

//@property (strong, nonatomic) IIViewDeckController* thisViewDeck;

@property (strong, nonatomic) NSMutableArray* notificationMessageViews;


//METHODS

- (BOOL) isLoggedIn;

- (UIColor*) greenColor;
- (UIColor*) greenColorTrans;
- (UIColor*) redColor;
- (UIColor*) offwhiteColor;
- (UIColor*) softBlackColor;
- (UIColor*) softerBlackColor;
- (UIColor*) goldColor;

- (UIFont*) helveticaFont:(float)size;

- (void) logFontNames;

//- (NSNumber*) loggedInUserID;

- (void) loginUser:(User*)user;
- (void) logoutUser;

//- (void) updateDeviceToken:(NSData*)deviceToken;

//- (void) showNewGroupAndSidebar;

//- (void) contactsSelectorReturnsWithArrayOfContacts:(NSMutableDictionary*)people;

- (NSString*) timeAgoInWords:(double) relativeTimestamp;
//
//- (void) initialLoad;
//
- (NSString*)getAuthTokenBase;


//SERVER STUFF
//
////users
//- (void) sendTokenHTTP:(NSString*)number key:(NSString*)key countryCode:(NSString*)countyCode;
//- (void) loginUserHTTP:(NSString*)phone nakedPassword:(NSString*)nakedPassword name:(NSString*)name countryCode:(NSString*)countryCode;
//- (void) userDetailHTTP:(NSNumber*)user_id password:(NSString*)encryptedPassword;
//- (void) updateUserHTTP:(NSString*)name;
////posts
//- (void) getAllUnseenPostsHTTP;
//- (void) submitPostHTTP:(Post*)post image:(UIImage*)image video:(NSString*)videoURL;
//- (void) submitPostViewHTTP:(Post*)post;
//- (void) submitPostLikeHTTP:(Post*)post;
//- (void) submitScreenshotHTTP:(Post*)post;
////groups
//- (void) createGroupWithNameHTTP:(NSString*)group_name;
//- (void) updateGroupWithIDHTTP:(NSNumber *)group_id groupName:(NSString*)group_name;
//- (void) groupDetailWithIDHTTP:(NSNumber*)group_id;
//- (void) groupSendInvitationsHTTP:(NSArray *)numbers groupID:(NSNumber*)group_id;
////memberships
//- (void) updateMembershipHTTP:(Membership*)membership withUserName:(NSString*)userName;
//- (void) destroyMembership:(Membership*)membership;
//- (void) destroyMembershipHTTP:(Membership*)membership;
//- (void) toggleNotificationSettingForMembers:(Membership*)membership to:(NSString*)newSetting;
//

// notifications
- (void) createNotificationWindowWithMessage:(NSString*)message;


@end
