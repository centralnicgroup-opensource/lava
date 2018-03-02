# Lava

> Nothing keeps your couch warm and molten like Lava. Keep your views flowing.

Lava is a simple MIT-licensed shell script with 2 dependencies that ensures all
DBs that are readable by a given user have the views of their corresponding
design documents rebuilt. It takes a single parameter, a CouchDB instance url,
with optional credentials, and bails at the first sign of an error.

It is expected to be run from cron or similar scheduler every half an hour or
so.

## Usage

Just pass in your base CouchDB URL:

    /usr/local/bin/lava.sh https://user:passwd@localhost:5984

Note the lack of trailing slash / and a username and password. The user does
not need to have admin privileges on the DB nor on the couch instance, a read
only user suffices -- only the ddocs are actually read.

## Dependencies

- [/bin/sh](https://www.freebsd.org/cgi/man.cgi?query=sh) the one true shell
- [jq](https://stedolan.github.io/jq/) an incredible JSON processor
- [curl](https://curl.haxx.se/) the internet was broken before cURL
- [couchdb](https://couchdb.apache.org/) go forth and replicate

## Bugs

It would be nice if it could take a second optional parameter, consisting of
regexes for paths (db or ddocs) to skip. PRs are welcome.

<hr>
&#9829;&nbsp;[iwantmyname](https://iwantmyname.com/)
