# Autofilter
<img src="https://raw.githubusercontent.com/Wyrrrd/Autofilter/master/thumbnail.png" width="128" height="128">

### Features
When you manually place an inserter, it reads the inventory contents, inventory filters or belt contents on the pickup side and enables and sets its filter to those items. There are extensive configuration options.

### Settings

There is only one text field to enter configuration into. This can be done on the fly, while ingame. You can add each of the following keywords into the text field, in any order, separated by spaces. They will be processed left to right.

+ **contents** - Checks for filter candidates in the inventory contents at the inserter's pickup position.
+ **filter** - Checks for filter candidates in the inventory's filter settings at the inserter's pickup position.
+ **belt** - Checks for filter candidates in the items on a belt at the inserter's pickup position.
+ **check** - Checks for the current filter candidates, if they could be inserted in the inventory at the inserter's drop position and removes them from the candidate list, if unsuccessful.
+ *anything else* - Gets ignored.

After those are processed, a deduplication removes all but the first appearance of each item from the filter candidate list, and then the candidates are written to the inserter's filter until it is full.

### Compatibility
This mod should work with all modded inserters, but I specifically added compatibility for the following mods:

+ [Bob's Adjustable Inserters](https://mods.factorio.com/mod/bobinserters) - rotated pickup positions

### Locale
If you want to contribute by translating this mod, you can view the existing translations on [Crowdin](https://crowdin.com/project/factorio-mods-localization). I'd be happy to add your language to the next release.
