# Xantoz overlay for various XR bits and bobs

At the moment this overlay is intended to be used together
with/extending the guru overlay. It adds some packages not in there +
otherwise customizing or fixing things about the XR-related ebuilds in
the guru overlay where whatever those ebuilds were doing didn't work for
me and what I was trying to do.

As you can see it's mainly a personal overlay for myself at the moment,
but maybe you will find some of the stuff here useful too?

## Tweaks compared with packages in guru overlay

Packages that already exists over in guru but that have various fixes included but are not limited to:
 * media-libs/monado being built against the system cjson causes issues
   running steam games (libcjson is not available inside the steam linux
   runtime), so we build it with the bundled cjson here.
 * media-libs/wivrn is built with support for lighthouse tracking so that
   one can use lighthouse tracked devices together with e.g. a Meta
   Quest (calibration of the two playspaces requires motoc)
 * media-libs/opencomposite ebuild that is pinned to a specific git commit
 * media-libs/wlx-overlay-s-9999 ebuild that actually builds (ATM I just removed the patches from the one I found in guru-overlay)

I might try to push some of these fixes to guru-overlay if I ever get
off of my lazy butt. Feel free to just add them there yourself too, if
I'm taking too long or whatever.

## Useful XR packages added that are currently missing in guru-overlay/upstream gentoo

 * app-misc/motoc added to be able to calibrate playspaces for FBT using
   e.g. Quest 2 + Vive Trackers with WiVRn.

Probably some upstreamability

## TODO

* TODO: Make an ebuild that is pinned to a specific for media-libs/monado
* TODO: Make an ebuild for wlx-overlay-s that isn't a -9999 (v25.3 seems good)
* TODO: make an ebuild for xrizer
* TODO: make an ebuild for watchman-pairing-agent (also needs an ebuild for its dependency customtkinter)
* TODO: make an ebuild for wayvr-dashboard (might be hard, doesn't seem like there's any upstream ebuilds for tauri...)
