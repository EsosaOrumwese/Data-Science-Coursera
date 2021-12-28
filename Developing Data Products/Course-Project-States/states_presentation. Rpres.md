Developing Data Products - Course Project (States Dataset)
========================================================
author: Esosa Orumwese
date: 28/12/2021
autosize: true
width: 1600
height: 900

Introduction
========================================================

- We want to be able to visualize the areas of US states. This was achieved using the US States Facts and Figures data set. 

- The sliders can be used to select the area range to display and check boxes to select different regions (North Central, Northeast, South and West). 



This shiny app will produce an interactive map of the US showing the states that satisfy the selected criteria.

Documentation
========================================================

- A data.frame called `states` was created using the vectors from the US Facts and  Figures data set.
 
- A fourth column (`hover`) was added for the interactivity of the map


```r
states <- data.frame(state.name, state.area, state.region,
                      hover=paste0(state.name, ": ", state.area,
                                   "square miles"))
states$hover <- as.character(states$hover)
```


Summary of Data set
========================================================

```r
head(states, 10)
```

```
    state.name state.area state.region                          hover
1      Alabama      51609        South     Alabama: 51609square miles
2       Alaska     589757         West     Alaska: 589757square miles
3      Arizona     113909         West    Arizona: 113909square miles
4     Arkansas      53104        South    Arkansas: 53104square miles
5   California     158693         West California: 158693square miles
6     Colorado     104247         West   Colorado: 104247square miles
7  Connecticut       5009    Northeast  Connecticut: 5009square miles
8     Delaware       2057        South     Delaware: 2057square miles
9      Florida      58560        South     Florida: 58560square miles
10     Georgia      58876        South     Georgia: 58876square miles
```

Links
========================================================
- Shiny app: https://youtube.com
- source code; https://instagram.com/esosaorumwese
