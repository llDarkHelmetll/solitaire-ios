
// Solitaire for iOS
// tepaanan@gmail.com
// FINLAND


#import "MainView.h"


@implementation MainView
@synthesize sourceDeckArray = _sourceDeckArray;


-(id) initWithCoder:(NSCoder*)sourceCoder
{
	if( (self = [super initWithCoder:sourceCoder]))
	{
        int screenWidth = self.bounds.size.width;
        int screenHeight = self.bounds.size.height;
        int cardWidth = screenWidth / 9;
        int cardHeight = cardWidth * 1.7;
        int cap = (screenWidth - cardWidth*7) / 8;
        
        // Array for the source decks
        self.sourceDeckArray = [[NSMutableArray alloc] init];
        
        // Source decks
        Deck* sourceDeck = [Deck alloc];
        [sourceDeck initWithData:cap:cardHeight*2:1:cardWidth:cardHeight:ESource];
		for (int i=0;i<2;i++)
		{
			Card* card = [Card alloc];
            [card initWithData:@"Club_ace.png":0:0:0:0:i:cardWidth:cardHeight];
            [sourceDeck addCard:card];
            [card release];
            card = nil;
		}
        [self.sourceDeckArray addObject:sourceDeck];
        [sourceDeck release];
        sourceDeck = nil;
        
        
        sourceDeck = [Deck alloc];
        [sourceDeck initWithData:cap*2+cardWidth:cardHeight*2:2:cardWidth:cardHeight:ESource];
		for (int i=0;i<3;i++)
		{
			Card* card = [Card alloc];
            [card initWithData:@"Club_ace.png":0:0:0:0:i:cardWidth:cardHeight];
            [sourceDeck addCard:card];
            [card release];
            card = nil;
		}
        [self.sourceDeckArray addObject:sourceDeck];
        [sourceDeck release];
        sourceDeck = nil;

        
        sourceDeck = [Deck alloc];
        [sourceDeck initWithData:cap*3+cardWidth*2:cardHeight*2:2:cardWidth:cardHeight:ESource];
		for (int i=0;i<4;i++)
		{
			Card* card = [Card alloc];
            [card initWithData:@"Club_ace.png":0:0:0:0:i:cardWidth:cardHeight];
            [sourceDeck addCard:card];
            [card release];
            card = nil;
		}
        [self.sourceDeckArray addObject:sourceDeck];
        [sourceDeck release];
        sourceDeck = nil;

        
        sourceDeck = [Deck alloc];
        [sourceDeck initWithData:cap*4+cardWidth*3:cardHeight*2:2:cardWidth:cardHeight:ESource];
		for (int i=0;i<5;i++)
		{
			Card* card = [Card alloc];
            [card initWithData:@"Club_ace.png":0:0:0:0:i:cardWidth:cardHeight];
            [sourceDeck addCard:card];
            [card release];
            card = nil;
		}
        [self.sourceDeckArray addObject:sourceDeck];
        [sourceDeck release];
        sourceDeck = nil;

        
        sourceDeck = [Deck alloc];
        [sourceDeck initWithData:cap*5+cardWidth*4:cardHeight*2:2:cardWidth:cardHeight:ESource];
		for (int i=0;i<6;i++)
		{
			Card* card = [Card alloc];
            [card initWithData:@"Club_ace.png":0:0:0:0:i:cardWidth:cardHeight];
            [sourceDeck addCard:card];
            [card release];
            card = nil;
		}
        [self.sourceDeckArray addObject:sourceDeck];
        [sourceDeck release];
        sourceDeck = nil;

        
        sourceDeck = [Deck alloc];
        [sourceDeck initWithData:cap*6+cardWidth*5:cardHeight*2:2:cardWidth:cardHeight:ESource];
		for (int i=0;i<7;i++)
		{
			Card* card = [Card alloc];
            [card initWithData:@"Club_ace.png":0:0:0:0:i:cardWidth:cardHeight];
            [sourceDeck addCard:card];
            [card release];
            card = nil;
		}
        [self.sourceDeckArray addObject:sourceDeck];
        [sourceDeck release];
        sourceDeck = nil;

        
        sourceDeck = [Deck alloc];
        [sourceDeck initWithData:cap*7+cardWidth*6:cardHeight*2:2:cardWidth:cardHeight:ESource];
		for (int i=0;i<8;i++)
		{
			Card* card = [Card alloc];
            [card initWithData:@"Club_ace.png":0:0:0:0:i:cardWidth:cardHeight];
            [sourceDeck addCard:card];
            [card release];
            card = nil;
		}
        [self.sourceDeckArray addObject:sourceDeck];
        [sourceDeck release];
        sourceDeck = nil;
        
        
        
        
	}
	return self;
}

- (void)dealloc {
	[_sourceDeckArray release];
    _sourceDeckArray = nil;
        

    
	// Remember to call base class dealloc
    [super dealloc];
}


-(void)drawRect:(CGRect)rect {
    //CGContextRef    context = UIGraphicsGetCurrentContext();
	
    // Game background
	[[UIColor greenColor] set];
	UIRectFill(rect);
	
    // Draw decks
    for(Deck* deck in self.sourceDeckArray)
    {
        [deck drawDeck];
    }
    
	
    // Draw active card on top of all others
	if (_activeCard)
	{
		[_activeCard drawCard];		
	}
	
}

-(Card*)findActiveCard:(CGPoint)point
{
    Card* card = nil;
    
    for(Deck* deck in self.sourceDeckArray)
    {
        card = [deck getCardAtPos:point];
        if (card)
            break;
    }    
    return card;
}

-(Deck*)findActiveDeck:(CGPoint)point
{
    Deck* ret = nil;
    
    for(Deck* deck in self.sourceDeckArray)
    {
        if(CGRectContainsPoint(deck.deckRect,point))
        {
            ret = deck;
            break;
        }
    }    
    return ret;
}

-(void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    UITouch* touchPoint = [touches anyObject]; 
    CGPoint point = [touchPoint locationInView:self];   
	
    _activeCard = [self findActiveCard:point];
    if (_activeCard)
    {
        xCap = point.x - _activeCard.cardRect.origin.x;
        yCap = point.y - _activeCard.cardRect.origin.y;
        
        [_activeCard storeCurrentPos];
	}
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (_activeCard)
	{
        UITouch* touch = [touches anyObject];
        CGPoint point = [touch locationInView:self];
		[_activeCard setPos:point.x - xCap:point.y - yCap];
		[self setNeedsDisplay];
	}
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{	
	if (_activeCard)
	{
        UITouch* touch = [touches anyObject];
        CGPoint point = [touch locationInView:self];
		[_activeCard setPos:point.x - xCap:point.y - yCap];
		
        
        // Change car deck to another
        Deck* toDeck = [self findActiveDeck:point];
        if (toDeck) {
            BOOL ret = [_activeCard changeDeckTo:_activeCard.ownerDeck:toDeck];
            if (!ret) 
               [_activeCard cancelMove]; 
        } else {
            [_activeCard cancelMove];
        }
    
        
        [self setNeedsDisplay];
		_activeCard = nil;
	}
    
}



@end
