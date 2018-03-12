# Find deprecated DITA markup

This DITA-OT plugin helps locate (but not correct) use of deprecated markup.
Specifically, it adds a step into DITA-OT builds that will generate infomrational
messages about markup that is deprecated in DITA 1.x and will be removed in DITA 2.0.
The primary goal is to give you some idea how much these changes will impact your content.

This is a quick and dirty way to find some of the most common markup. As of now,
it only notifies about markup that was officially marked deprecated or do-not-use
in DITA 1.x, based on the [DITA 2.0 proposal to remove deprecated markup](https://lists.oasis-open.org/archives/dita/201803/msg00024.html)

The informational messages from the plugin help to locate each use of the deprecated
markup. The only non-specific message is for `@navtitle`; because maps that use this
attribute tend to use it a lot, the message will only report the map and a count of `@navtitle` values
rather than generating a message for each instance.

The plugin does **not** yet identify any markup that might be changed or removed for
other reasons, because few proposals are advanced enough to know for sure that
other markup is being removed.

## Please be aware before updating!!

If you plan to update your content to remove deprecated markup, great!

But first, a warning. Switching from `@navtitle` to `<navtitle>` in maps requires
DITA-OT 3.0.3 in order to get the same results, after a defect in [`<navtitle>` processing](https://github.com/dita-ot/dita-ot/issues/2187) was [fixed in 3.0.3](https://github.com/dita-ot/dita-ot/pull/2897). 
DITA-OT 3.0.3 was released on 10 March 2018.

All other updates (removing
markup that doesn't do anything, or switching from old to new like `@alt` to `<alt>`) should be fine
with any 2.x version of DITA-OT. 

Also: I created this because I found it a useful way to check my content,
particularly content that is no longer edited regularly. If your editor already reports or fixes
deprecated markup (particularly if it can do so across your entire map), that's probably going
to be a better way to go.

## How to use

Install the latest version from https://github.com/robander/deprecated-dita/releases

To install version 0.1 from the DITA-OT command line, in the DITA-OT root directory, run:

`bin/dita --install https://github.com/robander/deprecated-dita/releases/download/v0.1/org.metadita.deprecated.zip`

To use the plugin, add the parameter `report.deprecated=true` to any DITA-OT transform that uses the full
preprocess pipeline. For example, the following command uses the DITA-OT user guide as an input map:

`bin/dita --input=docsrc/userguide.ditamap --format=html5 --report.deprecated=true`

To get a report on your own content, just change the input map parameter to your own content, and run with
whatever format and additional parameters you usually use. The log will contain informational messages 
for all deprecated markup.
