getOS <- function () {
    if (.Platform$OS.type == "windows")
        return("windows")

    if (Sys.info()["sysname"] == "Darwin")
        return("mac")

    return("otherunix")
}

guessBeastPackageLibraryDir <- function (version=2.4) {
    home <- path.expand("~")
    return(switch(getOS(),
                  windows =  file.path(home, "BEAST", version),
                  mac = file.path(home, "Library", "Application Support", "BEAST", version),
                  otherunix = file.path(home, ".beast", version)))
}

guessBeastPackageDir <- function(packageName, version=2.4) {
    return(file.path(guessBeastPackageLibraryDir(version), packageName))
}

beastPackageInstalled <- function(packageName, version=2.4) {
    return(length(dir(guessBeastPackageDir(packageName, version),
                      pattern="version\\.xml"))>0)
}

#' Load R scripts provided by a BEAST 2 package.
#'
#' \code{load.beast.scripts} sources all of the R files provided by a named
#' BEAST 2 package.
#'
#' This command assumes packages are installed in the default location for your
#' operating system.
#'
#' @param beastPackageName Name of an installed BEAST 2 package. (Case sensitive)
#' @param beastVersion Version of BEAST 2.
#' 
#' @return This function doesn't return anything.  It simply loads (sources) the
#' R scripts it finds.
#'
#' @export
load.beast.scripts <- function (beastPackageName, beastVersion=2.4) {
    if (!beastPackageInstalled(beastPackageName, beastVersion))
        stop(paste0("BEAST package '", beastPackageName, "' is not installed.  Aborting."))

    scriptsDir <- file.path(guessBeastPackageDir(beastPackageName, beastVersion), "scripts")

    for (scriptName in dir(scriptsDir, pattern="*\\.R")) {
        cat(paste0("Loading script ", scriptName, "\n"))
        source(file.path(scriptsDir, scriptName))
    }
}
