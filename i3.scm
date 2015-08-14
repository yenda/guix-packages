;;; GNU Guix --- Functional package management for GNU
;;; Copyright © 2015 Eric Dvorsak <eric@dvorsak.fr>
;;;
;;; This file is part of GNU Guix.
;;;
;;; GNU Guix is free software; you can redistribute it and/or modify it
;;; under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 3 of the License, or (at
;;; your option) any later version.
;;;
;;; GNU Guix is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with GNU Guix.  If not, see <http://www.gnu.org/licenses/>.

(define-module (i3)
  #:use-module ((guix licenses))
  #:use-module (gnu packages linux)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system cmake)
  #:use-module (guix packages)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages qt)
  #:use-module (gnu packages asciidoc)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages autotools)
  #:use-module (guix download)
  #:use-module (guix git-download))

(define-public util-cursor
  (package
    (name "util-cursor")
    (version "0.1.2")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "git://anongit.freedesktop.org/xcb/util-cursor")
                      (commit "8eb844d39a06f42019dede515c70e7a0b155357d")))
              (sha256
               (base32
                "0hgqxlg78lal7zpk3lnl85lzdlv3967qmr8mivg2dnxjyliv45kd"))))
    (build-system gnu-build-system)
        (arguments '(#:phases
                 (alist-cons-after
                  'unpack 'autoconf
                  (lambda _
                    (zero? (system* "autoreconf" "-vfi")))
                  %standard-phases)))
            (native-inputs
     `(("automake" ,automake)
       ("autoconf" ,autoconf)
       ("libtool" ,libtool)))

         ;; (arguments
    ;;  `(#:phases
    ;;    (modify-phases %standard-phases
    ;;      (delete 'configure))))
    (home-page "")
    (synopsis "Non-free firmware for Radeon integrated chips")
    (description "Non-free firmware for Radeon integrated chips")
    ;; FIXME: What license?
    (license (non-copyleft "http://git.kernel.org/?p=linux/kernel/git/firmware/linux-firmware.git;a=blob_plain;f=LICENCE.radeon_firmware;hb=HEAD"))))


(define-public libyajl
  (package
    (name "libyajl")
    (version "2.1.0")
    (source (origin
              (method url-fetch)
              (uri (string-append "https://github.com/lloyd/yajl/archive/" version ".tar.gz"))
              (sha256
               (base32
                "0nmcqpaiq4pv7dymyg3n3jsd57yhp5npxl26a1hzw3m3lmj37drz"))))
    (build-system cmake-build-system)
    (home-page "http://i3wm.org/")
    (synopsis "Improved tiling window manager")
    (description "i3 is a tiling window manager, completely written from scratch.  The target platforms are GNU/Linux and BSD operating systems, our code is Free and Open Source Software (FOSS) under the BSD license.  i3 is primarily targeted at advanced users and developers.")
    (license bsd-style)))


(define-public i3
  (package
    (name "i3")
    (version "4.10.3")
    (source (origin
              (method url-fetch)
              (uri (string-append "http://i3wm.org/downloads/i3-" version ".tar.bz2"))
              (sha256
               (base32
                "1lq7h4w7m0hi31iva8g7yf1sc11ispnknxjdaj9agld4smxqb44j"))))
    (build-system gnu-build-system)
    (arguments
     `(#:phases
       (modify-phases %standard-phases
         (delete 'configure))))
    (inputs
     `(("libxcb" ,libxcb)
       ("xcb-util" ,xcb-util)
       ("libxkbcommon" ,libxkbcommon)
       ("libxcursor" ,libxcursor)
       ("libevdev" ,libevdev)
       ("libyajl" ,libyajl)
       ("asciidoc" ,asciidoc)
       ("xmlto" ,xmlto)))
    (native-inputs
     `(("perl" ,perl)
       ("pkg-config" ,pkg-config)))
    (home-page "http://i3wm.org/")
    (synopsis "Improved tiling window manager")
    (description "i3 is a tiling window manager, completely written from scratch.  The target platforms are GNU/Linux and BSD operating systems, our code is Free and Open Source Software (FOSS) under the BSD license.  i3 is primarily targeted at advanced users and developers.")
    (license bsd-style)))






