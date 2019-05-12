//
//  Book.h
//  Greenreads
//
//  Created by Nada Yehia Dawoud on 5/11/19.
//  Copyright © 2019 Mobile Apps Kitchen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Book : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *averageRating;
@property (strong, nonatomic) NSString *ratingCount;
@property (strong, nonatomic) NSString *publicationYear;
@property (strong, nonatomic) NSString *imageURLString;
@property (strong, nonatomic) NSURL *imageURL;
@property (strong, nonatomic) NSData *image;

@end

NS_ASSUME_NONNULL_END
