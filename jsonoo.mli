open Js_of_ocaml

type t

val stringify : t -> string

module Decode : sig
  type 'a decoder = t -> 'a

  exception Decode_error of string

  val id : t decoder

  val null : 'a Js.opt decoder

  val bool : bool decoder

  val float : float decoder

  val int : int decoder

  val string : string decoder

  val char : char decoder

  val date : Js.date Js.t decoder

  val nullable : 'a decoder -> 'a Js.opt decoder

  val with_default : 'a -> 'a decoder -> 'a decoder

  val array : 'a decoder -> 'a array decoder

  val list : 'a decoder -> 'a list decoder

  val pair : 'a decoder -> 'b decoder -> ('a * 'b) decoder

  val tuple2 : 'a decoder -> 'b decoder -> ('a * 'b) decoder

  val tuple3 : 'a decoder -> 'b decoder -> 'c decoder -> ('a * 'b * 'c) decoder

  val tuple4 :
       'a decoder
    -> 'b decoder
    -> 'c decoder
    -> 'd decoder
    -> ('a * 'b * 'c * 'd) decoder

  val dict : 'a decoder -> (string, 'a) Hashtbl.t decoder

  val field : string -> 'a decoder -> 'a decoder

  val at : string list -> 'a decoder -> 'a decoder

  val optional : 'a decoder -> 'a option decoder

  val one_of : 'a decoder list -> 'a decoder

  val either : 'a decoder -> 'a decoder -> 'a decoder

  val map : ('a -> 'b) -> 'a decoder -> 'b decoder

  val bind : ('a -> 'b decoder) -> 'a decoder -> 'b decoder
end

module Encode : sig
  type 'a encoder = 'a -> t

  exception Encode_error of string

  val null : t

  val bool : bool encoder

  val float : float encoder

  val int : int encoder

  val string : string encoder

  val char : char encoder

  val data : Js.date Js.t encoder

  val nullable : 'a encoder -> 'a option encoder

  val with_default : 'a encoder -> 'a option encoder

  val dict : 'a encoder -> (string, 'a) Hashtbl.t encoder

  val object_ : (string * t) list encoder

  val array : 'a encoder -> 'a array encoder

  val list : 'a encoder -> 'a list encoder

  val pair : 'a encoder -> 'b encoder -> ('a * 'b) encoder

  val tuple2 : 'a encoder -> 'b encoder -> ('a * 'b) encoder

  val tuple3 : 'a encoder -> 'b encoder -> 'c encoder -> ('a * 'b * 'c) encoder

  val tuple4 :
       'a encoder
    -> 'b encoder
    -> 'c encoder
    -> 'd encoder
    -> ('a * 'b * 'c * 'd) encoder
end

val t_of_js : Ojs.t -> t

val js_of_t : t -> Ojs.t
