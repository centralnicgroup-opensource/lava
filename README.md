# Lava

> Nothing keeps your couch warm and molten like Lava. Keep your views flowing.

Lava is a "view heater" for Apache CouchDB.

CouchDB views are updated on read, so if a db has been written to many times
without any reads in between, the next read of the view may be unexpectedly
long, while the updated index is computed. This can be avoided by reading the
view at reasonable internals, triggering an update. This is done using the
`stale=update_after` view parameter.

If you have large couch databases with views that are infrequently accessed, it
can take an unacceptably long time to build that view when it is queried by your
application.

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

## Thanks

Lava was painstakingly created by the self-proclaimed geniuses at
[iwantmyname], a fairly awesome domain registrar in Wellington, New Zealand. If
you like (dare I say, love?) Lava, be sure to think of us when you're getting
your next domain.

[iwantmyname]: https://iwantmyname.com/

