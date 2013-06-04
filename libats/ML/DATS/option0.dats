(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2012 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
** later version.
**
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
**
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: July, 2012 *)

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/ML_basis.sats"
staload "libats/ML/SATS/option0.sats"

(* ****** ****** *)

implement{a} option0_some (x) = Some0 (x)
implement{ } option0_none ( ) = None0 ( )

(* ****** ****** *)

implement{}
option0_is_some (opt) =
  case+ opt of Some0 _ => true | None0 _ => false
// end of [option0_is_some]

implement{}
option0_is_none (opt) =
  case+ opt of Some0 _ => false | None0 _ => true
// end of [option0_is_none]

(* ****** ****** *)

implement{a}
option0_unsome_exn (opt) =
  case+ opt of
  | Some0 (x) => x | None0 ( ) => $raise NotSomeExn()
// end of [option0_unsome_exn]

(* ****** ****** *)

implement{a}
fprint_option0
  (out, opt) = fprint_option (out, option_of_option0 (opt))
// end of [fprint_option0]

(* ****** ****** *)

(* end of [option0.dats] *)
