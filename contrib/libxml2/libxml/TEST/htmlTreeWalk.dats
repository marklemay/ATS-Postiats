(*
** Some testing code for libxml2
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload "./../SATS/xmlheader.sats"
staload _ = "./../DATS/xmlheader.dats"
//
(* ****** ****** *)

staload "./../SATS/tree.sats"
staload "./../SATS/HTMLparser.sats"

(* ****** ****** *)

(*
%{^

void
treeWalk(xmlNode * a_node)
{
  xmlNode *cur_node = NULL;
  xmlAttr *cur_attr = NULL;
  for (cur_node = a_node; cur_node != NULL; cur_node = cur_node->next)
  {
    fprintf(stdout, "htmltag : %s\n", cur_node->name);
    for (cur_attr = cur_node->properties; cur_attr != NULL; cur_attr = cur_attr->next)
    {
      fprintf(stdout, "  -> with attribute : %s\n", cur_attr->name);
    }
    treeWalk(cur_node->children);
  }
}

%}
*)

(* ****** ****** *)

extern
fun treeWalk (!xmlNodePtr0): void
implement
treeWalk (node) = let
//
fun indent
(
  out: FILEref, n: int
) : void =
  if n > 0 then (fprint (out, ' '); indent (out, n-1))
//
fun auxNode
(
  out: FILEref
, node: !xmlNodePtr0
, nspace: int
) : void = let
//
val p_node = ptrcast (node)
//
in
//
if p_node > 0 then let
  val name = __name (node)
  val () = indent (out, nspace)
  val () = fprintln! (out, "htmltag: ", name)
//
  val (fpf | proplst) = __properties (node)
  val () = auxAttr (out, proplst, nspace)
  prval () = minus_addback (fpf, proplst | node)
//
  val (fpf | nodelst) = __children (node)
  val () = auxNode (out, nodelst, nspace+2)
  prval () = minus_addback (fpf, nodelst | node)
//
  val (fpf | node_next) = __next (node)
  val () = auxNode (out, node_next, nspace)
  prval () = minus_addback (fpf, node_next | node)
//
in
  // nothing
end else () // end of [if]
//
end // end of [auxNode]

and auxAttr
(
  out: FILEref
, attr: !xmlAttrPtr0
, nspace: int
) : void = let
  val p_attr = ptrcast (attr)
in
//
if p_attr > 0 then let
  val name = __name (attr)
  val () = indent (out, nspace)
  val () = fprintln! (out, "  -> with attribute: ", name)
  val (fpf | attr2) = __next (attr)
  val () = auxAttr (out, attr2, nspace)
  prval () = minus_addback (fpf, attr2 | attr)
in
  // nothing
end else () // end of [if]
//
end // end of [auxAttr]
//
in
  auxNode (stdout_ref, node, 0)
end // end of [treeWalk]

(* ****** ****** *)

implement
main0 () =
{
//
val filename =
  "DATA/atslangweb_home.html"
val encoding = stropt_none((*void*))
//
val doc = htmlParseFile (filename, encoding)
val ((*void*)) = assertloc (ptrcast (doc) > 0)
//
val () = println! ("The file [", filename, "] has been parsed successfully!")
//
val (fpf | node) = xmlDocGetRootElement (doc)
val () = treeWalk (node)
prval ((*void*)) = minus_addback (fpf, node | doc)
//
val () = xmlFreeDoc (doc)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [htmlParseFile.dats] *)
