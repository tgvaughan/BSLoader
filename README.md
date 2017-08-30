# BSLoader

This is a tiny R package designed to make loading scripts distributed with
[BEAST 2](https://beast2.org) trivially easy.

To install, enter the following from the R command line:

    install.packages("https://github.com/tgvaughan/BSLoader/releases/download/v1.0.0/BSLoader_1.0.0.tar.gz")
    
(You only need to do this once.)

Once installed, load the package using:

    library(BSLoader)

You can then use the `load.beast.scripts()` function to load all of the R scripts
distributed with a given package.  For example, to load the scripts distributed with
EpiInf (assuming this BEAST package is installed in the default location on your computer),
simply use

    load.beast.scripts("EpiInf")

Enjoy!
