function replaceSpaces
    set found (fd -d 1 \\s) | for file in $found
        mv -i $file (string replace -ra \\s _ $file)
    end
end
