//
//  MatchupCell.h
//  Pace Race
//
//  Created by Craig Hewitt on 10/14/13.
//  Copyright (c) 2013 Craig Hewitt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MatchupCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *averagePaceLabel;
@property (nonatomic, weak) IBOutlet UILabel *averageDistanceLabel;
@property (nonatomic, weak) IBOutlet UILabel *nextRunLabel;

@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;
@end
