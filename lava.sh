#!/bin/sh -e
# requires:
#   textproc/jq
#   ftp/curl
# expects:
#   argv is set to something like http://admin:passwd@localhost:5984
#   note the lack of trailing /
#   ensure the user has sufficient permissions to read all DBs
couch=${1:-"http://localhost:5984"}
dbs=`curl -s ${couch}/_all_dbs | jq -r '.[]' | egrep -v '^(_replicator|_users)$'`
# loop over all non-system dbs
for db in ${dbs}
do
		# loop over all ddocs
		ddocs=`curl -s ${couch}/${db}/_all_docs\?startkey=\"_design/\"\&endkey=\"_design/\uffff\" | jq -r '.rows[].id'`
		for ddoc in ${ddocs}
		do
				# get the name of the first view in this ddoc
				view=`curl -s ${couch}/${db}/${ddoc} | jq -r '.views  // empty | keys[0]'`
				echo heating ${db}/${ddoc}/_view/${view}
				# skip any ddoc that has no views to heat
				if [ "$view" ]
				then
						curl --head -s ${couch}/${db}/${ddoc}/_view/${view}\?stale=update_after > /dev/null
				fi
		done
		echo ${db} done
done
echo OK

