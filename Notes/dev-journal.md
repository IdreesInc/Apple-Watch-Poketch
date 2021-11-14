# Dev Journal

## Sunday November 14th, 2021

- Completed calculator, turns out I had to do some weird hacks to get everything looking the same as it did on the OG Poketch.
  - Mainly this included ignoring leading zeros while allowing trailing zeros, which required handling the current value as a string rather than a decimal value. Decimal to string conversion doesn't have any obvious side effects that I can see, but I'm sure things get weird when using numbers that aren't actually numbers like infinity and all that.
- Also found a divide-by-zero bug after converting from doubles to decimals (to reduce floating point errors). Adding a check for "isFinite" and setting the "overflow" flag if not seems to have done the trick.
- There is one inaccuracy left where when the app first opens it isn't meant to show a digit at all but in my case shows zero. I will keep this for now.

## Saturday November 13th, 2021

- Now that my new MacBook Pro is here, I can finally get back to work. The stupid swiftui-frontend bug was making it almost impossible to do anything, but the new M1 chips can run simulators almost as fast as the preview on my old mac.
- Pretty satisfied with the app as-is, but there are a few more apps I want to get on there. Namely the calculator, Voltorb timer, and calendar.
- The drawing apps are probably more trouble than they're worth considering they'd break the swipe gestures as they are currently and I'd have to learn how to use the canvas API quickly. If I have time, maybe I'll consider them again.
- Calculator app almost done, just have to add the "?" symbol to the output for overflows.
  - Hopefully I've gotten all of the big floating point errors down. It's always messy converting between big number types and strings but I think I did it without any obvious errors.
  - The original Poketch completely ignores decimal points past the displayed digits, which works I guess but definitely reduces the accuracy. Haven't decided if I want to follow this pattern yet.
- Poketch complications left:
    - Clock ✅
    - Pedometer ✅
    - Counter ✅
    - Analog Watch ✅
    - Coin Toss ✅
    - Move Tester ✅
    - Color Changer ✅
    - Calculator ⏳
    - Calendar
    - Stopwatch

## Wednesday October 27th, 2021

- Completed move tester app.
    - You know how I said I added "most of" the move tester app last week? Turns out that the last 5% was debugging, and that was very annoying. It might've been easier if SwiftUI previews weren't broken once again, this time due to a memory leak bug that causes memory usage to go above 40gb for the swiftui-frontend process. Bloody Xcode, it truly is the worst.

## Friday October 22nd, 2021

- Added color changer app.
    - Not a big fan of how some of the glowing colors look washed out, but gotta stay authentic!
- Added most of the move tester app.
    - This one was particularly hard. Not only does it have a lot of moving parts, I also had to reimplement the pokemon type chart myself.

## Wednesday October 20th, 2021

- Added analog watch app.
    - I expected this to be easy, but I had a little difficulty getting the clock hands right. I forgot that while the minute hand rotation is easy to solve (minute/60), the hour hand is more complex. I had to get the minutes from midnight, modulo by 12 hours, and then use that divided by another 12 hours. I originally missed the modulo step and was off by a few degrees until I realized the error of my ways.
- Adjusted digital watch Pikachu and coin size to be more readable and better match the "resolution" of the other apps.
- EnvironmentObject now no longer seems to crash preview, so I have made all the views use that instead like originally planned.
- Began work on color changer app. Need to allow for dragging the slider, and then grab the colors for the other themes.

## Tuesday October 19th, 2021

- Added the pedometer app.
    - Had to think a little bit about how to make this actually work in the real world. Decided to show the current amount of steps for the day by default and then go from there as long as the app is open.
    - If the view is switched, the counter gets reset.
    - Pressing the "clear" button resets the step count to 0.
- I was surprised by how responsive the HealthKit integration was. Steps update about every 30 seconds which is a lot better than I would've expected on an Apple Watch. Obviously it'd have been nice if it updated every step but I'm not going to complain.
- I'm concerned about what happens to the HealthKit query when the view is refreshed. Does it get garbage collected, or is it still querying in the background and trying to update a view that doesn't exist?
    - Even worse, does that view actually exist in some phantom zone and I am just creating more and more views with each swipe? I sure hope not...
- Poketch complications left:
    - Clock ✅
    - Calculator
    - Memo Pad
    - Pedometer ✅
    - Counter ✅
    - Analog Watch
    - Marking Map
    - Coin Toss ✅
    - Move Tester
    - Calendar
    - Dot Artist
    - Roulette
    - Kitchen Timer
    - Color Changer
    - Stopwatch
    - Alarm Clock

## Monday October 18th, 2021

- Added the counter app.
    - Not particularly tricky, though I did have to mess around with a few options for buttons before deciding that sticking to drag gestures is probably my best bet.
    - I may revisit this later if I have the time and convert everything to buttons, but for now it's quicker to just stick with gestures and not have to manage state further than the view's "global" state.
- Also can't decide if I should retain the count when the app is swiped away. The original poketch doesn't do that so for now I am taking the easy route and letting it be temporary.
- Poketch complications left:
    - Clock ✅
    - Calculator
    - Memo Pad
    - Pedometer
    - Counter ✅
    - Analog Watch
    - Marking Map
    - Coin Toss ✅
    - Move Tester
    - Calendar
    - Dot Artist
    - Roulette
    - Kitchen Timer
    - Color Changer
    - Stopwatch
    - Alarm Clock

