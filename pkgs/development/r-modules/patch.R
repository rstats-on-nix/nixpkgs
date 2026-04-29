lines <- readLines("generate-r-packages.R")

idx_start <- grep("^nixPrefetch <- function", lines)
idx_end <- grep("^}", lines)
idx_end <- idx_end[idx_end > idx_start[1]][1]

new_nixPrefetch <- c(
"nixPrefetch <- function(name, version) {",
"  prevPkg <- prevPkgs[[escapeName(name)]]",
"  if (!is.null(prevPkg) && prevPkg$version == version) {",
"    hash <- if (is.null(prevPkg$sha256)) NA_character_ else as.character(prevPkg$sha256)",
"    return(c(hash=hash, version=as.character(version)))",
"  } else {",
"    url <- paste0(mirrorUrl, name, \"_\", version, \".tar.gz\")",
"    tmp <- tempfile(pattern=paste0(name, \"_\", version), fileext=\".tar.gz\")",
"    cmd1 <- paste0(\"wget -q -O '\", tmp, \"' '\", url, \"'\")",
"    if(mirrorType == \"cran\"){",
"      archiveUrl <- paste0(mirrorUrl, \"Archive/\", name, \"/\", name, \"_\", version, \".tar.gz\")",
"      cmd1 <- paste0(cmd1, \" || wget -q -O '\", tmp, \"' '\", archiveUrl, \"'\")",
"    }",
"    sys_res <- system(cmd1)",
"    if (sys_res != 0 && mirrorType == \"cran\" && grepl(\"-[0-9]+$\", version)) {",
"       base_version <- sub(\"-[0-9]+$\", \"\", version)",
"       url_base <- paste0(mirrorUrl, name, \"_\", base_version, \".tar.gz\")",
"       archive_base <- paste0(mirrorUrl, \"Archive/\", name, \"/\", name, \"_\", base_version, \".tar.gz\")",
"       cmd2 <- paste0(\"wget -q -O '\", tmp, \"' '\", url_base, \"' || wget -q -O '\", tmp, \"' '\", archive_base, \"'\")",
"       if (system(cmd2) == 0) {",
"           version <- base_version",
"           sys_res <- 0",
"       }",
"    }",
"    if (sys_res != 0) return(c(hash=NA_character_, version=as.character(version)))",
"    cmd_hash <- paste0(\"nix-hash --type sha256 --base32 --flat '\", tmp, \"'\")",
"    res <- system(cmd_hash, intern=TRUE)",
"    res <- res[nzchar(res)]",
"    unlink(tmp)",
"    hash <- if (length(res) == 0) NA_character_ else res[length(res)]",
"    echo_cmd <- paste0(\"echo >&2 '  added \", name, \" v\", version, \"'\")",
"    system(echo_cmd)",
"    return(c(hash=as.character(hash), version=as.character(version)))",
"  }",
"}"
)

lines <- c(lines[1:(idx_start-1)], new_nixPrefetch, lines[(idx_end+1):length(lines)])

idx_apply <- grep("pkgTable\\$sha256 <- parApply", lines)
new_apply <- c(
"prefetch_res <- parApply(cl, pkgTable, 1, function(p) nixPrefetch(p[1], p[2]))",
"pkgTable$sha256 <- prefetch_res[\"hash\", ]",
"pkgTable$Version <- prefetch_res[\"version\", ]"
)
lines <- c(lines[1:(idx_apply-1)], new_apply, lines[(idx_apply+1):length(lines)])

writeLines(lines, "generate-r-packages.R")
