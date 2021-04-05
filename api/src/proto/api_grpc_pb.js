// GENERATED CODE -- DO NOT EDIT!

'use strict';
var grpc = require('@grpc/grpc-js');
var api_pb = require('./api_pb.js');
var google_protobuf_empty_pb = require('google-protobuf/google/protobuf/empty_pb.js');

function serialize_api_Record(arg) {
  if (!(arg instanceof api_pb.Record)) {
    throw new Error('Expected argument of type api.Record');
  }
  return Buffer.from(arg.serializeBinary());
}

function deserialize_api_Record(buffer_arg) {
  return api_pb.Record.deserializeBinary(new Uint8Array(buffer_arg));
}

function serialize_google_protobuf_Empty(arg) {
  if (!(arg instanceof google_protobuf_empty_pb.Empty)) {
    throw new Error('Expected argument of type google.protobuf.Empty');
  }
  return Buffer.from(arg.serializeBinary());
}

function deserialize_google_protobuf_Empty(buffer_arg) {
  return google_protobuf_empty_pb.Empty.deserializeBinary(new Uint8Array(buffer_arg));
}


var ApiService = exports.ApiService = {
  getRecord: {
    path: '/api.Api/GetRecord',
    requestStream: false,
    responseStream: false,
    requestType: google_protobuf_empty_pb.Empty,
    responseType: api_pb.Record,
    requestSerialize: serialize_google_protobuf_Empty,
    requestDeserialize: deserialize_google_protobuf_Empty,
    responseSerialize: serialize_api_Record,
    responseDeserialize: deserialize_api_Record,
  },
};

exports.ApiClient = grpc.makeGenericClientConstructor(ApiService);
