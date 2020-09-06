open Js_of_ocaml

type t = private < > Js.t

exception Decode_error of string

val stringify : t -> string
(** use [JSON.stringify] to turn JSON into a string *)

val try_parse_opt : string -> t option
(** try to parse the string into JSON, return [Some] if successful, [None] otherwise *)

val try_parse_exn : string -> t
(** try to parse the string into JSON, raise [Decode_error] if it fails *)

module Decode : sig
  type 'a decoder = t -> 'a
  (** the type for decoder functions which turn JSON into an ocaml value

      functions that are unsuccessful in decoding the JSON raise [Decode_error] *)

  val id : t decoder
  (** identity decoder returns its argument unchanged *)

  val null : 'a Js.opt decoder
  (** only decode [null] *)

  val bool : bool decoder
  (** decode [true] or [false] *)

  val float : float decoder
  (** decode a JSON number *)

  val int : int decoder
  (** decode a finite non-decimal JSON number *)

  val string : string decoder
  (** decode a JSON string *)

  val char : char decoder
  (** decode a single-character JSON string *)

  val nullable : 'a decoder -> 'a option decoder
  (** transform a decoder so it decodes nulls as [None] and other decoded values as [Some] *)

  val array : 'a decoder -> 'a array decoder
  (** decode a JSON array of values based on the given decoder *)

  val list : 'a decoder -> 'a list decoder
  (** decode an JSON array of values as a list *)

  val pair : 'a decoder -> 'b decoder -> ('a * 'b) decoder
  (** decode a 2-element JSON array with the given decoders *)

  val tuple2 : 'a decoder -> 'b decoder -> ('a * 'b) decoder
  (** decode a 2-element JSON array with the given decoders *)

  val tuple3 : 'a decoder -> 'b decoder -> 'c decoder -> ('a * 'b * 'c) decoder
  (** decode a 3-element JSON array with the given decoders *)

  val tuple4 :
       'a decoder
    -> 'b decoder
    -> 'c decoder
    -> 'd decoder
    -> ('a * 'b * 'c * 'd) decoder
  (** decode a 4-element JSON array with the given decoders *)

  val dict : 'a decoder -> (string, 'a) Hashtbl.t decoder
  (** decode a JSON dictionary as a hash table of strings to decoded values *)

  val field : string -> 'a decoder -> 'a decoder
  (** decode an element of a JSON dictionary with the decoder *)

  val at : string list -> 'a decoder -> 'a decoder
  (** follow a list of field names and decode the final element with the decoder *)

  val try_optional : 'a decoder -> 'a option decoder
  (** catch [Decode_error], return [None] if raised *)

  val try_default : 'a -> 'a decoder -> 'a decoder
  (** catch [Decode_error], return the given value if raised *)

  val any : 'a decoder list -> 'a decoder
  (** try a list of decoders until one succeeds, raise [Decode_error] if none succeed *)

  val either : 'a decoder -> 'a decoder -> 'a decoder
  (** try two decoders, raise [Decode_error] if neither succeed *)

  val map : ('a -> 'b) -> 'a decoder -> 'b decoder
  (** apply a function to the result of the decoder *)

  val bind : ('a -> 'b decoder) -> 'a decoder -> 'b decoder
  (** apply the decoder returned from the function *)
end

module Encode : sig
  type 'a encoder = 'a -> t
  (** the type for encoder functions which turn ocaml values into JSON *)

  val id : t encoder
  (** identity encoder returns its argument unchanged *)

  val null : t
  (** the null JSON value *)

  val bool : bool encoder
  (** encode a boolean into a JSON boolean *)

  val float : float encoder
  (** encode a float into a JSON number *)

  val int : int encoder
  (** encode an integer into JSON number *)

  val string : string encoder
  (** encode a string into a JSON string *)

  val char : char encoder
  (** encode a character into JSON *)

  val nullable : 'a encoder -> 'a option encoder
  (** encode a value with the decoder if [Some], return a JSON null if [None] *)

  val array : 'a encoder -> 'a array encoder
  (** encode an array *)

  val list : 'a encoder -> 'a list encoder
  (** encode a list as a JSON array *)

  val pair : 'a encoder -> 'b encoder -> ('a * 'b) encoder
  (** encode a 2-element tuple as a JSON array *)

  val tuple2 : 'a encoder -> 'b encoder -> ('a * 'b) encoder
  (** encode a 2-element tuple as a JSON array *)

  val tuple3 : 'a encoder -> 'b encoder -> 'c encoder -> ('a * 'b * 'c) encoder
  (** encode a 3-element tuple as a JSON array *)

  val tuple4 :
       'a encoder
    -> 'b encoder
    -> 'c encoder
    -> 'd encoder
    -> ('a * 'b * 'c * 'd) encoder
  (** encode a 4-element tuple as a JSON array *)

  val dict : 'a encoder -> (string, 'a) Hashtbl.t encoder
  (** encode a hash table as a JSON dict *)

  val object_ : (string * t) list encoder
  (** encode the pairs of keys and values as a JSON dict *)
end

(** {1 Compatibility with gen_js_api} *)

val t_of_js : Ojs.t -> t

val t_to_js : t -> Ojs.t
