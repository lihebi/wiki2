#lang scribble/manual

@title{Emacs}

@itemlist[]

- [[file:elisp.org][Emacs Lisp]]
- [[file:elisp-emacs.org][Emacs Part of Elisp]]


* Tmp
- =toggle-truncate-lines=: some file format, e.g. txt, will have a
  line wrap at the end of the screen. This might be annoying, and
  toggle this will truncate the line.

* buffer
  - =list-face-displays=
  - =fill-region=
- count-matches

* Getting Help
  * =describe-key-briefly=: defaults to =C-h c=, return the command name of a key stroke.
  * =where-is=: defaults to =C-h w=, return the current shortcut for a command
  * =info=: defaults to =C-h i=, open the built-in info reader.
  * =view-echo-area-messages=

* Configuration
  To configure a specific key map.
  Note that the =global-set-key= will /not/ overwrite a specific key map,
  because the specific one has a higher priority.

  #+BEGIN_SRC elisp
  (define-key org-mode-map (kbd "C-j") (lambda()
                                         (interactive)
                                         (join-line -1)))
  #+END_SRC

  Package installation is done by the built-in package management.
  Be sure to add it into the start script to be able to automatically install it for a new build of emacs.

  - =list-package=: open the package page. Use =U x= to update all available.

* Window and Frame
** window manage
   * ~balance-window~
   * ~toggle-window-split~
   - =enlarge-window=
   - =shrink-window=
** dired
   * ~dired-next-subdir~
   * ~dired-prev-subdir~
   * ~dired-tree-up~
   * ~dired-tree-down~
** packages
   In ~*package*~ buffer, ~Ux~ to update all packages.
* File Operation
  - =revert-buffer= :: Replace current buffer text with the text of the visited file on disk. I.e. Reload file.
  - =recover-file= :: recover from =#xxx#= file.
  - =read-only-mode= :: disable it to edit read only files

* Editing
** text transformation
   * ~replace-rectangle~
   * ~upcase-word~
   * ~downcase-word~
   * ~transpose-words~
   * ~transpose-lines~
   To insert a control sequence, use ~C-q xxx~.
   - =capitalize-word=

   - =fill-paragraph= (M-q)
   - =fill-region=
   - =auto-fill-mode=

When replace-string, use =C-q C-j= to represent newline.

** killing
   * ~zap-to-char~
   * ~zap-up-to-char~

** spell checking
   Use =ispell=, and =flycheck= to check on-the-fly. Check emacs manual for detail.

** Replace regexp for multiple files inside project
1. =find-name-dired=, select the root directory, and provide a pattern for files
2. press =t= to toggle mark all files
3. press Q for query and replace in files, and provide regexp and replacement
4. proceed each of the match by: =SPC= to confirm, and =n= to skip to next.
5. Finally all files are not saved. To save that, =C-x s= will prompt
   all file and wait for your confirm by =y=. To avoid hitting =y= many
   times, use =C-x s !=.

* Programming
  - =checkdoc=: check the warnings in doc string. It can also fix it: =C-h f=.
  - =C-x C-e=: evaluate
  - =C-u C-x C-e=: evaluate and insert result

* Remote
Use =tramp= can easily work with remote machine. It is shipped with
Emacs. To use it, simply =C-x C-f= and enter =/user@host:=, Emacs will
prompt password. =user@= is optional. Do not use fancy shell prompt,
otherwise tramp might hang. You can also enter =/su::= to edit as
root for local files.

You can use =helm= no problem, and you can also enter the remote
shell.



* Moving
Defun movement:
  - =C-M-a= :: move to the beginning of defun
  - =C-M-e= :: move to the end of defun
  - =C-M-h= :: mark defun
  - =C-M-x= :: evaluate defun

Sexp movement
  - =C-M-f= :: move forward a sexp
  - =C-M-b= :: move backward a sexp
  - =C-M-k= :: kill a sexp
  - =C-M-<SPC>= :: mark following sexp
  - =C-M-n= :: move to the next sexp
  - =C-M-p= :: move to the previous sexp

Other
  - =C-M-t= :: transpose expressions
  - =C-M-u= :: move up parenthesis
  - =C-M-d= :: move down parenthesis
  - =M-m= :: back-to-indentation
* Navigating
  * ~forward-sexp~: forward semantic block
  * ~backward-sexp~
  * =org-forward-heading-same-level=: =C-c C-f=
  * =org-backword-heading-same-level=: =C-c C-b=
** marking
   * ~exhange-point-and-mark~
   * ~mark-word~
   * ~mark-sexp~
   * ~mark-paragraph~
   * ~mark-defun~
   * ~mark-page~
   * ~mark-whole-buffer~
   * ~point-to-register~: save ppposition in a register
   * ~jump-to-register~
   * ~set-mark-command~: C-SPC, set mark, and activate it
   * ~C-SPC C-SPC~: set mark, but not activate it.
   * ~C-u C-SPC~: pop to previous mark in mark ring. current is stored at the end of mark ring(rotating)
   * ~pop-global-mark~: will store both position and buffer

   All events that set the mark:
   * ~C-SPC C-SPC~
   * ~C-w~
   * search
** register
   * ~jump-to-register~: the register can store a file
   * ~copy-to-register~
   * ~insert-register~

** Tags
   - =helm-etags-select=

* Special Modes
** Tex Mode
   - =tex-validate-region=

* Variables
** File Local Variable
   On first line, emacs will try to find
   #+BEGIN_EXAMPLE
-*- mode: Lisp; fill-column: 75; comment-column: 50; -*-=
   #+END_EXAMPLE

   =mode= defines the major mode for this file, while unlimited
   numbers of variables follows, separated by =;= Emacs looks for
   local variable specifications in the second line if the first line
   specifies an interpreter, e.g. /shebang/.

   A second way to specify file local variable is to have a "local
   variables list" near the end of the file (no more than 3000
   characters from the end of the file).  The =Local Variables:= and
   =End:= will be matched literally.

   #+BEGIN_EXAMPLE
This     /* Local Variables:  */
Is       /* mode: c           */
Garbage  /* comment-column: 0 */
Data     /* End:              */
   #+END_EXAMPLE

You can also interactively add by =add-file-local-variable=, reload
the variable by =revert-buffer=

** Directory Local Variable
   Put =.dir-locals.el= at the root directory, and it will be in effect for all the files under that directory, recursively.
   It should be an associate list, the car can be either a mode name (or =nil= applies to all modes) indicating the variables are for that mode,
   or a sub-directory name to apply only in that directory.
   #+BEGIN_SRC elisp
  ((nil . ((indent-tabs-mode . t)
           (fill-column . 80)))
   (c-mode . ((c-file-style . "BSD")
              (subdirs . nil)))
   ("src/imported"
    . ((nil . ((change-log-default-name
                . "ChangeLog.local"))))))
   #+END_SRC

