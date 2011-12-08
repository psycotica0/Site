
# This generates the default template script used by any tag without a special one

echo '#!/bin/sh

contents="$(cat)"
title="$(echo "$contents" | sed -n "/^Title:/s/^Title:[ 	]//p")"
body="$(echo "$contents" | sed "1,/^$/d")"
next="$(echo "$contents" | sed -n "/^Next-Link:/s/^Next-Link:[ 	]*//p")"
prev="$(echo "$contents" | sed -n "/^Previous-Link:/s/^Previous-Link:[ 	]*//p")"
id="$(echo "$contents" | sed -n "/^ID:/s/^ID:[ 	]*//p")"
' > "$3"
echo "tag='$1'" >> "$3"

echo 'redo-ifchange "tagindex"

tags="$(grep " $id\$" < tagindex | cut -d " " -f1)"

echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
echo "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">
<html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"en\">
<head>
<title>$title - psycoti.ca/0/</title>
<link rel=\"stylesheet\" href=\"../static/style.css\" />
<link rel=\"openid.server\" href=\"http://id.psycoti.ca/\" />
<link rel=\"openid.delegate\" href=\"http://id.psycoti.ca/\" />
<link rel=\"alternate\" type=\"application/atom+xml\" href=\"feed.atom\" />
</head>
<body>
<div id=\"header\">
<h1> psycoti.ca/0/ </h1>
</div>"
echo "<div id=\"navigation\">"
if [ -n "$prev" ]; then
	echo "<a href=\"$prev.html\" rel=\"prev\"> Prev </a>"
fi
if [ -n "$next" ]; then
	echo "<a href=\"$next.html\" rel=\"next\"> Next </a>"
fi
echo "</div>"
echo "<div id=\"tags\">"
echo "<ul>"
for t in $tags; do
	if [ "$t" = "$tag" ]; then
		echo "<li class=\"current\"> <a href=\"index.html\"> $t </a> </li>"
	else
		echo "<li> <a href=\"../$t/index.html\"> $t </a> </li>"
	fi
done
echo "</ul>"
echo "</div>"
echo "<div id=\"content\">
<h1> $title </h1>
$body
</div>
</body>
</html>"
' >> "$3"
chmod a+x "$3"
