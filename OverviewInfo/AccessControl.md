# Access Control
Swift has 5 levels of access control. Access levels can be applied to types (classes, enums, structs) as well as properties, methods, initializers and subscripts.

- `open`
  - accessable from any file inside the module + from any file in other modules
  - applies only to classes and class members
  - open classes can be subclassed within other modules
  - open class members can be overriden by subclasses within other moudles

- `public`
  - accessable from any file inside the module + from any file in other modules

- `internal`
  - accessable from any file inside the module
  - this is the default value if you dont specify any level

- `fileprivate`
  - accessable within its own sourcefile
  
- `private`
  - accessable to the enclosing declaration
  
  
