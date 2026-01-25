# Find deprecated DITA markup

This DITA-OT plugin helps locate (but not correct) use of deprecated markup.
Specifically, it adds a step into DITA-OT builds that will generate infomrational
messages about markup that is deprecated in DITA 1.x and will be removed in DITA 2.0.
The primary goal is to give you some idea how much these changes will impact your content.

This is a quick and dirty way to find some of the most common markup. 

Version one (the initial release) notified about markup that was officially marked deprecated or do-not-use
in DITA 1.x, based on the [DITA 2.0 proposal to remove deprecated markup](https://lists.oasis-open.org/archives/dita/201803/msg00024.html)

Version two (January 2026) adds additional messages about other markup that
is changing or going away in DITA 2.0. For example, it will warn about removed
elements like `<state>` and `<unknown>`. It will also notify about elements that will change, such as `<linktext>` moving to `<linktitle>`.  

The informational messages from the plugin help to locate each use of the deprecated
markup. A few non-specific messages will simply give a count of how often specific
markup is used, to get a better idea of the migration job ahead. For example, maps
that use `@navtitle` tend to use it a lot, so the message only reports the name
of the map and the count of `@navtitle` usage.

All but one of the messages in version two are informational; the only one that
comes out as a warning is for `@copy-to`, which does not yet have a clear migration
path in DITA 2.0.

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

To install version 0.2 from the DITA-OT command line, in the DITA-OT root directory, run:

`bin/dita --install https://github.com/robander/deprecated-dita/releases/download/v0.2/org.metadita.deprecated.zip`

To use the plugin, add the parameter `report.deprecated=true` to any DITA-OT transform that uses the full
preprocess pipeline. For example, the following command uses the DITA-OT user guide as an input map:

`bin/dita --input=docsrc/userguide.ditamap --format=html5 --report.deprecated=true`

If you only want to see messages about markup that can be fixed _before_ the migration
add the additional parameter `report.only.fixable=true`:

`bin/dita --input=docsrc/userguide.ditamap --format=html5 --report.deprecated=true --report.only.fixable=true`

To get a report on your own content, just change the input map parameter to your own content, and run with
whatever format and additional parameters you usually use. The log will contain messages 
for all deprecated markup.

## Automatically updating deprecated markup

Jason Fox's [DITA Validator](https://github.com/jason-fox/com.here.validate.svrl) plug-in will 
automatically detect any of the markup reported by this
plug-in, and apply the reccomended fix in that source file.
You should check it out.
