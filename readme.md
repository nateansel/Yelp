# Project 3 - *Yelp*

**Yelp** is a Yelp search app using the [Yelp API](https://www.yelp.com/developers/documentation/v3).

Time spent: **3** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] Table rows for search results should be dynamic height according to the content height. (3pt)
- [x] Custom cells should have the proper Auto Layout constraints. (+5pt)
- [x] Search bar should be in the navigation bar (doesn't have to expand to show location like the real Yelp app does). (+2pt)

The following **stretch** features are implemented:

- [ ] Infinite scroll for restaurant results. (+3pt)
- [ ] Implement map view of restaurant results. (+3pt)
- [ ] Implement the restaurant detail page. (+2pt)

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. I’d like to talk about the positives and negatives for using a UISearchBar vs. a UISearchController in iOS 11. iOS 11 added integration functionality with the UISearchController and UINavigationBars, and I would like to discuss when we should use each of the different methods.
2. I’d like to discuss how to use the Codable protocol to decode the results from the API, as it is a very easy way to translate the JSON results into objects in our apps.

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='https://github.com/nateansel/Yelp/blob/master/week3.gif' title='Video Walkthrough' width='300px' alt='Video Walkthrough'/>

GIF created with [Gifox](https://gifox.io).

## Notes

Describe any challenges encountered while building the app.

I initially had trouble with using the Codable protocol to decode the results before realizing that I had made a small mistake with the type for some of the variables I was attempting to decode. I set a variables type as a `String` rather than a `Float`. It took me longer than I care to admit to find that issue!

## License

    Copyright [2018] [Nathan Ansel]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.