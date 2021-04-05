// package: api
// file: api.proto

/* tslint:disable */
/* eslint-disable */

import * as grpc from "@grpc/grpc-js";
import {handleClientStreamingCall} from "@grpc/grpc-js/build/src/server-call";
import * as api_pb from "./api_pb";
import * as google_protobuf_empty_pb from "google-protobuf/google/protobuf/empty_pb";

interface IApiService extends grpc.ServiceDefinition<grpc.UntypedServiceImplementation> {
    getRecord: IApiService_IGetRecord;
}

interface IApiService_IGetRecord extends grpc.MethodDefinition<google_protobuf_empty_pb.Empty, api_pb.Record> {
    path: "/api.Api/GetRecord";
    requestStream: false;
    responseStream: false;
    requestSerialize: grpc.serialize<google_protobuf_empty_pb.Empty>;
    requestDeserialize: grpc.deserialize<google_protobuf_empty_pb.Empty>;
    responseSerialize: grpc.serialize<api_pb.Record>;
    responseDeserialize: grpc.deserialize<api_pb.Record>;
}

export const ApiService: IApiService;

export interface IApiServer extends grpc.UntypedServiceImplementation {
    getRecord: grpc.handleUnaryCall<google_protobuf_empty_pb.Empty, api_pb.Record>;
}

export interface IApiClient {
    getRecord(request: google_protobuf_empty_pb.Empty, callback: (error: grpc.ServiceError | null, response: api_pb.Record) => void): grpc.ClientUnaryCall;
    getRecord(request: google_protobuf_empty_pb.Empty, metadata: grpc.Metadata, callback: (error: grpc.ServiceError | null, response: api_pb.Record) => void): grpc.ClientUnaryCall;
    getRecord(request: google_protobuf_empty_pb.Empty, metadata: grpc.Metadata, options: Partial<grpc.CallOptions>, callback: (error: grpc.ServiceError | null, response: api_pb.Record) => void): grpc.ClientUnaryCall;
}

export class ApiClient extends grpc.Client implements IApiClient {
    constructor(address: string, credentials: grpc.ChannelCredentials, options?: Partial<grpc.ClientOptions>);
    public getRecord(request: google_protobuf_empty_pb.Empty, callback: (error: grpc.ServiceError | null, response: api_pb.Record) => void): grpc.ClientUnaryCall;
    public getRecord(request: google_protobuf_empty_pb.Empty, metadata: grpc.Metadata, callback: (error: grpc.ServiceError | null, response: api_pb.Record) => void): grpc.ClientUnaryCall;
    public getRecord(request: google_protobuf_empty_pb.Empty, metadata: grpc.Metadata, options: Partial<grpc.CallOptions>, callback: (error: grpc.ServiceError | null, response: api_pb.Record) => void): grpc.ClientUnaryCall;
}