## Thursday October 14th, 2021

- Okay, graduation cap project mostly done so I can get back to business! Only about a month left before the games actually come out, so not much time to get all the apps I want made. But I'll do my best!
- Tweaked the coin toss animation to be more accurate.
    - It's hard to figure out the exact timing of the Poketch in the games, but just from eyeing it I think I've got the time right.
- Seems like past me started working on getting swipe gestures to switch views going. Finished the job by calculating the swipe direction.
- Poketch complications left:
    - Clock ✅
    - Calculator 
    - Memo Pad
    - Pedometer
    - Counter
    - Analog Watch
    - Marking Map
    - Coin Toss ✅
    - Move Tester
    - Calendar
    - Dot Artist
    - Roulette
    - Kitchen Timer
    - Color Changer
    - Stopwatch
    - Alarm Clock
- Not sure I am actually going to do all of these, especially since I don't have that many days left until release. Definitely went to get in the useful or fun apps though if I can.

## Thursday September 9th, 2021

- Using SwiftUI animations I can emulate the coin animation pretty well.
- Getting the timings right for the coin bounces was a matter of recording my game screen and watching it back frame by frame. It is still just an estimate, but it is a pretty accurate one at least.
- One funny problem I had was trying to figure out which side of the coin is meant to be heads or tails. Using the Pokemon anime as reference (Season 10, Episode 46) I figured out that the pokeball is meant to be tails. Wouldn't have guessed that.

## Wednesday September 8th, 2021

- Started on the coin toss app. I know it's not in order, but I figured I would start with the least complex apps and go from there so that I could make as many apps as possible in case I run out of time.
- Currently trying to figure out how to do translation animations in SwiftUI. The goal would be to implement the coin "toss" and "flipping" using animations rather than a timer that increments the offset manually, though I'll do that if I have to.
- 

## Monday September 6th, 2021

- Added the glow when pressed feature to the Digital Watch, akin to "Indiglo" on Timex watches (which feature I loved as a kid).
- Had some problems getting EnvironmentObjects to work without crashing my Preview. Even when making sure to initialize the objects in each view, it'd cause Preview to crash with weird errors. Instead I used ObservableObjects to keep the theme colors shared between views for when the Kecleon Color Changer app is added.

## Saturday September 4th, 2021

- Screenshotted 108 different Poketch states for reference using the MelonDS emulator (which is by far the best DS emulator out there). Noticed an easter egg with the Stopwatch where the Voltorb explodes if you keep the button held down long enough. Decided to update the Poketch [Bulbapedia](https://bulbapedia.bulbagarden.net/wiki/Pok%C3%A9tch) page with this info since it wasn't mentioned anywhere.
- One problem I have been mulling over is the best way to manage the different color options. I messed around with using a darker, transparent color for the sprites and just setting different backgrounds, but I could not get a good match. Black with 50% transparency works almost perfectly for the green LCD background, but it doesn't look right with the other colors. Instead I went with splitting the sprites into layers using GIMP and using ```renderingMode(.template)``` and ```foregroundColor``` to color each layer individually. I can stack the images using ZStack and then set the color for each layer depending on the current theme. It takes a bit more time to break each sprite down, but I definitely think this will make things a lot easier with theming in the long run as well as keeping things as faithful as possible. It also helps that there's only three different possible colors.
- I also managed to get the Always On feature working. Turns out that updating WatchOS to the next beta fixed it without any changes so it was probably a bug with the beta. I added in some code to stop the colon ticking when the luminance is reduced, but I should probably switch to using a [TimelineView](https://developer.apple.com/documentation/swiftui/timelineview) if possible instead for the Digital Watch app.

## Sunday August 29th, 2021

- Updated my devices to the beta OS so I could try out some new features. Mainly the Canvas API and the Always On Display.
- Having some trouble trying to get the Always On thing working. I'm probably missing something, I'll have to look more into it tomorrow.
- Also turns out I'm an idiot and missed the fact that the ContentView is not actually the root of the app. The Xcode project starts with a PoketchApp file that contains the content view wrapped in a NavigationView. That's why the navigation bar was causing so many problems with the full screen thing without me realizing. Lesson learned.

## Thursday August 26th, 2021

- Finally got the bloody full screen presentation working. I've spent ages trying to get the SwiftUI view to take up the full screen but I couldn't find any resources describing how. I only found some people saying to click the Storyboard toggle for full screen, which doesn't help in this case because I am using SwiftUI. Some were saying that only SpriteKit and SceneKit views can be set to full screen but even using those I couldn't get ignoresSafeArea(.all) to work. Eventually I found [this](https://developer.apple.com/forums/thread/656562) forum post which finally gave me the function I needed (navigationBarHidden(true)). I swear it is almost impossible to find external info related to SwiftUI on watchOS. I wonder if that's because nobody develops watchOS apps anymore or because SwiftUI is so new?
- On another note, the newish (new for me at least) Xcode preview thing is great! The problem is that SpriteKit scenes aren't available in the preview, so for now I am trying to get everything working with all the other SwiftUI tools available. Honestly this is probably a blessing in disguise since it is taking me out of my comfort zone (sprite and canvas-like drawing) and forcing me to learn how to use the proper tools (views and controls and all that).
- Added Pikachu to the digital watch app. It is adorable.
    - Need to make digits responsive so that they don't intersect with the electric mouse.