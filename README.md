# Excavatinator
This is an archaeology addon for World of Warcraft. Its main purpose is to serve
as a checklist for completed artifacts, but it has evolved over time to have a
lot of general purpose archaeology assistance.

Note that starting from version 4, much of the data handling has been separated
out into another addon named ExcavatinatorAPI. You will need to install it for
Excavatinator to work. It can be found in
[this repository](https://github.com/tutti/ExcavatinatorAPI).

## How to use
To open Excavatinator, use the slash command `/arch`. This will open the main
window, where you can see your overall progress for each race. The window is
paginated into the different expansions the archaeology races belong to, and you
can use the arrows at the top to navigate through the expansions.

For each listed race, the left side shows the race's name and icon, and your
overall progress (completed artifacts) for that race. Pristine artifacts are
counted separately here. The right side shows your active project for that race,
with the progress bar filling up as you get fragments. Once you have enough
fragments to solve the artifact, the icon will light up and can be clicked to
solve it. You can hover over any other part of the race line to see some more
information about your completion for that race, and click the same to open the
race details window.

The large button at the bottom of the main window is a survey button. You can
click it to cast Survey if you are in a digsite.

The crate at the bottom left shows the number of crates in your inventory, with
the number of artifacts you can crate in brackets. If you have any artifacts to
crate, the crate icon can be clicked to crate one of them.

The arrow next to the close button opens the mini-window. In older versions of
Excavatinator this would replace the main window; in this version it is a
separate window.

### The race details window
Clicking a race line in the main window opens this window below it. Basic
information about the race and your completion of it is shown in the left
portion, while the right (main) portion is the race's artifacts. The icons will
be lit up for completed artifacts. There will also be a small quest mark on
artifacts you have not found the pristine version for (if applicable), as well
as a counter for the collector achievements for the Mists artifacts, if you have
not completed them. You can hover over any artifact to see more information
about it, such as how many times you've completed it (if applicable) and the
game's description of it. For rare Legion artifacts this also shows you when
they will next be available.

### The mini-window
The mini-window is designed to be used for active digging. It has the Survey
button, the crate button, and a solve button that changes to whichever race you
last got fragments for. At the bottom it has a list of the digsites on the
continent you're on.

### Minimap tracking
This version re-introduces minimap tracking. When you make a find at a digsite,
Excavatinator remembers it and marks it on your minimap. These marks are only
visible while you're in an active digsite - once you finish digging (or leave
the digsite), the markings disappear, until the next time you dig in the same
digsite.

### Bulk crate purchasing
Excavatinator allows you to shift-click a fragment crate at any archaeology
vendor in order to enter a number of crates to purchase, like it was any
ordinary stackable commodity. It will then purchase that number of crates over
the course of a few seconds.

There is a simple popup that opens up the first time you visit a vendor that
this can apply to, telling you about this. I put it in because there is
otherwise no visual indication that you can do this now. Don't worry -
Excavatinator remembers that you've seen this popup, and won't show it to you
a second time.

## Known issues
- Sometimes, when hovering over an artifact icon, the description doesn't load. Hovering over it a second time will show the description.

## Why two addons?
I am not, nor have I ever been, a designer. I have tried to make Excavatinator
acceptably pleasant to look at, particularly with the latest version, but I
expect there are others who can do much better, should they want to. If anyone
wants to make use of the data processing aspect of Excavatinator and just design
a better interface, I wanted that to be possible without needing to load the
entire UI of Excavatinator as well.

I may, of course, be getting well ahead of myself in thinking that is something
anyone would want to do, but in case someone does - have at it :)