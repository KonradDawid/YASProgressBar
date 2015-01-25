#YASProgressBar
Another simple resizable progress bar. Just for learning. 
![Awesome cat gif](https://github.com/KonradDawid/YASProgressBar/blob/master/anim.gif) 
## Usage

```   
YASProgressBar *progressBar = [[YASProgressBar alloc]initWithFrame:CGRectMake(100, 200, 200, 40) pulse:NO animated:YES];  
progressBar.trackColor = [UIColor colorWithRed:(61/255.0) green:(101/255.0) blue:(239/255.0) alpha:1.0];   
progressBar.backgroundColor = [UIColor colorWithRed:(97/255.0)  green:(170/255.0)  blue:(252/255.0)  alpha:1.0];  
progressBar.barColor = [UIColor blueColor];  
[self.view addSubview:progressBar];
```