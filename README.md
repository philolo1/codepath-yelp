## Yelp

This is a restaurant app displaying information with the ability to filter [YELP API](http://www.yelp.com/developers/documentation/v2/search_api).

Time spent: 15

### Features

I played with the headers a little bit so that one can click on the header and decollapse it in the selector without going back.

#### Required
- [x] Table rows should be dynamic height according to the content height
- [x] Custom cells should have the proper Auto Layout constraints
- [x] Search bar should be in the navigation bar (doesn't have to expand to show location like the real Yelp app does).
- [x] category, sort (best match, distance, highest rated), radius (meters), deals (on/off).
- [x] The filters table should be organized into sections as in the mock.
- [x] Radius filter should expand as in the real Yelp app

[x] Categories should show a subset of the full list with a "See All" row to expand. Category list is here: http://www.yelp.com/developers/documentation/category_list (Links to an external site.)

[x] Clicking on the "Search" button should dismiss the filters page and trigger the search w/ the new filter settings.


#### Comment 
I only did autolayout for the yelp cell. For the cell with the slider it did not make sense for me. I invested a lot of time making the app look good and playing with header. I somehow lost track of time and then had some bugs which I wanted to fix. I also did not wanted to watch the video of the filter and explore it myself. That is why it took longer than i expected. But I learned really a lot.

### Walkthrough
![Video Walkthrough](https://github.com/philolo1/rottentomatoes/blob/master/rot.gif)

Credits
---------
* [YELP API](http://www.yelp.com/developers/documentation/v2/search_api).
* [AFNetworking](https://github.com/AFNetworking/AFNetworking)










