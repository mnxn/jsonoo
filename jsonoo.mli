include Jsonoo_intf.S
(** @inline *)

module Make (T : Ojs.T) : Jsonoo_intf.S with type t = T.t
