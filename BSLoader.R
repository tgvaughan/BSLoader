getOS <- function () {
    if (.Platform$OS.type == "windows")
        return("windows")

    if (Sys.info()["sysname"] == "Darwin")
        return("mac")

    return("otherunix")
}

guessBeastPackageLibraryDir <- function () {
    home <- path.expand("~")
    return(switch(getOS(),
                  windows =  file.path(home, "BEAST", "2.4"),
                  mac = file.path(home, "Library", "Application Support", "BEAST", "2.4"),
                  otherunix = file.path(home, ".beast", "2.4")))
}

guessBeastPackageDir <- function(packageName) {
    return(file.path(guessBeastPackageLibraryDir(), packageName))
}

beastPackageInstalled <- function(packageName) {
    return(length(dir(guessBeastPackageDir(packageName), pattern="version\\.xml"))>0)
}

#' Load R scripts provided by a BEAST 2 package.
#'
#' \code{load.beast.scripts} sources all of the R files provided by a named
#' BEAST 2 package.
#'
#' This command assumes packages are installed in the default location for your
#' operating system.
load.beast.scripts <- function (beastPackageName) {
    if (!beastPackageInstalled(beastPackageName))
        stop(paste0("BEAST package '", beastPackageName, "' is not installed.  Aborting."))

    scriptsDir <- file.path(guessPackageDir(beastPackageName), "scripts")

    for (scriptName in dir(scriptsDir, pattern="*\\.R")) {
        cat(paste0("Loading script ", scriptName, "\n"))
        source(file.path(scriptsDir, scriptName))
    }
}
