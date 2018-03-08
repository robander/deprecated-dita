# Find deprecated DITA markup

This DITA-OT plugin helps locate (but not correct) use of deprecated markup.
Specifically, it adds a step into DITA-OT builds that will report infomrational
messages about markup that is deprecated in DITA 1.x and will be removed in DITA 2.0.

This is a quick and dirty way to find some of the most common markup. As of now,
it only notifies about markup that was officially marked deprecated or do-not-use
in DITA 1.x, based on the [DITA 2.0 proposal to remove deprecated markup](https://lists.oasis-open.org/archives/dita/201803/msg00024.html)

The informational messages from the plugin help to locate each use of the deprecated
markup. The only non-specific message is for `@navtitle`; because maps that use this
attribute tend to use it a lot, the message will only report the map and a count of `@navtitle` values
rather than generating a message for each instance.

**NOTE NOTE NOTE**: If you plan to update your content to remove deprecated markup, great!
But first, a warning. Switching from `@navtitle` to `<navtitle>` in maps requires
DITA-OT 3.0.3 in order to get the same results, after a defect in [`<navtitle>` processing|](https://github.com/dita-ot/dita-ot/issues/2187) was [fixed in 3.0.3](https://github.com/dita-ot/dita-ot/pull/2897).

The plugin does **not** yet identify any markup that might be changed or removed for
other reasons, because few proposals are advanced enough to know for sure that
other markup is being removed.
