# flutter_parallex

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.




TXT

So there are multiple ways to implememnt parallax effect in flutter 

1 
We use positioned widgets in Stack and change its parameters based on scroll value from ScrollListener 
With this we can achieve the parallax effect of whole screen like on the websites 
implementation in parallex1.dart 
source - https://www.youtube.com/watch?v=eJ_61QiJ_Sw 
https://github.com/MarcinusX/go_to_egypt 
Not very effective, we have to manage a stack and the control is difficult although the implementation is simple 

2 
But what if we have to implememnt this effect on a listView or cardView? 
where multiple similar items have to show parallax respective of each other 
We will then utilise a PageView 
implementation in parallex2.dart 
source : https://fidev.io/tickets-challenge-parallax/ and https://medium.com/@taydinadnan/flutter-parallax-animasyonu-nas%C4%B1l-yap%C4%B1l%C4%B1r-b1294484547d

/// Basics
/// inspired from
/// https://medium.com/@taydinadnan/flutter-parallax-animasyonu-nas%C4%B1l-yap%C4%B1l%C4%B1r-b1294484547d 
/// and 
/// https://fidev.io/tickets-challenge-parallax/ 
/// 

3 
Parallax using flutter widgets Flow and ParallaxFlowDelegate 
source : official cookbook https://docs.flutter.dev/cookbook/effects/parallax-scrolling
and https://www.youtube.com/watch?v=EUli31dh6MM&t=3s
using Videos : https://www.youtube.com/watch?v=tgK0u0qwM70 


4 
Parallax but with multiple images - 
method 1 - what we did in parallax2 - using PageViewer 
+ instead of using setState we will utilise AnimationBuilder 

5 
Parallax but with multiple images - but not on users's swipe actions.. instead on users action of moving the physcial device 
that is - using accelerometer sensor and we will utilise carouselSlider from the same name package instead of cooking stuff on our own using pageviews 


I loved the approach in parallax 2, using pageviews (can be done using carouselSlider as well)
so I am going to make a custom parallax Widget keeping best of what i've learned till now 
- use a pageView 

to simplify the things, we will just seperate the parallax Widget from the widget tree so setState will have minimal effect 
OR we can simply use a AnimatedBuilder anywhere we want to change offsets and we can provide the pageController as the listener to the animationBuilder widget 






