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
 * media-libs/monado ebuild sets cap_sys_nice on /usr/bin/monado-service, so you don't have to remember to do it yourself
 * media-libs/opencomposite ebuild that is pinned to a specific git commit
 * adding a media-libs/wlx-overlay-25.3 ebuild & fixing the media-libs/wlx-overlay-s-9999 ebuild so that it actually builds

I might try to push some of these fixes to guru-overlay if I ever get
off of my lazy butt. Feel free to just add them there yourself too, if
I'm taking too long or whatever.

## Useful XR packages added that are currently missing in guru-overlay/upstream gentoo

 * app-misc/motoc added to be able to calibrate playspaces for FBT using
   e.g. Quest 2 + Vive Trackers with WiVRn.

Probably some upstreamability

## TODO

* TODO: Make an ebuild that is pinned to a specific version for media-libs/monado
* TODO: make an ebuild for xrizer
* TODO: make an ebuild for watchman-pairing-agent (also needs an ebuild for its dependency customtkinter)
* TODO: make an ebuild for wayvr-dashboard (TODO: Figure out how to build tauri thingies)
* TODO: make an ebuild for ALCOM (also make one for the CLI vrc-get)
* TODO: make an ebuild for VRCX (dotnet...)
* TODO: make an ebuild for ReVision (dotnet..)
* TODO: make an ebuild for EyeTrackVR (python, need to add license) (might need ebuild for PySimpleGui-4-foss)
* TODO: make an ebuild for project babble (python, need to add license)
* TODO: make an ebuild for VRCFT.Avalonia (dotnet...)
* TODO: make an ebuild for openvr-space-calibrator
* TODO: make an ebuild for overte
* TODO: make an ebuild for eepyxr (make an ebuild for the SDL3XR forked SDL and put it under a special prefix)
