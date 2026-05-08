# protobuf

A port of [C# Protocol Buffers runtime library](https://github.com/protocolbuffers/protobuf/tree/main/csharp) to TwinCAT3.  

It enables efficient, language-neutral, and platform-neutral data serialization for industrial automation systems.  
This allows seamless integration with modern software stacks, facilitates communication between PLCs and external services, and brings the advantages of a widely adopted serialization standard to the TwinCAT ecosystem.

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

# Running the unit tests

The unit tests use [TcHaxx/snappy](https://github.com/TcHaxx/snappy) for snapshot-based assertions. The PLC sends snapshots over ADS to a listener that diffs them against the committed `*.verified.*` files in [src/protobuf/protobuf/__TESTs/__snappy-verified/](src/protobuf/protobuf/__TESTs/__snappy-verified/).

## Prerequisites

1. .NET SDK (any version that supports `dotnet tool install -g`).
2. TwinCAT 3 XAE.
3. A [Verify-supported diff tool](https://github.com/VerifyTests/DiffEngine#supported-tools).
4. Install the `TcHaxx.Snappy.CLI` global tool and the bundled TwinCAT libraries (`rplc.library`, `snappy.library`):
   ```sh
   dotnet tool install -g TcHaxx.Snappy.CLI
   TcHaxx.Snappy.CLI install
   ```

## Run

Start Snappy **before** launching the TwinCAT unit tests so it can receive snapshots from the PLC:

```powershell
.\start-tchaxx-snappy.ps1
```

[start-tchaxx-snappy.ps1](start-tchaxx-snappy.ps1) wraps `TcHaxx.Snappy.CLI verify` and points it at the verified-snapshot directory in this repo. Optional parameters:

| Parameter                  | Default       | Description                                     |
| -------------------------- | ------------- | ----------------------------------------------- |
| `-Port`                    | `25000`       | AMS port the snappy server listens on.          |
| `-LogLevel`                | `Information` | `Verbose`/`Debug`/`Information`/`Warning`/...   |
| `-FloatingPointPrecision`  | `5`           | Decimals used when comparing `REAL`/`LREAL`.    |
| `-CompactDiff`             | `$true`       | Compact diff output.                            |

With the verifier running, activate the PLC configuration and run `PRG_UnitTests` in TwinCAT. Mismatches show up as `*.received.*` files next to their `*.verified.*` counterparts; review with your diff tool, then either fix the PLC code or accept the new snapshot by replacing the `*.verified.*` file.

> [!TIP]
> When snappy runs on a different host than the PLC (e.g. a Usermode-Runtime / TwinCAT/BSD setup), override the snappy library parameter `cSnappyVerifyAmsNetID` on the `snappy` placeholder reference in `protobuf.plcproj` from the default `TcHaxx_rplc.GCL.cLocalAmsNetId` to the AMS Net ID of the machine running `TcHaxx.Snappy.CLI verify` (e.g. `'192.168.1.2.1.1'`). The PLC sends snapshots to this AMS Net ID + the configured port.
>

# Acknowledgments

* [TcUnit](https://github.com/tcunit/TcUnit) - A unit testing framework for Beckhoff's TwinCAT 3
* [protocolbuffers/protobuf](https://github.com/protocolbuffers/protobuf) - Protocol Buffers - Google's data interchange format
* [TcHaxx/snappy](https://github.com/TcHaxx/snappy) - Snapshot testing for TwinCAT 3
