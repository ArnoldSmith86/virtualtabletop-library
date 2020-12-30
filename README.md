# VirtualTableTop Library

## Maintenance

To extract the files to view their source:

    ./util/extract.sh

That creates a src dir with all the *.vtt files expanded.

To recreate the vtt files from source:

    ./util/build.sh

Note: this may cause vtt files to appear changed due to file timestamps
and relative vs absolute pathing of the zipped files.

Alternatively npm commands can be used:

    npm run extract
    npm run build
