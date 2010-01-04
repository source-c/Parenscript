(in-package "CL-USER")

(defpackage "PARENSCRIPT"
  (:use "COMMON-LISP" "ANAPHORA")
  (:nicknames "JS" "PS")
  (:export
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Compiler interface

   ;; compiler
   #:*js-target-version*
   #:ps
   #:*parenscript-stream*
   #:ps-to-stream
   #:ps-doc
   #:ps-doc*
   #:ps*
   #:ps-inline
   #:ps-inline*
   #:*ps-read-function*
   #:ps-compile-file
   #:ps-compile-stream
   ;; for parenscript macro definition within lisp
   #:defpsmacro
   #:defmacro/ps
   #:defmacro+ps
   #:import-macros-from-lisp

   ;; gensym
   #:ps-gensym
   #:with-ps-gensyms
   #:ps-once-only
   #:*ps-gensym-counter*

   ;; naming and namespaces
   #:ps-package-prefix
   #:obfuscate-package
   #:unobfuscate-package

   ;; printer
   #:symbol-to-js-string
   #:*js-string-delimiter*
   #:*js-inline-string-delimiter*
   #:*ps-print-pretty*
   #:*indent-num-spaces*

   ;; deprecated interface
   #:define-script-symbol-macro
   #:gen-js-name
   #:with-unique-js-names
   #:defjsmacro
   #:js-compile
   #:js-inline
   #:js-inline*
   #:js
   #:js*
   #:symbol-to-js
   #:slot-value
   #:compile-script

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Language

   ;; literals
   #:t
   #:f
   #:true
   #.(symbol-name 'nil) ; for case-sensitive Lisps like some versions of Allegro
   #:this
   #:false
   #:undefined
   #:{}

   ;; keywords
   #:break
   #:continue

   ;; array literals
   #:array
   #:list
   #:aref
   #:elt
   #:make-array
   #:[]

   ;; operators
   #:! #:not #:~
   #:* #:/ #:%
   #:+ #:-
   #:<< #:>>
   #:>>>
   #:< #:> #:<= #:>=
   #:in
   #:== #:!= #:=
   #:=== #:!==
   #:&
   #:^
   #:\|
   #:\&\& #:and
   #:\|\| #:or
   #:>>= #:<<=
   #:*= #:/= #:%= #:+= #:\&= #:^= #:\|= #:~=
   #:incf #:decf

   ;; compile-time stuff
   #:eval-when

   ;; body forms
   #:progn

   ;; object literals
   #:create
   #:with-slots

   ;; if
   #:if
   #:when
   #:unless

   ;; single argument statements
   #:return
   #:throw

   ;; single argument expressions
   #:delete
   #:void
   #:typeof
   #:instanceof
   #:new

   ;; assignment and binding
   #:setf
   #:defsetf
   #:psetf
   #:setq
   #:psetq
   #:let*
   #:let

   ;; variables
   #:var
   #:defvar

   ;; iteration
   #:labeled-for
   #:for
   #:for-in
   #:while
   #:do
   #:do*
   #:dotimes
   #:dolist
   #:loop

   ;; with
   #:with

   ;; case
   #:switch
   #:case
   #:default

   ;; try throw catch
   #:try

   ;; regex literals
   #:regex

   ;; function definition
   #:defun
   #:lambda
   #:flet
   #:labels

   ;; lambda lists
   #:&key
   #:&rest
   #:&body
   #:&optional
   #:&aux
   #:&environment
   #:&key-object

   ;; slot access
   #:with-slots
   #:getprop

   ;; macros
   #:macrolet
   #:symbol-macrolet
   #:define-symbol-macro
   #:define-ps-symbol-macro
   #:defmacro

   ;; lisp eval
   #:lisp

   ;; v v v STUFF WE SHOULD PROBABLY MOVE TO OTHER LIBS v v v

   ;; html generator for javascript
   #:*ps-html-empty-tag-aware-p*
   #:*ps-html-mode*
   #:ps-html
   #:who-ps-html

   ;; utils
   #:do-set-timeout
   #:max
   #:min
   #:floor
   #:ceiling
   #:round
   #:sin
   #:cos
   #:tan
   #:asin
   #:acos
   #:atan
   #:pi
   #:sinh
   #:cosh
   #:tanh
   #:asinh
   #:acosh
   #:atanh
   #:1+
   #:1-
   #:abs
   #:evenp
   #:oddp
   #:exp
   #:expt
   #:log
   #:sqrt
   #:random
   #:ignore-errors
   #:concatenate
   #:concat-string
   #:length
   #:defined
   #:undefined
   #:@
   #:chain
   #:stringp
   #:numberp
   #:functionp
   #:objectp
   #:append
   #:apply
   #:destructuring-bind

   ;; DOM accessing utils
   #:inner-html
   #:uri-encode
   #:attribute
   #:offset
   #:scroll
   #:inner
   #:client

   ;; js runtime utils
   #:*ps-lisp-library*
   #:mapcar
   #:map-into
   #:map
   #:member
   #:append
   #:set-difference

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Intermediate representation (will be moved to js-toolkit)
   ;; operators
   ;; arithmetic
   #:+
   #:-
   #:*
   #:/
   #:%

   ;; bitwise
   #:&
   #:|\||
   #:^
   #:~
   #:>>
   #:<<
   #:>>>

   ;; assignment
   #:=
   #:+=
   #:-=
   #:*=
   #:/=
   #:%=
   #:&=
   #:\|=
   #:^+
   #:>>=
   #:<<=
   #:>>>=

   ;; increment/decrement
   #:++
   #:--

   ;; comparison
   #:==
   #:===
   #:!=
   #:!==
   #:>
   #:>=
   #:<
   #:<=

   ;; logical
   #:&&
   #:||||
   #:!

   ;; misc
   #:? ;; ternary
   #:|,|
   #:delete
   #:function
   #:get
   #:in
   #:instanceof
   #:new
   #:this
   #:typeof
   #:void
   #:null

   ;; statements
   #:block
   #:break
   #:continue
   #:do-while
   #:for
   #:for-in
   #:if
   #:label
   #:return
   #:switch
   #:throw
   #:try
   #:var
   #:while
   #:with

   #:unary-operator
   #:literal
   #:array
   #:aref
   #:operator
   #:cond
   #:lambda
   #:object
   #:variable
   #:getprop
   #:funcall
   #:escape
   ))
