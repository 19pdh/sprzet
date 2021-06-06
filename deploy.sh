#!/bin/sh

mkdir -p dest

cat > dest/index.html <<EOF
<!doctype html>
<html lang="pl">
  <head>
    <title>Sprzęt 19PDH Puszcza</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <style>
body {
  margin: 0 auto;
  font-family: sans-serif;
  max-width: 80ex;
  box-sizing: border-box;
  padding: 1ex;
}
img {
  width: 80%;
  margin-left: 10%;
}
</style>
  </head>
  <body>
    <h1>Sprzęt 19PDH Puszcza</h1>
    <h2>Zastępy</h2>
    <ul>
EOF

cat > dest/index.gmi <<EOF
# Sprzęt 19PDH Puszcza

EOF

for f in `find zastępy -name '*.csv'`; do
  name=$(basename $f .csv)
  ./report.sh $name > dest/$name.pdf
  echo "<li><a href="$name.pdf">$name</a></li>" >> dest/index.html
  echo "=> $name.pdf $name" >> dest/index.gmi
done

cat >> dest/index.html <<EOF
  </body>
</html>
EOF

rsync -aP ./dest/ srv1:/srv/www/zhr.niedzwiedzinski.cyou/sprzet
