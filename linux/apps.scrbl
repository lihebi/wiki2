#lang scribble/manual

@title{Apps}

@section{mplayer}

There are something must be set on start. When changing the speed, the
pitch changed. To disable this, start mplayer by @tt{mplayer -af
scaletempo}.  To stretch the images to full screen, pass the
@tt{-zoom} option when starting.

Interactive controls: you can go forward and backward with
@tt{LEFT/RIGHT} (10s), @tt{UP/DOWN} (1m), @tt{PGUP/PGDWN}
(10min). Playback speed is controled by @tt{[]} (10%), @tt{{}} (50%),
and @tt{BACKSPACE} (reset). @tt{/*} adjusts volumn, @tt{SPACE} to
pause, and @tt{f} toggles fullscreen.


@section{youtube-dl}

When downloading a playlist, you can make the template to number the
files

@verbatim{
youtube-dl -o "%(playlist_index)s-%(title)s.%(ext)s" <playlist_link>
}


Download music only:

@verbatim{
youtube-dl --extract-audio --audio-format flac <url>
}

