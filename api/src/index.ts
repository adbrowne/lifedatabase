import * as grpc from '@grpc/grpc-js';
import { IApiServer, ApiService } from './proto/api_grpc_pb'
import { Record } from './proto/api_pb';
import { Empty } from 'google-protobuf/google/protobuf/empty_pb';
import { sendUnaryData } from '@grpc/grpc-js/build/src/server-call';

class ApiServer implements IApiServer {
    [name: string]: grpc.UntypedHandleCall;
    getRecord(call: grpc.ServerUnaryCall<Empty, Record>, callback: sendUnaryData<Record>): void {
        console.log(`${new Date().toISOString()}    getRecord`);
        let record = new Record();
        record.setId(1);
        record.setName("Funny2");
        callback(null, record);
    }
}
const server = new grpc.Server();
server.addService(ApiService, new ApiServer());
const port = process.env.PORT || 9000;
server.bindAsync(`0.0.0.0:${port}`, grpc.ServerCredentials.createInsecure(), (err, port) => {
    if (err) {
        throw err;
    }
    console.log(`Listening on ${port}`);
    server.start();
});