# protobuf
Protocol Buffers for TwinCAT

> <h1> 🚧 WIP
--- 

## `protoc` compiler plugin
* [TcHaxx/protoc-gen-twincat](https://github.com/TcHaxx/protoc-gen-twincat)

## Limitations

Due to constraints in `Structured Text` and real-time environment, not all features of `protobuf` are practical or feasible to implement.  
See following limitations (for now):

### Map
[Map](https://protobuf.dev/programming-guides/proto3/#maps) fields are not implemented because `Structured Text` does not support dynamic data structures efficiently.

### Oneof
[Oneof](https://protobuf.dev/programming-guides/proto3/#oneof) fields are not implemented due to the lack of native support for union types in `Structured Text`.

### Unknown Fields
[Unknown Fields](https://protobuf.dev/programming-guides/proto3/#unknowns) are currently not preserved to avoid dynamic allocations. 
They are just skipped, for now.

# Acknowledgments

* [TcUnit](https://github.com/tcunit/TcUnit) - A unit testing framework for Beckhoff's TwinCAT 3
* [protocolbuffers/protobuf](https://github.com/protocolbuffers/protobuf) - Protocol Buffers - Google's data interchange format