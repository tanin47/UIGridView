TNGridview (iOS = iPhone/iPad)
========================

TNGridview offers a simple way to build a grid (multiple-column UITableView).

It supports:

* Adjust the width of a column (individually)
* Adjust the height of a row (individually)
* Click event on a cell
* Customize cell

Here is how it looks like:

![TNGridview Example](https://github.com/tanin47/UIGridview/raw/master/uigridview_example.png)


How to use it
------------------------
1. Include /Classes/TNGridview/* into your project
2. Setup the delegate ```TNDemoGridViewDelegate``` of TNGridview; Methods that shall be implemented are shown below:

```objc
- (CGFloat) gridView:(TNGridview *)grid widthForColumnAt:(int)columnIndex
{
	return 80;
}

- (CGFloat) gridView:(TNGridview *)grid heightForRowAt:(int)rowIndex
{
	return 80;
}

- (NSInteger) numberOfColumnsOfGridView:(TNGridview *) grid
{
	return 4;
}


- (NSInteger) numberOfCellsOfGridView:(TNGridview *) grid
{
	return 33;
}

- (TNGridviewCell *) gridView:(TNGridview *)grid cellForRowAt:(int)rowIndex AndColumnAt:(int)columnIndex
{
	Cell *cell = (Cell *)[grid dequeueReusableCell];
	
	if (cell == nil) {
		cell = [[Cell alloc] init];
	}
	
	cell.label.text = [NSString stringWithFormat:@"(%d,%d)", rowIndex, columnIndex];
	
	return cell;
}

- (void) gridView:(TNGridview *)grid didSelectRowAt:(int)rowIndex AndColumnAt:(int)colIndex
{
	NSLog(@"%d, %d clicked", rowIndex, colIndex);
}
```

Author
------------------------
Tanin Na Nakorn


License
---------

Do What The Fuck You Want To Public License (http://sam.zoy.org/wtfpl/)

0. You just DO WHAT THE FUCK YOU WANT TO.
