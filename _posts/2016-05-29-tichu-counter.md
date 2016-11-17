---
title: Tichu Counter
---

I was playing a game of [Tichu][] with friends, when one of them suggested that instead of counting the points on paper, there should be an app for that.
So, naturally, after the game was over, I started working on one.

The basic requirements were the following:

1. Allow the tracking of points over several rounds compliant with Tichu rules
2. Be easy to use
3. Work on Android and iOS
4. Work offline
5. (Should not take to much time to program)

## Choosing the Right Tools

In order to archive the requirements 3 and 5 I choose html/css/js to build the app.
This might not be the best choice to build smartphone apps that should run offline, but it is possible and my go-to way for quickly building anything.

As I am using [GitHub Pages][] to publish the app/website I can use [Jekyll][]'s built-in compilers for SCSS and CoffeeScript, which are often more comfortable to write.
In order to use the latter, however, it is necessary to include a `_config.yml` file with the following content to load the CoffeeScript-Plugin:[^1]

[^1]:
	I learned later that this config file is not needed in order for GitHub Pages to compile CoffeeScript.
	You need it, however, if you want to use Jekyll to compile the file on your local machine.

```yml
gems:
    - jekyll-coffeescript
```

SCSS, on the other hand, is supported natively by Jekyll and doesn't need a plugin.
The only thing left to do is prefacing the SCSS and CoffeeScript files with a an empty YAML front matter consisting of two lines of three dashes (`---`) in order for Jekyll to process the file.
In the published version these files will now be replaced by their compiled counterparts bearing the same name, but a different extension. This allows an easy workflow with these pre-processors.

## Writing the Application

Writing the app itself was trivial by nature, as the app itself only stores two values and chances them on user input.
Because of that I'm going to focus more on the challenges of building it, which were making it look and work like a native app on smartphones.

### Optimizing the Experience for Smartphone Users

As this project was planed as an app and not a website I made the layout and design only for devices with a narrow screen, disregarding PCs and laptops completely.
I also adapted Google's [Material Design][] with [Materialize][] to give it a clean app-like look.

To make it look even more like an native app I also created a manifest for the "[Add to Homescreen][]"-function in Chrome on Android.
This allows the website to be opened without the navigation elements from chrome and also have a custom high-resolution icon on the homescreen.
(Which I didn't create yet)

### Caching

The most important part, however, was still missing.
The requirements included that the app needed to work offline.
In order for this to work, I created an `manifest.appcache` file and included it in the html via `<html manifest="manifest.appcache">`.
This file tells the browser which resources to cache and which to load from the internet.

However, because some browsers apparently don't support external links in the cache manifest I needed to include all used libraries locally first.
That meant downloading jQuery, MaterializeCSS and the Google Icon fonts and adding them directly to the project.

Then I added the following to the manifest to create it dynamically with Jekyll:

```liquid{% raw %}
---
# Empty front matter so that the file will be processed
---
CACHE MANIFEST                         # First line of the manifest
# {{ site.time | date_to_xmlschema }}  # Add a comment with the time the site
                                       # was last compiled, in order to check
                                       # for changes after the site is modified

CACHE:                                 # The following files will be cached

{% for file in site.static_files %}    # Loop over all static files
.{{ file.path }}{% endfor %}           # and print their path

{% for file in site.pages %}           # Loop over all generated files
.{{ file.url }}{% endfor %}            # and print their path

NETWORK:                               # Allow any other used resource to be
*                                      # loaded from the web
{% endraw %}```

The last two lines are only needed for Google Analytics to work if the user is online, as everything else is cached.

## Final Thoughts

While there could be still more done to make the app better (Refining the design for devices with very narrow screens, adding an icon, etc.) it works if you want to play Tichu regardless of your internet connection.

You can try the app [here](https://bernikr.github.io/tichu-counter) or look at the source code [here](https://github.com/bernikr/tichu-counter).

[tichu]: https://en.wikipedia.org/wiki/Tichu
[github pages]: https://pages.github.com/
[jekyll]: http://jekyllrb.com/
[material design]: https://www.google.com/design/spec/material-design/introduction.html
[materialize]: http://materializecss.com/
[add to homescreen]: https://developer.chrome.com/multidevice/android/installtohomescreen
