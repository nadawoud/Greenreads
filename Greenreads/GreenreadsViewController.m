//
//  ViewController.m
//  Greenreads
//
//  Created by Nada Yehia Dawoud on 5/11/19.
//  Copyright © 2019 Mobile Apps Kitchen. All rights reserved.
//

#import "GreenreadsViewController.h"
#import "Book.h"

@interface GreenreadsViewController ()

@property (strong, nonatomic) NSMutableArray<Book *> *books;

@end

@implementation GreenreadsViewController
NSString *const cellIdentifier = @"bookCellIdentifier";
NSString *const authorName = @"John Green";
NSString *const urlString = @"https://api.myjson.com/bins/jmln2";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBooks];
    self.navigationItem.title = @"Greenreads";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    [self.tableView registerClass: UITableViewCell.class forCellReuseIdentifier: cellIdentifier];
    
    [self fetchBooksUsingJSON];
}

- (void)setupBooks {
    self.books = NSMutableArray.new;
}

- (void)fetchBooksUsingJSON {
    
    NSURL *url = [NSURL URLWithString:urlString];
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        NSError *err;
        NSArray *booksJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        if (err){
            NSLog(@"Failed to serialize into JSON: %@", err);
            return;
        }
        
        for (NSDictionary *booksDict in booksJSON) {
            Book *book = Book.new;
            book.title = booksDict[@"title"];
            book.publicationYear = booksDict[@"original_publication_year"];
            book.averageRating = booksDict[@"average_rating"];
            book.ratingCount = booksDict[@"ratings_count"];
            book.imageURLString = booksDict[@"image_url"];
            book.imageURL = [NSURL URLWithString:book.imageURLString];
            book.image = [NSData dataWithContentsOfURL:book.imageURL];
            
            
            [self.books addObject:book];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
        
        NSLog(@"Finished fetching books...");
        
    }] resume];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.books.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    
    Book *book = self.books[indexPath.row];
    cell.textLabel.text = book.title;
    cell.imageView.image = [[UIImage alloc] initWithData:book.image];
    NSString *rating = @"Average Rating: ";
    cell.detailTextLabel.text = [rating stringByAppendingString:book.averageRating];
    return cell;
}

@end
