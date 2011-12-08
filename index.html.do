
# This file makes my index page

echo '<?xml version="1.0" encoding="UTF-8"?>'
echo '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<title>'
echo "psycoti.ca/0/"
echo '</title>
<link rel="stylesheet" href="static/style.css" />
<link rel="openid.server" href="http://id.psycoti.ca/" />
<link rel="openid.delegate" href="http://id.psycoti.ca/" />
<link rel="alternate" type="application/atom+xml" href="main/feed.atom" />
</head>
<body>
<div id="header">
<h1> psycoti.ca/0/ </h1>
</div>
'

redo-ifchange "tagindex"

tags="$(cut -d ' ' -f 1 < "tagindex" | sort | uniq)"

echo "<div id='tags'>Tags:<ul>"
for t in $tags; do
	echo "<li> <a href=\"$t/index.html\"> $t </a> </li>"
done
echo "</ul></div>"

echo '<div id="content">'

echo '<img src="static/avatar.png" alt="avatar" class="avatar" />
This is the website of Christopher Vollick.
<dl>
<dt> GitHub: </dt> <dd> <a href="https://github.com/psycotica0"> https://github.com/psycotica0 </a> </dd>
<dt> Email: </dt> <dd> <a href="mailto:0@psycoti.ca"> 0@psycoti.ca </a> </dd>
<dt> Email: </dt> <dd> <a href="mailto:psycotica0@gmail.com"> psycotica0@gmail.com </a> </dd>
<dt> XMPP: </dt> <dd> <a href="xmpp:0@psycoti.ca"> 0@psycoti.ca </a> </dd>
<dt> XMPP: </dt> <dd> <a href="xmpp:psycotica0@gmail.com"> psycotica0@gmail.com </a> </dd>
<dt> Identi.ca: </dt> <dd> <a href="http://identi.ca/psycotica0"> http://identi.ca/psycotica0 </a> </dd>
<dt> Twitter: </dt> <dd> <a href="http://twitter.com/psycotica0"> http://twitter.com/psycotica0 </a> </dd>
</dl>

<p>
The articles contained on this site are sorted into tags.
If you choose a tag from the list, it will list you all articles with that tag and you can read them from there.
They are sorted such that the newest article is at the top.
</p>

<p>
The "main" tag is intended to collect all articles, so clicking that link should take you to a full listing.
</p>
'


echo '</div>
</body>
</html>'
