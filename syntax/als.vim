" Ableton Live file
" Version: 0.1
"
+augroup als
+ au BufReadPre     *.als setlocal bin
+ au BufRead        *.als call gzip#read("gzip -dn -S .als")
+ au BufWritePost   *.als call gzip#write("gzip -S .als")
+ au FileAppendPost *.als call gzip#write("gzip -S .als")
+ au FileAppendPre  *.als call gzip#appre("gzip -dn -S .als")
+ au FileReadPost   *.als call gzip#read("gzip -dn" -S .als)
+ au FileReadPre    *.als setlocal bin
+ au FileWritePost  *.als call gzip#write("gzip -S .als")
+augroup end
