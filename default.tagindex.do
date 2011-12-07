
# This file makes list, for each tag, of recent articles, etc.

tag="$1"

echo '<?xml version="1.0" encoding="UTF-8"?>'
echo '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<title>'
echo "Tag: $tag"
echo '</title>
<link rel="stylesheet" href="../static/style.css" />
<link rel="openid.server" href="http://id.psycoti.ca/" />
<link rel="openid.delegate" href="http://id.psycoti.ca/" />
<link rel="alternate" type="application/atom+xml" href="feed.atom" />
</head>
<body>
'

echo "<h1> Tag: $tag </h1>"
echo '<ol>'

redo-ifchange "tagindex"
grep "^$tag " < "tagindex" | cut -d ' ' -f 2- | tac | while read file; do
	redo-ifchange "$file.converted"
	title="$(sed -n 's/Title:[ 	]*\(.*\)/\1/p' < "$file.converted")"
	echo '<li>'
	echo "<h2> <a href='$file.html'>$title</a> </h2>"
	# Now spit out the body
	sed '1,/^$/d' < "$file.converted"
	echo '</li>'
done

echo '</ol>'

echo '</body>
</html>'