* Advanced Topics
** Info
   Info is a document system.
   It is closely bundled with emacs, so I put it here.
   To install some new info document in the system,
   issue the following commands (using =gnu-c-manual= as an example):

   #+BEGIN_SRC shell
# download the gnu-c-manual code
make gnu-c-manual.info
mv gnu-c-manual.info /usr/local/share/info
cd /usr/local/share/info
sudo install-info --info-file=gnu-c-manual.info --info-dir=.
   #+END_SRC

*** Operations
    | key       | description                                          |
    |-----------+------------------------------------------------------|
    | SPC       | page down, can cross node                            |
    | BACKSPACE | page up, can cross node                              |
    | M-n       | ~clone-buffer~, create a new independent info window |
    | n         | next node on same level                              |
    | p         | previous                                             |
    | ]         | next node regardless of level                        |
    | [         | previous                                             |
    | u         | up node                                              |
    | l         | back                                                 |
    | r         | forward                                              |
    | m         | ~Info-menu~, convenient for search node title        |
    | s         | TODO search  a text in the whole info file           |
    | i         | TODO search indices only                             |

** Babel
   How to write a =ob-xxx.el= file?

   * search org-mode babel, you will get a link: http://orgmode.org/worg/org-contrib/babel/
   * In this link, there's a "languages" link. http://orgmode.org/worg/org-contrib/babel/languages.html
   * Under "Develop support for new languages" section, there's link to ob-template.el: http://orgmode.org/w/worg.git/blob/HEAD:/org-contrib/babel/ob-template.el
   * follow instruction to modify it.

   some good example to look at: ob-plantuml.el, ob-C.el

* Plugins

** ERC
- =erc=: connect
- =erc-iswitch=: =C-c C-b=
- =erc-join-channel=: =C-c C-j=
- =erc-save-buffer-in-logs=: =C-c C-l=
- =erc-channel-names=: =C-c C-n=: run =/names #channel= command in the
  current channel.
- =erc-part-from-channel=: =C-c C-p=: leave the channel
- =erc-quit-server=: =C-c C-q=: disconnect server

IRC commands
- identify: =/msg NickServ identify <password>=
- join: =/join #linux=
- register: =/msg NickServ register <psssword> <email>=
- private talking: =/query <nick>=. Only registered people can be
  queried

** Flycheck
  The default (at least the one I'm using) for C/C++ is =c/c++-clang=.

  - =flycheck-describe-checker=
  - =flycheck-list-errors=

** AUCTex
  - =C-c C-c=: tex-compile

** DocView
  Can view pdf in emacs. It is convenient to use the same keybinding for =tex-compile=:
  when you press =C-c C-c= the second time after compilation, it will default to =\doc-view=.

*** navigation
   - =C-p= =C-n= =C-b= =C-f= still works
   - =+= and =-= to adjust scale
   - =n= and =p= for page navigation
   - =space= and =delete= to page up and down across pages
   - =M-<= and =M->= still works
   - =M-g M-g= works as jump to page

** pdf-tools
  The doc view produce very blur text. The pdf-view-mode provided by pdf-tools solved this.
  Also, this package is said to open pdf on demand. It seems to solve my concern for pdf greatly.

  Extra bonus:
  - search in text
  - view and edit annotations!


  http://emacs.stackexchange.com/questions/19686/how-to-use-pdf-tools-pdf-view-mode-in-emacs


*** Installation

   #+BEGIN_EXAMPLE
sudo aptitude install libpng-dev libz-dev 
sudo aptitude install libpoppler-glib-dev 
sudo aptitude install libpoppler-private-dev
sudo aptitude install imagemagick
   #+END_EXAMPLE

   #+BEGIN_EXAMPLE
cd /path/to/pdf-tools
make install-server-deps # optional
make -s
make install-package
# or M-x package-install-file RET pdf-tools-${VERSION}.tar RET
   #+END_EXAMPLE

   activate in emacs by =(pdf-tools-install)=


*** key binding
   - =o=: open outline
   - =Q=: kill buffer
   - =q=: kill window

** Paredit

  | command                     | Key | description                     |
  |-----------------------------+-----+---------------------------------|
  | paredit-forward-slurp-sexp  | C-) | enclose the next into this sexp |
  | paredit-forward-barf-sexp   | C-} | exclude                         |
  | paredit-backward-slurp-sexp | C-( |                                 |
  | paredit-backward-barf-sexp  | C-{ |                                 |
  |-----------------------------+-----+---------------------------------|
  | paredit-wrap-round          | M-( |                                 |
  | paredit-join-sexp           | M-J |                                 |
  | paredit-splice-sexp         | M-s |                                 |
  | paredit-split-sexp          | M-S |                                 |
  | paredit-raise-sexp          | M-r |                                 |
  | paredit-convolute-sexp      | M-? | exchange child and parent       |

** Magit

=C-x g= to enter, and
- =c c= to commmit
- =c a= to amend commit
- =P u= to push
- =F u= to pull

** Speedbar
This is strictly not a plugin. Toggle by =speedbar=.

- q :: quit
- g :: refresh
- t :: toggle slowbar mode, which stop update until activate
- n,p :: next, previous
- M-n,M-p :: restricted next/previous. Will 1) skip subdirectory, and
             2) will not leave subdirectory
- f :: file mode
- b :: buffer mode
- r :: previous mode

- = :: expand
- - :: hide
- RET :: open


*** Buffer Mode
- k :: kill the buffer
- r :: revert the buffer

** EDBI
This is database viewer for MySQL, Sqlite, Postgresql.

Install =edbi= and =edbi-sqlite= package and run as root:

#+BEGIN_EXAMPLE
cpan RPC::EPC::Service DBI DBD::SQLite DBD::Pg DBD::mysql
#+END_EXAMPLE

Run =edbi-sqlite= to open a sqlite database. This will open /database view/.

To sum up:
- n/p :: nav rows
- c :: query editor
- C-c C-c :: execute
- q :: quit
- RET :: go into
- SPC :: display info
- V :: show table data

*** Database View
- n/p :: nav rows
- c :: switch to query editor buffer
- RET :: show table data
- SPC :: show table definition
- q :: quit and disconnenct

*** Table definition View
- n/p ::
- c ::
- V :: show table data
- q :: kill buffer

*** Query Editor
- C-c C-c :: execute
- C-c q :: kill buffer
- M-p/n :: SQL history back/forward

*** Query Result Viewer
- n/p ::
- SPC :: display whole data at current cell, hit SPC again to dismiss
- q :: quit


** EMMS
*** Add files into playlist
- emms-add-file
- emms-add-directory
- emms-add-directory-tree (recursive)
- emms-add-playlist (m3u)
- emms-add-find: use regexp with find

*** Interactive control in playlist mode
- emms-start
- emms-stop (s)
- emms-next (n)
- emms-previous
- emms-shuffle
- emms-pause (P)
- emms-random (r): go to a randomly selected track in the playlist
- emms-sort
- emms-show (f): show the current track in minibuffer
- emms-seek-forward (>)
- emms-seek-backward (<)
- emms-playlist-mode-center-current (c): center the current song
- emms-playlist-mode-play-smart (RET): play the song under cursor
- emms-playlist-mode-bury-buffer (q): bury buffer
- emms-playlist-mode-clear (C)

In playlist mode, you can kill and yank as normal, use =C-j= to insert
newline.

In addition to the default playlist, we also have the markable
playlist. The =emms-mark-mode= and =emms-mark-mode-disable= can switch
between them. In the mark mode, you can:
- emms-mark-forward (m)
- emms-mark-unmark-all (U)
- emms-mark-toggle (t)
- emms-mark-unmark-forward (u)
- emms-mark-regexp (% m)

When tracks are marked, you can
- emms-mark-delete-marked-tracks (D)
- emms-mark-kill-marked-tracks (K): like D, but put into kill ring, so
  we can yank it back
- emms-mark-copy-marked-tracks: just kill, ready for yank


Play Property
- =emms-repeat-playlist=: variable, non-nil means repeat the playlist
- =emms-toggle-repeat-playlist=: change =emms-repeat-playlist=
- =emms-toggle-random-playlist=: random

Play list
- =emms-playlist-new=
- =emms-playlist-save= (C-x C-s): just use m3u format

*** Edit the tags:
- emms-tag-editor-edit (E): need to have software support. E.g
  =mp3info=
- emms-tag-editor-rename-format: this variable controls how to
  generate file name from meta data, nice!
- emms-tag-editor-rename: this function perform file renaming
  according to above format

*** Smart Browser
=emms-smart-browse= to enter the smart browsing page.
**** TODO when I start emacs, it can find all the music, how did it remember?

In browser, you can update by relist the browser
- emms-browse-by-artist (b 1)
- emms-browse-by-album
- emms-browse-by-genre
- emms-browse-by-year

Interact:
- emms-browser-add-tracks (RET)
- emms-browser-add-tracks-and-play (C-j)
- emms-browser-toggle-subitems (SPC): toggle subitems
- emms-browser-collapse-all (1)
- 2: expand one level
- 3: expand two levels
- 4: expand three levels
- emms-browser-clear-playlist (C): also clear the playlist, but use capital
- E: expand everything
- d: visit the current directory
- r: jump to a random track
- /: search



* Gnus
#+BEGIN_QUOTE
In emacs, <DEL> means backspace, <delete> means the delete key.
#+END_QUOTE


** Gmail Setup
Add the credential information to =~/.authinfo=

#+BEGIN_EXAMPLE
machine imap.gmail.com login <username> password <password> port 993
machine smtp.gmail.com login <username> password <password> port 587
#+END_EXAMPLE

To configure multiple IMAP client for gnus:
#+begin_example
machine gmail login XXX@gmail.com password <PASSWORD> port 993
machine cymail login XXX@iastate.edu password <PASSWORD> port 993
#+end_example

Add the following into =.gnus=

#+BEGIN_EXAMPLE
(setq user-mail-address "lihebi.emacs@gmail.com"
      user-full-name "Hebi Li")

(setq gnus-select-method
      '(nnimap "gmail"
	       (nnimap-address "imap.gmail.com")  ; it could also be imap.googlemail.com if that's your server.
	       (nnimap-server-port "imaps")
	       (nnimap-stream ssl)))

