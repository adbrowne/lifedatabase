"use strict";
exports.__esModule = true;
var grpc = require("@grpc/grpc-js");
var api_grpc_pb_1 = require("./proto/api_grpc_pb");
var api_pb_1 = require("./proto/api_pb");
var ApiServer = /** @class */ (function () {
    function ApiServer() {
    }
    ApiServer.prototype.getRecord = function (call, callback) {
        console.log(new Date().toISOString() + "    getRecord");
        var record = new api_pb_1.Record();
        record.setId(1);
        record.setName("Funny2");
        callback(null, record);
    };
    return ApiServer;
}());
var server = new grpc.Server();
server.addService(api_grpc_pb_1.ApiService, new ApiServer());
var port = process.env.PORT || 9000;
server.bindAsync("localhost:" + port, grpc.ServerCredentials.createInsecure(), function (err, port) {
    if (err) {
        throw err;
    }
    console.log("Listening on " + port);
    server.start();
});
