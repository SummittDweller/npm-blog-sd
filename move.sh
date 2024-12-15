for filename in ./content/post/*.md; do
    [ ! -f "$filename" ] && continue

    if grep -q "micropost" "$filename"
    then
        mv -i "$filename" ./content/micropost/.
    fi
done