(setq smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587
      gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")


;; send mail using gmail smtp, no require for installation of sendmail or something
(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      smtpmail-auth-credentials '(("smtp.gmail.com" 587 "lihebi.emacs@gmail.com" nil))
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587
      starttls-use-gnutls t)
#+END_EXAMPLE

** Mail
To start a mail, use =compose-mail (C-x m)=. This will drop you to a
=message= buffer, with =message-mode=.

- =message-send-and-exit (C-c C-c)=: send it

Actually when =gnus= is set up, simply type =m= to compose email.

** gmane news group setting
#+BEGIN_SRC elisp
(setq gnus-default-nntp-server "news.gmane.org")
(setq gnus-select-method '(nntp "news.gmane.org"))
(setq gnus-use-adaptive-scoring t)
(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)
#+END_SRC

** Usage
Inside emacs, run =gnus= command. This brings the =*Group*=
buffer. You will see the list of groups, use =<spc>= or =<enter>= to
enter the group. As usual, =g= to refresh. =q= for quit.

In general in all buffers, the important keybindings are: =c= for
catch up current item, =n= and =p= for next or previous *unread*
articles =N= and =P= for actually next and previous article, =m= for
create new message, =a= for creating new post, =r= for reply without
cite, =R= for reply with cite, =t= for toggle some mode.

*** Server buffer
From group buffer, type =^= to enter server buffer. Use =<space>= (NOT
=<enter>=!) to browse the groups of it, and subscribe via =u=. To
unsubscribe, type =u= again. Actually after unsubscribe, the group
still shows up in the group buffer, with =U= mark. To /really/ remove
it, use =C-k= (=gnus-group-kill-group=) on it /in the group
buffer/. Oh, just noticed this is just kill-line command, so you can
yank it back via =C-y= (=gnus-group-yank-group=). Likewise, kill a
region also works as expect.

*** Group Buffer:
Finding the groups
- =gnus-group-browse-foreign-server= (=B=): use =nntp= as back-end and
  =news.gmane.org= as address.
- =gnus-group-list-active (A A)=: List all groups that are available
  from the server(s).
- =gnus-group-unsubscribe-current-group (u)=: toggle subscription of
  the group
- *=gnus-group-list-groups (l)=*: list only subscribed ones with
  unread articles
- *=gnus-group-list-all-groups (L)=*: show all subscribed groups
- =gnus-group-make-rss-group (G R)=: paste the rss feed url to add RSS
  feeds
- =gnus-group-jump-to-group (j)=: jump to a group by entering name,
  this works for non-listing groups.
- =gnus-group-make-rss-group (G R)=: prompt to enter the RSS url. It
  is the link of the rss page of a blog,
  e.g. https://danluu.com/atom.xml


Management
- =gnus-group-catchup-current (c)=: mark all unread articles in the
  group under cursor as read
- =gnus-group-catchup-current-all (C)=: mark all +unread+ articles in
  the group under cursor as read
- =gnus-group-mail (m)=: create a new message
- =gnus-group-post-news (a)=: create a new post
- =gnus-group-enter-server-mode (^)=: enter server buffer


Since we like organizing, there's a topic mode, enabled by =t=. After
that, you will have a bunch of command prefixed with =T=. Topic mode
group subscriptions into categories.

- =gnus-topic-mode (t)=: toggle topic minor mode. 
- =gnus-topic-create-topic (T n)=: create a new topic
- =gnus-topic-indent (<TAB>)=: indent current topic
- =gnus-topic-unindent (M-<TAB>)=: unindent
- =gnus-topic-delete (T <Del>)=: delete topic under cursor

You generally just kill (C-k) and yank (C-y) to organize the groups
into specific topics. UPDATE: Don't use C-k C-y, it seems to cause
bug, that cannot save the configuration. Use the following instead.

- =gnus-topic-move-group (T m)=: move the group under cursor to a
  topic

When topic mode is enabled, <enter> and <space> on a topic line will
fold or unfold it. So you don't really need the following commands.
- =gnus-topic-hide-topic (T h)=:
- =gnus-topic-show-topic (T s)=:

Groups can be combined into virtual groups. This is very helpful for
reading emails. For gmail, the inbox will not show *my* interactions,
that is in =Sent Mail=. So on Group buffer, create a virtual group by
=gnus-group-make-empty-virtual (G V)= and edit it via
=gnus-group-edit-group-method (M-e)= with regular expression like
this:

#+begin_example
(nnvirtual "nnimap\\+cymail:INBOX\\|nnimap\\+cymail:.*/Sent Mail")
#+end_example


*** Summary and Article buffer
This will list all the mails. =<RET>= to enter a specific mail.  The
following commands work in both buffers.

- =gnus-summary-next-unread-article (n)=: next unread article
- =gnus-summary-prev-unread-article (p)=: previous unread article
- =gnus-summary-next-article (N)=: next article
- =gnus-summary-prev-article (P)=: previous article
- =gnus-summary-next-page (<SPC>)=: scroll down, move to next unread
  article when at bottom
- =gnus-summary-prev-page (<DEL> or <BACKSPACE>)=: scroll up, but will
  not move article
- ~gnus-summary-expand-window (=)~: this expand the summary buffer,
  very handy (instead of switch to summary and C-x 1).

Replying
- =gnus-summary-followup-with-original (F)=: follow-up to group and
  cite the article
- =gnus-summary-followup (f)=: follow-up to group without citing the
  article
- =gnus-summary-reply-with-original (R)=: reply by mail and cite the
  article
- =gnus-summary-reply-with-original (r)=: reply by mail without cite
  the article
- =message-forward-show-mml (C-c C-f)=: forward to another person
- =gnus-summary-mail-other-window (m)=: new mail
- =gnus-summary-post-news (a)=: new post

Management
- =gnus-summary-catchup-and-exit (c)=: catchup ALL in the buffer
- =gnus-summary-toggle-header (t)=: toggle all headers (a lot of MIME
  information)
- *=gnus-summary-insert-old-articles (/ o)=*: show all read articles
- =gnus-summary-rescore (V R)=: recompute the score. Score is computed
  by emacs rules. This can be explicitly set, or affected by some
  operations. For example, when you mark an article as read while
  didn't really read it, the related ones are marked like this.
- =gnus-sticky-article (A S)=: normally the article and summary buffer
  is reused, that means you cannot put two mails side-by-side. This
  command make the current article buffer un-reusable for doing that.

Threading
- *=gnus-summary-toggle-threads (T T)=*: toggle threading (flat style
  or thread style)
- *=gnus-summary-refer-thread (A T)=*: display the full thread
- *=gnus-summary-refer-parent-article (^)=*: fetch parent article
- =gnus-summary-top-thread (T o)=: go to the top of this thread
- =gnus-summary-kill-thread (T k)=: mark whole thread as read

Scores are computed for each article, for the sake of making important
ones stand out.
- =gnus-summary-lower-score (L)=: create low score
- =gnus-summary-increase-score (I)=: create high score

Article will have marks to indicate the status of them. The followings
are read marks:
- =r=: marked as read by =d= command
- =R=: actually been read
- =O=: stands for old, marked as read in previous session
- =Y=: having a too low score
- =C=: marked as catchup

Other marks:
- =!=: tick, i.e. important, and will always show
- =?=: dormant for now. This will show up whenever there are
  follow-ups.
- =A=: this article has been replied or followed-up by
  me. =gnus-replied-mark=, this variable has a default value of 65,
  the ASCII for "A".
- =F=: this article has been forwarded
- =*=: this article is stored in cache
- =S=: this article is saved
- =#=: the process mark. This is similar to =m= in dired: you select
  some articles, and process them at the same time, using some
  commands.
- =.=: gnus-unseen-mark, this article hasn't been seen before by the
  user. What does this mean??

The following commands interact with marks
- =gnus-summary-clear-mark-forward (M c)=: clear mark
- =gnus-summary-mark-as-read-forward (d)=: mark as read.
- =gnus-summary-tick-article-forward (!)=: mark as important.
- =gnus-summary-mark-as-dormant (?)=: mark as dormant.
- =gnus-summary-set-bookmark (M b)=: set a bookmark in the *current
  article*. This seems to be a position inside a long article. Gnus
  will jump to this bookmark the next time it encounters the article.
- =gnus-summary-remove-bookmark (M B)=: remove the bookmark from
  current article.
- =gnus-summary-mark-as-processable (#)=: mark the current article the
  process mark
- =gnus-summary-unmark-as-processable (M-#)=: remove the process mark

*** Message buffer
This is pretty standard: =C-c C-c= for send, =C-c C-k= for kill. What
is not standard though is =C-c C-d= for draft, =C-c C-m f= to attach
file.

During editing a message, you can just save it normally, and it will
be in the draft group. The next time you enter draft, type =D e=
(=gnus-draft-edit-message=) in draft summary buffer, you will resume
to editing. Rejected articles will also be in draft group.

There are some commands for jumping around the buffer, and edit the
headers.

** Scoring

To mark a score for an article:
1. how: =I= for increase or =L= for lower.
2. what:
   - =a= for author
   - =s= for subject line
3. match type:
   - =e= exact match
   - =f= fuzzy
4. expiring
   - =t=: temporary
   - =p=: permanent
   - =i=: immediate, i.e. in effect right now, before even save the
     file

So what I want is actually =I a f p=. The scoring file is stored by
default at =~/News/<group-name>.SCORE=.

* Elisp

In emacs lisp intro, the Robert J. Chassell quoted the following.

#+begin_quote
I prefer to learn from reference manuals.  I “dive into” each
paragraph, and “come up for air” between paragraphs.

When I get to the end of a paragraph, I assume that that subject is
done, finished, that I know everything I need (with the possible
exception of the case when the next paragraph starts talking about it
in more detail).  I expect that a well written reference manual will
not have a lot of redundancy, and that it will have excellent pointers
to the (one) place where the information I want is.
#+end_quote

** IO
=princ= is for human, it print object without quotes. =print= is the
most verbose, print quotes and newlines. =prin1= omit the newlines.
If you just evaluate the print, the result is the object being
printing, so the echo area will have two copy of the object.

=message= accepts only string, and used inclusively on echo area.


** Symbol
Since elisp is lisp-1, a symbol can be both variable and a function at
the same time.  Macros and functions use the same namespace.
 
Elisp use nil in three ways: the symbol, the logical false, and the
empty list.

Elisp also has ~#'~, but instead of syntax, it is the read syntax of
quoting for function, i.e. =function=.

Elisp by default uses *dynamic binding* and dynamic extent for local
variables. This means, the variable refers to the most recent local
binding, and a binding exists all the way as long as the binding form
is executing (e.g. body of let). =setq= works on the most recent
binding.

Thus, when using a local dynamic binding, always make sure (by
yourself, unfortunately) the variable is bound. When really using
global variable, *declare* it at the top, via =defvar= and
=defconst=. =defvar= will initialize the variable if it is originally
/void/, while =defconst= will unconditionally initialize it. Other
than that, there's no difference, the compiler will not complain if
you changed the constant. The variable will be marked as "special",
meaning that it will always have dynamic binding.  There's a third way
to create global binding, the =defcustom=. It is used to create
/customizable variable/, also called /user option/. It is special in
that, it is shown in customize interface, and the =defcustom= will
specify how it should be displayed, and what values to take.

On the other hand, lexical scope establish lexical binding, and has
indefinite extent. This means the variable has to refer to a binding
that is lexical written in scope. The binding is available even
outside the execution of the binding form, and construct a closure.
To enable lexical binding, you have to set buffer-local variable
=lexical-binding= to non-nil. Even after this, special variables are
still dynamic binding.

Emacs supports another binding, called buffer-local binding. As name
suggests, the binding is in effect when that buffer is the current
buffer, and goes out of effect when it is not. This is most useful in
major modes. Two ways can make buffer-local
variable. =make-local-variable= set the variable to local to current
buffer, while =make-variable-buffer-local= set a variable buffer-local
in all buffers.


** Regular Expression
You can use basic =.*+?=, as well as non-greedy counter part =*?=,
=+?=, =??=.

Bracket is special in elisp regex. Character classes can be used
inside =[]=. E.g. =[[:ascii:]]=.  Possible values include
- ascii: 0-127
- alnum: letter or digit
- alpha: letter
- blank: space and tab
- digit: 0-9
- lower: lower case
- upper
- punct
- space: white space
- word: same as =\w=

Parenthesis and braces are not special, thus can be used
literally. When using for grouping, they need to be escaped for
capturing, otherwise it is literal. Non-capturing group is also
supported by =\(?:\)=. =\1= for back reference.

Back slash some code has special meanings. e.g. =\w= =\b=. The
uppercase is negation.
- =\w=: word
- =\b=: 
- =\s-=: whitespace
- =\sw=: \w
- =\s.=: punctuation

When constructing regexp that match string literals, you can use
=regexp-quote= and =regexp-opt= to avoid getting specially
interpreted. =regexp-quote= returns a regular expression, whose only
exact match is string. =regexp-opt= returns an /efficient/ regular
expression, that will matches any of the strings supplied.

The mostly used functions are =re-search-forward= and backward. It
search in the buffer. You can also search in a string by
=string-match= or =string-match-p=. They will set /match data/.  

After search, you can retrieve the previous match data by
=match-string= and =match-string-no-property= (for clean string). You
can also use =match-beginning= and =match-end= to get the position of
the match instead of content.

Finally, =replace-regexp-in-string= replaces all matches in a string.

** Lisp Common Sense
=eq=, =equal=, ~=~ are available.

Numeric function:
- comparison: =max=, =min=, =abs=
- rounding: =truncate=, =floor=, =ceiling=, =round=
- arithmetic: =%=, =mod=
- bit-wise: =lsh=, =ash=, =logand=, =logior=, =logxor=, =lognot=
- math: =expt=, =exp=, =sin=, =cos=, =log=, =sqrt=
- random: =random=



** string
Creating string by =make-string=. Most likely we are creating from
existing strings, e.g. =substring=, =concat=, =split-string=.  String
are compared using ~string=~, =string<= (no =string>=?).  Converted by
=number-to-string=, =string-to-number=, and casing operations
=downcase=, =upcase=, =capitalize=.

Of course, the most powerful string construction function is
formating, with =foramt=, and =format-message=. The format string
follows C style though, using =%s= as printed representation
(=princ=), =%S= for =prin1=, =%c= for character, 

** list
List is defined as the last cdr to be =nil=.  If the last is not nil,
it is called /dotted list/ instead of /improper list/.

- append: the interesting part is, all arguments except the last one
  are copied.  If you want to force copy the last one as well, add a
  =nil= as the last of append.
- reverse

list generation:
- number-sequence: inclusive from a to b

Apart from =car= and =cdr=, elisp has =car-safe= and =cdr-safe=, that,
if the argument is not a cons cell, return nil.  =nth=, =nthcdr=,
=last= are available.

/destructive/ means the cdr of the cons cells are modified.

=pop= and =push= is destructive. =pop= will return the car of the
list. =push= is the counter part for =cons= onto the
list. =add-to-list= only adds if the element is not there
already. There are also very bare-bone functions =setcar= and
=setcdr=. Note that =sort= is also destructive.

List can be, of course, used as set. =member= does predicate, =remove=
removes item from set, =delete= destructively removes. They use
=equal=, but have =eq= counter parts obviously. Finally, =delete-dups=
remove duplication.

Association list is same as scheme, a list of pairs. =assoc= can be
used to retrieve by =car=, while =rassoc= retrieve by =cdr=.

Property list is a flat list. The odd elements are property name, and
the even elements are values.  The property names /must/ be unique.
The order of the "pairs" does not matter. =plist-get= and =plist-put=
modify the list. =plist-member= is useful because it can distinguish
the missing property and the property with value "nil"

A symbol can have a property list. It has a simpler syntax, =get= and
=put= with the symbol as argument. =symbol-plist= can retrieve the
plist from symbol, =setplist= gives a plist to a symbol.

** Sequence
Sequence is more general than list, specifically it also covers array.
=elt= is used to retrieve from sequence by position. =copy-sequence=
creates new sequence, but the elements are not copied.

Array is fixed length sequence, can be vector or string. =make-vector=
or =vector= constructs vector, and =aref= and =aset= access it.

** Hash Table
=make-hash-table= constructs a table, and access by =gethash=,
=puthash=, =remhash=, =clrhash=. Hash table can be counted by
=hash-table-count= instead of =length=, iterated by =maphash= instead
of =map=.

** Function
Functions are defined by following.  To specify optional argument, use
=&optional= before all optional arguments. Collect rest arguments by
putting =&rest= before the *final* argument.  A lambda expression
evaluates to a function object.

#+begin_example elisp
(defun name (var ...) body ...)
(lambda (arg ...) body ...)
(required-var ...
   [&optional op-var ...]
   [&rest rest-var])
#+end_example

=apply= append the arguments into a list, and call the function with
the splice of list as arguments. The last argument must be a
list. =funcall= just call with the rest arguments.

=mapcar= is the typical map, return the list. =mapc= is used for side
effect. =mapconcat= is a shorthand for concatenate the result as a
string.


A function with =(interactive)= is a /command/, i.e. it can be
executed with M-x. This apply to both defun and lambda. Although
interactive is often used without argument, it can actually do very
interesting staff. It basically defines what kind of arguments the
user should provide to the command. Most likely, it is a multi-line
string containing key code of what kind of values to expect, and
prompt string. The numeric prefix argument "p" is just one of them,
and it can differentiate =C-u= prefix of the command.


** Macro
=defmacro name (args) body...=

The macro is very simple: leave the arguments /as is/ and put them
into the macro body to form an expression. The expression is then
evaluated for result.

** Control Structure
Sequential structure has =progn=, =prog1=, =prog2=.

=if=, =when=, =unless=, =not=, =and=, =or= are common.

=cond= takes the following form
#+begin_example
(cond (condition body ...) ...)
#+end_example

=pcase= takes
#+begin_example
(pcase exp (pat code ...) ...)
#+end_example

Loops takes follows. There's no mention what is the return of
while. =dolist= does return the value of result, defaults to
nil. =dotimes= bind var to =[0,count)=.

#+begin_example
(while condition forms ...)
(dolist (var list [result]) body ...)
(dotimes (var count [result]) body ...)
#+end_example


** Packages
*** Dash.el
 https://github.com/magnars/dash.el

 This is a collection of list libraries.

- =-map= takes a function to map over the list,
 the anaphoric form with double dashes executed with =it= exposed as the list item. 
 #+BEGIN_SRC elisp
 ;; normal version
 (-map (lambda (n) (* n n)) '(1 2 3 4))
 ;; also works for defun, of course
 (defun square (n) (* n n))
 (-map 'square '(1 2 3 4))
 ;; anaphoric version
 (--map (* it it) '(1 2 3 4))
 #+END_SRC

- =-update-at=: =(-update-at N FUNC LIST)= Return a list with element at Nth position in LIST replaced with `(func (nth n list))`.
- =-flatten=: =(-flatten L)=: Take a nested list L and return its contents as a single, flat list.

*** s.el
 https://github.com/magnars/s.el

 The string manipulation library

*** cl-lib.el loop
This package ports many common lisp facilities into elisp,
most importantly, the loop facility.
So this section, at least for now, focus on =cl-loop=.

**** general loop form
#+BEGIN_SRC elisp
(cl-loop clauses...)
#+END_SRC
The clauses can be:
- for clauses
- TODO
**** for clauses
- =for VAR from FROM to TO by STEP= ::
  - =FROM= defaults to 0. =STEP= must be positive and default to 1.
  - inclusive =[from,to]=
  - =from= can be =upfrom= and =downfrom=. I think it is wired to use this.
  - =to= can be =upto= and =downto=. This makes more sense.
  - =above= and =below= can be used, but /exclusive/. e.g. =for var below 10=
- =for VAR in LIST by FUNCTION= :: =FUNCTION= is used to traverse the list, defaults to =cdr=
- =for VAR on LIST by FUNCTION= :: =VAR= is bound to the cons cell of the list instead of the element.
- =for VAR across ARRAY= :: iterates all elements of array
- =for VAR = EXPR1 then EXPR2= :: this is the most general form.
  The =VAR= is bound to =EXPR1= initially, and will be set by evaluating =EXPR2= in successive iterations.
  =EXPR2= can refer the old =VAR=

**** iteration clauses
- =repeat integer= :: repeat the loop how many times
- =while condition= :: stops the loop when the condition becomes nil
- =until condition= ::
- =always condition= :: like while except it returns =nil=, and =finally= clauses are not executed.
- =never condition= :: counter part for =always=

**** accumulation clauses
- =collect form= :: collect into a list and return the list in the end
- =append form= :: collect the lists into a list by appending, and return it in the end
- =concat form= :: for string only
- =count form= :: count how many times form evaluates to non-nil.
- =sum form= :: sum all the values
- =maximize form= :: get the max. If the form is never executed, result is /undefined/
- =minimize form= ::

**** Other clauses
- ~with var = value~ :: set the value one-time at the beginning of the loop.
  Often used as return variable.
  *The spaces around ~=~ is essential!*.
- =if condition clause [else clause]= ::
- =when condition clause= :: same as if
- =unless condition clause= :: similar
- =initially [do] forms...= :: execute before the loop begins, but after the =for= and =with= variable bindings. =do= is optional.
- =finally [do] forms...= :: execute after the loop finishes
- =finally return form= :: finally return it ...
- =do forms...= :: execute as an implicit =progn= in the body
- =return form= :: this is often used in =if= or =unless=, because put it in top level will cause the loop always execute only once.

*** cl-lib other
Of course, cl-lib provides much more than just loops ...
- =incf PLACE= :: is ~i++~

** Debugging
*** lisp debugger
The simplest debugger is called =lisp debugger=.
You can turn on the =debug-or-error= flag,
but I found inserting the =(debug)= command useful.
Simply insert =(debug)= where you want program to suspend, and run it.
You will enter the debugger at that point.
In the debugger buffer, the following commands are available:
- =c= :: continue run program
- =d= :: step
- =e= :: evaluate an prompt expression
- =R= :: like =e=, but also save the result in =*Debugger-record*=
- =q= :: quit
- =v= :: toggle display of local variables ???
*** Edebug
For this to work, first you need to instrument the code.
You can instrument the defun by =C-u C-M-x=.
Actually this is adding a prefix before =eval-defun=,
which instrument, and then evaluate the defun.

After instrumentation, running the defun will cause the program to stop at the first /stop point/ of the function.
The /stop points/ are
- before and after each subexpression that is a list
- after each variable reference

**** breakpoints
- =b= :: set a breakpoint
- =u= :: unset a breakpoint
- =x CONDITION= :: set a conditional breakpoint

You can also set the /source breakpoints/, by adding =(edebug)=.

**** Moving of point
- =B= :: move point to the next breakpoint
- =w= :: move point back to the current stop point

**** executions
- =<SPC>= :: run to next stop point
- =g= :: execute until next breakpoint
- =q= :: exit
- =S= :: stop and wait for Edebug commands
- =n= :: evaluate a sexp and stop at stop point
- =t= :: /trace/, pause one second at each stop point ...
- =T= :: rapid trace. Update the display at each stop point but don't actually pause ...
- =c= :: pause one second at each breakpoint
- =C= :: rapid continue.
- =G= :: run and ignore breakpoints (but you can stop it by =S=)

- =h= :: proceed to the stop point near the point ...
- =f= :: run one expression
- =o= :: step out the containing expression
- =i= :: step in
**** evaluation
- =e EXP= :: evaluate a prompt expression
- =C-x C-e= :: evaluate an expression at point

**** other commands
- =?= :: show help
- =r= :: redisplay the most recent sexp result
- =d= :: display the backtrace



** Unit Testing
Use =ert= for unit testing.

*** Write test
#+BEGIN_SRC elisp
(ert-deftest addition-test()
  "Outline docstring."
  (should (= (+ 1 2) 4)))
#+END_SRC

The family of functions:
- =should=
- =shoult-not=
- =should-error=

expected failure:
#+BEGIN_SRC elisp
(ert-deftest addition-test()
  "Outline docstring."
  :expected-result :failed
  (should (= (+ 1 2) 4)))
#+END_SRC

skip test
#+BEGIN_SRC elisp
(ert-deftest addition-test()
  "Outline docstring."
  (slip-unless (featurep 'dbusbind'))
  (should (= (+ 1 2) 4)))
#+END_SRC

*** Run test
=M-x ert= will run it. The selector of test accept some more fancy staff like regular expression matching.
But in the case of scratch testing, I need to evaluate the deftest and then call =ert=.

The nice thing is it supports interactive debugging.
In the ert buffer, the following commands are available:
- =r= :: re-run the test
- =.= :: jump to the source code of this test 
- =b= :: show back-trace
- =m= :: show the message this test printed
- =d= :: re-run the test with debugger enabled
- instrumentation :: go to source code, type =C-u C-M-x=, and re-run the test. You are able to step!

Also, select test by this:
#+BEGIN_SRC elisp
(ert-run-test (ert-get-test 'my-defined-test))
#+END_SRC

** Some random code snippets


#+begin_src elisp
(cl-prettyprint (font-family-list)) ;; see all font family available on this system
#+end_src

**** Url retrieval
#+BEGIN_SRC elisp
  (with-current-buffer (url-retrieve-synchronously "http://scholar.google.com/scholar?q=segmented symbolic analysis")
    (goto-char (point-min))
    (kill-ring-save (point-min) (point-max))
    )
  (let ((framed-url (match-string 1)))
    (with-current-buffer (url-retrieve-synchronously framed-url)
      (goto-char (point-min))
      (when (re-search-forward "<frame src=\"\\(http[[:ascii:]]*?\\)\"")
        (match-string 1))))
#+END_SRC


** Emacs Related

*** Buffer
- =with-temp-buffer=
  =(with-temp-buffer &rest BODY)= Create a temporary buffer, and evaluate BODY there like =progn=.

- =(insert-file-contents FILENAME &optional VISIT BEG END REPLACE)=: Insert contents of file FILENAME after point.
- =(secure-hash ALGORITHM OBJECT &optional START END BINARY)=: the object can be a buffer.
  This can be used to compare if a file has changed.
- =(current-buffer)=: Return the current buffer as a Lisp object.
- =(message FORMAT-STRING &rest ARGS)=: Display a message at the bottom of the screen.

There will be many buffers in an Emacs session, and the
=current-buffer= returns the current one, which is the default target
for most commands. When you want to make something interesting to some
other buffer, you will need to =set-buffer= to set that buffer
current. You will likely want to switch back to the original buffer
after those operations, for that, don't use =set-buffer= to set back,
because it is not error-safe. Instead, use =save-current-buffer=, or
better =with-current-buffer=. =with-temp-buffer= don't need a provided
buffer object, but creates a temporary one. The temporary buffer will
be killed at the end of execution of body. All of these 3 form does
not display the buffer, just make it current.

A buffer has a name, retrieved by =buffer-name=. The name can be set
using =rename-buffer=. Buffers can be obtained by name via
=get-buffer=.  Buffers are also likely to be associated with a file,
and the non-directory file name is =buffer-file-name=. You can also
get the buffer using the file name via =get-file-buffer=. Since it
just the filename, there must be multiple ones, and this function
returns the first.

To create a buffer, use =get-buffer-create=, which returns the new
buffer, or an existing buffer. It does not make that buffer current.
Create a new unique buffer name by =generate-new-buffer-name=. It is
not typically directly used though. The function =generate-new-buffer=
uses that function to generate new name (by post-fixing <N>), if the
provided name is in use.

Obtain all the live buffers using =buffer-list=. The order of list
matters. The newly created buffer is added to the end of list, the
current displayed buffer moves to the front. When a buffer is buried,
it is moved to the end. =other-buffer= returns the first in the list
that is not current one. =last-buffer= returns the last (end) in the
list. =bury-buffer= and =unbury-buffer= moves a buffer to the end and
switch buffer to the last buffer respectively. A buffer is killed by
=kill-buffer=, in which case it is removed from the list.

*** Position

A position is the index in a buffer. There of course will be a
character before and one after the position. When we say "at
position", we mean after position. Position in a buffer starts from 1,
while position in a string starts from 0.

The point is the current cursor position. =point= returns the current
point, =point-min= and =point-max= returns the beginning and end
point.

There are many commands to move point. =goto-char= moves by position,
and all other commands build upon it. I'm omitting the opposite
version, e.g. forward v.s. backward, up v.s. down., beginning v.s. end
- moves by characters: =forward-char=
- moves by word: =forward-word=
- buffer: =beginning-of-buffer= moves to =point-min=
- line: =beginning-of-line= and =end-of-line=, =forward-line= and
  =backward-line=
- screen: you can also count the current vertical screen lines, and
  move the corresponding lines accordingly.
- balanced expression: =forward-list=, =up-list=, =forward-sexp=,
  =end-of-defun=
- skipping: =skip-chars-forward= skips over a list of chars
  represented by a pattern string. It is like regular expression, but
  is put implicitly inside brackets. Thus you can use for example
  ="a-zA-Z"=.

It is useful to temporarily move to some position, do some tasks, and
move back. It is called /execursion/, and is done via
=save-execursion=.

Narrowing works with two positions. =narrow-to-region= does the
narrowing, and =widen= undoes it. This creates the following effects:
0. determine the accessible portion of the buffer, but don't alter the
   position of the actual buffer.
1. The point cannot move outside the positions
2. no texts outside are displayed
3. most (?) functions refuse to operate on outside text


*** Marker
A marker has two component: the buffer it is in, and the position in
the buffer. They can be retrieved by =marker-position= and
=marker-buffer=.

The position is updated automatically when the text changes. The
invariant is the surrounding two characters. The updating of marker
position takes time, especially there are a lot of them. Thus, remove
the marker if you know you won't use if any more.

You can make a marker by 4 functions, which differs only its initial
point. =make-marker=, =point-marker=, =point-min-marker=,
=point-max-marker=. You can also =copy-markder= from existing one. A
marker can be moved by =set-marker=.

There's one special marker, designated /the mark/, *whose position* is
returned by =mark=. To return the actual marker, use =mark-marker=,
but this is dangerous, try to avoid it. The mark is mainly used to
provide a default region for a command. The text between point and the
mark is called /the region/. The beginning and end of it can be
obtained by =region-beginning= and =region-end=. When using
=(interactive)= to define a command, the ="r"= code will give the
command two numeric values as the (point) and the mark, the smaller
first. This region is used for most region based command by
default.

Some command will set the mark, and when it does this, it will
typically save the old mark on the /mark ring/.  =set-mark= set the
position of the mark, but it is not commonly used, because it discard
the previous mark. Instead, =push-mark= and =pop-mark= handles the
mark ring automatically.

*** Process
Elisp can create async or sync processes. There are three primitives
to create subprocess: =make-process= for async, =call-process= and
=call-process-region= for sync. All others are built upon them.

To get a list of current live async processes, use
=list-processes=. This seems to be for display purpose, and
=process-list= seems to return process objects. You can also get
process by its name via =get-process=. Process information can be
retrieved by =process-command=, =process-id=, =process-name=,
=process-status=, =process-live-p=, =process-type=,
=process-exit-status=.

You also want to communicate with the subprocess: either send input,
receive output, or send signals. To send string as input, use
=process-send-string=, =process-send-region=, =process-send-eof=. To
send signals, use =interrupt-process=, =kill-process=, =quit-process=,
=stop-process=, =continue-process=, or the general one
=signal-process=.

The output of a subprocess is inserted into a associated buffer,
called the /process buffer/. This buffer serves two purposes: receive
the output, and kill the process by kill the buffer. =process-buffer=
returns the buffer with a particular process, and =get-buffer-process=
returns the process object associated with the buffer. The position to
insert is determined by the process mark, which is always set to the
end of the buffer. You can set process buffer by =set-process-buffer=.

Network connection is also represented by a process object, but it is
not a child process, has no process id, cannot be killed or sent
signal. You can only send and receive data, or close the
connection. =make-network-process= creates network connection. It
seems to be a primitive, able to create TCP, UDP, or a
server. Alternatively, =open-network-stream= creates TCP specifically.


*** File System Related
**** Traversing
#+BEGIN_SRC elisp
(directory-files DIRECTORY &optional FULL MATCH NOSORT)
#+END_SRC

Return a list of names of files in DIRECTORY.

Usage example:
#+BEGIN_SRC elisp
(bib-files (directory-files bib-dir t ".*\.bib$"))
#+END_SRC

**** Predicates
=directory-files= will throw error if the directory does not exist.
So a safe way is to check if the directory exists first.
This predicate does this:
#+BEGIN_SRC elisp
(file-exists-p FILENAME)
#+END_SRC
Directory is also a file.

Other predicates includes:
#+BEGIN_EXAMPLE
file-readable-p
file-executable-p
file-writable-p
file-accessible-directory-p
#+END_EXAMPLE

*** Other
- =(defalias SYMBOL DEFINITION &optional DOCSTRING)=: Set SYMBOL's function definition to DEFINITION.
  E.g. =(defalias 'helm-bibtex-get-value 'bibtex-completion-get-value)=,
  serves as a temporary patch for =helm-bibtex= update its API to =bibtex-completion=

**** make-obsolete-variable
=(make-obsolete-variable OBSOLETE-NAME CURRENT-NAME WHEN &optional ACCESS-TYPE)=

Make the byte-compiler warn that OBSOLETE-NAME is obsolete.

=helm-bibte= used it when it refactored the "helm" part off into a module,
to support different backend other than =helm=.
As a result, most =helm-bibtex-= prefixes are changed to =bibtex-completion-= ones.
But they want the end user's configuration will not break,
and at the same time warn them to update to the new name.
Here's the code, and the last line is what actually uses the function.
The actual effect is the user's configuration will be marked as warning,
the mini-buffer will describe the obsolete detail.

#+BEGIN_SRC elisp
  (cl-loop
   for var in '("bibliography" "library-path" "pdf-open-function"
                "pdf-symbol" "format-citation-functions" "notes-path"
                "notes-template-multiple-files"
                "notes-template-one-file" "notes-key-pattern"
                "notes-extension" "notes-symbol" "fallback-options"
                "browser-function" "additional-search-fields"
                "no-export-fields" "cite-commands"
                "cite-default-command"
                "cite-prompt-for-optional-arguments"
                "cite-default-as-initial-input" "pdf-field")
   for oldvar = (intern (concat "helm-bibtex-" var))
   for newvar = (intern (concat "bibtex-completion-" var))
   do
   (defvaralias newvar oldvar)
   (make-obsolete-variable oldvar newvar "2016-03-20"))
#+END_SRC



* Reference
  Sacha's super long Emacs Config: http://pages.sachachua.com/.emacs.d/Sacha.html
  Some emacs.d I started with https://github.com/jordonbiondo/.emacs.d/blob/master/init.el
  C++ IDE and some tutorials: http://tuhdo.github.io/
