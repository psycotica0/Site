
# This generates the default template script used by any tag without a special one

echo '#!/bin/sh

contents="$(cat)"
title="$(echo "$contents" | ./extract_headers "Title")"
body="$(echo "$contents" | sed "1,/^$/d")"
next="$(echo "$contents" | ./extract_headers "Next-Link")"
prev="$(echo "$contents" | ./extract_headers "Previous-Link")"
created="$(echo "$contents" | ./extract_headers "Date-Created")"
modified="$(echo "$contents" | ./extract_headers "Date-Modified")"
id="$(echo "$contents" | ./extract_headers "ID")"
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
echo "Tags:"
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
echo "<div id=\"content\">"
echo "<h1> $title </h1>
$body"
echo "<dl id=\"dates\">"
if [ "$created" = "$modified" ]; then
	echo "<dt> Published: </dt> <dd> $created </dd>"
else
	echo "<dt> Originally Published: </dt> <dd> $created </dd>"
	echo "<dt> Last Updated: </dt> <dd> $modified </dd>"
fi
echo "</dl>"
echo "</div>
</body>
</html>"
' >> "$3"
chmod a+x "$3"
