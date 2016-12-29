# DxWaveRefresh_Swift

pull down to refresh with wave animation. by swift 3.0

#demo


![](https://github.com/StevenDXC/DxWaveRefresh_Swift/blob/master/image/waverefresh.gif)

#usage


```swift
let contentView = WaveRefreshView(frame: CGRect(x:0,y:0,width:view.bounds.width,height:1000));
contentView.topMargin = 200;      
contentView.bgColor = UIColor.white;
contentView.waveAmplitude = 15;
contentView.angle = 10;
contentView.gravity = .left
contentView.waveAnimationDuration = 1.6;

//add WaveRefreshView to UIScrollView, and as first child view
scrollView.addSubview(contentView!)
```

pulling down:

```swift
 contentView.progress = progress; //pregress = current scrollView.contentOffset.y / the contentOffsetY of trigger refreshing
```

start refreshing:

```swift
contentView.startRefreshing();
```


stop refreshing:

```swift
contentView.stopRefreshing();
```



