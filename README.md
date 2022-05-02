# XKCD Reader

<p align="center">
    <a href="#" alt="Xcode Version">
        <img src="https://img.shields.io/static/v1?label=XCode%20Version&message=13&color=brightgreen&logo=xcode" alt="Xcode version 13"></a>
    <a href="#" alt="Swift Version">
        <img src="https://img.shields.io/static/v1?label=Swift%20Version&message=5&color=brightgreen&logo=swift" alt="Swift Version 5"></a>
    <a href="#" alt="Framework SwiftUI">
        <img src="https://img.shields.io/static/v1?label=Framework&message=SwiftUI&color=brightgreen&logo=Swift"
            alt="Framework SwiftUI"></a>  
      <a href="#" alt="Built for iOS 15">
        <img src="https://img.shields.io/static/v1?label=Built%20for&message=iOS%2015&color=brightgreen"
            alt="built for iOS 15"></a>
                  <a href="#" alt="Designed for iPhone 13">
        <img src="https://img.shields.io/static/v1?label=Designed%20for&message=iPhone%2013&color=brightgreen"
            alt="designed for iPhone 13"></a>
			
</p>

A simple XKCD viewer App built in SwiftUI. The app gets the comics from the official API.
## Screenshots
  
<p align="center">
<img width="1119" alt="Screenshots" src="https://user-images.githubusercontent.com/36189306/166219653-bd24a0f5-61e7-4680-ba11-d23ff95c50a4.png">
<img width="746" alt="darkmode" src="https://user-images.githubusercontent.com/36189306/166219657-17f5614d-5122-4fd5-acd3-454e034047ec.png">
</p>
<p align = "center">
  <i>The app is Dark Mode compatible.</i>
</p>

## Coding Challenge Overview

The app was built as a **coding challenge**, requiring the following features:
 - [x] browse through the comics,
 - [x] see the comic details, including its description,
 - [x] favorite the comics, ~~which would be available offline too~~
 - [x] support multiple form factors.
 - [ ] search for comics by the comic number as well as text
 - [ ] get the comic explanation
 - [ ] send comics to others
 - [ ] get notifications when a new comic is published

The challenge was to **prioritize these features and do as much as possible in 16 hours**. I managed to build the highlighted features in approx. 15 hours.

I kept track of my work with Toggl Track to better understand how I would tackle the challenge, here's a breakdown of how I spent these hours:

|   Description                                 |   Duration  |
|-----------------------------------------------|-------------|
|   Backlog analysis                            |   00:15:21  |
|   Wireframe                                   |   00:49:33  |
|   Project setup / UI Skeleton                 |   01:00:33  |
|   Architecture                                |   00:14:29  |
|   Completing the UI                           |   02:34:00  |
|   Comic view + completed interface structure  |   02:08:31  |
|   Networking & MVVM                           |   01:29:25  |
|   Networking                                  |   02:50:48  |
|   Connecting view w/ viewmodel                |   01:34:46  |
|   Added Favorites and left/right buttons      |   01:05:00  |
|   Minor changes & Comments                    |   01:00:34  |
|   **Total**                                   | **15:03:00**|

## The development process
In the beginning of the process I spent some time **planning** what to do, analysing the requirements and making some decisions about them. Then I created a **lo-fi prototype/wirefame** on Figma to get a rough idea of how I wanted things to look. This took a bit more than what I anticipated since in the beginning I misunderstood some requirements that led to drawing some useless screens.

<p align="center">
<img width="917" alt="Wireframe" src="https://user-images.githubusercontent.com/36189306/166222509-b44c259f-4625-4ecc-b5b6-51b30ef6616c.png">
</p>
<p align = "center">
  <i>The Figma Wireframe</i>
</p>

Once I had a clear idea about what I wanted to create, I spent some time setting up the project and building the basic skeleton of the app, this also involved starting to envision the overall architecture. I knew I wanted to use the MVVM pattern, but I still had to decide how to implement it.

Then it was a **deep dive on completing the interface**, which took me roughly 4 hours, maybe a bit more since I stumbled upon a nasty bug that took me some time to fix, time that I don't recall if I recorded on Toggl. The bug occurred while nesting a NavigationView inside a ScrollView inside a TabView, which led to some unexpected behaviour that I wasn't able to fix. Eventually, I decided to slightly modify the design of the detailed ComicView: going from a normal NavigationView page with Navigation Bar to a fullScreenCover Sheet. It was different from how I envisioned the app in the wireframe, but the time I saved removing the bug was well worth it. I also think the resulting design is more compliant with the Human Interface Guidelines.

Once the interface was working, it was time to focus on also making the app work. I spent some time **tinkering with API calls**, trying to understand how I wanted it to work. It took me a while to think an efficient way to manage calls. I probably missed some edge cases, especially about poor connectivity, but for the scope of the challenge it's good enough.

The app fetches the 10 comics at a time either at first launch or after the user taps the "show more" button at the end of the list. Each time the app is opened it also checks if new comics have been published and eventually fetches them. 

When the app retrieves the JSON files for the comics it decodes them in an array of objects. This array is then encoded and **stored locally** in UsersDefaults, this ensures that no useless API calls are done. Once information about a comic is obtained the first time, the next time is going to be retrieved locally without making any more calls.
The array is used to populate a LazyVGrid: the comic information comes from the stored data, the images from the internet using AsyncImage.

Thanks to the **MVVM** architecture was relatively easy to connect the interface to the logic and after I was done I also implemented the favorites functionality and the ability to switch comics from the ComicView itself.

Some other things that I didn't mention was the custom component to hide the Alt Text and the Explanation of the comic until the user decides to reveal it. The app is also compatible with Dark Mode and works automatically with the user's settings.

## Next steps
The challenge is over, but I might want to further expand the app as an exercise. Some things I have in mind:

- I might want to implement CoreData instead of relying of UserDefaults, it would be more elegant and the data might be easier to manipulate. Plus I could learn more about CoreData.
- I still have to finish the interface, specifically the MenuView and FiltersView. While the menu is trivial, the filters could be fun to explore.
- I also want to implement the sorting and the search functionality. The sort might be fun since I would have to rethink how the API calls are made and how data is stored. Now it just fetches 10 more comics from the last one it fetched, but if I give the user the ability to see older comics first I would have to reverse everything.
- The comic explanation is interesting too since I would add another data source, but being the wiki based on MediaWiki it should be easy to get every page in JSON format.
- Lastly, adding notifications is the most interesting aspect to me, since I've never worked with notifications yet and I would have to learn about it.

It has been fun building this small app for this challenge and I managed to learn some new things about API calls and SwiftUI.


