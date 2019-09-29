#lang info

;; (define source-keep-files '("doc"))

(define raco-commands
  '(("scribble" scribble/run "render a Scribble document" #f)))

;; (define purpose "This collect contains the implementation of scribble.")

;; (define release-note-files '(("Scribble" "HISTORY.txt")))

;; (define version "1.1")

;; (define test-responsibles '(("html.rkt" eli)))

(define scribblings '(("index.scrbl" (multi-page))
                      ("linux.scrbl" (multi-page))

                      ;; ("demo-s1.scrbl" (keep-style no-search))
                      ;; ("demo-m1.scrbl" (multi-page keep-style no-search))
                      ))
