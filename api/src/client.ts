import * as grpc from '@grpc/grpc-js';
import { ApiClient } from './proto/api_grpc_pb';
import { Record } from './proto/api_pb';
import { Empty } from 'google-protobuf/google/protobuf/empty_pb';

const port : string = `${process.env.PORT as string | 9000}`;
const client = new ApiClient(`0.0.0.0:${port}`, grpc.credentials.createInsecure());

client.getRecord(new Empty(), (err, record) => {
    if (err) {
        return console.error(err);
    }
    return console.log("Got record", record.getName())
});