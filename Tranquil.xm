//
//  Tranquil.xm
//  Tranquil
//
//  Created by Julian Weiss on 2/14/14.
//  Copyright (c) 2014 insanj. All rights reserved.
//

/*
 -[<SBTodayViewController: 0x13e69b360> commitInsertionOfSection:<SBBBSectionInfo: 0x1706212c0; representedObject: <SBBulletinListSection: 0x17811e8d0; type = Bulletin; sectionID = com.apple.mobiletimer>> beforeSection:(null)]
 -[<SBTodayViewController: 0x13e69b360> commitInsertionOfBulletin:<SBSnippetBulletinInfo: 0x178485500; representedObject: <BBBulletin: 0x13f829e10>{
		com.apple.mobiletimer / 0 / 8BDBD482-490A-4282-ABDE-09743E93EE87
		Match ID: DA3F90D3-BBBA-499C-8697-A4BA2EBCD35C
		Content: <redacted>
		Date: (null)
		Sound: (null)
	
	}> beforeBulletin:(null) inSection:<SBBBSectionInfo: 0x1706212c0; representedObject: <SBBulletinListSection: 0x17811e8d0; type = Bulletin; sectionID = com.apple.mobiletimer>> forFeed:32]

*/

#import "Tranquil.h"

%hook SBTodayViewController

-(void)commitInsertionOfBulletin:(id)bulletin beforeBulletin:(id)bulletin2 inSection:(id)section forFeed:(unsigned)feed{
	
	%orig();

	NSLog(@"[Tranquil] Listening to insertion, bulletin is: %@, section is: %@, section name is: %@", bulletin, section, [section identifier]);

	if([[section identifier] isEqualToString:@"com.apple.mobiletimer"])
		 [[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"TQAddClock" object:nil userInfo:@{@"bulletin" : bulletin}];
}

%end