# protobuf

A port of [C# Protocol Buffers runtime library](https://github.com/protocolbuffers/protobuf/tree/main/csharp) to TwinCAT3.  

It enables efficient, language-neutral, and platform-neutral data serialization for industrial automation systems.  
This allows seamless integration with modern software stacks, facilitates communication between PLCs and external services, and brings the advantages of a widely adopted serialization standard to the TwinCAT ecosystem.

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
~~[Oneof](https://protobuf.dev/programming-guides/proto3/#oneof) fields are not implemented due to the lack of native support for union types in `Structured Text`.~~
[see #3](https://github.com/TcHaxx/protobuf/issues/3)

### Unknown Fields
[Unknown Fields](https://protobuf.dev/programming-guides/proto3/#unknowns) are currently not preserved to avoid dynamic allocations. 
They are just skipped, for now.

### Groups
[Groups](https://protobuf.dev/programming-guides/encoding/#groups) are a deprecated feature and are therefore not implemented in this library.  

# Acknowledgments

* [TcUnit](https://github.com/tcunit/TcUnit) - A unit testing framework for Beckhoff's TwinCAT 3
* [protocolbuffers/protobuf](https://github.com/protocolbuffers/protobuf) - Protocol Buffers - Google's data interchange format
