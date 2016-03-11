// Bundle
static const NSBundle *tweakBundle = [NSBundle bundleWithPath:@"/Library/Application Support/NotesCreationDate"];
#define LOCALIZED(str) [tweakBundle localizedStringForKey:str value:@"" table:nil]

@interface ICNoteEditorViewController : UIViewController
- (void)updateDateLabel;
@end

%hook ICNoteEditorViewController

- (void)viewDidLayoutSubviews {
	%orig;
	[self updateDateLabel];
}

- (void)viewDidAppear:(BOOL)animated {
	%orig;
	[self updateDateLabel];
}

%new
- (void)updateDateLabel {
	id note = [self valueForKey:@"note"];

	NSDateFormatter *dateFormatter = (NSDateFormatter *)[self valueForKey:@"dateFormatter"];
	NSDate *creationDate 	 = (NSDate *)[note valueForKey:@"creationDate"];
	NSDate *modificationDate = (NSDate *)[note valueForKey:@"modificationDate"];
	NSString *creationDateString 	 = [dateFormatter stringFromDate:creationDate];
	NSString *modificationDateString = [dateFormatter stringFromDate:modificationDate];

	NSString *lineOne  = [NSString stringWithFormat:@"%@ %@", LOCALIZED(@"CREATED"), creationDateString];
	NSString *lineTwo  = [NSString stringWithFormat:@"%@ %@", LOCALIZED(@"MODIFIED"), modificationDateString];
	NSString *fullText = [NSString stringWithFormat:@"%@\n%@", lineOne, lineTwo];

	id textView = [self valueForKey:@"textView"];
	UILabel * dateLabel = (UILabel *)[textView valueForKey:@"dateLabel"];
	[dateLabel setNumberOfLines:0];
	[dateLabel setText:fullText];
}

%end

%hook ICTextView

- (double)dateLabelOverscroll {
	double r = %orig;
	return r * 2;
}

%end
