###
# Copyright (c) 2016, Clifford Snow
# All rights reserved.
#
#
###

import csv
import osmapi



default = ''
# comment out next line when live
api = osmapi.OsmApi(api="api06.dev.openstreetmap.org")

# uncomment the next line when live
#api = osmapi.OsmApi()

cfile = open('picks.csv','wb')

with open('picks.txt') as picks:
    for line in picks:
        csid = line.rstrip()
        cs = api.ChangesetGet(csid)
        tags = cs.get('tag')
        c = [ cs["id"], cs["user"],  cs["created_at"], cs["closed_at"], tags.get('comment',default), tags.get('created_by',default), tags.get('imagery_used',default), tags.get('locale',default), tags.get('discussion',default) ]
        cwriter = csv.writer(cfile, delimiter=',',quotechar='"', quoting=csv.QUOTE_MINIMAL)
        cwriter.writerow(c)

cfile.close()
picks.close()

