![App Icon](https://github.com/RedCommander735/Spritverbrauch/blob/main/android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png)
#  Spritverbrauch

A simple app to keep track of how much fuel you're using on average.


## Available languages
- German

## Project Git Structure
I established a simple system to manage this Git repository.
Basically, there are two main branches: **master** and **develop**. They both are permanent and cannot be deleted.

### Branch: master
This branch always and only contains the latest release version. This includes alpha/beta releases.

### Branch: develop
This branch contains the current development version. Small changes and fixes can be committed directly to this branch.

When it reaches a state ready to release, it can be merged into the **master**-branch and a new release can be published.

### Other branches
Especially bigger features which require multiple commits should branch off **develop** and merge back into it. These should be named in a way to describe the feature as clearly as possible.

These branches have a limited lifetime. After the last merge back into **develop**, they should be deleted if no longer needed.