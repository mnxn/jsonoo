(lang dune 2.7)

(name jsonoo)

(license MIT)

(maintainers "Max Lantas <mnxn.dev@outlook.com>")

(authors "Max Lantas <mnxn.dev@outlook.com>")

(source
 (github mnxn/jsonoo))

(generate_opam_files true)

(implicit_transitive_deps false)

(package
 (name jsonoo)
 (synopsis "JSON library for Js_of_ocaml")
 (depends
  js_of_ocaml
  gen_js_api
  gen_js_api
  (webtest :with-test)
  (webtest-js :with-test)
  (conf-npm :with-test)))
