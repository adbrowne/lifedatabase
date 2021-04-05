// package: api
// file: api.proto

/* tslint:disable */
/* eslint-disable */

import * as jspb from "google-protobuf";
import * as google_protobuf_empty_pb from "google-protobuf/google/protobuf/empty_pb";

export class Record extends jspb.Message { 
    getId(): number;
    setId(value: number): Record;
    getName(): string;
    setName(value: string): Record;

    serializeBinary(): Uint8Array;
    toObject(includeInstance?: boolean): Record.AsObject;
    static toObject(includeInstance: boolean, msg: Record): Record.AsObject;
    static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
    static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
    static serializeBinaryToWriter(message: Record, writer: jspb.BinaryWriter): void;
    static deserializeBinary(bytes: Uint8Array): Record;
    static deserializeBinaryFromReader(message: Record, reader: jspb.BinaryReader): Record;
}

export namespace Record {
    export type AsObject = {
        id: number,
        name: string,
    }
}
